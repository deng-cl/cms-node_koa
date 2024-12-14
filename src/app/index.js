const Koa = require('koa')
const useRoutes = require("../router")
const bodyParser = require('koa-bodyparser')
const cors = require('koa2-cors');
const staticFiles = require('koa-static')
const path = require('path')

const app = new Koa()

app.use(bodyParser()) /* 注册 body 参数解析中间件 */

app.use(cors({ // 配置跨域等
    origin: '*',
    allowMethods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowHeaders: ['Content-Type', 'Authorization'],
    credentials: true,
    maxAge: 86400,
}));

useRoutes(app) /* 自动注册 router 目录下的所有路由表 */

// 定义静态目录
app.use(staticFiles(path.join(__dirname, "../../public")))

app.on("error", (ctx, errorInfo) => { // -- 处理通过 ctx.app.emit 触发的 'error' 事件，进行对应的错误响应 : 🔺具体错误信息再 /constants/types-error.js 中进行统一管理
    ctx.body = errorInfo
})

module.exports = app
