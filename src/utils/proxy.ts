const base = '/proxy/22222';
// const base = '';

export default base;

export function getAssetsUrl(url:string):string {
    return base + url;
}