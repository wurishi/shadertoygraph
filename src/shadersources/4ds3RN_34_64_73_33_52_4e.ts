import { Config } from '../type';
import fragment from './glsl/4ds3RN_34_64_73_33_52_4e.glsl?raw';
export default [
  {
    // '4ds3RN': 'Cubemap Shading',
    name: '4ds3RN',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'cubemap',
        map: 'Basilica',
        filter: 'linear',
        wrap: 'clamp',
        noFlip: true,
      },
      {
        type: 'cubemap',
        map: 'BasilicaBlur',
        filter: 'linear',
        wrap: 'clamp',
        noFlip: true,
      },
    ],
  },
] as Config[];
