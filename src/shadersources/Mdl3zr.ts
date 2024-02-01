import { Config } from '../type';
import fragment from './glsl/Mdl3zr.glsl?raw';
export default [
  {
    // 'Mdl3zr': 'Round sound',
    name: 'Mdl3zr',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
