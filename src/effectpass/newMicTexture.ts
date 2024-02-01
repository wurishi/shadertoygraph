import { EffectPassInfo, EffectPassInput } from "../type";

export default function NewMicTexture(
    wa: AudioContext,
    gl: WebGL2RenderingContext,
    url: EffectPassInfo): EffectPassInput {

    const num = 512;
    const input: EffectPassInput = {
        mInfo: url,
        loaded: false,
        mic: {
            num,
            freqData: new Uint8Array(num),
            waveData: new Uint8Array(num),
        }
    }

    // navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
    
    // const n:any = navigator
    // console.log(wa)
    // console.log(n.mediaDevices)
    // // console.log(n.webkitGetUserMedia)
    // // console.log(n.mozGetUserMedia)
    // // console.log(n.msGetUserMedia)
    // if('getUserMedia' in navigator) {
    //     const getUserMedia = (navigator.getUserMedia as any);
    //     getUserMedia(({"audio": true}), function micStream(stream: any) {
    //         console.log(stream);
    //     }, function micError(error: any) {
    //         console.warn(error)
    //     });
    // }

    return input
}