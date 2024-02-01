export default function drawMusicWave(
    canvas: HTMLCanvasElement,
    wave: Uint8Array
) {
    const ctx = canvas.getContext('2d')!
    const w = canvas.width
    const h = canvas.height

    const voff = 0

    ctx.fillStyle = '#000000'
    ctx.fillRect(0, 0, w, h)
    ctx.fillStyle = '#ffffff'

    let numfft = wave.length
    numfft /= 2
    numfft = Math.min(numfft, 512)
    const num = 32
    const numb = (numfft / num) | 0
    const s = (w - 8 * 2) / num
    let k = 0

    for (let i = 0; i < num; i++) {
        let f = 0.0
        for (let j = 0; j < numb; j++) {
            f += wave[k++]
        }
        f /= numb
        f /= 255.0

        const fr = f
        const fg = 4.0 * f * (1.0 - f)
        const fb = 1.0 - f

        const rr = (255.0 * fr) | 0
        const gg = (255.0 * fg) | 0
        const bb = (255.0 * fb) | 0

        const decColor = 0x1000000 + bb + 0x100 * gg + 0x10000 * rr
        ctx.fillStyle = '#' + decColor.toString(16).substr(1)

        const a = Math.max(2, f * (h - 2 * 20))
        ctx.fillRect(8 + i * s, h - voff - a, (3 * s) / 4, a)
    }
}
