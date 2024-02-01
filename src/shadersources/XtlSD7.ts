import { Config } from '../type'

import fragment from './glsl/XtlSD7.glsl?raw'
import s from './glsl/XtlSD7_s.glsl?raw'

export default [
    {
        name: 'XtlSD7',
        type: 'image',
        fragment,
    },
    {
        type: 'sound',
        fragment: s,
    },
] as Config[]
