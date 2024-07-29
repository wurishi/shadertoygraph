import { defineConfig } from 'vite'
import base from './src/utils/proxy'

const hmr = base ? {
    host: '1.94.119.31:8080' + base
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
