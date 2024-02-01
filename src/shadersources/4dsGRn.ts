import { Config } from '../type';
import fragment from './glsl/4dsGRn.glsl?raw';
export default [
  {
    // '4dsGRn': 'Ray tracer with volumetric light',
    name: '4dsGRn',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
