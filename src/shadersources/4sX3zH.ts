import { Config } from '../type';
import fragment from './glsl/4sX3zH.glsl?raw';
export default [
  {
    // '4sX3zH': 'Blobs'n Goo',
    name: '4sX3zH',
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
