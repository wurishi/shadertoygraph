import { LGraphNode } from "litegraph.js";
import * as CONSTANTS from '../constants';

export default class FunctionNode extends LGraphNode {
    static title: string = 'function';

    protected offset = 1;

    constructor() {
        super(FunctionNode.title);

        // 0
        this.addInput(CONSTANTS.CODE, CONSTANTS.CODE_TYPE);

        // 0
        this.addOutput(CONSTANTS.CODE, CONSTANTS.CODE_TYPE);

        this.properties = {
            returnType: 'void',
            name: 'fun',
            argLen: 0,
        }

    }

    getTitle(): string {
        const { returnType, name } = this.properties;
        return `${returnType} ${name}`;
    }

    onPropertyChanged(property: string, value: any, prevValue: any): boolean | void {
        if (property === 'argLen') {
            const newArgLen = +value;
            const len = this.inputs.length - this.offset
            if (len > newArgLen) {
                for (let i = len - 1; i >= newArgLen; i--) {
                    this.removeInput(i + this.offset);
                }
            } else if (len < newArgLen) {
                for (let i = len; i < newArgLen; i++) {
                    this.addInput('arg' + i, 'string');
                }
            }
        }
    }

    onExecute(): void {
        const fnBody = this.getInputDataByName(CONSTANTS.CODE) || '';
        const { argLen } = this.properties;
        const argArr = [];
        for (let i = 0; i < argLen; i++) {
            let arg = this.getInputData(i + this.offset);
            if (arg) {
                if (arg.endsWith(';')) {
                    arg = arg.substring(0, arg.length - 1);
                }
                argArr.push(arg);
            }
        }

        const code = `${this.getTitle()}(${argArr.join(' ,')}) {
            ${fnBody}
        }`;
        this.setOutputData(0, code);
    }
}