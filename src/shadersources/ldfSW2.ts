import { Config } from '../type';
import fragment from './glsl/ldfSW2.glsl?raw';
import Sound from './glsl/ldfSW2_sound.glsl?raw';
export default [
  {
    // 'ldfSW2': 'sound - acid jam',
    name: 'ldfSW2',
    type: 'image',
    fragment,
    channels: [],
  },

  {
    name: 'Sound',
    type: 'sound',
    fragment: Sound,
  },
] as Config[];
