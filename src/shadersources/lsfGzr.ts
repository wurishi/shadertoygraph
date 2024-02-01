import { Config } from '../type';
import fragment from './glsl/lsfGzr.glsl?raw';
export default [
  {
    // 'lsfGzr': 'Blobs',
    name: 'lsfGzr',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
