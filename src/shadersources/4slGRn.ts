import { Config } from '../type';
import fragment from './glsl/4slGRn.glsl?raw';
export default [
  {
    // '4slGRn': 'Alien in London',
    name: '4slGRn',
    type: 'image',
    fragment,
    channels: [
      { type: 'texture', src: 'London', filter: 'mipmap', wrap: 'repeat' },
    ],
  },
] as Config[];
