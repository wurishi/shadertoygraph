import { Config } from '../type';
import fragment from './glsl/4dfGzn.glsl?raw';
export default [
  {
    // '4dfGzn': 'Postprocessing',
    name: '4dfGzn',
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
