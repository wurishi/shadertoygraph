const path = require('path')
const fs = require('fs')

const exportDir = path.join(__dirname, 'export');
const assetFile = path.join(__dirname, 'export/all.json');

(() => {
    fs.readdir(exportDir, (err, files) => {
        if (err) {
            console.log(err)
            return
        }
        fs.writeFile(assetFile, JSON.stringify(files), 'utf-8', (writeErr) => {
            if (writeErr) {
                console.log(writeErr)
            } else {
                console.log('创建成功:', files.length)
            }
        })
    })
})()