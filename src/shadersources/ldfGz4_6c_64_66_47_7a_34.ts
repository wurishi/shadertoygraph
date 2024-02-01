import { Config } from '../type';
import fragment from './glsl/ldfGz4_6c_64_66_47_7a_34.glsl?raw';
export default [
  {
    // 'ldfGz4': 'Blur Banding Redux',
    name: 'ldfGz4',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'London',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'Bayer',
        filter: 'nearest',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
