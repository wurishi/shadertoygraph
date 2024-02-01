import { Config } from '../type';
import fragment from './glsl/MdfGRr.glsl?raw';
export default [
  {
    // 'MdfGRr': 'Juliabulb - derivative',
    name: 'MdfGRr',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
