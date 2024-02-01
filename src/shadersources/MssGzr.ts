import { Config } from '../type';
import fragment from './glsl/MssGzr.glsl?raw';
export default [
  {
    // 'MssGzr': 'R.E.D. - final scene',
    name: 'MssGzr',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
