import { Config } from '../type'

import fragment from './glsl/4tdSWr.glsl?raw'

export default [
    {
        name: '4tdSWr',
        type: 'image',
        fragment,
    },
] as Config[]
