import { Config } from '../type'
import fragment from './glsl/ldl3Rj_d0711bed.glsl?raw'
export default [
  {
    // 'ldl3Rj': 'ellipsoid elephant',
    name: 'ldl3Rj',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'RGBANoiseMedium',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[]
