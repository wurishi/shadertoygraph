import { Config } from '../type';
import fragment from './glsl/Xt3SR4.glsl?raw';
import A from './glsl/Xt3SR4_A.glsl?raw';
export default [
  {
    // 'Xt3SR4': 'Interactive thinks',
    name: 'Xt3SR4',
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
      { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
    ],
  },

  {
    name: 'Buffer A',
    type: 'buffer',
    fragment: A,
    channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
  },
] as Config[];
