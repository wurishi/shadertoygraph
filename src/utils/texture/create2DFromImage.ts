import { FILTER, GLFormat } from '../../type'

export default function createTextureT2DFromImage(
    id: WebGLTexture,
    gl: WebGL2RenderingContext,
    glFoTy: GLFormat,
    filter: FILTER,
    glWrap: number,
    flipY: boolean,
    image: HTMLImageElement
) {
    gl.bindTexture(gl.TEXTURE_2D, id)

    gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, flipY)
    gl.pixelStorei(gl.UNPACK_PREMULTIPLY_ALPHA_WEBGL, false)
    gl.pixelStorei(gl.UNPACK_COLORSPACE_CONVERSION_WEBGL, gl.NONE)

    gl.texImage2D(
        gl.TEXTURE_2D,
        0,
        glFoTy.format,
        glFoTy.external,
        glFoTy.type,
        image
    )

    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, glWrap)
    gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, glWrap)

    let mag = gl.LINEAR,
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

    gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, false)
    gl.bindTexture(gl.TEXTURE_2D, null)
}
