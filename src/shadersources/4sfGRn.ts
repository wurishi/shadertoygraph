import { Config } from '../type';
import fragment from './glsl/4sfGRn.glsl?raw';
export default [
  {
    // '4sfGRn': 'Radial Blur',
    name: '4sfGRn',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Abstract1',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
