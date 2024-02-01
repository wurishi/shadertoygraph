type ExrType = 'Uint' | 'Half' | 'Float'

export default function exportToExr(
    width: number,
    height: number,
    numComponents: number,
    type: ExrType,
    bytes: Float32Array
) {
    let bytesPerComponent = 0
    if (type === 'Uint') {
        bytesPerComponent = 4
    } else if (type === 'Half') {
        bytesPerComponent = 2
    } else if (type === 'Float') {
        bytesPerComponent = 4
    }

    const tHeader = 258 + (18 * numComponents + 1)
    const tTable = 8 * height
    const tScanlines =
        height * (4 + 4 + numComponents * bytesPerComponent * width)
    const tTotal = tHeader + tTable + tScanlines

    const buffer = new ArrayBuffer(tTotal)
    const data = new DataView(buffer)

    let c = 0
    // Header : 4 bytes -> 0x76, 0x2f, 0x31, 0x01
    ;[0x76, 0x2f, 0x31, 0x01].forEach((v) => data.setUint8(c++, v))

    // Version: 4 bytes -> 0x02, 0, 0, 0
    ;[0x02, 0, 0, 0].forEach((v) => data.setUint8(c++, v))

    // write attribute name: channels
    c = writeStr(data, 'channels', c)

    // chlist
    c = writeStr(data, 'chlist', c)

    // attribute size: 18 * 3 + 1 = 55
    const attribSize = 18 * numComponents + 1
    data.setUint8(c++, attribSize)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    for (let i = 0; i < numComponents; i++) {
        // Attribute: B(42) G(47) R(52)
        if (i === 0) data.setUint8(c++, 0x42)
        else if (i === 1) data.setUint8(c++, 0x47)
        else if (i === 2) data.setUint8(c++, 0x52)
        data.setUint8(c++, 0x00)

        // Value: Float(2) Half(1) Uint(0)
        if (type === 'Uint') data.setUint8(c++, 0x00)
        else if (type === 'Half') data.setUint8(c++, 0x01)
        else if (type === 'Float') data.setUint8(c++, 0x02)
        data.setUint8(c++, 0x00)
        data.setUint8(c++, 0x00)
        data.setUint8(c++, 0x00)

        // Plinear
        data.setUint8(c++, 0x01)

        // Reserved
        data.setUint8(c++, 0x00)
        data.setUint8(c++, 0x00)
        data.setUint8(c++, 0x00)

        // X sampling
        data.setUint8(c++, 0x01)
        data.setUint8(c++, 0x00)
        data.setUint8(c++, 0x00)
        data.setUint8(c++, 0x00)

        // Y sampling
        data.setUint8(c++, 0x01)
        data.setUint8(c++, 0x00)
        data.setUint8(c++, 0x00)
        data.setUint8(c++, 0x00)
    } // End Attribute
    data.setUint8(c++, 0x00)

    // write attribute name: compression
    c = writeStr(data, 'compression', c)

    // Write attribute type : "compression"
    c = writeStr(data, 'compression', c)

    // wirte attribute size 1
    data.setUint8(c++, 0x01)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    // write att value : 0 (None)
    data.setUint8(c++, 0x00)

    // datawindow
    c = writeStr(data, 'datawindow', c)

    // box2i
    c = writeStr(data, 'box2i', c)

    // size 16
    data.setUint8(c++, 0x10)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    // value 0 0 3 2
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    data.setUint32(c, width - 1, true)
    c += 4

    data.setUint32(c, height - 1, true)
    c += 4

    // displayWindow
    c = writeStr(data, 'displayWindow', c)

    // box2i
    c = writeStr(data, 'box2i', c)

    // size 16
    data.setUint8(c++, 0x10)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    // value 0 0 3 2
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    data.setUint32(c, width - 1, true)
    c += 4

    data.setUint32(c, height - 1, true)
    c += 4

    // lineOrder
    c = writeStr(data, 'lineOrder', c)

    // lineOrder
    c = writeStr(data, 'lineOrder', c)

    // size
    data.setUint8(c++, 0x01)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    // value
    data.setUint8(c++, 0x00)

    // PixelAspectRatio
    c = writeStr(data, 'PixelAspectRatio', c)

    // float
    c = writeStr(data, 'float', c)

    // size 4
    data.setUint8(c++, 0x04)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    // value 1.0
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x80)
    data.setUint8(c++, 0x3f)

    // screenWindowCenter
    c = writeStr(data, 'screenWindowCenter', c)

    // v2f
    c = writeStr(data, 'v2f', c)

    // size 8
    data.setUint8(c++, 0x08)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    // value 0 0
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    // screenWindowWidth
    c = writeStr(data, 'screenWindowWidth', c)
    // float
    c = writeStr(data, 'float', c)

    // size
    data.setUint8(c++, 0x04)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)

    // value
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x00)
    data.setUint8(c++, 0x80)
    data.setUint8(c++, 0x3f)

    // end of header
    data.setUint8(c++, 0x00)

    // Scanline table
    const initc = c + height * 8
    for (let scanline = 0; scanline < height; scanline++) {
        const jump =
            initc + scanline * (8 + width * bytesPerComponent * numComponents)
        data.setUint32(c, jump, true)
        c += 4

        data.setUint32(c, 0x00, true)
        c += 4
    }

    // Scanlines
    for (let scanline = 0; scanline < height; scanline++) {
        // Scanline
        data.setUint32(c, scanline, true)
        c += 4

        // size 24
        const size = width * numComponents * bytesPerComponent
        data.setUint32(c, size, true)
        c += 4

        const numComponentsSource = 4 // number of components in the SOURCE image
        for (let component = 0; component < numComponents; component++) {
            for (let pixel = 0; pixel < width; pixel++) {
                // flip vertical, so we read OpenGL buffers without JS image flipping
                const v =
                    bytes[
                        (height - 1 - scanline) * width * numComponentsSource +
                            pixel * numComponentsSource +
                            (2 - component)
                    ]
                if (type === 'Float') {
                    data.setFloat32(c, v, true)
                } else if (type === 'Half') {
                    data.setUint16(c, v, true)
                }

                c += bytesPerComponent
            }
        }
    }

    return new Blob([buffer], { type: 'application/octet-stream' })
}

function writeStr(data: DataView, attribute: string, offset: number) {
    const len = attribute.length
    for (let i = 0; i < len; i++) {
        data.setUint8(offset++, attribute.charCodeAt(i))
    }
    data.setUint8(offset++, 0x00)

    return offset
}
