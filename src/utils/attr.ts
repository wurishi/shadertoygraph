import { CreateShaderResolveSucc, RenderTarget } from '../type'

export function getAttribLocation(
    gl: WebGL2RenderingContext,
    shader: CreateShaderResolveSucc,
    name: string
) {
    return gl.getAttribLocation(shader.program, name)
}

export function getShaderConstantLocation(
    gl: WebGL2RenderingContext,
    shader: CreateShaderResolveSucc,
    name: string
) {
    return gl.getUniformLocation(shader.program, name)
}

let bindedShader: CreateShaderResolveSucc | null
export function attachShader(
    gl: WebGL2RenderingContext,
    shader: CreateShaderResolveSucc
) {
    if (shader === null) {
        bindedShader = null
        gl.useProgram(null)
    } else {
        bindedShader = shader
        gl.useProgram(shader.program)
    }
}

export function detachShader(gl: WebGL2RenderingContext) {
    gl.useProgram(null)
}

export function setShaderConstant1F(
    gl: WebGL2RenderingContext,
    uname: string,
    x: number
) {
    if (bindedShader) {
        const pos = gl.getUniformLocation(bindedShader.program, uname)
        if (pos) {
            gl.uniform1f(pos, x)
            return true
        }
    }
    return false
}

export function setShaderConstant3F(
    gl: WebGL2RenderingContext,
    uname: string,
    x: number,
    y: number,
    z: number
) {
    if (bindedShader) {
        const pos = gl.getUniformLocation(bindedShader.program, uname)
        if (pos) {
            gl.uniform3f(pos, x, y, z)
            return true
        }
    }
    return false
}

export function setShaderConstant4FV(
    gl: WebGL2RenderingContext,
    uname: string,
    x: number[]
) {
    if (bindedShader) {
        const pos = gl.getUniformLocation(bindedShader.program, uname)
        if (pos) {
            gl.uniform4fv(pos, new Float32Array(x))
            return true
        }
    }
    return false
}

export function setShaderConstant1FV(
    gl: WebGL2RenderingContext,
    uname: string,
    x: number[]
) {
    if (bindedShader) {
        const pos = gl.getUniformLocation(bindedShader.program, uname)
        if (pos) {
            gl.uniform1fv(pos, new Float32Array(x))
            return true
        }
    }
    return false
}

export function setShaderConstant3FV(
    gl: WebGL2RenderingContext,
    uname: string,
    x: number[]
) {
    if (bindedShader) {
        const pos = gl.getUniformLocation(bindedShader.program, uname)
        if (pos) {
            gl.uniform3fv(pos, new Float32Array(x))
            return true
        }
    }
    return false
}

export function setShaderTextureUnit(
    gl: WebGL2RenderingContext,
    uname: string,
    unit: number
) {
    if (bindedShader) {
        const pos = gl.getUniformLocation(bindedShader.program, uname)
        if (pos) {
            gl.uniform1i(pos, unit)
            return true
        }
    }
    return false
}

export function setShaderConstant1I(
    gl: WebGL2RenderingContext,
    uname: string,
    x: number
) {
    if (bindedShader) {
        const pos = gl.getUniformLocation(bindedShader.program, uname)
        if (pos) {
            gl.uniform1i(pos, x)
            return true
        }
    }
    return false
}

export function setViewport(gl: WebGL2RenderingContext, vp: number[]) {
    gl.viewport(vp[0], vp[1], vp[2], vp[3])
}

export function setBlend(gl: WebGL2RenderingContext, enabled: boolean) {
    if (enabled) {
        gl.enable(gl.BLEND)
        gl.blendEquationSeparate(gl.FUNC_ADD, gl.FUNC_ADD)
        gl.blendFuncSeparate(
            gl.SRC_ALPHA,
            gl.ONE_MINUS_SRC_ALPHA,
            gl.ONE,
            gl.ONE_MINUS_SRC_ALPHA
        )
    } else {
        gl.disable(gl.BLEND)
    }
}

export function getPixelData(
    gl: WebGL2RenderingContext,
    data: ArrayBufferView,
    offset: number,
    xres: number,
    yres: number
) {
    gl.readPixels(0, 0, xres, yres, gl.RGBA, gl.UNSIGNED_BYTE, data, offset)
}

export function getPixelDataRenderTarget(
    gl: WebGL2RenderingContext,
    target: RenderTarget,
    data: ArrayBufferView,
    xres: number,
    yres: number
) {
    gl.bindFramebuffer(gl.FRAMEBUFFER, target.id)
    gl.readBuffer(gl.COLOR_ATTACHMENT0)
    gl.readPixels(0, 0, xres, yres, gl.RGBA, gl.FLOAT, data, 0)
    gl.bindFramebuffer(gl.FRAMEBUFFER, null)
}
