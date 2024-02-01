import { Config } from '../type';

import fragment from './glsl/lllBDM.glsl?raw';
import A from './glsl/lllBDM_a.glsl?raw';
import B from './glsl/lllBDM_b.glsl?raw';

export default [
  {
    name: 'lllBDM',
    type: 'image',
    fragment,
    channels: [{ type: 'buffer', id: 1 }],
  },
  {
    type: 'buffer',
    fragment: A,
  },
  {
    type: 'buffer',
    fragment: B,
    channels: [{ type: 'buffer', id: 0 }],
  },
] as Config[];
