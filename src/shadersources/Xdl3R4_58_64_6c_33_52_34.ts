import { Config } from '../type';
import fragment from './glsl/Xdl3R4_58_64_6c_33_52_34.glsl?raw';
export default [
  {
    // 'Xdl3R4': 'Cell',
    name: 'Xdl3R4',
    type: 'image',
    fragment,
    channels: [
      { type: 'music' },
      {
        type: 'cubemap',
        map: 'Forest',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'RGBANoiseMedium',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'Stars',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
