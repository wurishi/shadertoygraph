import { Config } from '../type'
import fragment from './glsl/XtX3Rr.glsl?raw'
import Sound from './glsl/XtX3Rr_sound.glsl?raw'
export default [
    {
        // 'XtX3Rr': 'Neptune Racing',
        name: 'XtX3Rr',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Organic2',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Abstract1',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'RGBANoiseMedium',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
            {
                type: 'texture',
                src: 'Stars',
                filter: 'mipmap',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },

    {
        name: 'Sound',
        type: 'sound',
        fragment: Sound,
        channels: [{ type: 'texture', src: 'Organic2' }],
    },
] as Config[]
