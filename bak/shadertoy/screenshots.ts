import * as Type from './type'
import * as Utils from './utils'

export default function screenshots(): Type.Screenshots {
    const props: Type.ScreenshotsProps = {}

    return {
        Initialize: (renderer) => {
            const caps = renderer.GetCaps()
            const vsSourceC = `
            layout(location = 0) in vec2 pos;
            void main() {
                gl_Position = vec4(pos.xy, 0.0, 1.0);
            }`
            const fsSourceC = `
            uniform samplerCube t;
            out vec4 outColor;
            void main() {
                vec2 px = gl_FragCoord.xy / vec2(4096.0, 2048.0);
                vec2 an = 3.1415926535898 * (px * vec2(2.0, 1.0) - vec2(0.0, 0.5));
                vec3 rd = vec3(-cos(an.y) * sin(an.x), sin(an.y), cos(an.y) * cos(an.x));
                outColor = texture(t, rd);
            }`

            renderer.CreateShader(
                vsSourceC,
                fsSourceC,
                false,
                true,
                (result) => {
                    if (!result.succ) {
                        Utils.warn(
                            'screenshots.Initialize',
                            'CreateShader 失败',
                            result.errorType,
                            result.errorStr
                        )
                    } else {
                        props.mCubemapToEquirectProgram = result
                    }
                }
            )
        },
    }
}
