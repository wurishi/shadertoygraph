import { Config } from '../type';
import fragment from './glsl/4df3RH.glsl?raw';
export default [
  {
    // '4df3RH': 'jittering: Blur aliasing',
    name: '4df3RH',
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
