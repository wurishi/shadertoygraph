import { Config } from '../type';
import fragment from './glsl/XsXSWS.glsl?raw';
export default [
  {
    // 'XsXSWS': 'Fires',
    name: 'XsXSWS',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
