import { Config } from '../type'
import fragment from './glsl/ldXGRf_f576f8bc.glsl?raw'
export default [
  {
    // 'ldXGRf': 'NTSC Codec',
    name: 'ldXGRf',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }],
  },
] as Config[]
