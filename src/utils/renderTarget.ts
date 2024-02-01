import { RenderTarget, Texture } from '../type'

export function createRenderTarget(
    gl: WebGL2RenderingContext,
    color0: Texture,
    depth: any,
    wantZbuffer: boolean
): RenderTarget {
    const id = gl.createFramebuffer()!
    gl.bindFramebuffer(gl.FRAMEBUFFER, id)

    if (depth === null) {
        if (wantZbuffer) {
            const zb = gl.createRenderbuffer()
            gl.bindRenderbuffer(gl.RENDERBUFFER, zb)
            gl.renderbufferStorage(
                gl.RENDERBUFFER,
                gl.DEPTH_COMPONENT16,
                color0.xres,
                color0.yres
            )

            gl.framebufferRenderbuffer(
                gl.FRAMEBUFFER,
                gl.DEPTH_ATTACHMENT,
                gl.RENDERBUFFER,
                zb
            )
        }
    } else {
        // gl.framebufferTexture2D(gl.FRAMEBUFFER, gl.DEPTH_ATTACHMENT, gl.TEXTURE_2D, depth.mObjectID, 0)
    }

    gl.framebufferTexture2D(
        gl.FRAMEBUFFER,
        gl.COLOR_ATTACHMENT0,
        gl.TEXTURE_2D,
        color0.id,
        0
    )

    if (gl.checkFramebufferStatus(gl.FRAMEBUFFER) !== gl.FRAMEBUFFER_COMPLETE) {
        throw new Error('frame buffer')
    }
    gl.bindRenderbuffer(gl.RENDERBUFFER, null)
    gl.bindFramebuffer(gl.FRAMEBUFFER, null)

    return {
        id,
        tex0: color0,
        Destroy: () => {
            gl.deleteFramebuffer(id)
        },
    }
}

export function setRenderTarget(
    gl: WebGL2RenderingContext,
    target: RenderTarget | null
) {
    if (target) {
        gl.bindFramebuffer(gl.FRAMEBUFFER, target.id)
    } else {
        gl.bindFramebuffer(gl.FRAMEBUFFER, null)
    }
}

export function setRenderTargetCubeMap(
    gl: WebGL2RenderingContext,
    fbo: RenderTarget | null,
    face: number
) {
    if (fbo) {
        gl.bindFramebuffer(gl.FRAMEBUFFER, fbo.id)
        gl.framebufferTexture2D(
            gl.FRAMEBUFFER,
            gl.COLOR_ATTACHMENT0,
            gl.TEXTURE_CUBE_MAP_POSITIVE_X + face,
            fbo.tex0.id,
            0
        )
    } else {
        gl.bindFramebuffer(gl.FRAMEBUFFER, null)
    }
}
