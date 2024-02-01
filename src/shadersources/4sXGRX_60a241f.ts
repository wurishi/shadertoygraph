import { Config } from '../type'
import fragment from './glsl/4sXGRX_60a241f.glsl?raw'
export default [
  {
    // '4sXGRX': 'webcam game tracker - pong',
    name: '4sXGRX',
    type: 'image',
    fragment,
    channels: [{ type: 'webcam', filter: 'linear', wrap: 'clamp' }],
  },
] as Config[]
