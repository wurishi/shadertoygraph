import { Config } from '../type';
import fragment from './glsl/4sXGzn.glsl?raw';
export default [
  {
    // '4sXGzn': 'Deform - holes',
    name: '4sXGzn',
    type: 'image',
    fragment,
    channels: [
      { type: 'texture', src: 'Stars', filter: 'mipmap', wrap: 'repeat' },
    ],
  },
] as Config[];
