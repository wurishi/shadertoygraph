import { Config } from '../type';
import fragment from './glsl/4dSGW1.glsl?raw';
export default [
  {
    // '4dSGW1': 'Grid of Cylinders',
    name: '4dSGW1',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Organic1',
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
        src: 'GrayNoiseMedium',
        filter: 'linear',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'Wood',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
