import {
    AttribLocation,
    CanvasMouseHandler,
    CanvasMouseMetadata,
    CopyRender,
    FILTER,
    Format,
    GLFormat,
    GPUDraw,
    Image2D,
    ImageTextureSetting,
    MyWebGLFramebuffer,
    RenderSampler,
    Sampler,
    TextureSetting,
    TextureType,
    TEXWRP,
    UniformLocation,
} from './type'
import ImageList from './image'
import { COPY_FRAGMENT, newVertex } from './shaderTemplate'

export function createProgram(
    gl: WebGL2RenderingContext,
    vertex: string,
    fragment: string
) {
    const vertexShader = compileShader(gl, vertex, ShaderType.VERTEX_SHADER)
    const fragmentShader = compileShader(
        gl,
        fragment,
        ShaderType.FRAGMENT_SHADER
    )

    const program = gl.createProgram() as WebGLProgram

    gl.attachShader(program, vertexShader)
    gl.attachShader(program, fragmentShader)

    gl.linkProgram(program)

    const success = gl.getProgramParameter(program, gl.LINK_STATUS)
    if (!success) {
        throw new Error('链接失败：' + gl.getProgramInfoLog(program))
    }

    return program
}

enum ShaderType {
    VERTEX_SHADER = WebGL2RenderingContext.VERTEX_SHADER,
    FRAGMENT_SHADER = WebGL2RenderingContext.FRAGMENT_SHADER,
}

export function compileShader(
    gl: WebGL2RenderingContext,
    shaderSource: string,
    shaderType: ShaderType
) {
    const shader = gl.createShader(shaderType) as WebGLShader
    gl.shaderSource(shader, shaderSource)
    gl.compileShader(shader)

    const success = gl.getShaderParameter(shader, gl.COMPILE_STATUS)
    if (!success) {
        throw new Error('着色器未编译成功：' + gl.getShaderInfoLog(shader))
    }

    return shader
}

export function createDrawFullScreenTriangle(
    gl: WebGL2RenderingContext,
    program: WebGLProgram
): GPUDraw {
    const vpos = gl.getAttribLocation(program, 'pos')
    let buffer: WebGLBuffer = gl.createBuffer() as WebGLBuffer
    gl.bindBuffer(gl.ARRAY_BUFFER, buffer)
    gl.bufferData(
        gl.ARRAY_BUFFER,
        new Float32Array([-1.0, -1.0, 3.0, -1.0, -1.0, 3.0]),
        gl.STATIC_DRAW
    )
    gl.bindBuffer(gl.ARRAY_BUFFER, null)

    return () => {
        gl.bindBuffer(gl.ARRAY_BUFFER, buffer)
        gl.vertexAttribPointer(vpos, 2, gl.FLOAT, false, 0, 0)
        gl.enableVertexAttribArray(vpos)
        gl.drawArrays(gl.TRIANGLES, 0, 3)
        gl.disableVertexAttribArray(vpos)
        gl.bindBuffer(gl.ARRAY_BUFFER, null)
    }
}

export function createDrawUnitQuad(
    gl: WebGL2RenderingContext,
    program: WebGLProgram
): GPUDraw {
    const vpos = gl.getAttribLocation(program, 'pos')
    let buffer: WebGLBuffer = gl.createBuffer() as WebGLBuffer
    gl.bindBuffer(gl.ARRAY_BUFFER, buffer)
    gl.bufferData(
        gl.ARRAY_BUFFER,
        new Float32Array([
            -1.0, -1.0, 1.0, -1.0, -1.0, 1.0, 1.0, -1.0, 1.0, 1.0, -1.0, 1.0,
        ]),
        gl.STATIC_DRAW
    )
    gl.bindBuffer(gl.ARRAY_BUFFER, null)

    return () => {
        gl.bindBuffer(gl.ARRAY_BUFFER, buffer)
        gl.vertexAttribPointer(vpos, 2, gl.FLOAT, false, 0, 0)
        gl.enableVertexAttribArray(vpos)
        gl.drawArrays(gl.TRIANGLES, 0, 6)
        gl.disableVertexAttribArray(vpos)
        gl.bindBuffer(gl.ARRAY_BUFFER, null)
    }
}

