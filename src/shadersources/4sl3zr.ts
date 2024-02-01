import { Config } from '../type';
import fragment from './glsl/4sl3zr.glsl?raw';
export default [
  {
    // '4sl3zr': 'pixelate',
    name: '4sl3zr',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }],
  },
] as Config[];
