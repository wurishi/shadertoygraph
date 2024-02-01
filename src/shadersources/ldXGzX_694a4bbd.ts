import { Config } from '../type'
import fragment from './glsl/ldXGzX_694a4bbd.glsl?raw'
export default [
  {
    // 'ldXGzX': 'texture2d edge filter',
    name: 'ldXGzX',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'London',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[]
