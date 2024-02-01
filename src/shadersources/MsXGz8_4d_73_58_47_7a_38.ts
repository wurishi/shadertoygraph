import { Config } from '../type';
import fragment from './glsl/MsXGz8_4d_73_58_47_7a_38.glsl?raw';
export default [
  {
    // 'MsXGz8': 'Isolines',
    name: 'MsXGz8',
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
      { type: 'music' },
    ],
  },
] as Config[];
