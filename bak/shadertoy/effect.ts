import EffectPass from './effectpass'
import renderer from './renderer'
import screenshots from './screenshots'
import * as Type from './type'
import * as Utils from './utils'

type UNKNOW = any

export default function effect(
    vr: UNKNOW,
    ac: UNKNOW,
    canvas: HTMLCanvasElement
): Type.Effect {
    const props: Type.EffectProps = {
        mMaxBuffers: 4,
        mMaxCubeBuffers: 1,
        mBuffers: [],
        mCubeBuffers: [],
        mMaxPasses: 0,
        mIsLowEnd: Utils.piIsMobile(),
    }
    props.mMaxPasses = props.mMaxBuffers + 1 + 1 + 1 + 1 // 4 buffers + common + Imagen + sound + cubemap

    initContext(props, canvas)
    createRenderer(props)

    const caps = props.mRenderer!.GetCaps()
    props.mShaderTextureLOD = caps.mShaderTextureLOD

    // if (ac !== null) {
    //     // TODO:
    // }

    createShader(props)
    initBuffers(props)

    initKeyboard(props)
    initResize(props)

    return {
        Load: (jobj) => {
            load(props, jobj)
        },
    }
}

function createGlContext(
    cv: HTMLCanvasElement,
    useAlpha: boolean,
    useDepth: boolean,
    usePreserveBuffer: boolean,
    useSupersampling: boolean
) {
    const opts = {
        alpha: useAlpha,
        depth: useDepth,
        stencil: false,
        premultipliedAlpha: false,
        antialias: useSupersampling,
        preserveDrawingBuffer: usePreserveBuffer,
        powerPreference: 'high-performance', // "low_power", "high_performance", "default"
    }

    // if( gl === null) gl = cv.getContext( "experimental-webgl2", opts );
    // if( gl === null) gl = cv.getContext( "webgl", opts );
    // if( gl === null) gl = cv.getContext( "experimental-webgl", opts );

    return cv.getContext('webgl2', opts)
}

function initContext(props: Type.EffectProps, canvas: HTMLCanvasElement) {
    const glContext = createGlContext(
        canvas,
        false,
        false,
        true,
        false
    ) as WebGL2RenderingContext

    // canvas.addEventListener(
    //     'webglcontextlost',
    //     (ev) => {
    //         ev.preventDefault()
    //         // TODO: crash
    //     },
    //     false
    // )

    props.mGlContext = glContext
}

function createRenderer(props: Type.EffectProps) {
    const glContext = props.mGlContext!

    const mRenderer = renderer()
    mRenderer.Initialize(glContext)

    const mScreenshotSytem = screenshots()
    mScreenshotSytem.Initialize(mRenderer)

    props.mRenderer = mRenderer
    props.mScreenshotSytem = mScreenshotSytem
}

function createShader(props: Type.EffectProps) {
    const mRenderer = props.mRenderer!

    const vsSourceC = `
    layout(location = 0) in vec2 pos;
    void main() {
        gl_Position = vec4(pos.xy, 0.0, 1.0);
    }
    `
    const fsSourceC = `
    uniform vec4 v;
    uniform sampler2D t;
    out vec4 outColor;
    void main() {
        outColor = textureLod(t, gl_FragCoord.xy / v.zw, 0.0);
    }
    `
    mRenderer.CreateShader(vsSourceC, fsSourceC, false, true, (result) => {
        if (result.succ) {
            props.programCopy = result
        } else {
            Utils.warn(
                'effect',
                '创建 programCopy 失败',
                result.errorType,
                result.errorStr
            )
        }
    })

    const vsSourceD = `
    layout(location = 0) in vec2 pos;
    void main() {
        gl_Position = vec4(pos.xy, 0.0, 1.0);
    }
    `
    const fsSourceD = `
    uniform vec4 v;
    uniform sampler2D t;
    out vec4 outColor;
    void main() {
        vec2 uv = gl_FragCoord.xy / v.zw;
        outColor = texture(t, vec2(uv.x, 1.0 - uv.y));
    }
    `
    mRenderer.CreateShader(vsSourceD, fsSourceD, false, true, (result) => {
        if (result.succ) {
            props.programDownscale = result
        } else {
            Utils.warn(
                'effect',
                '创建 programDownscale 失败',
                result.errorType,
                result.errorStr
            )
        }
    })
}

function initBuffers(props: Type.EffectProps) {
    const { mMaxBuffers, mMaxCubeBuffers } = props
    for (let i = 0; i < mMaxBuffers; i++) {
        props.mBuffers[i] = {
            mTexture: [null, null],
            mTarget: [null, null],
            mResolution: [0, 0],
            mLastRenderDone: 0,
            mThumbnailRenderTarget: null,
            mThumbnailTexture: null,
            mThumbnailBuffer: null,
            mThumbnailRes: [0, 0],
        }
    }
    for (let i = 0; i < mMaxCubeBuffers; i++) {
        props.mCubeBuffers[i] = {
            mTexture: [null, null],
            mTarget: [null, null],
            mResolution: [0, 0],
            mLastRenderDone: 0,
            mThumbnailRenderTarget: null,
            mThumbnailTexture: null,
            mThumbnailBuffer: null,
            mThumbnailRes: [0, 0],
        }
    }
}

function initKeyboard(props: Type.EffectProps) {
    // TODO:
}

function initResize(props: Type.EffectProps) {
    // TODO:
}

function load(props: Type.EffectProps, jobj: Type.ShaderToyInstance) {
    const numPasses = jobj.renderpass.length
    if (numPasses < 1 || numPasses < props.mMaxPasses) {
        Utils.warn('effect', 'Corrupted Shader', numPasses)
        return
    }

    props.mPasses = []
    for (let j = 0; j < numPasses; j++) {
        const rpass = jobj.renderpass[j]

        const wpass = new EffectPass(
            props.mRenderer!,
            props.mIsLowEnd,
            props.mShaderTextureLOD!,
            props.programCopy!,
            j
        )
        wpass.Create(rpass.type, null)

        for (let i = 0; i < 4; i++) {
            wpass.NewTexture(null, i)
        }
        rpass.inputs.forEach((input) => {
            const lid = input.channel
            wpass.NewTexture(
                null,
                lid,
                input,
                props.mBuffers,
                props.mCubeBuffers,
                props.mKeyboard
            )
        })

        for (let i = 0; i < 4; i++) {
            wpass.SetOutputs(i, null)
        }
        rpass.outputs.forEach((output) => {
            wpass.SetOutputs(output.channel, output.id)
        })

        props.mPasses[j] = wpass
    }
}

function compile(props: Type.EffectProps, preventCache: boolean) {
    const numPasses = props.mPasses?.length!
    const allPromisses = new Array<Promise<void>>()
    for (let j = 0; j < numPasses; j++) {
        allPromisses.push(
            new Promise((resolve) => {
                // newShader(j, preventCache, resolve)
            })
        )
    }
    // Promise.all()
}

function newShader(
    props: Type.EffectProps,
    passid: number,
    preventCache: boolean
) {
    props.mPasses![passid]
}
