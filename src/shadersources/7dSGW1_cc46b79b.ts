import { Config } from '../type';
import fragment from './glsl/7dSGW1_cc46b79b.glsl?raw';
import Common from './glsl/7dSGW1_cc46b79b_common.glsl?raw';
import A from './glsl/7dSGW1_cc46b79b_A.glsl?raw';
import B from './glsl/7dSGW1_cc46b79b_B.glsl?raw';
export default [
  {
    // '7dSGW1': 'Green Field Diorama',
    name: '7dSGW1',
    type: 'image',
    fragment,
    channels: [
      { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
      { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
    ],
  },

  {
    name: 'Common',
    type: 'common',
    fragment: Common,
  },

  {
    name: 'Buffer A',
    type: 'buffer',
    fragment: A,
    channels: [],
  },

  {
    name: 'Buffer B',
    type: 'buffer',
    fragment: B,
    channels: [
      { type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' },
      { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
    ],
  },
] as Config[];
