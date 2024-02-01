import { Config } from '../type';
import fragment from './glsl/Xsf3RH.glsl?raw';
export default [
  {
    // 'Xsf3RH': 'jit.gl.pix exporting test',
    name: 'Xsf3RH',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
