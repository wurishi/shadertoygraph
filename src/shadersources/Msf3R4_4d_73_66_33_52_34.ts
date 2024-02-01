import { Config } from '../type';
import fragment from './glsl/Msf3R4_4d_73_66_33_52_34.glsl?raw';
export default [
  {
    // 'Msf3R4': 'spectrum_mod',
    name: 'Msf3R4',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
