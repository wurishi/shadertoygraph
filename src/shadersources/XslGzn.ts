import { Config } from '../type';
import fragment from './glsl/XslGzn.glsl?raw';
export default [
  {
    // 'XslGzn': 'CPU intro!',
    name: 'XslGzn',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
