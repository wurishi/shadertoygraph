import MyEffect from './myEffect'
import {
    createAudioContext,
    getRealTime,
    requestAnimFrame,
} from './utils/index'
import { RefreshTextureThumbail, ShaderPassConfig } from './type'

export default class ShaderToy {
    public canvas
    private effect
    private tOffset
    private to
    private tf
    private isPaused = false
    private forceFrame = false
    private restarted = true
    private audioContext
    private destoryed = false
    private textureCallbackFun: RefreshTextureThumbail | null = null

    constructor() {
        this.tOffset = 0
        this.to = getRealTime()
        this.tf = 0

        const canvas = document.createElement('canvas')
        this.canvas = canvas
        document.body.appendChild(canvas)

        canvas.style.width = '400px'
        canvas.style.height = '300px'
        canvas.width = canvas.offsetWidth
        canvas.height = canvas.offsetHeight

        canvas.addEventListener('mousedown', this.mouseDown)
        canvas.addEventListener('mouseup', this.mouseUp)
        canvas.addEventListener('mousemove', this.mouseMove)
        document.body.addEventListener('keydown', this.keydown)
        document.body.addEventListener('keyup', this.keyup)

        this.audioContext = createAudioContext()

        this.effect = new MyEffect(
            null,
            this.audioContext,
            canvas,
            this.textureCallbackFun,
            null,
            null,
            null,
            null
        )

        window.addEventListener('focus', this.onfocus)
    }

    private onfocus = () => {
        if (!this.isPaused) {
            this.tOffset = this.tf
            this.to = getRealTime()
            this.restarted = true
        }
    }

    // public load = (renderpass: ShaderPassConfig[]) => {
    //     this.effect.Load({
    //         renderpass,
    //     })
    //     this.effect.Compile()
    //     this.resetTime(true)
    // }

    private loopCallback?: () => any
    public start = (callback?: () => any) => {
        this.loopCallback = callback
        this.renderLoop()
    }

    private mouseOriX: number = 0
    private mouseOriY: number = 0
    private mousePosX: number = 0
    private mousePosY: number = 0
    private mouseIsDown = false
    private mouseSignalDown = false
    private mouseDown = (ev: MouseEvent) => {
        const rect = this.canvas.getBoundingClientRect()
        this.mouseOriX = Math.floor(
            ((ev.clientX - rect.left) / (rect.right - rect.left)) *
                this.canvas.width
        )
        this.mouseOriY = Math.floor(
            this.canvas.height -
                ((ev.clientY - rect.top) / (rect.bottom - rect.top)) *
                    this.canvas.height
        )
        this.mousePosX = this.mouseOriX
        this.mousePosY = this.mouseOriY
        this.mouseIsDown = true
        this.mouseSignalDown = true
        if (this.isPaused) {
            this.forceFrame = true
        }
    }

    private mouseMove = (ev: MouseEvent) => {
        if (this.mouseIsDown) {
            const rect = this.canvas.getBoundingClientRect()
            this.mousePosX = Math.floor(
                ((ev.clientX - rect.left) / (rect.right - rect.left)) *
                    this.canvas.width
            )
            this.mousePosY = Math.floor(
                this.canvas.height -
                    ((ev.clientY - rect.top) / (rect.bottom - rect.top)) *
                        this.canvas.height
            )
            if (this.isPaused) {
                this.forceFrame = true
            }
        }
    }

    private mouseUp = (ev: MouseEvent) => {
        this.mouseIsDown = false
        if (this.isPaused) {
            this.forceFrame = true
        }
    }

    private keydown = (ev: KeyboardEvent) => {
        this.effect.SetKeyDown(ev.keyCode)
        // ev.preventDefault()
    }

    private keyup = (ev: KeyboardEvent) => {
        this.effect.SetKeyUp(ev.keyCode)
        // ev.preventDefault()
    }

    private renderLoop = () => {
        if (this.destoryed) {
            return
        }
        requestAnimFrame(this.renderLoop)

        if (this.isPaused && !this.forceFrame) {
            // update inputs
            return
        }
        this.forceFrame = false

        const time = getRealTime()

        let ltime = 0.0,
            dtime = 0.0

        if (this.isPaused) {
            ltime = this.tf
            dtime = 1000.0 / 60.0
        } else {
            ltime = this.tOffset + time - this.to
            if (this.restarted) {
                dtime = 1000.0 / 60.0
            } else {
                dtime = ltime - this.tf
            }

            this.tf = ltime
        }
        this.restarted = false

        const newFPS = 60
        let mouseOriX = Math.abs(this.mouseOriX)
        let mouseOriY = Math.abs(this.mouseOriY)
        if (!this.mouseIsDown) {
            mouseOriX = -mouseOriX
        }
        if (!this.mouseSignalDown) {
            mouseOriY = -mouseOriY
        }
        this.mouseSignalDown = false

        this.effect.Paint(
            ltime / 1000.0,
            dtime / 1000.0,
            newFPS,
            mouseOriX,
            mouseOriY,
            this.mousePosX,
            this.mousePosY,
            this.isPaused
        )

        this.loopCallback && this.loopCallback()
    }

    public pauseTime = (doFocusCanvas?: boolean) => {
        if (!this.isPaused) {
            this.isPaused = true
            // effect stopOutputs
        } else {
            this.tOffset = this.tf
            this.to = getRealTime()
            this.isPaused = false
            this.restarted = true
            // effect resumeoutputs
            if (doFocusCanvas) {
                this.canvas.focus()
            }
        }
    }

    private resetTime = (doFocusCanvas?: boolean) => {
        this.tOffset = 0
        this.to = getRealTime()
        this.tf = 0
        this.restarted = true
        this.forceFrame = true
        this.effect.ResetTime()
        if (doFocusCanvas) {
            this.canvas.focus()
        }
    }

    public newEffect = (
        renderpass: ShaderPassConfig[],
        callback?: RefreshTextureThumbail
    ) => {
        if (this.effect) {
            this.effect.Destroy()
        }
        if (callback) {
            this.textureCallbackFun = callback
        }

        this.effect = new MyEffect(
            null,
            this.audioContext,
            this.canvas,
            this.textureCallbackFun,
            null,
            null,
            null,
            null
        )
        this.effect.Load({
            renderpass,
        })
        this.effect.Compile()
        this.resetTime(true)
    }

    public setGainValue = (value: number) => {
        this.effect.setGainValue(value)
    }

    public exportToWav = () => {
        this.effect.exportToWav()
    }

    public exportToExr = (id: number) => {
        this.effect.exportToExr(id)
    }
}
