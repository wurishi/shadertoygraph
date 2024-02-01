import Stats from 'stats.js'
import * as Utils from './utils'
import * as Type from './type'
import effect from './effect'

export default class ShaderToy {
    static STATS: Stats

    private mCanvas!: HTMLCanvasElement
    private mEffect!: Type.Effect

    private mIsPaused = false
    private mForceFrame = false

    private mTOffset = 0
    private mTf = 0
    private mTo = 0
    private mRestarted = false

    private mMouseOriX = 0
    private mMouseOriY = 0
    private mMousePosX = 0
    private mMousePosY = 0
    private mMouseIsDown = false
    private mMouseSignalDown = false

    constructor() {
        if (!ShaderToy.STATS) {
            ShaderToy.STATS = new Stats()
            document.body.appendChild(ShaderToy.STATS.dom)
        }
        this.initialize()
    }

    private initialize = (): void => {
        this.mCanvas = document.createElement('canvas')
        this.mCanvas.style.marginTop = '50px'
        this.mCanvas.style.width = '400px'
        this.mCanvas.style.height = '300px'
        document.body.appendChild(this.mCanvas)

        this.mCanvas.width = this.mCanvas.offsetWidth
        this.mCanvas.height = this.mCanvas.offsetHeight

        window.addEventListener('focus', this.handleWindowFocus)
        this.mCanvas.addEventListener('mousedown', this.handleCanvasMouseDown)
        this.mCanvas.addEventListener('mousemove', this.handleCanvasMouseMove)
        this.mCanvas.addEventListener('mouseup', this.handleCanvasMouseUp)

        this.mEffect = effect(null, null, this.mCanvas)
    }

    private handleWindowFocus = (): void => {
        if (!this.mIsPaused) {
            this.mTOffset = this.mTf
            this.mTo = Utils.getRealTime()
            this.mRestarted = true
        }
    }

    private handleCanvasMouseDown = (ev: MouseEvent): void => {
        const rect = this.mCanvas.getBoundingClientRect()
        this.mMouseOriX = Math.floor(
            ((ev.clientX - rect.left) / (rect.right - rect.left)) *
                this.mCanvas.width
        )
        this.mMouseOriY = Math.floor(
            this.mCanvas.height -
                ((ev.clientY - rect.top) / (rect.bottom - rect.top)) *
                    this.mCanvas.height
        )
        this.mMousePosX = this.mMouseOriX
        this.mMousePosY = this.mMouseOriY
        this.mMouseIsDown = true
        this.mMouseSignalDown = true
        if (this.mIsPaused) {
            this.mForceFrame = true
        }
    }

    private handleCanvasMouseMove = (ev: MouseEvent): void => {
        if (this.mMouseIsDown) {
            const rect = this.mCanvas.getBoundingClientRect()
            this.mMousePosX = Math.floor(
                ((ev.clientX - rect.left) / (rect.right - rect.left)) *
                    this.mCanvas.width
            )
            this.mMousePosY = Math.floor(
                this.mCanvas.height -
                    ((ev.clientY - rect.top) / (rect.bottom - rect.top)) *
                        this.mCanvas.height
            )
            if (this.mIsPaused) {
                this.mForceFrame = true
            }
        }
    }

    private handleCanvasMouseUp = (ev: MouseEvent): void => {
        this.mMouseIsDown = false
        if (this.mIsPaused) {
            this.mForceFrame = true
        }
    }

    public Load = (
        jsn: Type.ShaderToyInstance,
        preventCache: boolean,
        doResolve: any
    ) => {
        this.mEffect.Load(jsn)

        // this.mEffect.Compile
    }
}
