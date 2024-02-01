import { Config } from '../type';
import fragment from './glsl/Mds3Rr.glsl?raw';
export default [
  {
    // 'Mds3Rr': 'Frosted Torus',
    name: 'Mds3Rr',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
