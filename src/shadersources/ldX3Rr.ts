import { Config } from '../type';
import fragment from './glsl/ldX3Rr.glsl?raw';
export default [
  {
    // 'ldX3Rr': 'Yin Yang',
    name: 'ldX3Rr',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
