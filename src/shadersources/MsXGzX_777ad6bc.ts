import { Config } from '../type'
import fragment from './glsl/MsXGzX_777ad6bc.glsl?raw'
export default [
  {
    // 'MsXGzX': 'Fixed-Base Wave',
    name: 'MsXGzX',
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
