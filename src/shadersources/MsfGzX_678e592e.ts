import { Config } from '../type'
import fragment from './glsl/MsfGzX_678e592e.glsl?raw'
export default [
  {
    // 'MsfGzX': 'Blurry Britney',
    name: 'MsfGzX',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }],
  },
] as Config[]
