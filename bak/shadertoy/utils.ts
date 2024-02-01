import * as Type from './type'

export function warn(fnName: string, ...args: any[]) {
    console.warn(`[${fnName}]:`, ...args)
}

export function iFormatPI2GL(format: Type.TEXFMT): Type.GLFormat {
    const GL = WebGL2RenderingContext
    let glFormat: Type.GLFormat = {
        format: 0,
        external: 0,
        type: 0,
    }
    switch (format) {
        case Type.TEXFMT.C4I8:
            glFormat = {
                format: GL.RGBA8,
                external: GL.RGBA,
                type: GL.UNSIGNED_BYTE,
            }
            break
        case Type.TEXFMT.C1I8:
            glFormat = {
                format: GL.R8,
                external: GL.RED,
                type: GL.UNSIGNED_BYTE,
            }
            break
        case Type.TEXFMT.C1F16:
            glFormat = {
                format: GL.R16F,
                external: GL.RED,
                type: GL.FLOAT,
            }
            break
        case Type.TEXFMT.C4F16:
            glFormat = {
                format: GL.RGBA16F,
                external: GL.RGBA,
                type: GL.FLOAT,
            }
            break
        case Type.TEXFMT.C1F32:
            glFormat = {
                format: GL.R32F,
                external: GL.RED,
                type: GL.FLOAT,
            }
            break
        case Type.TEXFMT.C4F32:
            glFormat = {
                format: GL.RGBA32F,
                external: GL.RGBA,
                type: GL.FLOAT,
            }
            break
        case Type.TEXFMT.C3F32:
            glFormat = {
                format: GL.RGB32F,
                external: GL.RGB,
                type: GL.FLOAT,
            }
            break
        case Type.TEXFMT.Z16:
            glFormat = {
                format: GL.DEPTH_COMPONENT16,
                external: GL.DEPTH_COMPONENT,
                type: GL.UNSIGNED_SHORT,
            }
            break
        case Type.TEXFMT.Z24:
            glFormat = {
                format: GL.DEPTH_COMPONENT24,
                external: GL.DEPTH_COMPONENT,
                type: GL.UNSIGNED_SHORT,
            }
            break
        case Type.TEXFMT.Z32:
            glFormat = {
                format: GL.DEPTH_COMPONENT32F,
                external: GL.DEPTH_COMPONENT,
                type: GL.UNSIGNED_SHORT,
            }
            break
        default:
            warn('iFormatPI2GL', '没有找到正确的format', format)
    }
    return glFormat
}

export function randomStr(start = 7): string {
    return Math.random().toString(36).substring(start)
}

export const getRealTime = (function () {
    if ('performance' in window) {
        return function () {
            return window.performance.now()
        }
    }
    return function () {
        return new Date().getTime()
    }
})()

export function piIsMobile() {
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
