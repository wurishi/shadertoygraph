import { LGraphNode } from "litegraph.js";
import * as CONSTANTS from '../constants';

export default class DefineNode extends LGraphNode {
    static title: string = '#define';

    constructor() {
        super(DefineNode.title);

        this.addInput('value', 'string');

        this.addOutput('name', 'string');
        this.addOutput(CONSTANTS.CODE, CONSTANTS.CODE_TYPE);
        this.properties = {
            name: 'foo',
            value: 'iTime',
        }
    }

    protected getCode(): string {
        const name = this.properties.name;
        const value = this.getInputDataByName('value') || this.properties.value;
        return `#define ${name} ${value}`;
    }

    getTitle(): string {
        return this.getCode();
    }

    onExecute(): void {
        const name = this.properties.name;
        this.setOutputData(0, name);
        this.setOutputData(1, this.getCode());
    }
}