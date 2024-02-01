import { Config } from '../type'
import fragment from './glsl/MdX3zX_f6425da2.glsl?raw'
export default [
  {
    // 'MdX3zX': 'Foggy Mountains',
    name: 'MdX3zX',
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
      { type: 'music' },
    ],
  },
] as Config[]
