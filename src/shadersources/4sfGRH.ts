import { Config } from '../type';
import fragment from './glsl/4sfGRH.glsl?raw';
export default [
  {
    // '4sfGRH': 'TextCandy',
    name: '4sfGRH',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
