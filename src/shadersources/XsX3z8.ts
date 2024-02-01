import { Config } from '../type';
import fragment from './glsl/XsX3z8.glsl?raw';
export default [
  {
    // 'XsX3z8': 'Video filters',
    name: 'XsX3z8',
    type: 'image',
    fragment,
    channels: [{ type: 'webcam', filter: 'linear', wrap: 'clamp' }],
  },
] as Config[];
