import { EffectPassInfo, EffectPassInput, TEXFMT, TEXTYPE } from '../type'
import { sampler2Renderer } from '../utils'
import binaryFile from '../utils/binaryFile'
import { createTexture } from '../utils/texture'

export default function NewVolumeTexture(
    gl: WebGL2RenderingContext,
    url: EffectPassInfo
): EffectPassInput {
    const input: EffectPassInput = {
        mInfo: url,
        loaded: false,
    }

    const xmlHttp = new XMLHttpRequest()
    const xmlLoadHandler = () => {
        const data = xmlHttp.response
        const file = binaryFile(data)

        const signature = file.readUInt32()
        input.volume!.image.xres = file.readUInt32()
        input.volume!.image.yres = file.readUInt32()
        input.volume!.image.zres = file.readUInt32()
        const binNumChannels = file.readUInt8()
        const binLayout = file.readUInt8()
        const binFormat = file.readUInt16()
        let format = TEXFMT.C1I8
        if (binNumChannels === 1 && binFormat === 0) {
            format = TEXFMT.C1I8
        } else if (binNumChannels === 2 && binFormat === 0) {
            // format = TEXFMT.C2I8
        } else if (binNumChannels === 3 && binFormat === 0) {
            // format = TEXFMT.C3I8
        } else if (binNumChannels === 4 && binFormat === 0) {
            format = TEXFMT.C4I8
        } else if (binNumChannels === 1 && binFormat === 10) {
            format = TEXFMT.C1F32
        } else if (binNumChannels === 2 && binFormat === 10) {
            // format = TEXFMT.C2F32
        } else if (binNumChannels === 3 && binFormat === 10) {
            // format = TEXFMT.C3F32
        } else if (binNumChannels === 4 && binFormat === 10) {
            format = TEXFMT.C4F32
        }
        const buffer = new Uint8Array(data, 20) // skip 16 bytes (header of .bin)
        const rti = sampler2Renderer(url.sampler)
        input.globject = createTexture(
            gl,
            TEXTYPE.T3D,
            input.volume!.image.xres,
            input.volume!.image.yres,
            format,
            rti.filter,
            rti.wrap,
            buffer
        )
        input.loaded = true
    }
    input.volume = {
        image: {
            xres: 0,
            yres: 0,
            zres: 0,
        },
        destroy: () => {
            xmlHttp.removeEventListener('load', xmlLoadHandler)
            input.globject?.Destroy()
        },
    }
    xmlHttp.open('GET', url.src, true)
    xmlHttp.responseType = 'arraybuffer'
    xmlHttp.addEventListener('load', xmlLoadHandler)
    xmlHttp.send()

    return input
}
