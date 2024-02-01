import { defineConfig } from 'vite'
import base from './src/utils/proxy'

const hmr = base ? {
    host: '124.221.113.125:8080' + base
} : undefined

export default defineConfig({
    plugins: [],
    server: {
        port: 22222,
        hmr,
        watch: {
            usePolling: true
        },
    },
    base,
    publicDir: 'export',
})
