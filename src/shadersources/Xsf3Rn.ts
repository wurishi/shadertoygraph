import { Config } from '../type';
import fragment from './glsl/Xsf3Rn.glsl?raw';
export default [
  {
    // 'Xsf3Rn': 'Motion Blurred Texture',
    name: 'Xsf3Rn',
    type: 'image',
    fragment,
    channels: [{ type: 'texture', src: 'Organic2', filter: 'mipmap', wrap: 'repeat' }],
  },
] as Config[];
