import { Config } from '../type'
import fragment from './glsl/MdfGRX_e813bc16.glsl?raw'
export default [
  {
    // 'MdfGRX': 'Hell',
    name: 'MdfGRX',
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
