import {
    CanvasMouseHandler,
    MyWebGLFramebuffer,
    RenderInstance,
    ShaderBufferName,
    ShaderInstance,
    ShaderToy,
} from './type'
import {
    createDrawFullScreenTriangle,
    createFramebuffer,
    createProgram,
    getAttribLocation,
    getImageTexture,
    getUniformLocation,
    handleMouseEvent,
} from './utils'
import {
    vertex,
    fragment,
    DEFAULT_SOUND,
    newVertex,
    buffFragment,
} from './shaderTemplate'
import MyEffectPass from './myEffectPass'

enum PRECISION {
    MEDIUMP = 'mediump',
    HIGHP = 'highp',
    LOW = 'lowp',
}

let renderList: RenderInstance[] = []
let firstRender = false
let rootCanvas: HTMLCanvasElement | null = null
let rootGL: WebGL2RenderingContext | null = null
let canvasMouseHandler: CanvasMouseHandler | null = null
const framebufferMap = new Map<string, MyWebGLFramebuffer>()

export function createRender(shaderToy: ShaderToy) {
    destory()

    init()

    const shaderList = shaderToy.shaderList.concat()
    shaderList.sort((a, b) => {
        if (a.name === 'Image') {
            return 1
        } else if (b.name === 'Image') {
            return -1
        }
        return a.name.localeCompare(b.name)
    })

    shaderList.forEach((shader, index) => {
        const render = createRenderInstance(shader, index)
        if (render) {
            if (shader.channels) {
                render.channels = []
                shader.channels?.forEach((channel, i) => {
                    if (channel.type === 'Buffer') {
                        const myfb = framebufferMap.get(channel.value)
                        if (myfb) {
                            render.channels?.push(myfb.bindChannel)
                        }
                    } else if (channel.type === 'Img') {
                        const img = getImageTexture(render.gl, channel.value)
                        render.channels?.push(img.bindChannel)
                    }
                })
            }

            renderList.push(render)
        }
    })
}

function createRenderInstance(
    shader: ShaderInstance,
    index: number
): RenderInstance | null {
    const gl = rootGL as WebGL2RenderingContext
    if (gl) {
        const v = newVertex
        let f = shader.name.startsWith('Buffer') ? buffFragment : fragment
        f = f.replace('{COMMON}', '')
        f = f.replaceAll('{PRECISION}', PRECISION.MEDIUMP)
        f = f.replace('{USER_FRAGMENT}', shader.getFragment())
        f = f.replace('{MAIN_SOUND}', DEFAULT_SOUND)
        const program = createProgram(gl, v, f)

        const gpuDraw = createDrawFullScreenTriangle(gl, program)

        let framebuffer: MyWebGLFramebuffer | undefined = undefined
        if (shader.name.startsWith('Buffer')) {
            framebuffer = createFramebuffer(gl, index)
            framebufferMap.set(shader.name, framebuffer)
        }

        return {
            name: shader.name,
            canvas: rootCanvas as HTMLCanvasElement,
            gl,
            program,
            props: {
                iResolution: getUniformLocation(gl, program, 'iResolution'),
                iTime: getUniformLocation(gl, program, 'iTime'),
                iFrame: getUniformLocation(gl, program, 'iFrame'),
                iTimeDelta: getUniformLocation(gl, program, 'iTimeDelta'),
                iMouse: getUniformLocation(gl, program, 'iMouse'),
                iDate: getUniformLocation(gl, program, 'iDate'),
            },
            framebuffer,
            draw: gpuDraw,
        }
    }
    return null
}

export function resizeCanvasToDisplaySize(
    canvas: HTMLCanvasElement,
    pixelRatio = true
): boolean {
    const realToCSSPixels = pixelRatio ? window.devicePixelRatio : 1

    const displayWidth = Math.floor(canvas.clientWidth * realToCSSPixels)
    const displayHeight = Math.floor(canvas.clientHeight * realToCSSPixels)

    if (canvas.width != displayWidth || canvas.height != displayHeight) {
        canvas.width = displayWidth
        canvas.height = displayHeight
        return true
    }
    return false
}

const wh = { width: 0, height: 0 }

