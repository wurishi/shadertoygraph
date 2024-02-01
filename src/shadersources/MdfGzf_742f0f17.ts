import { Config } from '../type'
import fragment from './glsl/MdfGzf_742f0f17.glsl?raw'
export default [
  {
    // 'MdfGzf': 'Digital clock',
    name: 'MdfGzf',
    type: 'image',
    fragment,
    channels: [{ type: 'keyboard' }],
  },
] as Config[]
