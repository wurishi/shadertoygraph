import { Config } from '../type';
import fragment from './glsl/MdKXzc.glsl?raw';
export default [
  {
    // 'MdKXzc': 'Supernova remnant',
    name: 'MdKXzc',
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
      { type: 'keyboard' },
      {
        type: 'texture',
        src: 'GrayNoiseMedium',
        filter: 'linear',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
