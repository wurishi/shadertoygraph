import { Config } from "../type";

import fragment from './glsl/lsySzd.glsl?raw'

export default [
  {
    name:'lsySzd',
    type:'image',
    fragment,
    channels: [
      {type:'texture', src:'RGBANoiseMedium', filter:'linear', noFlip: true},
      {type:'keyboard'},
      {type:'texture', src:'GrayNoiseSmall', filter:'linear', noFlip: true}
    ]
  }
] as Config[]