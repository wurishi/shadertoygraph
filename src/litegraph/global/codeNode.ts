import { LGraphNode } from 'litegraph.js';
import * as CONSTANTS from '../constants';

export default class CodeNode extends LGraphNode {
    static title: string = 'codes';

    constructor() {
        super(CodeNode.title);

        // 0
        this.addOutput(CONSTANTS.CODE, CONSTANTS.CODE_TYPE);

        this.addInput('row1', 'string');

        this.properties = {
            rows: 1,
            code: '',
        }
    }

    onPropertyChanged(property: string, value: any, prevValue: any): boolean | void {
        if (property === 'rows') {
            const newRow = +value;
            const len = this.inputs.length;
            if (len > newRow) {
                for (let i = len - 1; i >= newRow; i--) {
                    this.removeInput(i);
                }
            } else if (len < newRow) {
                for (let i = len; i < newRow; i++) {
                    this.addInput('row' + (i + 1), 'string')
                }
            }
        }
    }

    onExecute(): void {
        const { rows } = this.properties;
        const codeArr: string[] = [];
        for (let i = 0; i < rows; i++) {
            const row = this.getInputData(i) || '';
            codeArr.push(row);
        }
        let codeRaw = this.properties.code || '';
        if (rows > 0) {
            codeRaw = codeArr.join('\n')
        }
        this.setOutputData(0, codeRaw);
    }
}