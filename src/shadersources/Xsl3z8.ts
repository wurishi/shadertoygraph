import { Config } from '../type'
import fragment from './glsl/Xsl3z8.glsl?raw'
export default [
    {
        // 'Xsl3z8': 'Color Zebra',
        name: 'Xsl3z8',
        type: 'image',
        fragment,
        channels: [{ type: 'video' }],
    },
] as Config[]
