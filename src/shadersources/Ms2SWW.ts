import { Config } from '../type';
import fragment from './glsl/Ms2SWW.glsl?raw';
export default [
  {
    // 'Ms2SWW': 'Deform - square tunnel',
    name: 'Ms2SWW',
    type: 'image',
    fragment,
    channels: [{ type: 'texture', src: 'RustyMetal', filter: 'mipmap', wrap: 'repeat' }],
  },
] as Config[];
