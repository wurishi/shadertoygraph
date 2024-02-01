import { Config } from '../type';
import fragment from './glsl/lsX3Rr.glsl?raw';
export default [
  {
    // 'lsX3Rr': 'Nyan Cat',
    name: 'lsX3Rr',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Nyancat',
        filter: 'nearest',
        wrap: 'clamp',
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
