import { Config } from '../type';
import fragment from './glsl/XdfGzn.glsl?raw';
export default [
  {
    // 'XdfGzn': 'Deform - rotozoom',
    name: 'XdfGzn',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'Abstract2',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
