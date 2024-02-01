import { Config } from '../type'
import fragment from './glsl/4sXGzX_5b578ab5.glsl?raw'
export default [
  {
    // '4sXGzX': 'pulsing universe - test',
    name: '4sXGzX',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Stars',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[]
