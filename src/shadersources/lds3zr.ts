import { Config } from '../type';
import fragment from './glsl/lds3zr.glsl?raw';
import A from './glsl/lds3zr_A.glsl?raw';
export default [
  {
    // 'lds3zr': 'Ribbons',
    name: 'lds3zr',
    type: 'image',
    fragment,
    channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
  },

  {
    name: 'Buffer A',
    type: 'buffer',
    fragment: A,
    channels: [{ type: 'music' }],
  },
] as Config[];
