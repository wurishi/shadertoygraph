import { Config } from '../type';
import fragment from './glsl/lsX3R4_6c_73_58_33_52_34.glsl?raw';
export default [
  {
    // 'lsX3R4': 'Simplest raytracing',
    name: 'lsX3R4',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Wood',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
