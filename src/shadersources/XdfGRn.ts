import { Config } from '../type';
import fragment from './glsl/XdfGRn.glsl?raw';
export default [
  {
    // 'XdfGRn': 'Apple',
    name: 'XdfGRn',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
