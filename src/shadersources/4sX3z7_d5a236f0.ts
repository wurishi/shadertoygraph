import { Config } from '../type'
import fragment from './glsl/4sX3z7_d5a236f0.glsl?raw'
export default [
    {
        // '4sX3z7': 'Tunnel Effect',
        name: '4sX3z7',
        type: 'image',
        fragment,
        channels: [
            {
                type: 'texture',
                src: 'Bayer',
                filter: 'nearest',
                wrap: 'repeat',
                noFlip: true,
            },
        ],
    },
] as Config[]
