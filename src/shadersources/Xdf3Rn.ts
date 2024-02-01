import { Config } from '../type';
import fragment from './glsl/Xdf3Rn.glsl?raw';
export default [
  {
    // 'Xdf3Rn': 'Deform - z invert',
    name: 'Xdf3Rn',
    type: 'image',
    fragment,
    channels: [{ type: 'texture', src: 'Abstract2', filter: 'mipmap', wrap: 'repeat' }],
  },
] as Config[];
