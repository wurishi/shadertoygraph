export default function binaryFile(binaryDataArrayBuffer: ArrayBuffer) {
    const mDataView = binaryDataArrayBuffer
    let mOffset = 0

    const file = {
        seek: (offset: number) => (mOffset = offset),
        readUInt8: () => {
            const res = new Uint8Array(mDataView, mOffset)[0]
            mOffset += 1
            return res
        },
        readUInt16: () => {
            const res = new Uint16Array(mDataView, mOffset)[0]
            mOffset += 2
            return res
        },
        readUInt32: () => {
            const res = new Uint32Array(mDataView, mOffset)[0]
            mOffset += 4
            return res
        },
        readUInt64: () => {
            return file.readUInt32() + (file.readUInt32() << 32)
        },
        readFloat32: () => {
            const res = new Float32Array(mDataView, mOffset)[0]
            mOffset += 4
            return res
        },
        readFloat32Array: (len: number) => {
            const src = new Float32Array(mDataView, mOffset)
            const res = new Array<number>()
            for (let i = 0; i < len; i++) {
                res[i] = src[i]
            }
            mOffset += 4 * len
            return res
        },
        readFloat32ArrayNative: (len: number) => {
            const src = new Float32Array(mDataView, mOffset)
            mOffset += 4 * len
            return src
        },
    }
    return file
}
