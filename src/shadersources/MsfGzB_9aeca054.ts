import { Config } from '../type'
import fragment from './glsl/MsfGzB_9aeca054.glsl?raw'
export default [

                        {
                            // 'MsfGzB': 'yet another metaballs',
                            name: 'MsfGzB',
                            type: 'image',
                            fragment,
                            channels: [{"type":"texture","src":"RGBANoiseMedium","filter":"mipmap","wrap":"repeat","noFlip":true},{"type":"cubemap","map":"Basilica","filter":"linear","wrap":"clamp","noFlip":true}]
                        },
] as Config[]