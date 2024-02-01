import { Config } from '../type';
import fragment from './glsl/XdfGzH.glsl?raw';
export default [
  {
    // 'XdfGzH': 'post: Screen Distort',
    name: 'XdfGzH',
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
