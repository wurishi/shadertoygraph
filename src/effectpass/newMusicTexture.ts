import {
    EffectPassInfo,
    EffectPassInput,
    FILTER,
    TEXFMT,
    TEXTYPE,
    TEXWRP,
} from '../type'
import { createTexture } from '../utils/texture'

export default function NewMusicTexture(
    wa: AudioContext,
    gl: WebGL2RenderingContext,
    url: EffectPassInfo,
    globalGain?: GainNode
): EffectPassInput {
    const audio = document.createElement('audio')
    const input: EffectPassInput = {
        mInfo: url,
        loaded: false,
        audio: {
            el: audio,
            hasFalled: false,
        },
    }

    audio.loop = true
    // audio.muted = false
    audio.autoplay = true
    audio.src = url.src

    audio.addEventListener('canplay', () => {
        if (input.loaded) {
            return
        }

        input.globject = createTexture(
            gl,
            TEXTYPE.T2D,
            512,
            2,
            TEXFMT.C1I8,
            FILTER.LINEAR,
            TEXWRP.CLAMP,
            null
        )

        if (wa && input.audio) {
            input.audio.source = wa.createMediaElementSource(audio)
            input.audio.analyser = wa.createAnalyser()
            input.audio.gain = wa.createGain()

            input.audio.source.connect(input.audio.analyser)
            input.audio.analyser.connect(input.audio.gain)
            input.audio.gain.connect(globalGain!)

            input.audio.freqData = new Uint8Array(
                input.audio.analyser.frequencyBinCount
            )
            input.audio.waveData = new Uint8Array(
                input.audio.analyser.frequencyBinCount
            )
        }

        audio.play()
        input.loaded = true
    })

    if (input.audio) {
        input.audio.destroy = () => {
            audio.pause()
            input.audio?.source?.disconnect()
            input.audio?.analyser?.disconnect()
            input.audio?.gain?.disconnect()
            input.globject?.Destroy()
        }
    }

    return input
}
