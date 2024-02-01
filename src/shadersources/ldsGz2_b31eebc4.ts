import { Config } from '../type'
import fragment from './glsl/ldsGz2_b31eebc4.glsl?raw'
export default [
  {
    // 'ldsGz2': 'kaleidoscope',
    name: 'ldsGz2',
    type: 'image',
    fragment,
    channels: [
      { type: 'music' },
      { type: 'webcam', filter: 'linear', wrap: 'clamp', noFlip: true },
    ],
  },
] as Config[]
