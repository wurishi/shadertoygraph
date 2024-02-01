import { Config } from '../type';
import fragment from './glsl/Md3yRB.glsl?raw';
import Common from './glsl/Md3yRB_common.glsl?raw';
import A from './glsl/Md3yRB_A.glsl?raw';
import B from './glsl/Md3yRB_B.glsl?raw';
export default [
  {
    // 'Md3yRB': 'Wythoff explorer',
    name: 'Md3yRB',
    type: 'image',
    fragment,
    channels: [
      { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
      { type: 'buffer', id: 1, filter: 'linear', wrap: 'repeat' },
      { type: 'texture', src: 'Font1', filter: 'mipmap', wrap: 'repeat' },
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
    channels: [
      { type: 'buffer', id: 0, filter: 'nearest', wrap: 'clamp' },
      { type: 'keyboard' },
    ],
  },

  {
    name: 'Buffer B',
    type: 'buffer',
    fragment: B,
    channels: [
      { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
      { type: 'texture', src: 'Font1', filter: 'mipmap', wrap: 'repeat' },
    ],
  },
] as Config[];
