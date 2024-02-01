import { Config } from '../type';
import fragment from './glsl/lslGR4_6c_73_6c_47_52_34.glsl?raw';
export default [
  {
    // 'lslGR4': 'Chalk stroke',
    name: 'lslGR4',
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
