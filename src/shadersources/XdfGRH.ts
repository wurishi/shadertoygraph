import { Config } from '../type';
import fragment from './glsl/XdfGRH.glsl?raw';
export default [
  {
    // 'XdfGRH': 'Dancing Metalights',
    name: 'XdfGRH',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
