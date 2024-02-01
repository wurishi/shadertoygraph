import { Config } from '../type';
import fragment from './glsl/lsfGRr.glsl?raw';
export default [
  {
    // 'lsfGRr': 'Beautypi',
    name: 'lsfGRr',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
