import { Config } from '../type';
import fragment from './glsl/Msl3zr.glsl?raw';
export default [
  {
    // 'Msl3zr': 'led spectrum analyser',
    name: 'Msl3zr',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
