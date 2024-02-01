import { Config } from '../type';
import fragment from './glsl/ldj3Dm.glsl?raw';
export default [
  {
    // 'ldj3Dm': 'Fish swimming',
    name: 'ldj3Dm',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Organic2',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'Abstract1',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'GrayNoiseSmall',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'Lichen',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
