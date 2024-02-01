import { Config } from '../type';
import fragment from './glsl/MsX3zN_4d_73_58_33_7a_4e.glsl?raw';
export default [
  {
    // 'MsX3zN': 'Test Refraction',
    name: 'MsX3zN',
    type: 'image',
    fragment,
    channels: [
      { type: 'texture', src: 'London', filter: 'mipmap', wrap: 'repeat' },
      {
        type: 'texture',
        src: 'RGBANoiseSmall',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
