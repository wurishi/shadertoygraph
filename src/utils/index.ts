import { CLEAR, GLFormat, TEXFMT, Texture, TEXTYPE } from '../type'

export function iFormatPI2GL(format: TEXFMT): GLFormat {
    const log = (() => {}) as any
    const GL = WebGL2RenderingContext
    let glFormat: GLFormat = {
        format: 0,
        external: 0,
        type: 0,
    }
    switch (format) {
        case TEXFMT.C4I8:
            log('C4I8')
            glFormat = {
                format: GL.RGBA8,
                external: GL.RGBA,
                type: GL.UNSIGNED_BYTE,
            }
            break
        case TEXFMT.C1I8:
            log('C1I8')
            glFormat = {
                format: GL.R8,
                external: GL.RED,
                type: GL.UNSIGNED_BYTE,
            }
            break
        case TEXFMT.C1F16:
            glFormat = {
                format: GL.R16F,
                external: GL.RED,
                type: GL.FLOAT,
            }
            break
        case TEXFMT.C4F16:
            glFormat = {
                format: GL.RGBA16F,
                external: GL.RGBA,
                type: GL.FLOAT,
            }
            break
        case TEXFMT.C1F32:
            glFormat = {
                format: GL.R32F,
                external: GL.RED,
                type: GL.FLOAT,
            }
            break
        case TEXFMT.C4F32:
            glFormat = {
                format: GL.RGBA32F,
                external: GL.RGBA,
                type: GL.FLOAT,
            }
            break
        case TEXFMT.C3F32:
            glFormat = {
                format: GL.RGB32F,
                external: GL.RGB,
                type: GL.FLOAT,
            }
            break
        case TEXFMT.Z16:
            glFormat = {
                format: GL.DEPTH_COMPONENT16,
                external: GL.DEPTH_COMPONENT,
                type: GL.UNSIGNED_SHORT,
            }
            break
        case TEXFMT.Z24:
            glFormat = {
                format: GL.DEPTH_COMPONENT24,
                external: GL.DEPTH_COMPONENT,
                type: GL.UNSIGNED_SHORT,
            }
            break
        case TEXFMT.Z32:
            log('Z32')
            glFormat = {
                format: GL.DEPTH_COMPONENT32F,
                external: GL.DEPTH_COMPONENT,
                type: GL.UNSIGNED_SHORT,
            }
            break
        default:
        // warn('iFormatPI2GL', '没有找到正确的format', format)
    }
    return glFormat
}

export function randomStr(start = 7) {
    return Math.random().toString(36).substring(start)
}

export const getRealTime = (function () {
    if ('performance' in window) {
        return () => window.performance.now()
    }
    return () => new Date().getTime()
})()

export const requestAnimFrame = (function () {
    const W: any = window
    return (
        window.requestAnimationFrame ||
        W.webkitRequestAnimationFrame ||
        W.mozRequestAnimationFrame ||
        W.oRequestAnimationFrame ||
        W.msRequestAnimationFrame ||
        function (cb: any) {
            window.setTimeout(cb, 1000 / 60)
        }
    )
})()

export function clear(
    gl: WebGL2RenderingContext,
    flags: CLEAR,
    ccolor: number[],
    cdepth: number,
    cstencil: number
) {
    let mode = 0
    if (flags & 1) {
        mode |= gl.COLOR_BUFFER_BIT
        gl.clearColor(ccolor[0], ccolor[1], ccolor[2], ccolor[3])
    }
    if (flags & 2) {
        mode |= gl.DEPTH_BUFFER_BIT
        gl.clearDepth(cdepth)
    }
    if (flags & 4) {
        mode |= gl.STENCIL_BUFFER_BIT
        gl.clearStencil(cstencil)
    }
    gl.clear(mode)
}

export function createMipmaps(gl: WebGL2RenderingContext, te: Texture) {
    if (te.type === TEXTYPE.T2D) {
        gl.activeTexture(gl.TEXTURE0)
        gl.bindTexture(gl.TEXTURE_2D, te.id)
        gl.generateMipmap(gl.TEXTURE_2D)
        gl.bindTexture(gl.TEXTURE_2D, null)
    } else if (te.type === TEXTYPE.CUBEMAP) {
        gl.activeTexture(gl.TEXTURE0)
        gl.bindTexture(gl.TEXTURE_CUBE_MAP, te.id)
        gl.generateMipmap(gl.TEXTURE_CUBE_MAP)
        gl.bindTexture(gl.TEXTURE_CUBE_MAP, null)
    }
}

export function createAudioContext() {
    let res = null
    try {
        if (window.AudioContext) {
            res = new AudioContext()
        }
        const w: any = window
        if (res === null && w.webkitAudioContext) {
            const WAC = w.webkitAudioContext
            res = new WAC()
        }
    } catch (error) {
        res = null
    }
    return res
}

export function download(name: string, blob: Blob) {
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.target = '_self'
    a.download = name
    a.click()
}

export function exportToWav(
    numSamples: number,
    rate: number,
    bits: number,
    numChannels: number,
    words: Int16Array
) {
    const numBytes = (numSamples * numChannels * bits) / 8

    const buffer = new ArrayBuffer(44 + numBytes)
    const data = new DataView(buffer)

    data.setUint32(0, 0x46464952, true) // RIFF
    data.setUint32(4, numBytes + 36, true)

    data.setUint32(8, 0x45564157, true) // WAV_WAVE
    data.setUint32(12, 0x20746d66, true) // WAV_FMT

    data.setUint32(16, 16, true)
    data.setUint16(20, 1, true) // WAV_FORMAT_PCM
    data.setUint16(22, numChannels, true)
    data.setUint32(24, rate, true)
    data.setUint32(28, (rate * numChannels * bits) / 8, true)
    data.setUint32(32, (numChannels * bits) / 8, true)
    data.setUint16(34, bits, true)

    data.setUint32(36, 0x61746164, true) // WAV_DATA
    data.setUint32(40, numBytes, true)
    const numWords = numSamples * numChannels
    for (let i = 0; i < numWords; i++) {
        data.setInt16(44 + i * 2, words[i], true)
    }

    return new Blob([buffer], { type: 'application/octet-stream' })
}

export function requestFullScreen(ele: any) {
    if (ele === null) {
        ele = document.documentElement
    }

    if (ele.requestFullscreen) {
        ele.requestFullscreen()
    } else if (ele.msRequestFullscreen) {
        ele.msRequestFullscreen()
    } else if (ele.mozRequestFullScreen) {
        ele.mozRequestFullScreen()
    } else if (ele.webkitRequestFullscreen) {
        ele.webkitRequestFullscreen((Element as any).ALLOW_KEYBOARD_INPUT)
    }
}