export function getAttribLocation(
    gl: WebGL2RenderingContext,
    program: WebGLProgram,
    name: string
): AttribLocation {
    const loc = gl.getAttribLocation(program, name)
    let buffer: WebGLBuffer
    let size: number
    let type: number
    let normalize = false
    return {
        setFloat32(arr: Float32Array) {
            if (buffer) {
                throw new Error('buffer已经设置过了')
                return
            }
            size = 2
            type = gl.FLOAT
            normalize = false
            buffer = gl.createBuffer() as WebGLBuffer
            gl.bindBuffer(gl.ARRAY_BUFFER, buffer)
            gl.bufferData(gl.ARRAY_BUFFER, arr, gl.STATIC_DRAW)
        },
        bindBuffer() {
            if (buffer) {
                gl.enableVertexAttribArray(loc)
                gl.bindBuffer(gl.ARRAY_BUFFER, buffer)
                gl.vertexAttribPointer(loc, size, type, normalize, 0, 0)
            }
        },
    }
}

export function getUniformLocation(
    gl: WebGL2RenderingContext,
    program: WebGLProgram,
    name: string
): UniformLocation {
    const loc = gl.getUniformLocation(program, name)
    return {
        uniform1i(x) {
            gl.uniform1i(loc, x)
        },
        uniform1f(x) {
            gl.uniform1f(loc, x)
        },
        uniform2f(x, y) {
            gl.uniform2f(loc, x, y)
        },
        uniform3f(x, y, z) {
            gl.uniform3f(loc, x, y, z)
        },
        uniform4fv(v) {
            gl.uniform4fv(loc, v)
        },
    }
}

function createTexture(
    gl: WebGL2RenderingContext,
    type: TextureType,
    setting: TextureSetting,
    format: Format,
    width?: number,
    height?: number
): WebGLTexture {
    const texture = gl.createTexture() as WebGLTexture
    if (texture) {
        const wrap = setting.wrap === 'CLAMP' ? gl.CLAMP_TO_EDGE : gl.REPEAT
        const glFormat = format2GL(format)
        if (type === 'T2D') {
            let needMipmap = true
            let isImage = false
            gl.bindTexture(gl.TEXTURE_2D, texture)

            if ('vflip' in setting) {
                needMipmap = false
                isImage = true
                const imgSetting = setting as ImageTextureSetting
                gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, imgSetting.vflip)
                gl.pixelStorei(gl.UNPACK_PREMULTIPLY_ALPHA_WEBGL, false)
                gl.pixelStorei(gl.UNPACK_COLORSPACE_CONVERSION_WEBGL, gl.NONE)
            } else {
                width = width || 0
                height = height || 0
                gl.texImage2D(
                    gl.TEXTURE_2D,
                    0,
                    glFormat.format,
                    width,
                    height,
                    0,
                    glFormat.external,
                    glFormat.type,
                    null
                )
            }

            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, wrap)
            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, wrap)

            let magFilter = isImage ? gl.LINEAR : gl.NEAREST
            let minFilter = gl.NEAREST_MIPMAP_LINEAR

            switch (setting.filter) {
                case 'NONE':
                    {
                        magFilter = minFilter = gl.NEAREST
                        needMipmap = false
                    }
                    break
                case 'LINEAR':
                    {
                        magFilter = minFilter = gl.LINEAR
                        needMipmap = false
                    }
                    break
                case 'MIPMAP':
                    {
                        magFilter = gl.LINEAR
                        minFilter = gl.LINEAR_MIPMAP_LINEAR
                    }
                    break
            }

            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, magFilter)
            gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, minFilter)
            needMipmap && gl.generateMipmap(gl.TEXTURE_2D)

            gl.bindTexture(gl.TEXTURE_2D, null)
        }
    }
    return texture
}

export const DEFAULT_TEXTURE_SETTING: TextureSetting = {
    wrap: 'CLAMP',
    filter: 'LINEAR',
}

