import { getCubemaps } from '../image'
import {
    EffectBuffer,
    EffectPassInfo,
    EffectPassInput,
    TEXFMT,
    TEXTYPE,
} from '../type'
import { sampler2Renderer } from '../utils'
import { CreateTextureFromImage } from '../utils/texture'

export default function NewCubemapsTexture(
    gl: WebGL2RenderingContext,
    url: EffectPassInfo
): EffectPassInput {
    const input: EffectPassInput = {
        mInfo: url,
        loaded: false,
    }
    const rti = sampler2Renderer(url.sampler)

    if (url.src === undefined) {
        input.loaded = true
    } else {
        const images = [
            new Image(),
            new Image(),
            new Image(),
            new Image(),
            new Image(),
            new Image(),
        ]

        const urls = getCubemaps(url.src)
        let numLoaded = 0
        const onLoad = () => {
            numLoaded++
            if (numLoaded === 6) {
                input.globject = CreateTextureFromImage(
                    gl,
                    TEXTYPE.CUBEMAP,
                    images,
                    TEXFMT.C4I8,
                    rti.filter,
                    rti.wrap,
                    rti.vflip
                )
                input.loaded = true
            }
        }
        for (let i = 0; i < 6; i++) {
            images[i].crossOrigin = ''
            images[i].addEventListener('load', onLoad)
            images[i].src = urls[i]
        }

        const destroy = () => {
            images.forEach((img) => img.removeEventListener('load', onLoad))
            input.globject?.Destroy()
        }

        input.cubemaps = {
            images,
            destroy,
        }
    }

    return input
}
