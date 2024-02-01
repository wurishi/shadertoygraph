import { Config } from '../type';
import fragment from './glsl/Xd23zh.glsl?raw';
export default [
  {
    // 'Xd23zh': 'Storm',
    name: 'Xd23zh',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'RGBANoiseMedium',
        filter: 'linear',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
