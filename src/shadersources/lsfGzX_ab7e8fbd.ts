import { Config } from '../type'
import fragment from './glsl/lsfGzX_ab7e8fbd.glsl?raw'
export default [
  {
    // 'lsfGzX': 'Chroma key test',
    name: 'lsfGzX',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }, { type: 'video' }],
  },
] as Config[]
