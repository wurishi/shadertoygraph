export type ShaderToy = {
    key: string
    name: string
    shaderList: ShaderInstance[]
}

export type ShaderBufferName = 'BufferA' | 'BufferB' | 'BufferC' | 'BufferD'

type ShaderChannel = {
    type: string
    value: string
}

type ShaderBufferChannel = ShaderChannel & {
    type: 'Buffer'
    value: ShaderBufferName
    setting?: TextureSetting
}

type ShaderImageChannel = ShaderChannel & {
    type: 'Img'
    value: string
    setting?: ImageTextureSetting
}

export type ShaderInstance = {
    name: 'Image' | ShaderBufferName
    getFragment(): string
    channels?: (ShaderBufferChannel | ShaderImageChannel)[]
}

export type RenderInstance = {
    name: string
    canvas: HTMLCanvasElement
    gl: WebGL2RenderingContext
    program: WebGLProgram
    props: {
        iResolution: UniformLocation
        iTime: UniformLocation
        iFrame: UniformLocation
        iTimeDelta: UniformLocation
        iMouse: UniformLocation
        iDate: UniformLocation
    }
    framebuffer?: MyWebGLFramebuffer
    channels?: BindChannel[]
    draw: GPUDraw
}

export type CopyRender = {
    (pos: number[], source: WebGLTexture, target: WebGLTexture): void
}

export type AttribLocation = {
    setFloat32(arr: Float32Array): void
    bindBuffer(): void
}

export type UniformLocation = {
    uniform1i(x: number): void
    uniform1f(x: number): void
    uniform2f(x: number, y: number): void
    uniform3f(x: number, y: number, z: number): void
    uniform4fv(v: Float32List): void
}

export type BindChannel = {
    (id: WebGLUniformLocation, index: number): void
}

export type MyWebGLFramebuffer = {
    // framebuffer: WebGLFramebuffer
    // texture: WebGLTexture
    renderFramebuffer(): void
    bindChannel: BindChannel
    drawCopy(pos: number[]): void
}

export type CanvasMouseMetadata = {
    oriX: number
    oriY: number
    posX: number
    posY: number
    isDown: boolean
    isSignalDown: boolean
}

export type CanvasMouseHandler = {
    data: CanvasMouseMetadata
    clear(): void
}

export type Image2D = {
    bindChannel: BindChannel
}

export type TextureFilterSetting = 'NONE' | 'LINEAR' | 'MIPMAP' | 'NEAREST'
export type TextureWrapSetting = 'CLAMP' | 'REPEAT'

export type TextureType = 'T2D'

export type TextureSetting = {
    filter?: TextureFilterSetting
    wrap: TextureWrapSetting
}

export type ImageTextureSetting = {
    vflip: boolean
} & TextureSetting

export type Format =
    | 'C4I8'
    | 'C1I8'
    | 'C1F16'
    | 'C4F16'
    | 'C1F32'
    | 'C4F32'
    | 'C3F32'
    | 'Z16'
    | 'Z24'
    | 'Z32'
    | 'UNKNOW'

export type GLFormat = {
    format: number
    external: number
    type: number
}

export type GPUDraw = {
    (): void
}

export type PassType = 'image' | 'sound' | 'buffer' | 'common' | 'cubemap'

export type EffectPassInfoType =
    | PassType
    | 'volume'
    | 'texture'
    | 'webcam'
    | 'mic'
    | 'music'
    | 'musicstream'
    | 'keyboard'
    | 'video'

export type EffectPassInfo = {
    channel: number
    type: EffectPassInfoType
    src: string
    sampler: Sampler
}

export type EffectPassInput = {
    mInfo: EffectPassInfo
    globject?: Texture
    loaded?: boolean
    texture?: {
        image: HTMLImageElement
        destroy: () => void
    }
    volume?: {
        image: { xres: number; yres: number; zres: number }
        destroy: () => void
    }
    buffer?: {
        id: number
        destroy: () => void
    }
    audio?: {
        el: HTMLAudioElement
        hasFalled: boolean

        source?: MediaElementAudioSourceNode
        analyser?: AnalyserNode
        gain?: GainNode
        freqData?: Uint8Array
        waveData?: Uint8Array

        destroy?: () => void
    }
    cubemaps?: {
        images: HTMLImageElement[]
        destroy: () => void
    }
    video?: {
        video: HTMLVideoElement
        destroy: () => void
    }
    keyboard?: EffectPassInput_Keyboard
    mic?: {
        num: number
        freqData: Uint8Array
        waveData: Uint8Array
    }
} | null

export type EffectPassInput_Keyboard = {
    data: Uint8Array
    texture: Texture
}

export type EffectPassSoundProps = {
    mSampleRate: number
    mPlayTime: number
    mPlaySamples: number
    mTextureDimensions: number
    mTmpBufferSamples: number
    mPlaying: boolean

    mBuffer?: AudioBuffer
    mRenderTexture?: Texture
    mRenderFBO?: RenderTarget
    mData?: Uint8Array
    mPlayNode?: AudioBufferSourceNode | null
    mGainNode?: GainNode

    mSoundShaderCompiled?: boolean
}

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

