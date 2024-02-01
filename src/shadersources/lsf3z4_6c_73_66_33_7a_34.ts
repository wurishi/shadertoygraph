import { Config } from '../type';
import fragment from './glsl/lsf3z4_6c_73_66_33_7a_34.glsl?raw';
export default [
  {
    // 'lsf3z4': 'BadTV',
    name: 'lsf3z4',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }],
  },
] as Config[];
