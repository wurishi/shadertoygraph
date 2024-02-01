import * as Drawer from './drawer'
import * as Type from './type'
import * as Utils from './utils'

export default function piRenderer(): Type.Renderer {
    const props: Type.RendererProps = {
        shaderHeaders: [],
    }

    return {
        Initialize: (gl: WebGL2RenderingContext) => {
            props.mGL = gl
            initialize(gl, props)
            createDrawers(gl, props)
            addShaderHeaders(props)
        },
        props,
        GetCaps: () => {
            return {
                mFloat32Textures: props.mFloat32Textures != null,
                mFloat16Textures: props.mFloat16Textures != null,
                mDrawBuffers: props.mDrawBuffers != null,
                mDepthTextures: props.mDepthTextures != null,
                mDerivatives: props.mDerivatives != null,
                mShaderTextureLOD: props.mShaderTextureLOD != null,
            }
        },
        CreateShader: (
            vsSource,
            fsSource,
            preventCache,
            forceSynch,
            onResolve
        ) => {
            createShader(
                props,
                vsSource,
                fsSource,
                preventCache,
                forceSynch,
                onResolve
            )
        },
    }
}

function initialize(gl: WebGL2RenderingContext, props: Type.RendererProps) {
    printWebGLInfo_2(gl, props)
}

function createDrawers(gl: WebGL2RenderingContext, props: Type.RendererProps) {
    props.unitQuad = Drawer.createUnitQuad(gl)
    props.triangle = Drawer.createFullScreenTriangle(gl)
    props.cube = Drawer.createUnitCube(gl)
    props.cubeNor = Drawer.createUnitCubeNor(gl)
}

function addShaderHeaders(props: Type.RendererProps) {
    props.shaderHeaders[0] = `#version 300 es
    #ifdef GL_ES
    precision highp float;
    precision highp int;
    precision mediump sampler3D;
    #endif
    `
    props.shaderHeaders[1] = `#version 300 es
    #ifdef GL_ES
    precision highp float;
    precision highp int;
    precision mediump sampler3D;
    #endif
    `

    if (props.mShaderTextureLOD) {
        props.shaderHeaders[1] += `
        vec4 textureLod(sampler2D s, vec2 c, float b) {
            return texture2DlodEXT(s, c, b);
        }
        vec4 textureGrad(sampler2D s, vec2 c, vec2 dx, vec2 dy) {
            return texture2DGradEXT(s, c, dx, dy);
        }`
    }
}

function yesOrNo(sth: any): string {
    return sth !== null ? 'yes' : 'no'
}

function printWebGLInfo_2(
    gl: WebGL2RenderingContext,
    props: Type.RendererProps
) {
    const float32Textures = true
    const float32Filter = gl.getExtension('OES_texture_float_linear')
    const float16Textures = true
    const float16Filter = gl.getExtension('OES_texture_half_float_linear')
    const Derivatives = true
    const DrawBuffers = true
    const DepthTextures = true
    const ShaderTextureLOD = false // true
    const Anisotropic = gl.getExtension('EXT_texture_filter_anisotropic')
    const RenderToFloat32F = gl.getExtension('EXT_color_buffer_float')
    const DebugShader = gl.getExtension('WEBGL_debug_shaders')
    const AsynchCompile = gl.getExtension('KHR_parallel_shader_compile')

    gl.hint(gl.FRAGMENT_SHADER_DERIVATIVE_HINT, gl.NICEST)

    const maxTexSize = gl.getParameter(gl.MAX_TEXTURE_SIZE)
    const maxCubeSize = gl.getParameter(gl.MAX_CUBE_MAP_TEXTURE_SIZE)
    const maxRenderbufferSize = gl.getParameter(gl.MAX_RENDERBUFFER_SIZE)
    const extensions = gl.getSupportedExtensions()
    const textureUnits = gl.getParameter(gl.MAX_TEXTURE_IMAGE_UNITS)

    console.log(`WebGL (2.0):
    Asynch Compile: ${yesOrNo(AsynchCompile)}
    Textures:
        F32 [${yesOrNo(float32Textures)}]
        F16 [${yesOrNo(float16Textures)}]
        Depth [${yesOrNo(DepthTextures)}]
        LOD [${yesOrNo(ShaderTextureLOD)}]
        Aniso [${yesOrNo(Anisotropic)}]
        Units [${textureUnits}]
        Max Size [${maxTexSize}]
        Cube Max Size [${maxCubeSize}]
    Targets:
        MRT [${yesOrNo(DrawBuffers)}]
        F32 [${yesOrNo(RenderToFloat32F)}]
        Max Size [${maxRenderbufferSize}]
    Extensions:
        ${extensions?.join('|')}
    `)

    props.mFloat32Textures = float32Textures
    props.mFloat16Textures = float16Textures
    props.mDrawBuffers = DrawBuffers
    props.mDepthTextures = DepthTextures
    props.mDerivatives = Derivatives
    props.mShaderTextureLOD = ShaderTextureLOD
    props.mAsynchCompile = AsynchCompile
}

function createShader(
    props: Type.RendererProps,
    vsSource: string,
    fsSource: string,
    preventCache: boolean,
    forceSynch: boolean,
    onResolve?: Type.CreateShaderResolve
) {
    const gl = props.mGL!
    if (gl === null) {
        return
    }
    const vs = gl.createShader(gl.VERTEX_SHADER)!
    const fs = gl.createShader(gl.FRAGMENT_SHADER)!
    vsSource = props.shaderHeaders[0] + vsSource
    fsSource = props.shaderHeaders[1] + fsSource

    if (preventCache) {
        vsSource += `\n#define K${Utils.randomStr()}\n`
        fsSource += `\n#define K${Utils.randomStr()}\n`
    }

    const timeStart = Utils.getRealTime()

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
                log = gl.getShaderInfoLog(vs)!
            } else if (!gl.getShaderParameter(fs, gl.COMPILE_STATUS)) {
                errorType = 1
                log = gl.getShaderInfoLog(fs)!
            } else {
                errorType = 2
                log = gl.getProgramInfoLog(pr)!
            }
            onResolve && onResolve({ succ: false, errorType, errorStr: log })
            gl.deleteProgram(pr)
        } else {
            const compilationTime = Utils.getRealTime() - timeStart
            onResolve &&
                onResolve({ succ: true, program: pr, time: compilationTime })
        }
    }

    if (props.mAsynchCompile === null || forceSynch === true) {
        checkErrors()
    } else {
        const loopCheckCompletion = () => {
            if (
                gl.getProgramParameter(
                    pr,
                    props.mAsynchCompile!.COMPLETION_STATUS_KHR
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
