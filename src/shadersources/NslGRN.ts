import { Config } from "../type";

import fragment from './glsl/NslGRN.glsl?raw'

export default [
  {
    name:'NslGRN',
    type:'image',
    fragment,
    channels: [
      {type:'texture', src:'London'}
    ]
  }
] as Config[]