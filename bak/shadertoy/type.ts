import EffectPass from './effectpass'

export enum TEXTYPE {
    T2D = 0,
    T3D = 1,
    CUBEMAP = 2,
}

export enum TEXFMT {
    C4I8 = 0,
    C1I8 = 1,
    C1F16 = 2,
    C4F16 = 3,
    C1F32 = 4,
    C4F32 = 5,
    Z16 = 6,
    Z24 = 7,
    Z32 = 8,
    C3F32 = 9,
}

export enum CLEAR {
    Color = 1,
    ZBuffer = 2,
    Stencil = 4,
}

export enum TEXWRP {
    CLAMP = 0,
    REPEAT = 1,
}

export enum BUFTYPE {
    STATIC = 0,
    DYNAMIC = 1,
}

export enum PRIMTYPE {
    POINTS = 0,
    LINES = 1,
    LINE_LOOP = 2,
    LINE_STRIP = 3,
    TRIANGLES = 4,
    TRIANGLE_STRIP = 5,
}

export enum RENDSTGATE {
    WIREFRAME = 0,
    FRONT_FACE = 1,
    CULL_FACE = 2,
    DEPTH_TEST = 3,
    ALPHA_TO_COVERAGE = 4,
}

export enum FILTER {
    NONE = 0,
    LINEAR = 1,
    MIPMAP = 2,
    NONE_MIPMAP = 3,
}

export enum TYPE {
    UINT8 = 0,
    UINT16 = 1,
    UINT32 = 2,
    FLOAT16 = 3,
    FLOAT32 = 4,
    FLOAT64 = 5,
}

export type GLFormat = {
    format: number
    external: number
    type: number
}

export type Texture = {
    id: WebGLTexture
    xres: number
    yres: number
    format: TEXFMT
    type: TEXTYPE
    filter: FILTER
    wrap: TEXWRP
    vFlip: boolean
}

export type ScreenshotsProps = {
    mCubemapToEquirectProgram?: CreateShaderResolveSucc
}

export type Screenshots = {
    Initialize(renderer: Renderer): void
}

export type RendererProps = {
    mGL?: WebGL2RenderingContext

    unitQuad?: Drawer
    triangle?: Drawer
    cubeNor?: Drawer
    cube?: Drawer
    shaderHeaders: string[]

    mFloat32Textures?: any
    mFloat16Textures?: any
    mDrawBuffers?: any
    mDepthTextures?: any
    mDerivatives?: any
    mShaderTextureLOD?: any
    mAsynchCompile?: any
}

export type Renderer = {
    Initialize(gl: WebGL2RenderingContext): void
    props: RendererProps
    GetCaps(): {
        mFloat32Textures: boolean
        mFloat16Textures: boolean
        mDrawBuffers: boolean
        mDepthTextures: boolean
        mDerivatives: boolean
        mShaderTextureLOD: boolean
    }
    CreateShader(
        vsSource: string,
        fsSource: string,
        preventCache: boolean,
        forceSynch: boolean,
        onResolve?: CreateShaderResolve
    ): void
}

export type Drawer = {
    (param: { vpos: number; vposa: number[] }): void
}

export type CreateShaderResolve = {
    (state: CreateShaderResolveSucc | CreateShaderResolveFail): void
}

export type CreateShaderResolveSucc = {
    succ: true
    program: WebGLProgram
    time: number
}

export type CreateShaderResolveFail = {
    succ: false
    errorType: number
    errorStr: string
}

export type Effect = {
    Load(jobj: ShaderToyInstance): void
}

export type EffectProps = {
    mMaxBuffers: number
    mMaxCubeBuffers: number
    mBuffers: Buffer[]
    mCubeBuffers: Buffer[]
    mMaxPasses: number
    mIsLowEnd: boolean

    mKeyboard?: any

    mShaderTextureLOD?: boolean

    mPasses?: EffectPass[]

    mGlContext?: WebGL2RenderingContext
    mRenderer?: Renderer
    mScreenshotSytem?: Screenshots
    programCopy?: CreateShaderResolveSucc
    programDownscale?: CreateShaderResolveSucc
}

export type Buffer = {
    mTexture: any[]
    mTarget: any[]
    mResolution: number[]
    mLastRenderDone: number
    mThumbnailRenderTarget: any
    mThumbnailTexture: any
    mThumbnailBuffer: any
    mThumbnailRes: number[]
}

export type ShaderToyInstanceRenderPassType = 'image' | 'buffer'
export type ShaderToyInstanceRenderPassStream = {
    channel: number
    id: string
}
export type ShaderToyInstanceRenderPassInput =
    ShaderToyInstanceRenderPassStream & {
        filepath: string
        // previewfilepath:string
        // published:number
        sampler: {
            filter: string
            internal: string
            srgb: boolean
            vflip: boolean
            wrap: string
        }
        type: string
    }
// channel: 0
// filepath: "/media/previz/buffer00.png"
// id: "4dXGR8"
// previewfilepath: "/media/previz/buffer00.png"
// published: 1
// sampler:
// filter: "nearest"
// internal: "byte"
// srgb: "false"
// vflip: "true"
// wrap: "clamp"
// [[Prototype]]: Object
// type: "buffer"

export type ShaderToyInstanceRenderPass = {
    code: string
    name: string
    type: ShaderToyInstanceRenderPassType
    inputs: ShaderToyInstanceRenderPassInput[]
    outputs: ShaderToyInstanceRenderPassStream[]
}

export type ShaderToyInstance = {
    renderpass: ShaderToyInstanceRenderPass[]
}

export type MyInfoType = 'cubemap' | 'volume'

export type MyInfo = {
    mInfo: {
        mType: MyInfoType
    }
} | null
