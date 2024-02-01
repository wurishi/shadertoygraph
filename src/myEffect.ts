import MyEffectPass from './myEffectPass'
import {
    CLEAR,
    EffectBuffer,
    EffectPassInput_Keyboard,
    FILTER,
    PaintParam,
    RefreshTextureThumbail,
    ShaderConfig,
    TEXFMT,
    Texture,
    TEXTYPE,
    TEXWRP,
} from './type'
import { setBlend } from './utils/attr'
import { clear, createMipmaps } from './utils/index'
import {
    createRenderTarget,
    setRenderTarget,
    setRenderTargetCubeMap,
} from './utils/renderTarget'
import { createTexture } from './utils/texture'
import updateTexture from './utils/texture/updateTexture'

export default class MyEffect {
    public xres
    public yres
    private glContext
    private canvas

    private maxBuffers
    private buffers
    private maxCubeBuffers
    private cubeBuffers
    private frame

    private mPasses: MyEffectPass[]

    private audioContext?
    public gainNode?
    private textureCallbackFun
    private RO?

    private keyboard: EffectPassInput_Keyboard

    constructor(
        vr: any,
        ac: AudioContext | null,
        canvas: HTMLCanvasElement,
        callback: RefreshTextureThumbail | null,
        obj: any,
        forceMuted: any,
        forcePaused: any,
        resizeCallback: any,
        crashCallback?: () => void
    ) {
        this.xres = canvas.width
        this.yres = canvas.height
        this.maxBuffers = 4
        this.buffers = new Array<EffectBuffer>()
        this.maxCubeBuffers = 1
        this.cubeBuffers = new Array<EffectBuffer>()
        this.frame = 0
        this.mPasses = []
        this.textureCallbackFun = callback

        this.glContext = createGlContext(canvas, false, false, true, false)
        this.canvas = canvas
        canvas.addEventListener(
            'webglcontextlost',
            (event) => {
                event.preventDefault()
                crashCallback && crashCallback()
            },
            false
        )

        // this.mRenderer = piRenderer()

        // this.mScreenshotSytem = Screenshots()

        if (ac) {
            this.audioContext = ac
            this.gainNode = ac.createGain()
            this.gainNode.connect(ac.destination)
            this.gainNode.gain.value = 0.0
        }

        // mProgramCopy

        for (let i = 0; i < this.maxBuffers; i++) {
            this.buffers[i] = {
                texture: [null, null],
                target: [null, null],
                resolution: [0, 0],
                lastRenderDone: 0,
            }
        }

        for (let i = 0; i < this.maxCubeBuffers; i++) {
            this.cubeBuffers[i] = {
                texture: [null, null],
                target: [null, null],
                resolution: [0, 0],
                lastRenderDone: 0,
            }
        }

        let keyboardData = new Uint8Array(256 * 3)
        for (let j = 0; j < 256 * 3; j++) {
            keyboardData[j] = 0
        }
        const keyboardTexture = createTexture(
            this.glContext,
            TEXTYPE.T2D,
            256,
            3,
            TEXFMT.C1I8,
            FILTER.NONE,
            TEXWRP.CLAMP,
            null
        )
        this.keyboard = {
            data: keyboardData,
            texture: keyboardTexture,
        }

        if (!window.ResizeObserver) {
            this.bestAttemptFallback()
            window.addEventListener('resize', this.bestAttemptFallback)
        } else {
            this.RO = new ResizeObserver((entries, observer) => {
                const entry = entries[0]
                if (!entry.devicePixelContentBoxSize) {
                    observer.unobserve(canvas)
                    this.bestAttemptFallback()
                    window.addEventListener('resize', this.bestAttemptFallback)
                } else {
                    const box = entry.devicePixelContentBoxSize[0]
                    const xres = box.inlineSize
                    const yres = box.blockSize
                    this.iResize(xres, yres)
                }
            })
            try {
                this.RO.observe(canvas, {
                    box: 'device-pixel-content-box',
                })
            } catch (error) {
                this.bestAttemptFallback()
                window.addEventListener('resize', this.bestAttemptFallback)
            }
        }
    }

