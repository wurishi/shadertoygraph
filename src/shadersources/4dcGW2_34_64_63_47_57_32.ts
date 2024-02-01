import { Config } from '../type';
import fragment from './glsl/4dcGW2_34_64_63_47_57_32.glsl?raw';
import A from './glsl/4dcGW2_34_64_63_47_57_32_A.glsl?raw';
import B from './glsl/4dcGW2_34_64_63_47_57_32_B.glsl?raw';
import C from './glsl/4dcGW2_34_64_63_47_57_32_C.glsl?raw';
import D from './glsl/4dcGW2_34_64_63_47_57_32_D.glsl?raw';
export default [
  {
    // '4dcGW2': ' expansive reaction-diffusion',
    name: '4dcGW2',
    type: 'image',
    fragment,
    channels: [
      { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
      { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
      { type: 'Empty' },
      {
        type: 'texture',
        src: 'RGBANoiseMedium',
        filter: 'mipmap',
        wrap: 'repeat',
      },
    ],
  },

  {
    name: 'Buffer A',
    type: 'buffer',
    fragment: A,
    channels: [
      { type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' },
      { type: 'buffer', id: 2, filter: 'linear', wrap: 'clamp' },
      { type: 'buffer', id: 3, filter: 'linear', wrap: 'clamp' },
      {
        type: 'texture',
        src: 'RGBANoiseMedium',
        filter: 'mipmap',
        wrap: 'repeat',
      },
    ],
  },

  {
    name: 'Buffer B',
    type: 'buffer',
    fragment: B,
    channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
  },

  {
    name: 'Buffer C',
    type: 'buffer',
    fragment: C,
    channels: [{ type: 'buffer', id: 1, filter: 'linear', wrap: 'clamp' }],
  },

  {
    name: 'Buffer D',
    type: 'buffer',
    fragment: D,
    channels: [{ type: 'buffer', id: 0, filter: 'linear', wrap: 'clamp' }],
  },
] as Config[];
