import { Config } from '../type';
import fragment from './glsl/Ms3XWN.glsl?raw';
import A from './glsl/Ms3XWN_A.glsl?raw';
import B from './glsl/Ms3XWN_B.glsl?raw';
import Common from './glsl/Ms3XWN_common.glsl?raw';
export default [
  {
    // 'Ms3XWN': 'Pacman Game',
    name: 'Ms3XWN',
    type: 'image',
    fragment,
    channels: [
      { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
      { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
    ],
  },

  {
    name: 'Buffer A',
    type: 'buffer',
    fragment: A,
    channels: [
      { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
      { type: 'keyboard' },
    ],
  },

  {
    name: 'Buffer B',
    type: 'buffer',
    fragment: B,
    channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
  },

  {
    name: 'Common',
    type: 'common',
    fragment: Common,
  },
] as Config[];
