import { Config } from '../type';
import fragment from './glsl/lsXGzr.glsl?raw';
export default [
  {
    // 'lsXGzr': 'Noise bump',
    name: 'lsXGzr',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
