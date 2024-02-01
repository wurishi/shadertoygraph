import { Config } from '../type';
import fragment from './glsl/XdlGRr.glsl?raw';
export default [
  {
    // 'XdlGRr': 'Julia - mare version',
    name: 'XdlGRr',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
