import { Config } from '../type';

import fragment from './glsl/XlBSRz.glsl?raw';

export default [
  {
    name: 'XlBSRz',
    type: 'image',
    fragment,
    channels: [{ type: 'texture', src: 'GrayNoiseSmall' }],
  },
] as Config[];
