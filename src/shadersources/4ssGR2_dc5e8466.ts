import { Config } from '../type'
import fragment from './glsl/4ssGR2_dc5e8466.glsl?raw'
export default [
  {
    // '4ssGR2': 'mengerSponge',
    name: '4ssGR2',
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
] as Config[]
