import { Config } from '../type'
import fragment from './glsl/MsXGRf_eb4665bd.glsl?raw'
export default [
  {
    // 'MsXGRf': 'Flames',
    name: 'MsXGRf',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'RGBANoiseMedium',
        filter: 'linear',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[]
