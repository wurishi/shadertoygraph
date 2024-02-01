import { Config } from '../type'
import fragment from './glsl/Xs2GDd.glsl?raw'
export default [
    {
        // 'Xs2GDd': '[SH2014] Cellular',
        name: 'Xs2GDd',
        type: 'image',
        fragment,
        channels: [],
    },
] as Config[]
