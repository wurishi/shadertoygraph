import { download } from './index'

type IsRecordingCallback = {
    (isRecording: boolean): any
}

export default function createMediaRecorder(
    isRecordingCallback: IsRecordingCallback,
    canvas: HTMLCanvasElement
) {
    if (!canMediaRecorded(canvas)) {
        return null
    }

    const options = {
        audioBitsPerSecond: 0,
        videoBitsPerSecond: 8000000,
        mimeType: 'video/webm;',
    }
    const testMimeTypes = [
        'video/webm;codecs=h264',
        'video/webm;codecs=vp9',
        'video/webm;codecs=vp8',
    ]
    testMimeTypes.find((mimeType) => {
        if (MediaRecorder.isTypeSupported(mimeType)) {
            options.mimeType = mimeType
            return true
        }
        return false
    })

    const mediaRecorder = new MediaRecorder(canvas.captureStream(), options)

    let chunks: Blob[] = []

    mediaRecorder.addEventListener('dataavailable', (e) => {
        if (e.data.size > 0) {
            chunks.push(e.data)
        }
    })
    mediaRecorder.addEventListener('start', () => {
        isRecordingCallback(true)
    })
    mediaRecorder.addEventListener('stop', () => {
        isRecordingCallback(false)

        const blob = new Blob(chunks, { type: 'video/webm' })
        chunks = []

        download('capture.webm', blob)
    })

    return mediaRecorder
}

function canMediaRecorded(canvas: HTMLCanvasElement) {
    if (
        typeof window.MediaRecorder !== 'function' ||
        typeof canvas.captureStream !== 'function'
    ) {
        return false
    }
    return true
}
