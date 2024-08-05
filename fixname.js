const fs = require('fs');
const path = require('path');

function createNodePromise(nodeFunction, ...args) {
    return new Promise((resolve, reject) => {
        nodeFunction.apply(null, [
            ...args,
            (err, files) => {
                if (err) {
                    reject(err);
                }
                resolve(files);
            },
        ]);
    });
}

const EXPORT_FOLDER = path.join(__dirname, 'export')
const NAME_JSON = path.join(__dirname, './src/name.json')
const TEST_JSON = path.join(__dirname, './src/name_test.json')

const IGNORE_FILES = {'.DS_Store': 1, 'all.json': 1}

async function checkFileNames() {
    let files = await createNodePromise(fs.readdir, EXPORT_FOLDER, 'utf-8');

    const nameJSON = await createNodePromise(fs.readFile, NAME_JSON, 'utf-8');
    let count = 0
    const json = JSON.parse(nameJSON)
    for (const key in json) {
        if (Object.hasOwnProperty.call(json, key)) {
            count++
        }
    }
    files = files.filter(f => !IGNORE_FILES[f])
    if (files.length !== count) {
        console.log(`file:[${files.length}] nameCount:${count}`)
        reSaveName(files)
    }
}

async function reSaveName(files) {
    const nameObj = {}
    let count = 0
    const len = files.length
    let file = ''
    try {
        for (let i = 0; i < len; i++) {
            file = files[i]
            const raw = await createNodePromise(fs.readFile, path.join(EXPORT_FOLDER, file), 'utf-8')
            const json = JSON.parse(raw);
            const [key] = (file + '').split('_');
            nameObj[key] = json.info.name
            count++
            if (count % 10000 === 0) {
                console.log(`finish: ${count}`);
            }
        }
    } catch (error) {
        console.log(file, error);
    }
    console.log(len, count);
    await createNodePromise(fs.writeFile, TEST_JSON, JSON.stringify(nameObj), 'utf-8');
    console.log('success');
}

checkFileNames()