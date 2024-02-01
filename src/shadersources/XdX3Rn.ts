import { Config } from '../type';
import fragment from './glsl/XdX3Rn.glsl?raw';
export default [
  {
    // 'XdX3Rn': 'Kinderpainter (made in 2006)',
    name: 'XdX3Rn',
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
