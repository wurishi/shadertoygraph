import { Config } from '../type';
import fragment from './glsl/MdSGDm.glsl?raw';
export default [
  {
    // 'MdSGDm': 'Analytic Motionblur 2D',
    name: 'MdSGDm',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
