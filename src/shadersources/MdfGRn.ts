import { Config } from '../type';
import fragment from './glsl/MdfGRn.glsl?raw';
export default [
  {
    // 'MdfGRn': 'Vorotissue',
    name: 'MdfGRn',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
