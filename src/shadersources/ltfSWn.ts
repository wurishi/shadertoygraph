import { Config } from '../type';
import fragment from './glsl/ltfSWn.glsl?raw';
export default [
  {
    // 'ltfSWn': 'Mandelbulb - derivative',
    name: 'ltfSWn',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
