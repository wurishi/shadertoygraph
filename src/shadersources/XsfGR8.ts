import { Config } from '../type';
import fragment from './glsl/XsfGR8.glsl?raw';
export default [
  {
    // 'XsfGR8': 'Mandelbulb',
    name: 'XsfGR8',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
