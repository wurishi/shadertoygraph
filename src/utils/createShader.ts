import {
    CreateShaderResolve,
    CreateShaderResolveSucc,
    WebGLInfo,
} from '../type'
import { getRealTime, randomStr } from './index'

const VERTEX_SHADER_HEADER = `#version 300 es
#ifdef GL_ES
precision highp float;
precision highp int;
precision mediump sampler3D;
#endif
`
const FRAGMENT_SHADER_HEADER = `#version 300 es
#ifdef GL_ES
precision highp float;
precision highp int;
precision mediump sampler3D;
#endif
`

let info: WebGLInfo | null = null

type T = {
    a: number
    b: string
}

function yesOrNo(sth: any): string {
    return sth !== null ? 'yes' : 'no'
}

function initWebGLInfo(gl: WebGL2RenderingContext) {
    if (!info) {
        gl.hint(gl.FRAGMENT_SHADER_DERIVATIVE_HINT, gl.NICEST)
        info = {
            float32Textures: true,
            float32Filter: gl.getExtension('OES_texture_float_linear')!,
            float16Textures: true,
            float16Filter: gl.getExtension('OES_texture_half_float_linear')!,
            derivatives: true,
            drawBuffers: true,
            depthTextures: true,
            shaderTextureLOD: false, // true
            anisotropic: gl.getExtension('EXT_texture_filter_anisotropic')!,
            renderToFloat32F: gl.getExtension('EXT_color_buffer_float')!,
            debugShader: gl.getExtension('WEBGL_debug_shaders')!,
            asynchCompile: gl.getExtension('KHR_parallel_shader_compile')!,
            maxTexSize: gl.getParameter(gl.MAX_TEXTURE_SIZE),
            maxCubeSize: gl.getParameter(gl.MAX_CUBE_MAP_TEXTURE_SIZE),
            maxRenderbufferSize: gl.getParameter(gl.MAX_RENDERBUFFER_SIZE),
            extensions: gl.getSupportedExtensions() || [],
            textureUnits: gl.getParameter(gl.MAX_TEXTURE_IMAGE_UNITS),
        }

        console.log(`WebGL (2.0):
        Asynch Compile: ${yesOrNo(info.asynchCompile)}
        Textures:
            F32 [${yesOrNo(info.float32Textures)}]
            F16 [${yesOrNo(info.float16Textures)}]
            Depth [${yesOrNo(info.depthTextures)}]
            LOD [${yesOrNo(info.shaderTextureLOD)}]
            Aniso [${yesOrNo(info.anisotropic)}]
            Units [${info.textureUnits}]
            Max Size [${info.maxTexSize}]
            Cube Max Size [${info.maxCubeSize}]
        Targets:
            MRT [${yesOrNo(info.drawBuffers)}]
            F32 [${yesOrNo(info.renderToFloat32F)}]
            Max Size [${info.maxRenderbufferSize}]
        Extensions:
            ${info.extensions?.join('|')}
        `)
    }
}

export default function createShader(
    gl: WebGL2RenderingContext,
    vsSource: string,
    fsSource: string,
    preventCache: boolean,
    forceSynch: boolean,
    onResolve?: CreateShaderResolve
) {
    initWebGLInfo(gl)

    const vs = gl.createShader(gl.VERTEX_SHADER)!
    const fs = gl.createShader(gl.FRAGMENT_SHADER)!

    vsSource = VERTEX_SHADER_HEADER + vsSource
    fsSource = FRAGMENT_SHADER_HEADER + fsSource

    if (preventCache) {
        vsSource += `\n#define K${randomStr()}\n`
        fsSource += `\n#define K${randomStr()}\n`
    }

    const timeStart = getRealTime()

    gl.shaderSource(vs, vsSource)
    gl.shaderSource(fs, fsSource)
    gl.compileShader(vs)
    gl.compileShader(fs)

    const pr = gl.createProgram()!
    gl.attachShader(pr, vs)
    gl.attachShader(pr, fs)
    gl.linkProgram(pr)

    const checkErrors = () => {
        if (!gl.getProgramParameter(pr, gl.LINK_STATUS)) {
            let errorType = -1
            let log = ''
            if (!gl.getShaderParameter(vs, gl.COMPILE_STATUS)) {
                errorType = 0
                log = gl.getShaderInfoLog(vs) || 'vs compile failed'
            } else if (!gl.getShaderParameter(fs, gl.COMPILE_STATUS)) {
                errorType = 1
                log = gl.getShaderInfoLog(fs) || 'fs compile failed'
            } else {
                errorType = 2
                log = gl.getProgramInfoLog(pr) || 'other error'
            }
            onResolve && onResolve({ succ: false, errorType, errorStr: log })
            gl.deleteProgram(pr)
        } else {
            const compilationTime = getRealTime() - timeStart
            onResolve &&
                onResolve({
                    succ: true,
                    program: pr,
                    time: compilationTime,
                    Destroy: () => {
                        gl.deleteProgram(pr)
                    },
                })
        }
    }

    if (info?.asynchCompile === null || forceSynch) {
        checkErrors()
    } else {
        const loopCheckCompletion = () => {
            if (
                gl.getProgramParameter(
                    pr,
                    info!.asynchCompile!.COMPLETION_STATUS_KHR
                ) === true
            ) {
                checkErrors()
            } else {
                setTimeout(loopCheckCompletion, 10)
            }
        }
        setTimeout(loopCheckCompletion, 10)
    }
}
