import { Config } from '../type';
import fragment from './glsl/MslGzr.glsl?raw';
export default [
  {
    // 'MslGzr': 'Blueorange',
    name: 'MslGzr',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }],
  },
] as Config[];
