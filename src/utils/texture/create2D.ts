import { FILTER, GLFormat } from '../../type'

export default function createTextureT2D(
    id: WebGLTexture,
    gl: WebGL2RenderingContext,
    xres: number,
    yres: number,
    glFoTy: GLFormat,
    filter: FILTER,
    glWrap: number,
    buffer: ArrayBufferView | null = null
) {
    gl.bindTexture(gl.TEXTURE_2D, id)
    gl.texImage2D(
        gl.TEXTURE_2D,
        0,
        glFoTy.format,
        xres,
        yres,
        0,
        glFoTy.external,
        glFoTy.type,
        buffer
    )
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, glWrap)
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, glWrap)

    let mag = gl.NEAREST,
        min = gl.NEAREST_MIPMAP_LINEAR,
        mipmap = true
    switch (filter) {
        case FILTER.NONE:
            {
                mag = gl.NEAREST
                min = gl.NEAREST
                mipmap = false
            }
            break
        case FILTER.LINEAR:
            {
                mag = gl.LINEAR
                min = gl.LINEAR
                mipmap = false
            }
            break
        case FILTER.MIPMAP:
            {
                mag = gl.LINEAR
                min = gl.LINEAR_MIPMAP_LINEAR
            }
            break
    }
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, mag)
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, min)
    mipmap && gl.generateMipmap(gl.TEXTURE_2D)
    gl.bindTexture(gl.TEXTURE_2D, null)
}
