const app = require('./src/app')

const { APP_PORT } = require('./src/app/config')

app.listen(APP_PORT, () => {
    console.log('服务器启动成功...');
})