export function render(iTime: number, iFrame: number, iTimeDelta: number) {
    let resize = false
    if (rootCanvas) {
        resize = resizeCanvasToDisplaySize(rootCanvas, false)
    }
    if (resize) {
        wh.width = rootCanvas?.width || 0
        wh.height = rootCanvas?.height || 0
    }
    const d = new Date()
    const iDate = [
        d.getFullYear(), // the year (four digits)
        d.getMonth(), // the month (from 0-11)
        d.getDate(), // the day of the month (from 1-31)
        d.getHours() * 60.0 * 60.0 + d.getMinutes() * 60 + d.getSeconds(),
    ]
    let posX = 0
    let posY = 0
    let oriX = 0
    let oriY = 0
    if (canvasMouseHandler) {
        const { data } = canvasMouseHandler
        posX = data.posX
        posY = data.posY
        oriX = Math.abs(data.oriX)
        oriY = Math.abs(data.oriY)
        if (!data.isDown) {
            oriX = -oriX
        }
        if (!data.isSignalDown) {
            oriY = -oriY
        }
        data.isSignalDown = false
    }
    const props = {
        resize,
        wh,
        iTime,
        iFrame,
        iTimeDelta,
        posX,
        posY,
        oriX,
        oriY,
        iDate,
    }
    // if (firstRender) {
    //     firstRender = false
    //     renderListRun(props, true)
    // }
    renderListRun(props)
}

function renderListRun(props: any, first = false) {
    const {
        resize,
        wh,
        iTime,
        iFrame,
        iTimeDelta,
        posX,
        posY,
        oriX,
        oriY,
        iDate,
    } = props
    renderList.forEach((r) => {
        // console.log(r.name)
        const { framebuffer, gl, props } = r
        // if (first) {
        //     if (r.name.startsWith('Buffer')) {
        //         gl.clearColor(0, 0, 0, 0)
        //         gl.clearDepth(1.0)
        //         gl.clearStencil(0)
        //         gl.clear(
        //             gl.COLOR_BUFFER_BIT |
        //                 gl.DEPTH_BUFFER_BIT |
        //                 gl.STENCIL_BUFFER_BIT
        //         )
        //         return
        //     }
        // }
        if (resize) {
            gl.viewport(0, 0, wh.width, wh.height)
        }

        gl.useProgram(r.program)
        // gl.clear(gl.COLOR_BUFFER_BIT);

        r.channels?.forEach((bind, channelIdx) => {
            // gl.getUniformLocation(program, name)
            const id = gl.getUniformLocation(
                r.program,
                `iChannel${channelIdx}`
            ) as WebGLUniformLocation
            bind(id, channelIdx)
        })

        if (resize) {
            props.iResolution.uniform3f(wh.width, wh.height, 1)
        }

        props.iTime.uniform1f(iTime)
        props.iFrame.uniform1i(iFrame)
        props.iTimeDelta.uniform1f(iTimeDelta)
        props.iMouse.uniform4fv([posX, posY, oriX, oriY])
        props.iDate.uniform4fv(iDate)

        if (framebuffer) {
            framebuffer.renderFramebuffer()
        } else {
            gl.bindFramebuffer(gl.FRAMEBUFFER, null)
        }

        r.draw()

        if (framebuffer) {
            framebuffer.drawCopy([0, 0, wh.width, wh.height])
        }
    })
}

function init() {
    rootCanvas = document.createElement('canvas')
    rootCanvas.style.marginTop = '50px'
    rootCanvas.style.width = '400px'
    rootCanvas.style.height = '300px'
    document.body.appendChild(rootCanvas)

    rootGL = rootCanvas.getContext('webgl2')

    canvasMouseHandler = handleMouseEvent(rootCanvas)

    firstRender = true

    const pass0 = new MyEffectPass(rootGL!, 0)
    pass0.Create('image')
    pass0.NewTexture(null, 0, {
        channel: 0,
        type: 'texture',
        src: '/textures/Abstract1.jpeg',
        sampler: {
            filter: 'linear',
            wrap: 'clamp',
            vflip: true,
        },
    })
    setTimeout(() => {
        pass0.NewTexture(null, 0, {
            channel: 0,
            type: 'texture',
            src: '/textures/Abstract1.jpeg',
            sampler: {
                filter: 'linear',
                wrap: 'clamp',
                vflip: true,
            },
        })
    }, 1000)
    const pass1 = new MyEffectPass(rootGL!, 1)
    pass1.Create('sound')
    pass1.NewTexture(null, 0, {
        channel: 0,
        type: 'volume',
        src: '/textures/GreyNoise3D.bin',
        sampler: {
            filter: 'linear',
            wrap: 'clamp',
            vflip: true,
        },
    })
    new MyEffectPass(rootGL!, 2).Create('buffer')
    new MyEffectPass(rootGL!, 3).Create('common')
    new MyEffectPass(rootGL!, 4).Create('cubemap')

    pass0.NewShader([], true)
}

function destory() {
    if (canvasMouseHandler) {
        canvasMouseHandler.clear()
        canvasMouseHandler = null
    }
    if (rootCanvas && rootCanvas.parentElement) {
        rootCanvas.parentElement.removeChild(rootCanvas)
    }
    rootCanvas = null
    rootGL = null
    renderList.forEach((r) => {
        r.gl.deleteProgram(r.program)
    })
    renderList = []
    framebufferMap.clear()
}
