import { Config } from '../type'
import fragment from './glsl/4dXGRX_d4ca6f8d.glsl?raw'
export default [
  {
    // '4dXGRX': 'tracker',
    name: '4dXGRX',
    type: 'image',
    fragment,
    channels: [
      { type: 'webcam', filter: 'linear', wrap: 'clamp', noFlip: true },
    ],
  },
] as Config[]
