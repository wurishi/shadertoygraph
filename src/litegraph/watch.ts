import { LGraphNode } from "litegraph.js";

export default class Watch extends LGraphNode {
    static title: string = 'Watch';

    value = '';
    constructor() {
        super(Watch.title);
        this.addInput('value', '', { label: '' })
    }

    onExecute(): void {
        if (this.inputs[0]) {
            this.value = this.getInputData(0);
        }
    }

    getTitle(): string {
        if (this.flags.collapsed) {
            return this.inputs[0] ? (this.inputs[0].label + '') : this.title;
        }
        return this.title;
    }

    onDrawBackground(ctx: CanvasRenderingContext2D, canvas: HTMLCanvasElement): void {
        this.inputs[0] && (this.inputs[0].label = this.value);
    }
}