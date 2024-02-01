import { Config } from '../type'
import fragment from './glsl/Xss3R2_f0908bcb.glsl?raw'
export default [
  {
    // 'Xss3R2': 'Circles And Lines',
    name: 'Xss3R2',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[]
