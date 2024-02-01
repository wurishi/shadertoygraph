import { Config } from '../type';
import fragment from './glsl/4sXGR8.glsl?raw';
export default [
  {
    // '4sXGR8': 'string',
    name: '4sXGR8',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
