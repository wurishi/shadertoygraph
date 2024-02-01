import { Config } from '../type';
import fragment from './glsl/MsfGRn.glsl?raw';
export default [
  {
    // 'MsfGRn': 'Burn',
    name: 'MsfGRn',
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
