import { Config } from '../type'
import fragment from './glsl/lsX3zX_e872c0a3.glsl?raw'
export default [
  {
    // 'lsX3zX': '3 videos',
    name: 'lsX3zX',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }, { type: 'video' }, { type: 'video' }],
  },
] as Config[]
