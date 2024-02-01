import { FILTER, GLFormat } from '../../type'

export default function createTextureCubeMap(
    id: WebGLTexture,
    gl: WebGL2RenderingContext,
    xres: number,
    yres: number,
    glFoTy: GLFormat,
    filter: FILTER,
    glWrap: number,
    buffer: ArrayBufferView | null = null
) {
    gl.bindTexture(gl.TEXTURE_CUBE_MAP, id)

    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_POSITIVE_X,
        0,
        glFoTy.format,
        xres,
        yres,
        0,
        glFoTy.external,
        glFoTy.type,
        buffer
    )
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_NEGATIVE_X,
        0,
        glFoTy.format,
        xres,
        yres,
        0,
        glFoTy.external,
        glFoTy.type,
        buffer
    )
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_POSITIVE_Y,
        0,
        glFoTy.format,
        xres,
        yres,
        0,
        glFoTy.external,
        glFoTy.type,
        buffer
    )
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_NEGATIVE_Y,
        0,
        glFoTy.format,
        xres,
        yres,
        0,
        glFoTy.external,
        glFoTy.type,
        buffer
    )
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_POSITIVE_Z,
        0,
        glFoTy.format,
        xres,
        yres,
        0,
        glFoTy.external,
        glFoTy.type,
        buffer
    )
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_NEGATIVE_Z,
        0,
        glFoTy.format,
        xres,
        yres,
        0,
        glFoTy.external,
        glFoTy.type,
        buffer
    )

    let mag = gl.LINEAR,
        min = gl.LINEAR_MIPMAP_LINEAR
    switch (filter) {
        case FILTER.NONE:
            {
                mag = gl.NEAREST
                min = gl.NEAREST
            }
            break
        case FILTER.LINEAR:
            {
                mag = gl.LINEAR
                min = gl.LINEAR
            }
            break
        case FILTER.MIPMAP:
        default:
            break
    }
    gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_MAG_FILTER, mag)
    gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_MIN_FILTER, min)
    if (filter === FILTER.MIPMAP) {
        gl.generateMipmap(gl.TEXTURE_CUBE_MAP)
    }
    gl.bindTexture(gl.TEXTURE_CUBE_MAP, null)
}
