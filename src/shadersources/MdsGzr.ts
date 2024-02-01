import { Config } from '../type';
import fragment from './glsl/MdsGzr.glsl?raw';
import Sound from './glsl/MdsGzr_sound.glsl?raw';
export default [
  {
    // 'MdsGzr': 'Mostly Harmless',
    name: 'MdsGzr',
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
