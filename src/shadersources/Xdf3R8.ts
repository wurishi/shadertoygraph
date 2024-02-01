import { Config } from '../type';
import fragment from './glsl/Xdf3R8.glsl?raw';
export default [
  {
    // 'Xdf3R8': 'Fl0wer',
    name: 'Xdf3R8',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
