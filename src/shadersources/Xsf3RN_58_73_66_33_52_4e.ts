import { Config } from '../type';
import fragment from './glsl/Xsf3RN_58_73_66_33_52_4e.glsl?raw';
export default [
  {
    // 'Xsf3RN': 'Night vision device',
    name: 'Xsf3RN',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }],
  },
] as Config[];
