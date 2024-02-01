import { Config } from '../type'
import fragment from './glsl/ldX3RX_67ef259b.glsl?raw'
export default [
  {
    // 'ldX3RX': 'Exterminate!',
    name: 'ldX3RX',
    type: 'image',
    fragment,
    channels: [
      {
        type: 'cubemap',
        map: 'Basilica',
        filter: 'linear',
        wrap: 'clamp',
        noFlip: true,
      },
    ],
  },
] as Config[]
