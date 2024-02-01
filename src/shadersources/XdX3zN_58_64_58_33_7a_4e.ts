import { Config } from '../type';
import fragment from './glsl/XdX3zN_58_64_58_33_7a_4e.glsl?raw';
export default [
  {
    // 'XdX3zN': 'Flying Logo',
    name: 'XdX3zN',
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
    ],
  },
] as Config[];
