import { Config } from '../type'
import fragment from './glsl/ldXGRX_3417e517.glsl?raw'
export default [
  {
    // 'ldXGRX': 'Procedural Tech Rings',
    name: 'ldXGRX',
    type: 'image',
    fragment,
    channels: [
      { type: 'texture', src: 'Bayer', filter: 'nearest', wrap: 'repeat' },
      { type: 'music' },
    ],
  },
] as Config[]
