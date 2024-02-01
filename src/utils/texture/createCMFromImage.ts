import { FILTER, GLFormat } from '../../type'

export default function createTextureCubeMapFromImage(
    id: WebGLTexture,
    gl: WebGL2RenderingContext,
    glFoTy: GLFormat,
    filter: FILTER,
    flipY: boolean,
    image: HTMLImageElement[]
) {
    gl.bindTexture(gl.TEXTURE_CUBE_MAP, id)
    gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, flipY)
    gl.activeTexture(gl.TEXTURE0)
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_POSITIVE_X,
        0,
        glFoTy.format,
        glFoTy.external,
        glFoTy.type,
        image[0]
    )
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_NEGATIVE_X,
        0,
        glFoTy.format,
        glFoTy.external,
        glFoTy.type,
        image[1]
    )
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_POSITIVE_Y,
        0,
        glFoTy.format,
        glFoTy.external,
        glFoTy.type,
        flipY ? image[3] : image[2]
    )
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_NEGATIVE_Y,
        0,
        glFoTy.format,
        glFoTy.external,
        glFoTy.type,
        flipY ? image[2] : image[3]
    )
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_POSITIVE_Z,
        0,
        glFoTy.format,
        glFoTy.external,
        glFoTy.type,
        image[4]
    )
    gl.texImage2D(
        gl.TEXTURE_CUBE_MAP_NEGATIVE_Z,
        0,
        glFoTy.format,
        glFoTy.external,
        glFoTy.type,
        image[5]
    )

    let mag = gl.NEAREST,
        min = gl.NEAREST,
        mipmap = false
    switch (filter) {
        case FILTER.LINEAR:
            {
                mag = gl.LINEAR
                min = gl.LINEAR
            }
            break
        case FILTER.MIPMAP:
            {
                mag = gl.LINEAR
                min = gl.LINEAR_MIPMAP_LINEAR
                mipmap = true
            }
            break
    }
    gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_MAG_FILTER, mag)
    gl.texParameteri(gl.TEXTURE_CUBE_MAP, gl.TEXTURE_MIN_FILTER, min)
    mipmap && gl.generateMipmap(gl.TEXTURE_CUBE_MAP)
    gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, false)
    gl.bindTexture(gl.TEXTURE_CUBE_MAP, null)
}
