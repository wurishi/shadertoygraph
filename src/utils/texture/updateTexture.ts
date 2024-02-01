import { iFormatPI2GL } from '../index'
import { Texture, TEXTYPE } from '../../type'

export default function updateTexture(
    gl: WebGL2RenderingContext,
    tex: Texture,
    x0: number,
    y0: number,
    xres: number,
    yres: number,
    buffer: ArrayBufferView
) {
    const glFoTy = iFormatPI2GL(tex.format)
    if (tex.type === TEXTYPE.T2D) {
        gl.activeTexture(gl.TEXTURE0)

        gl.bindTexture(gl.TEXTURE_2D, tex.id)
        gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, tex.vFlip)
        gl.texSubImage2D(
            gl.TEXTURE_2D,
            0,
            x0,
            y0,
            xres,
            yres,
            glFoTy.external,
            glFoTy.type,
            buffer
        )
        gl.bindTexture(gl.TEXTURE_2D, null)
        gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, false)
    }
}
