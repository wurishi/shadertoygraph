import { Texture, TEXTYPE } from '../../type'
import { iFormatPI2GL } from '../index'

export function updateTextureFromImage(
    gl: WebGL2RenderingContext,
    tex: Texture,
    image: any
) {
    const glFoTy = iFormatPI2GL(tex.format)

    if (tex.type === TEXTYPE.T2D) {
        gl.activeTexture(gl.TEXTURE0)
        gl.bindTexture(gl.TEXTURE_2D, tex.id)
        gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, tex.vFlip)
        gl.texImage2D(
            gl.TEXTURE_2D,
            0,
            glFoTy.format,
            glFoTy.external,
            glFoTy.type,
            image
        )
        gl.bindTexture(gl.TEXTURE_2D, null)
        gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, false)
    }
}
