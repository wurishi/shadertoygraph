import { Config } from '../type'
import fragment from './glsl/ldf3Rf_b67ab7a2.glsl?raw'
export default [
  {
    // 'ldf3Rf': 'Full MAME/MESS Shader Pipe',
    name: 'ldf3Rf',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }],
  },
] as Config[]
