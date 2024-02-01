import { Config } from '../type';
import fragment from './glsl/4sl3z4_34_73_6c_33_7a_34.glsl?raw';
export default [
  {
    // '4sl3z4': 'Moonlight',
    name: '4sl3z4',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'RGBANoiseMedium',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
