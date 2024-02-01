import { Config } from '../type';
import fragment from './glsl/MlKSWm.glsl?raw';
export default [
  {
    // 'MlKSWm': 'Sparks drifting',
    name: 'MlKSWm',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
