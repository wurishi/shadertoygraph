import { Config } from '../type';
import fragment from './glsl/4ssGzn.glsl?raw';
export default [
  {
    // '4ssGzn': 'Fire2',
    name: '4ssGzn',
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
