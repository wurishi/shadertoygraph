import { Config } from '../type';
import fragment from './glsl/Mdl3z8_4d_64_6c_33_7a_38.glsl?raw';
export default [
  {
    // 'Mdl3z8': 'RedSpace',
    name: 'Mdl3z8',
    type: 'image',
    fragment,
    channels: [
      { type: 'Empty' },
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