    private iResize = (xres: number, yres: number) => {
        this.canvas.width = xres
        this.canvas.height = yres
        this.xres = xres
        this.yres = yres
        this.ResizeBuffers(xres, yres)
    }

    private bestAttemptFallback = () => {
        const devicePixelRatio = window.devicePixelRatio || 1
        const xres = Math.round(this.canvas.offsetWidth * devicePixelRatio) | 0
        const yres = Math.round(this.canvas.offsetHeight * devicePixelRatio) | 0
        this.iResize(xres, yres)
    }

    public Paint = (
        time: number,
        dtime: number,
        fps: number,
        mouseOriX: number,
        mouseOriY: number,
        mousePosX: number,
        mousePosY: number,
        isPaused: boolean
    ) => {
        const da = new Date()
        const vrData = null
        // TODO: resize
        let xres = this.xres / 1
        let yres = this.yres / 1
        if (this.frame === 0) {
            this.buffers.forEach((buffer) => {
                if (buffer.texture[0]) {
                    setRenderTarget(this.glContext, buffer.target[0])
                    clear(
                        this.glContext,
                        CLEAR.Color,
                        [0.0, 0.0, 0.0, 0.0],
                        1.0,
                        0
                    )
                    setRenderTarget(this.glContext, buffer.target[1])
                    clear(
                        this.glContext,
                        CLEAR.Color,
                        [0.0, 0.0, 0.0, 0.0],
                        1.0,
                        0
                    )

                    createMipmaps(this.glContext, buffer.texture[0]!)
                    createMipmaps(this.glContext, buffer.texture[1]!)
                }
            })
            this.cubeBuffers.forEach((buffer) => {
                if (buffer.texture[0]) {
                    for (let face = 0; face < 6; face++) {
                        setRenderTargetCubeMap(
                            this.glContext,
                            buffer.target[0],
                            face
                        )
                        clear(
                            this.glContext,
                            CLEAR.Color,
                            [0.0, 0.0, 0.0, 0.0],
                            1.0,
                            0
                        )
                        setRenderTargetCubeMap(
                            this.glContext,
                            buffer.target[1],
                            face
                        )
                        clear(
                            this.glContext,
                            CLEAR.Color,
                            [0.0, 0.0, 0.0, 0.0],
                            1.0,
                            0
                        )
                        createMipmaps(this.glContext, buffer.texture[0]!)
                        createMipmaps(this.glContext, buffer.texture[1]!)
                    }
                }
            })
            //
        }

        const paintParam: PaintParam = {
            wa: this.audioContext,
            time,
            dtime,
            fps,
            mouseOriX,
            mouseOriY,
            mousePosX,
            mousePosY,
            isPaused,
            buffers: this.buffers,
            cubeBuffers: this.cubeBuffers,
            da,
            xres,
            yres,
        }

        //
        // render sound first
        this.mPasses.forEach((pass) => {
            if (pass.mType === 'sound' && pass.mProgram) {
                pass.Paint(paintParam)
            }
        })

        // render buffers second
        this.mPasses.forEach((pass) => {
            if (pass.mType === 'buffer' && pass.mProgram) {
                const bufferID = pass.mOutputs[0]
                let needMipMaps = false
                for (let j = 0; j < this.mPasses.length; j++) {
                    for (let k = 0; k < this.mPasses[j].mInputs.length; k++) {
                        const inp = this.mPasses[j].mInputs[k]
                        if (
                            inp?.mInfo.type === 'buffer' &&
                            inp.mInfo.sampler.filter === 'mipmap' &&
                            inp.buffer?.id === bufferID
                        ) {
                            needMipMaps = true
                            console.log('need mipmap?')
                        }
                    }
                }
                pass.Paint({
                    ...paintParam,
                    bufferID,
                    bufferNeedsMimaps: needMipMaps,
                })
            }
        })

        // render cubemap buffers
        this.mPasses.forEach((pass) => {
            if (pass.mType === 'cubemap' && pass.mProgram) {
                const bufferID = 0
                let needMipMaps = false
                for (let j = 0; j < this.mPasses.length; j++) {
                    for (let k = 0; k < this.mPasses[j].mInputs.length; k++) {
                        const inp = this.mPasses[j].mInputs[k]
                        if (
                            inp?.mInfo.type === 'cubemap' &&
                            inp.mInfo.sampler.filter === 'mipmap'
                        ) {
                            needMipMaps = true
                            console.log('need cube mipmap?')
                        }
                    }
                }
                pass.Paint({
                    ...paintParam,
                    bufferID,
                    bufferNeedsMimaps: needMipMaps,
                })
            }
        })

        // render image last
        this.mPasses.forEach((pass) => {
            if (pass.mType === 'image' && pass.mProgram) {
                pass.Paint(paintParam)
            }
        })

        // erase keypresses
        for (let k = 0; k < 256; k++) {
            this.keyboard.data[k + 1 * 256] = 0
        }
        updateTexture(
            this.glContext,
            this.keyboard.texture,
            0,
            0,
            256,
            3,
            this.keyboard.data
        )

        this.frame++
    }

