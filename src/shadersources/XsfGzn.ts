import { Config } from '../type';
import fragment from './glsl/XsfGzn.glsl?raw';
export default [
  {
    // 'XsfGzn': 'Matte compositing',
    name: 'XsfGzn',
    type: 'image',
    fragment,
    channels: [{ type: 'video' }, { type: 'video' }],
  },
] as Config[];
