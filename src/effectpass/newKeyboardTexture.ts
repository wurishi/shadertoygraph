import {
    EffectPassInfo,
    EffectPassInput,
    EffectPassInput_Keyboard,
} from '../type'

export default function NewKeyboardTexture(
    url: EffectPassInfo,
    keyboard?: EffectPassInput_Keyboard
): EffectPassInput {
    const input: EffectPassInput = {
        mInfo: url,
        loaded: !!keyboard,
        keyboard,
    }

    return input
}
