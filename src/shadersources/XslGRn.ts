import { Config } from '../type';
import fragment from './glsl/XslGRn.glsl?raw';
export default [
  {
    // 'XslGRn': 'Nyan and Britney Take London',
    name: 'XslGRn',
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
        src: 'London',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      { type: 'video' },
    ],
  },
] as Config[];
