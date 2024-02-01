import { Config } from '../type'
import fragment from './glsl/4sl3z2_da81ad89.glsl?raw'
export default [
  {
    // '4sl3z2': 'Storm clouds',
    name: '4sl3z2',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'GrayNoiseSmall',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[]
