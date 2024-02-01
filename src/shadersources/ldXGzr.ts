import { Config } from '../type';
import fragment from './glsl/ldXGzr.glsl?raw';
export default [
  {
    // 'ldXGzr': 'Mouse Scroller',
    name: 'ldXGzr',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Organic2',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
