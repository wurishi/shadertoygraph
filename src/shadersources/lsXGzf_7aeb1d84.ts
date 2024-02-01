import { Config } from '../type'
import fragment from './glsl/lsXGzf_7aeb1d84.glsl?raw'
export default [
  {
    // 'lsXGzf': 'Input - Keyboard',
    name: 'lsXGzf',
    type: 'image',
    fragment,
    channels: [{ type: 'keyboard' }],
  },
] as Config[]
