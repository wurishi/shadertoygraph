import { Config } from '../type';
import fragment from './glsl/Xsl3zr.glsl?raw';
export default [
  {
    // 'Xsl3zr': 'little fluffy clouds',
    name: 'Xsl3zr',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
