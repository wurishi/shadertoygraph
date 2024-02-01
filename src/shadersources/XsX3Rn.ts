import { Config } from '../type';
import fragment from './glsl/XsX3Rn.glsl?raw';
export default [
  {
    // 'XsX3Rn': 'Deform - fly',
    name: 'XsX3Rn',
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
