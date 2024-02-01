import { Config } from '../type'

import fragment from './glsl/XtGGRt.glsl?raw'

export default [
    {
        name: 'XtGGRt',
        type: 'image',
        fragment,
    },
] as Config[]
