import { Config } from '../type';
import fragment from './glsl/ldXGz4_6c_64_58_47_7a_34.glsl?raw';
export default [
  {
    // 'ldXGz4': 'water-horizontal',
    name: 'ldXGz4',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Abstract1',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
