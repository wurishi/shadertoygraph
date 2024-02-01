import { Config } from '../type';
import fragment from './glsl/MsXGz4_4d_73_58_47_7a_34.glsl?raw';
export default [
  {
    // 'MsXGz4': 'Cubemaps',
    name: 'MsXGz4',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'cubemap',
        map: 'Gallery',
        filter: 'linear',
        wrap: 'clamp',
        noFlip: true,
      },
      {
        type: 'cubemap',
        map: 'GalleryB',
        filter: 'linear',
        wrap: 'clamp',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'Organic1',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'Lichen',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[];
