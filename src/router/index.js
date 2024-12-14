const fs = require('fs')

const useRoutes = (app) => {
    /**
      + fs.readdirSync(__dirname) --> 获取当前目录下的所有的文件名称 --> 用于遍历当前目录下的所有文件进行所有路由表自动注册
     */
    fs.readdirSync(__dirname).forEach(filename => {
        if (filename == "index.js") return /* 当前目录下的入口文件 index 无需注册路由 <用于统一管理路由表> */

        const router = require(`./${filename}`)

        app.use(router.routes()) // 注册 users 路由中间件
        app.use(router.allowedMethods()) // 注册 users 路由自动校验无效路由 --> 自动丰富 response 相应头
    })
}

module.exports = useRoutes 