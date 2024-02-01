import { Config } from '../type';
import fragment from './glsl/Mdl3zn.glsl?raw';
export default [
  {
    // 'Mdl3zn': 'depth',
    name: 'Mdl3zn',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
