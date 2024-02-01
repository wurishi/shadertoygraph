import { LGraphNode } from 'litegraph.js';
import * as CONSTANTS from '../constants';

export default class VarNode extends LGraphNode {
    static title: string = 'variable';

    constructor() {
        super();

        // 0
        this.addInput('initValue', 'string');

        // 0
        this.addOutput(CONSTANTS.CODE, CONSTANTS.CODE_TYPE);
        // 1
        this.addOutput('Variable name', 'string');

        this.properties = {
            isConst: false,
            type: 'float',
            name: 'foo',
            isOut: false,
        };
    }

    protected getCode(): string {
        const { isConst, name, type, isOut } = this.properties;
        const initValue = this.getInputDataByName('initValue');
        let prefix = isConst ? 'const ' : '';
        if (isOut) {
            prefix = 'out ';
        }
        return `${prefix}${type} ${name} ${initValue === undefined ? '' : '= ' + initValue};`;
    }

    getTitle(): string {
        return this.getCode();
    }

    onExecute(): void {
        const { name } = this.properties;
        this.setOutputData(0, this.getCode());
        this.setOutputData(1, name);
    }
}