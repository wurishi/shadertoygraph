import { Config } from '../type';
import fragment from './glsl/XdXGzn.glsl?raw';
export default [
  {
    // 'XdXGzn': 'Deform - square tunnel II',
    name: 'XdXGzn',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'RustyMetal',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      { type: 'texture', src: 'Wood', filter: 'mipmap', wrap: 'repeat' },
    ],
  },
] as Config[];
