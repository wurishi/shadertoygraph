import { Config } from '../type';
import fragment from './glsl/lsXGzH.glsl?raw';
export default [
  {
    // 'lsXGzH': 'Spout',
    name: 'lsXGzH',
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
