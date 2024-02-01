import { Config } from '../type';
import fragment from './glsl/4df3R8.glsl?raw';
export default [
  {
    // '4df3R8': 'Audio Fl0wer',
    name: '4df3R8',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
