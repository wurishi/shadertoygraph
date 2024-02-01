import { Config } from '../type';
import fragment from './glsl/MdfGzr.glsl?raw';
export default [
  {
    // 'MdfGzr': 'Sierpinski plus',
    name: 'MdfGzr',
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
    ],
  },
] as Config[];
