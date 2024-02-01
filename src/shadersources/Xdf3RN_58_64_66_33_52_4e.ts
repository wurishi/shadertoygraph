import { Config } from '../type';
import fragment from './glsl/Xdf3RN_58_64_66_33_52_4e.glsl?raw';
export default [
  {
    // 'Xdf3RN': 'Contrast',
    name: 'Xdf3RN',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }],
  },
] as Config[];
