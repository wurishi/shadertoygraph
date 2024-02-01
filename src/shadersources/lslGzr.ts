import { Config } from '../type';
import fragment from './glsl/lslGzr.glsl?raw';
export default [
  {
    // 'lslGzr': 'The Triforce',
    name: 'lslGzr',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
