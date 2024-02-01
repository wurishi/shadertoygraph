import { Config } from '../type';
import fragment from './glsl/4dXGRn.glsl?raw';
export default [
  {
    // '4dXGRn': 'Deform - star',
    name: '4dXGRn',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Abstract2',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
