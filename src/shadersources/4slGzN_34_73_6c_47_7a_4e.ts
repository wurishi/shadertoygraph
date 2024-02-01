import { Config } from '../type';
import fragment from './glsl/4slGzN_34_73_6c_47_7a_4e.glsl?raw';
export default [
  {
    // '4slGzN': 'My SpotLight',
    name: '4slGzN',
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
