import { Config } from '../type';
import fragment from './glsl/lss3zr.glsl?raw';
export default [
  {
    // 'lss3zr': 'Volume raycasting',
    name: 'lss3zr',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
