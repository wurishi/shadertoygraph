import { Config } from '../type';
import fragment from './glsl/lsf3R4_6c_73_66_33_52_34.glsl?raw';
export default [
  {
    // 'lsf3R4': 'Wavy Texture Shader',
    name: 'lsf3R4',
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
    ],
  },
] as Config[];