export function createFramebuffer(
    gl: WebGL2RenderingContext,
    level: number,
    setting: TextureSetting = DEFAULT_TEXTURE_SETTING
): MyWebGLFramebuffer {
    const v = newVertex
    let f = COPY_FRAGMENT
    f = f.replaceAll('{PRECISION}', 'mediump')

    function createFBO() {
        const texture = createTexture(gl, 'T2D', setting, 'C4I8', 400, 300)
        const framebuffer = gl.createFramebuffer() as WebGLFramebuffer

        gl.bindFramebuffer(gl.FRAMEBUFFER, framebuffer)
        gl.framebufferTexture2D(
            gl.FRAMEBUFFER,
            gl.COLOR_ATTACHMENT0,
            gl.TEXTURE_2D,
            texture,
            0
        )

        const copyProgram = createProgram(gl, v, f)
        const copyDraw = createDrawUnitQuad(gl, copyProgram)
        const copyPos = getUniformLocation(gl, copyProgram, 'v')

        return {
            texture,
            framebuffer,
            copy: (pos: number[], source: WebGLTexture) => {
                gl.useProgram(copyProgram)

                copyPos.uniform4fv([0, 0, 400, 300])

                const t = gl.getUniformLocation(copyProgram, 't')
                gl.uniform1i(t, 0)
                gl.activeTexture(gl.TEXTURE0)
                gl.bindTexture(gl.TEXTURE_2D, source)

                gl.bindFramebuffer(gl.FRAMEBUFFER, framebuffer)

                copyDraw()
            },
        }
    }

    const fbo1 = createFBO()
    const fbo2 = createFBO()

    let flag = true
    let useFramebuffer = fbo1.framebuffer
    let useTexture = fbo2.texture

    return {
        renderFramebuffer: () => {
            gl.bindFramebuffer(gl.FRAMEBUFFER, useFramebuffer)
            // flag = !flag
            // if (flag) {
            //     useFramebuffer = fbo1.framebuffer
            //     useTexture = fbo2.texture
            // } else {
            //     useFramebuffer = fbo2.framebuffer
            //     useTexture = fbo1.texture
            // }
        },
        bindChannel: (id: WebGLUniformLocation, index: number) => {
            gl.uniform1i(id, index)
            gl.activeTexture(gl.TEXTURE0 + index)
            gl.bindTexture(gl.TEXTURE_2D, useTexture)
        },
        drawCopy: (pos: number[]) => {
            // if (flag) {
            //     fbo1.copy(pos, fbo2.texture)
            // } else {
            //     fbo2.copy(pos, fbo1.texture)
            // }
            fbo2.copy(pos, fbo1.texture)
        },
    }
}

export const DEFAULT_IMAGE_TEXTURE_SETTING: ImageTextureSetting = {
    vflip: true,
    wrap: 'REPEAT',
    filter: 'MIPMAP',
}

export function getImageTexture(
    gl: WebGL2RenderingContext,
    path: string,
    setting: ImageTextureSetting = DEFAULT_IMAGE_TEXTURE_SETTING
): Image2D {
    let loading = false
    const image = new Image()
    image.src = path
    image.addEventListener('load', () => {
        loading = true
    })
    let _source = image

    let f: Format = 'C4I8'
    const imgConfig = ImageList.find((it) => it.url === path)
    imgConfig && (f = imgConfig.format)

    const texture = createTexture(gl, 'T2D', setting, f)
    return {
        bindChannel: (id, index) => {
            if (loading) {
                gl.uniform1i(id, index)
                gl.activeTexture(gl.TEXTURE0 + index)
                gl.bindTexture(gl.TEXTURE_2D, texture)

                const format = format2GL(f)

                gl.texImage2D(
                    gl.TEXTURE_2D,
                    0,
                    format.format,
                    format.external,
                    format.type,
                    _source
                )
                if (!setting.filter || setting.filter === 'MIPMAP') {
                    gl.generateMipmap(gl.TEXTURE_2D)
                }
            }
        },
    }
}

