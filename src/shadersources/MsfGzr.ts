import { Config } from '../type';
import fragment from './glsl/MsfGzr.glsl?raw';
export default [
  {
    // 'MsfGzr': 'To the road of ribbon',
    name: 'MsfGzr',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
