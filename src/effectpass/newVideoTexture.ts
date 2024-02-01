import { EffectPassInfo, EffectPassInput, TEXFMT, TEXTYPE } from '../type'
import { sampler2Renderer } from '../utils'
import { CreateTextureFromImage } from '../utils/texture'

export default function NewVideoTexture(
    gl: WebGL2RenderingContext,
    url: EffectPassInfo
): EffectPassInput {
    const video = document.createElement('video')
    video.loop = true
    video.preload = 'auto'
    video.autoplay = false
    video.volume = 0
    video.muted = true
    const input: EffectPassInput = {
        mInfo: url,
        loaded: false,
    }

    const rti = sampler2Renderer(url.sampler)

    const canplay = () => {
        video
            .play()
            .then(() => {
                input.globject = CreateTextureFromImage(
                    gl,
                    TEXTYPE.T2D,
                    [video as any],
                    TEXFMT.C4I8,
                    rti.filter,
                    rti.wrap,
                    rti.vflip
                )
                input.loaded = true
            })
            .catch((error) => {
                console.log('video play:', error)
            })
    }
    const error = (err: any) => {
        console.log('video error', err)
    }

    video.addEventListener('canplay', canplay)
    video.addEventListener('error', error)

    video.src = url.src

    input.video = {
        video,
        destroy: () => {
            video.removeEventListener('canplay', canplay)
            video.removeEventListener('error', error)
            input.globject?.Destroy()
        },
    }

    return input
}