export function handleMouseEvent(
    canvas: HTMLCanvasElement
): CanvasMouseHandler {
    const data: CanvasMouseMetadata = {
        oriX: 0,
        oriY: 0,
        posX: 0,
        posY: 0,
        isDown: false,
        isSignalDown: false,
    }
    function mouseDown(ev: MouseEvent) {
        const rect = canvas.getBoundingClientRect()
        data.oriX = Math.floor(
            ((ev.clientX - rect.left) / (rect.right - rect.left)) * canvas.width
        )
        data.oriY = Math.floor(
            canvas.height -
                ((ev.clientY - rect.top) / (rect.bottom - rect.top)) *
                    canvas.height
        )
        data.posX = data.oriX
        data.posY = data.oriY
        data.isDown = true
        data.isSignalDown = true
    }

    function mouseUp(ev: MouseEvent) {
        data.isDown = false
    }

    function mouseMove(ev: MouseEvent) {
        if (data.isDown) {
            const rect = canvas.getBoundingClientRect()
            data.posX = Math.floor(
                ((ev.clientX - rect.left) / (rect.right - rect.left)) *
                    canvas.width
            )
            data.posY = Math.floor(
                canvas.height -
                    ((ev.clientY - rect.top) / (rect.bottom - rect.top)) *
                        canvas.height
            )
        }
    }

    canvas.addEventListener('mousedown', mouseDown)
    canvas.addEventListener('mouseup', mouseUp)
    canvas.addEventListener('mousemove', mouseMove)

    return {
        data,
        clear() {
            canvas.removeEventListener('mousedown', mouseDown)
            canvas.removeEventListener('mouseup', mouseUp)
            canvas.removeEventListener('mousemove', mouseMove)
        },
    }
}

export function format2GL(format: Format): GLFormat {
    const GL = WebGL2RenderingContext
    switch (format) {
        case 'C4I8':
            return {
                format: GL.RGBA8,
                external: GL.RGBA,
                type: GL.UNSIGNED_BYTE,
            }
        case 'C1I8':
            return {
                format: GL.R8,
                external: GL.RED,
                type: GL.UNSIGNED_BYTE,
            }
        case 'C1F16':
            return {
                format: GL.R16F,
                external: GL.RED,
                type: GL.FLOAT,
            }
        case 'C4F16':
            return {
                format: GL.RGBA16F,
                external: GL.RGBA,
                type: GL.FLOAT,
            }
        case 'C1F32':
            return {
                format: GL.R32F,
                external: GL.RED,
                type: GL.FLOAT,
            }

        case 'C3F32':
            return {
                format: GL.RGB32F,
                external: GL.RGB,
                type: GL.FLOAT,
            }
        case 'Z16':
            return {
                format: GL.DEPTH_COMPONENT16,
                external: GL.DEPTH_COMPONENT,
                type: GL.UNSIGNED_SHORT,
            }
        case 'Z24':
            return {
                format: GL.DEPTH_COMPONENT24,
                external: GL.DEPTH_COMPONENT,
                type: GL.UNSIGNED_SHORT,
            }
        case 'Z32':
            return {
                format: GL.DEPTH_COMPONENT32F,
                external: GL.DEPTH_COMPONENT,
                type: GL.UNSIGNED_SHORT,
            }
        case 'UNKNOW':
            return {
                format: GL.RGBA,
                external: GL.RGBA,
                type: GL.UNSIGNED_BYTE,
            }
        case 'C4F32':
        default:
            return {
                format: GL.RGBA32F,
                external: GL.RGBA,
                type: GL.FLOAT,
            }
    }
}

export function isMobile() {
    return navigator.userAgent.match(/Android/i) ||
        navigator.userAgent.match(/webOS/i) ||
        navigator.userAgent.match(/iPhone/i) ||
        navigator.userAgent.match(/iPad/i) ||
        navigator.userAgent.match(/iPod/i) ||
        navigator.userAgent.match(/BlackBerry/i) ||
        navigator.userAgent.match(/Windows Phone/i)
        ? true
        : false
}

export function sampler2Renderer(sampler: Sampler): RenderSampler {
    let filter = FILTER.NONE
    if (sampler.filter === 'linear') {
        filter = FILTER.LINEAR
    } else if (sampler.filter === 'mipmap') {
        filter = FILTER.MIPMAP
    }
    let wrap = TEXWRP.REPEAT
    if (sampler.wrap === 'clamp') {
        wrap = TEXWRP.CLAMP
    }
    return {
        filter,
        wrap,
        vflip: sampler.vflip,
    }
}
