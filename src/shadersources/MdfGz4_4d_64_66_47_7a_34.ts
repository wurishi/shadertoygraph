import { Config } from '../type';
import fragment from './glsl/MdfGz4_4d_64_66_47_7a_34.glsl?raw';
export default [
  {
    // 'MdfGz4': 'CRT',
    name: 'MdfGz4',
    type: 'image',
    fragment,
    channels: [
      { type: 'video' },
      {
        type: 'texture',
        src: 'GrayNoiseMedium',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
