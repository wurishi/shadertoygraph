import { Config } from '../type';
import fragment from './glsl/XdlGzr.glsl?raw';
export default [
  {
    // 'XdlGzr': 'Gameboy ',
    name: 'XdlGzr',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
