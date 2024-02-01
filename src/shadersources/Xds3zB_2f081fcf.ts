import { Config } from '../type'
import fragment from './glsl/Xds3zB_2f081fcf.glsl?raw'
export default [

                        {
                            // 'Xds3zB': 'Holiday moon',
                            name: 'Xds3zB',
                            type: 'image',
                            fragment,
                            channels: [{"type":"texture","src":"Organic2","filter":"mipmap","wrap":"repeat","noFlip":true}]
                        },
] as Config[]