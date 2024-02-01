import { Config } from '../type';
import fragment from './glsl/4sf3RH.glsl?raw';
export default [
  {
    // '4sf3RH': 'spectrum circle starter',
    name: '4sf3RH',
    type: 'image',
    fragment,
    channels: [{ type: 'music' }],
  },
] as Config[];
