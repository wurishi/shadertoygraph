import { Config } from '../type';
import fragment from './glsl/Mdf3RN_4d_64_66_33_52_4e.glsl?raw';
export default [
  {
    // 'Mdf3RN': 'Audio heightfield 2',
    name: 'Mdf3RN',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
