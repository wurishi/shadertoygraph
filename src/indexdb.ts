import { getAssetsUrl } from "./utils/proxy";

const mock = {
    date: '1632532180',
    description: 'Experimenting with lines and stuff',
    id: '7dtSRr',
    name: '4',
    tags: ['lines'],
    username: "Jonkel"
}
type JSON_TYPE = typeof mock & { tagstr: string }
type IDBPrimaryKey = {
    keyPath?: string | string[] | null;
    autoIncrement?: boolean;
}

type IDBIndexKey = {
    name: string;
    keyPath: string | string[];
    multiEntry?: boolean;
    unique?: boolean;
}

export default async function (shaderNames: Record<string, string>) {
    const dbName = 'my_shader_toy';
    const objName = 'my_tags';
    const db = new IndexDB();
    await db.init(dbName);
    await db.open();
    const v = await db.createObject(objName,
        { keyPath: 'id', autoIncrement: false },
        [
            { name: 'name', keyPath: 'name', unique: false },
            { name: 'tags', keyPath: 'tagstr', unique: false }
        ]);

    // saveData(shaderNames, db, objName);

    // const arr = Object.values(shaderNames);
    // console.log(arr[0]);

    // 7dtSRr

    // const r = await db.add('my_tags', { id: 'ab' });
    // console.log(r);

    // fetch(getAssetsUrl('/' + arr[0] + '.json')).then(res => {
    //     res.json().then(raw => {
    //         const d = {
    //             date: raw.info.date,
    //             description: raw.info.description,
    //             id: raw.info.id,
    //             name: raw.info.name,
    //             tags: raw.info.tags,
    //             username: raw.info.username,
    //         };
    //         console.log(d);
    //         db.add('my_tags', d);
    //     })
    // })
}

async function saveData(shaderNames: Record<string, string>, db: IndexDB, objName: string) {
    const arr = Object.values(shaderNames);
    const keyArr = Object.keys(shaderNames);
    const len = arr.length;
    for (let i = 0; i < len; i++) {
        if (arr[i] === 'all') {
            continue;
        }
        if (!arr[i]) {
            console.log(i, keyArr[i]);
            continue;
        }
        const [k, hash] = arr[i].split('_');
        const dbRes = await db.get(objName, k);
        if (dbRes) {
            continue;
        }
        const res = await fetch(getAssetsUrl(`/${arr[i]}.json`));
        const raw = await res.json();
        const d = {
            date: raw.info.date,
            description: raw.info.description,
            id: raw.info.id,
            name: raw.info.name,
            tags: raw.info.tags,
            username: raw.info.username,
            tagstr: Array.isArray(raw.info.tags) ? raw.info.tags.join(',') : ''
        };
        await db.add(objName, d);
        console.log(`(${i}) ${d.id} save succ`);
    }
    console.log('finish');
}

function getDBFromEvent(evt: any): IDBDatabase {
    return evt.target.result;
}

class IndexDB {

    private _database: IDBDatabase | null = null;
    private _dbName: string = '';
    private _version: number = 1;

    public async init(dbName: string) {
        this._dbName = dbName;
        const v = await IndexDB.GetDatabaseVersion(dbName);
        this._version = v === -1 ? 1 : v;
    }

    public static async GetDatabaseVersion(dbName: string) {
        const dbList = await window.indexedDB.databases();
        const db = dbList.find(db => db.name === dbName);
        return db ? db.version! : -1;
    }

    public getRequest(version?: number) {
        version = version === undefined ? this._version : version;
        this._version = version;
        return window.indexedDB.open(this._dbName, version);
    }

    public createObject(objectName: string, primaryKey: IDBPrimaryKey, indexList?: IDBIndexKey[]) {
        return new Promise<number>((resolve, reject) => {
            if (this._database) {
                if (this._database.objectStoreNames.contains(objectName)) {
                    resolve(this._version);
                    return;
                }
                this._database.close();
                this._database = null;
                const req = this.getRequest(this._version + 1);
                req.addEventListener('upgradeneeded', (evt: any) => {
                    const db = getDBFromEvent(evt);
                    const store = db.createObjectStore(objectName, primaryKey);
                    if (Array.isArray(indexList)) {
                        indexList.forEach(indexKey => {
                            store.createIndex(indexKey.name, indexKey.keyPath, { multiEntry: indexKey.multiEntry, unique: indexKey.unique })
                        })
                    }
                    resolve(this._version);
                });
                req.addEventListener('success', (evt: any) => {
                    this._database = getDBFromEvent(evt);
                });
            } else {
                reject('请先open');
            }
        });
    }

    public open() {
        return new Promise<IDBDatabase>((resolve, reject) => {
            if (this._database) {
                resolve(this._database);
            } else {
                const req = this.getRequest();
                req.addEventListener('success', (evt: any) => {
                    this._database = getDBFromEvent(evt);
                    resolve(this._database);
                });
                req.addEventListener('error', evt => {
                    console.log(evt);
                    reject('error');
                });
            }
        });
    }

    public get(objectName: string, key: string) {
        return new Promise((resolve, reject) => {
            if (this._database) {
                const objStore = this._database.transaction(objectName, 'readonly')
                    .objectStore(objectName);
                const req = objStore.get(key);
                req.addEventListener('success', (evt: any) => {
                    resolve(evt.target.result);
                });
                req.addEventListener('error', (evt) => {
                    reject(evt);
                });
            }
        })
    }

    public add(objectName: string, data: any) {
        return new Promise<boolean>(resolve => {
            if (this._database) {
                const objStore = this._database.transaction(objectName, 'readwrite')
                    .objectStore(objectName);
                const req = objStore.get(data.id);
                req.addEventListener('success', (evt: any) => {
                    if (evt.target.result) {
                        resolve(false);
                    } else {
                        const req2 = objStore.add(data);
                        req2.addEventListener('success', evt => {
                            // console.log('succ2', evt);
                            resolve(true);
                        });
                        req2.addEventListener('error', evt => {
                            console.log('fail2', evt);
                        });
                    }
                });
                req.addEventListener('error', evt => {
                    console.log('fail', evt);
                });
            }
        })
    }

}