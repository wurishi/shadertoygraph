import { Config } from '../type';
import fragment from './glsl/XdlGzn.glsl?raw';
export default [
  {
    // 'XdlGzn': 'Rasterizer - Cube',
    name: 'XdlGzn',
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
        src: 'Wood',
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
