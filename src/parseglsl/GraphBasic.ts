export type GraphType = 'line';

export default class GraphBasic {
    private _start = 0;
    private _end = 0;
    private _code = '';
    private _type: GraphType = 'line';

    constructor(line:number, code:string) {
        this._start = line;
        this._end = line;
        this._code = code;
    }

    public get start() {
        return this._start;
    }

    public get end() {
        return this._end;
    }

    public get type() {
        return this._type;
    }

    public getCode(): string {
        return this._code;
    }

    public updateCode(code: string) {
        this._code = code;
    }
}