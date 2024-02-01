import { Config } from '../type'
import fragment from './glsl/Mss3zj_9b666f8f.glsl?raw'
export default [
  {
    // 'Mss3zj': 'Cellular Automata',
    name: 'Mss3zj',
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
