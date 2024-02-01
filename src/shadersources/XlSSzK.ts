import { Config } from '../type';
import fragment from './glsl/XlSSzK.glsl?raw';
export default [
  {
    // 'XlSSzK': 'Sun surface',
    name: 'XlSSzK',
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
