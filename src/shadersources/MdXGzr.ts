import { Config } from '../type';
import fragment from './glsl/MdXGzr.glsl?raw';
export default [
  {
    // 'MdXGzr': 'Texture vortex',
    name: 'MdXGzr',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'London',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
