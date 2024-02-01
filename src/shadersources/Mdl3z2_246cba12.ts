import { Config } from '../type'
import fragment from './glsl/Mdl3z2_246cba12.glsl?raw'
export default [
  {
    // 'Mdl3z2': 'planet ocean',
    name: 'Mdl3z2',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'RustyMetal',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'cubemap',
        map: 'Gallery',
        filter: 'linear',
        wrap: 'clamp',
        noFlip: true,
      },
    ],
  },
] as Config[]
