import { Config } from '../type';
import fragment from './glsl/ldScDh.glsl?raw';
import A from './glsl/ldScDh_A.glsl?raw';
export default [
  {
    // 'ldScDh': 'Greek Temple',
    name: 'ldScDh',
    type: 'image',
    fragment,
    channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
  },

  {
    name: 'Buffer A',
    type: 'buffer',
    fragment: A,
    channels: [
      { type: 'texture', src: 'Organic3', filter: 'mipmap', wrap: 'repeat' },
      {
        type: 'texture',
        src: 'RGBANoiseMedium',
        filter: 'linear',
        wrap: 'repeat',
        noFlip: true,
      },
      { type: 'texture', src: 'Abstract1', filter: 'mipmap', wrap: 'repeat' },
      { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
    ],
  },
] as Config[];
