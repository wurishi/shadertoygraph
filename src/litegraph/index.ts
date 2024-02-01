import { LGraph, LGraphCanvas, LiteGraph, } from 'litegraph.js'
import 'litegraph.js/css/litegraph.css';
import Watch from './watch';

import DefineNode from './global/defineNode';
import FunctionNode from './global/functionNode';
import VarNode from './global/varNode';
import CodeNode from './global/codeNode';
import { GUI } from 'dat.gui';

LiteGraph.clearRegisteredTypes();

LiteGraph.registerNodeType('log/watch', Watch);

LiteGraph.registerNodeType('定义/define', DefineNode);
LiteGraph.registerNodeType('定义/var', VarNode);
LiteGraph.registerNodeType('定义/code', CodeNode);
LiteGraph.registerNodeType('定义/function', FunctionNode);


export default function (params: { gui: GUI, setCurrent: any }) {
    const { gui, setCurrent } = params;
    const canvas = document.getElementById('litegraph_canvas') as HTMLCanvasElement;

    const graph = new LGraph();
    const gCanvas = new LGraphCanvas(canvas, graph, { autoresize: true });

    graph.start();

    const init = () => {
        graph.clear();
        // graph.configure()
    }

    const saveCurrent = () => {
        const nodeJSON = graph.serialize()
        console.log(nodeJSON);
    };

    const guiData = {
        showLiteGraph: false,
        saveCurrent,
        init,
    }
    const folder = gui.addFolder('Graph');
    folder.add(guiData, 'showLiteGraph').name('显示 LiteGraph').onChange(v => {
        if (canvas.parentElement) {
            canvas.parentElement.style.visibility = v ? '' : 'hidden';
        }
    });
    folder.add(guiData, 'init').name('初始化');
    folder.add(guiData, 'saveCurrent').name('Save');

    folder.open();
    if (canvas.parentElement) {
        canvas.parentElement.style.visibility = 'hidden';
    }

    window.addEventListener('CurrentShader', (evt) => {
        // console.log(evt);
    });
}