    public Load = (jobj: ShaderConfig) => {
        jobj.renderpass.forEach((rpass, j) => {
            const wpass = new MyEffectPass(
                this.glContext,
                j,
                this,
                this.textureCallbackFun
            )
            wpass.name = rpass.name || ''
            wpass.Create(rpass.type, this.audioContext)

            for (let i = 0; i < 4; i++) {
                wpass.NewTexture(this.audioContext, i)
            }
            rpass.inputs.forEach((info) => {
                wpass.NewTexture(
                    this.audioContext,
                    info.channel,
                    info,
                    this.buffers,
                    this.cubeBuffers,
                    this.keyboard
                )
            })

            for (let i = 0; i < 4; i++) {
                wpass.SetOutputs(i, -1)
            }

            rpass.outputs.forEach((output) => {
                wpass.SetOutputs(output.channel, output.id)
            })

            wpass.SetCode(rpass.code)

            this.mPasses.push(wpass)
        })
    }

    public Compile = () => {
        const commonSourceCodes: string[] = []
        this.mPasses.forEach((pass) => {
            if (pass.mType === 'common') {
                commonSourceCodes.push(pass.GetCode())
            }
        })
        this.mPasses.forEach((pass) => {
            pass.NewShader(commonSourceCodes, false)
        })
    }

    public ResizeBuffers = (xres: number, yres: number) => {
        for (let i = 0; i < this.maxBuffers; i++) {
            this.ResizeBuffer(i, xres, yres, true)
        }
    }

    public ResetTime = () => {
        this.frame = 0
        this.audioContext?.resume()

        this.mPasses.forEach((pass) => {
            pass.mFrame = 0
            // TODO: pass rewind input
        })
    }

    public Destroy = () => {
        window.removeEventListener('resize', this.bestAttemptFallback)

        if (this.RO) {
            this.RO.unobserve(this.canvas)
            this.RO.disconnect()
        }

        this.mPasses.forEach((pass) => pass.Destroy(this.audioContext!))

        this.buffers.forEach((buffer) => {
            buffer.texture[0]?.Destroy()
            buffer.texture[1]?.Destroy()
            buffer.target[0]?.Destroy()
            buffer.target[1]?.Destroy()
        })
        this.cubeBuffers.forEach((buffer) => {
            buffer.texture[0]?.Destroy()
            buffer.texture[1]?.Destroy()
            buffer.target[0]?.Destroy()
            buffer.target[1]?.Destroy()
        })

        this.buffers = []
        this.cubeBuffers = []
        this.mPasses = []
        this.audioContext = undefined
        this.gainNode = undefined
    }