export type Texture = {
    id: WebGLTexture
    xres: number
    yres: number
    format: TEXFMT
    type: TEXTYPE
    filter: FILTER
    wrap: TEXWRP
    vFlip: boolean
    Destroy(): void
}

export type RenderTarget = {
    id: WebGLFramebuffer
    tex0: Texture
    Destroy(): void
}

export type Sampler = {
    filter: string
    wrap: string
    vflip: boolean
}

export type RenderSampler = {
    filter: FILTER
    wrap: TEXWRP
    vflip: boolean
}

export type TextureInfo = {
    failed: boolean
    needsShaderCompile?: boolean
}

export type CreateShaderResolveSucc = {
    succ: true
    program: WebGLProgram
    time: number
    Destroy(): void
}

export type CreateShaderResolveFail = {
    succ: false
    errorType: number
    errorStr: string
}

export type CreateShaderResolve = {
    (state: CreateShaderResolveSucc | CreateShaderResolveFail): void
}

export type WebGLInfo = {
    float32Textures: boolean
    float32Filter?: OES_texture_float_linear
    float16Textures: boolean
    float16Filter?: OES_texture_half_float_linear
    derivatives: boolean
    drawBuffers: boolean
    depthTextures: boolean
    shaderTextureLOD: boolean
    anisotropic?: EXT_texture_filter_anisotropic
    renderToFloat32F?: EXT_color_buffer_float
    debugShader?: WEBGL_debug_shaders
    asynchCompile?: KHR_parallel_shader_compile

    maxTexSize: number
    maxCubeSize: number
    maxRenderbufferSize: number
    extensions: string[]
    textureUnits: number
}

export type PaintParam = {
    vrData?: any
    wa?: AudioContext
    da?: Date
    time?: number
    dtime?: number
    fps?: number
    mouseOriX?: number
    mouseOriY?: number
    mousePosX?: number
    mousePosY?: number
    xres?: number
    yres?: number
    isPaused?: boolean
    bufferID?: any
    bufferNeedsMimaps?: boolean
    buffers?: EffectBuffer[]
    cubeBuffers?: EffectBuffer[]
    keyboard?: any
    effect?: any
}

export type EffectBuffer = {
    texture: (Texture | null)[]
    target: (RenderTarget | null)[]
    resolution: { [0]: number; [1]: number }
    lastRenderDone: number
}

export type ShaderPassConfig = {
    name?: string
    type: PassType
    code: string
    inputs: EffectPassInfo[]
    outputs: {
        id: number
        channel: number
    }[]
}

export type ShaderConfig = {
    renderpass: ShaderPassConfig[]
}

export type ConfigChannel = {
    type: string
    filter?: 'nearest' | 'linear' | 'mipmap'
    wrap?: 'clamp' | 'repeat'
    noFlip?: boolean
}
export type ConfigChannel_Buffer = ConfigChannel & {
    type: 'buffer'
    id: number
}
export type ConfigChannel_Texture = ConfigChannel & {
    type: 'texture'
    src:
        | 'Abstract1'
        | 'Abstract2'
        | 'Abstract3'
        | 'Bayer'
        | 'BlueNoise'
        | 'Font1'
        | 'GrayNoiseMedium'
        | 'GrayNoiseSmall'
        | 'Lichen'
        | 'London'
        | 'Nyancat'
        | 'Organic1'
        | 'Organic2'
        | 'Organic3'
        | 'Organic4'
        | 'Pebbles'
        | 'RGBANoiseMedium'
        | 'RGBANoiseSmall'
        | 'RockTiles'
        | 'RustyMetal'
        | 'Stars'
        | 'Wood'
}

export type ConfigChannel_Volume = ConfigChannel & {
    type: 'volume'
    volume: 'GreyNoise3D' | 'RGBANoise3D'
}

export type ConfigChannel_Empty = ConfigChannel & {
    type: 'Empty'
}

export type ConfigChannel_Music = ConfigChannel & {
    type: 'music'
}

export type ConfigChannel_Cubemap = ConfigChannel & {
    type: 'cubemap'
    map?: 'Basilica' | 'Forest' | 'ForestBlur' | 'BasilicaBlur' | 'Gallery' | 'GalleryB'
}

export type ConfigChannel_Video = ConfigChannel & {
    type: 'video'
}

export type ConfigChannel_Keyboard = ConfigChannel & {
    type: 'keyboard'
}

export type ConfigChannel_WebCam = ConfigChannel & {
    type: 'webcam'
}

export type Config = {
    name: string
    type: 'image' | 'buffer' | 'sound' | 'common' | 'cubemap'
    fragment: string
    channels?: (
        | ConfigChannel_Buffer
        | ConfigChannel_Texture
        | ConfigChannel_Volume
        | ConfigChannel_Empty
        | ConfigChannel_Music
        | ConfigChannel_Cubemap
        | ConfigChannel_Video
        | ConfigChannel_Keyboard
        | ConfigChannel_WebCam
    )[]
}

export type RenderSoundCallback = {
    (off: number, mData: Uint8Array, numSamples: number): void
}

export type RefreshTextureThumbail = {
    (wave: Uint8Array, passID: number): void
}
