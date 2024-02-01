import { Config } from '../type';
import fragment from './glsl/Xss3zr.glsl?raw';
export default [
  {
    // 'Xss3zr': 'video heightfield',
    name: 'Xss3zr',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }],
  },
] as Config[];
