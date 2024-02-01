import { Config } from '../type'
import fragment from './glsl/ldl3z2_e89c6c81.glsl?raw'
export default [
  {
    // 'ldl3z2': 'lava drip',
    name: 'ldl3z2',
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
        type: 'cubemap',
        map: 'BasilicaBlur',
        filter: 'linear',
        wrap: 'clamp',
        noFlip: true,
      },
    ],
  },
] as Config[]
