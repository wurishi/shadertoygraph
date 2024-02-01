import { Config } from '../type'
import fragment from './glsl/Mds3z2_2c16fddb.glsl?raw'
export default [
  {
    // 'Mds3z2': 'Bridge',
    name: 'Mds3z2',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'texture',
        src: 'RockTiles',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'Organic2',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
      {
        type: 'texture',
        src: 'RGBANoiseMedium',
        filter: 'mipmap',
        wrap: 'repeat',
        noFlip: true,
      },
    ],
  },
] as Config[]
