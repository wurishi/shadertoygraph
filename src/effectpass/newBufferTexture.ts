import { EffectPassInfo, EffectPassInput } from '../type'

export default function NewBufferTexture(url: EffectPassInfo): EffectPassInput {
    const input: EffectPassInput = {
        mInfo: url,
        loaded: true,
        buffer: {
            id: Number(url.src) || 0,
            destroy: () => {},
        },
    }

    return input
}
