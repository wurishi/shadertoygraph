import { Config } from '../type';
import fragment from './glsl/4sXGRn.glsl?raw';
export default [
  {
    // '4sXGRn': 'Deform - relief tunnel',
    name: '4sXGRn',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Organic1',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
