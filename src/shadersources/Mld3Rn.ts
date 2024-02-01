import { Config } from "../type";

import fragment from './glsl/Mld3Rn.glsl?raw'

export default [
  {
    name: 'Mld3Rn',
    type:'image',
    fragment,
    channels: [
      {type:'texture', src:'London'}
    ]
  }
] as Config[]