import { Config } from '../type';
import fragment from './glsl/4ttGDH.glsl?raw';
export default [
  {
    // '4ttGDH': 'Abstract Glassy Field',
    name: '4ttGDH',
    type: 'image',
    fragment,
    channels: [
      { type: 'texture', src: 'Pebbles', filter: 'mipmap', wrap: 'repeat' },
      { type: 'texture', src: 'Organic2', filter: 'mipmap', wrap: 'repeat' },
    ],
  },
] as Config[];
