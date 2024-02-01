import { Config } from '../type';
import fragment from './glsl/XdlSDs.glsl?raw';
export default [
  {
    // 'XdlSDs': '[SIG2014] - Total Noob',
    name: 'XdlSDs',
    type: 'image',
    fragment,
    channels: [],
  },
] as Config[];
