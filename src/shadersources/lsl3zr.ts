import { Config } from '../type';
import fragment from './glsl/lsl3zr.glsl?raw';
export default [
  {
    // 'lsl3zr': 'codelifeclone@0:44',
    name: 'lsl3zr',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
