import { GUI } from 'dat.gui'
import GraphBasic from './GraphBasic';

// let graphList = new Array<GraphBasic>();
const graphListMap = new Map<number, GraphBasic[]>();

export default function (updateConfig: any, config: any, gui: GUI, passIndex: number) {
    // config.renderpass[passIndex].inputs[j]
    // const changeConfig = (inputIndex: number, part: any) => {
    //     const input = config.renderpass[passIndex].inputs[inputIndex]
    //     Object.keys(part).forEach(key => {
    //         const value = part[key]
    //         if (value) {
    //             input[key] = value
    //         } else {
    //             delete input[key]
    //         }
    //     })
    //     updateConfig(config)
    // }
    const changeCode = (code: string) => {
        const pass = config.renderpass[passIndex];
        pass.code = code;
        updateConfig(config);
    }

    const pass: {
        name: string;
        code: string;
    } = config.renderpass[passIndex];
    const graphList = groupGLSL(pass.code);
    graphListMap.set(passIndex, graphList);

    const uiData = {
        code() {
            createCodePanel(pass.name, passIndex, graphList, changeCode);
        }
    };
    gui.add(uiData, 'code');
}

function groupGLSL(code: string) {
    const arr = code.split('\n')
    const graphArr = arr.map((code, index) => new GraphBasic(index, code));

    return graphArr;
}

function createCodePanel(title: string, id: number, list: GraphBasic[], changeCode: any) {
    const destoryFnList: any[] = [];
    const dom: HTMLDivElement = document.querySelector('#tools')!;
    const panelID = `codePanel_${id}`;

    let panel: HTMLDivElement | null = document.querySelector('#' + panelID);
    if (!panel) {
        panel = document.createElement('div');
        panel.id = panelID;
        panel.className = 'codePanel';
        dom.appendChild(panel);

        const dragDom = document.createElement('div');
        dragDom.id = 'title';
        dragDom.innerHTML = title;
        panel.appendChild(dragDom);
    }

    const codeChange = (e: Event) => {
        const div = e.target as HTMLDivElement;
        const index = +(div.getAttribute('data-index')!);
        const content = div.innerText;
        // console.log('n', content.indexOf('\n'));
        const arr = content.split('\n');
        list[index].updateCode(arr.join(' '));
    };

    const listDiv = document.createElement('div');
    listDiv.className = 'list';
    panel!.appendChild(listDiv);
    const items: HTMLDivElement[] = []
    list.forEach((it, index) => {
        const line = document.createElement('div');
        line.className = 'line';
        line.innerHTML = `<div class="num">${it.start}</div>`;
        listDiv.appendChild(line);

        const item = document.createElement('div');
        item.setAttribute('data-index', index.toString());
        // item.innerHTML = it.getCode();
        item.innerText = it.getCode();
        // item.contentEditable = 'true';
        // item.contentEditable = 'plaintext-only';
        item.style.setProperty('-webkit-user-modify', 'read-write-plaintext-only');
        line.appendChild(item);
        item.addEventListener('input', codeChange);
        items.push(item);
    })
    destoryFnList.push(() => {
        items.forEach(it => {
            it.removeEventListener('input', codeChange);
        });
    });

    if (!document.querySelector(`#${panelID} #bottom`)) {
        const bottomDom = document.createElement('div');
        bottomDom.id = 'bottom';
        panel.appendChild(bottomDom);

        const applyBtn = document.createElement('button');
        applyBtn.innerHTML = '应用修改';
        bottomDom.appendChild(applyBtn);
        const applyFn = () => {
            changeCode(list.map(it => it.getCode()).join('\n'))
        };
        applyBtn.addEventListener('click', applyFn);

        const consoleBtn = document.createElement('button');
        consoleBtn.innerHTML = 'console';
        bottomDom.appendChild(consoleBtn);
        const consoleFn = () => {
            const str = list.map(it => it.getCode()).join('\n');
            console.log(str);
        }
        consoleBtn.addEventListener('click', consoleFn);

        // TODO:
        const closeBtn = document.createElement('button');
        closeBtn.innerHTML = '关闭';
        bottomDom.appendChild(closeBtn);
        const closeFn = () => {
            hideCodePanel(id, destoryFnList);
        };
        closeBtn.addEventListener('click', closeFn);

        destoryFnList.push(() => {
            closeBtn.removeEventListener('click', closeFn);
            applyBtn.removeEventListener('click', applyFn);
            consoleBtn.removeEventListener('click', consoleFn);
        });
    }
}

function hideCodePanel(id: number, destoryFnList: any[]) {
    destoryFnList.forEach(fn => {
        fn && fn();
    });

    const dom: HTMLDivElement = document.querySelector('#tools')!;
    const panelID = `codePanel_${id}`;

    let panel = document.querySelector('#' + panelID);
    if (panel) {
        dom.removeChild(panel);
    }
}