    public ResizeCubemapBuffer = (i: number, xres: number, yres: number) => {}

    public ResizeBuffer = (
        i: number,
        xres: number,
        yres: number,
        skipIfNotExists: boolean
    ) => {
        if (skipIfNotExists) {
            if (this.buffers[i].texture[0] === null) {
                return
            }
        }

        const oldXres = this.buffers[i]?.resolution[0]
        const oldYres = this.buffers[i]?.resolution[1]

        if (oldXres !== xres || oldYres !== yres) {
            const needCopy = this.buffers[i]?.texture[0] !== null
            let filter = needCopy
                ? this.buffers[i].texture[0]!.filter
                : FILTER.NONE
            let wrap = needCopy
                ? this.buffers[i].texture[0]!.wrap
                : TEXWRP.CLAMP

            const texture1 = createTexture(
                this.glContext,
                TEXTYPE.T2D,
                xres,
                yres,
                TEXFMT.C4F32,
                filter,
                wrap
            )

            filter = needCopy ? this.buffers[i].texture[1]!.filter : FILTER.NONE
            wrap = needCopy ? this.buffers[i].texture[1]!.wrap : TEXWRP.CLAMP

            const texture2 = createTexture(
                this.glContext,
                TEXTYPE.T2D,
                xres,
                yres,
                TEXFMT.C4F32,
                filter,
                wrap
            )

            const target1 = createRenderTarget(
                this.glContext,
                texture1,
                null,
                false
            )
            const target2 = createRenderTarget(
                this.glContext,
                texture2,
                null,
                false
            )

            if (needCopy) {
                // TODO
                setBlend(this.glContext, false)
                console.log('needcopy')
            }

            this.buffers[i].texture = [texture1, texture2]
            this.buffers[i].target = [target1, target2]
            this.buffers[i].lastRenderDone = 0
            this.buffers[i].resolution[0] = xres
            this.buffers[i].resolution[1] = yres
        }
    }

    public setGainValue = (value: number) => {
        if (this.gainNode) {
            this.gainNode.gain.value = value
        }
    }

    public exportToWav = () => {
        const pass = this.mPasses.find((p) => p.mType === 'sound')
        if (pass) {
            pass.exportToWav()
        }
    }

    public exportToExr = (id: number) => {
        let tmp = 0
        const pass = this.mPasses.find((p) => {
            if (p.mType === 'buffer') {
                if (tmp === id) {
                    return true
                }
                tmp++
            }
            return false
        })
        if (pass) {
            pass.exportToExr(this.buffers)
        }
    }

    public SetKeyDown = (k: number) => {
        if (this.keyboard.data[k + 0 * 256] == 255) {
            return
        }
        this.keyboard.data[k + 0 * 256] = 255
        this.keyboard.data[k + 1 * 256] = 255
        this.keyboard.data[k + 2 * 256] = 255 - this.keyboard.data[k + 2 * 256]
        updateTexture(
            this.glContext,
            this.keyboard.texture,
            0,
            0,
            256,
            3,
            this.keyboard.data
        )
    }

    public SetKeyUp = (k: number) => {
        this.keyboard.data[k + 0 * 256] = 0
        this.keyboard.data[k + 1 * 256] = 0
        updateTexture(
            this.glContext,
            this.keyboard.texture,
            0,
            0,
            256,
            3,
            this.keyboard.data
        )
    }
}

function createGlContext(
    cv: HTMLCanvasElement,
    useAlpha: boolean,
    useDepth: boolean,
    usePreserveBuffer: boolean,
    useSupersampling: boolean
): WebGL2RenderingContext {
    return cv.getContext('webgl2', {
        alpha: useAlpha,
        depth: useDepth,
        stencil: false,
        premultipliedAlpha: false,
        antialias: useSupersampling,
        preserveDrawingBuffer: usePreserveBuffer,
        powerPreference: 'high-performance', // "low_power", "high_performance", "default"
    })!
}
