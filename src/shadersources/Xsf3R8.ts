import { Config } from '../type';
import fragment from './glsl/Xsf3R8.glsl?raw';
export default [
  {
    // 'Xsf3R8': 'Point light and Plane',
    name: 'Xsf3R8',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'RockTiles',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
