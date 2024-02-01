import { Config } from '../type';
import fragment from './glsl/XdX3z4_58_64_58_33_7a_34.glsl?raw';
export default [
  {
    // 'XdX3z4': 'Simple Modulation Example',
    name: 'XdX3z4',
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
