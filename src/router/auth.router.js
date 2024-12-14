const Router = require("koa-router")
const authRouter = new Router({ prefix: "/login" })

const {
    verifyLoginInfo,
    verifyIsBlackOrNormalUser,
    verifyIsBlackUser,
    verifyIsClientUser
} = require('../middleware/auth.middleware')

const {
    login
} = require('../controller/auth.controller')

/*  用户使用账号密码登录接口 | 后台管理系统
        verifyLogin:验证登录信息是否完全 
        verifyIsBlackOrNormalUser:验证是否为黑名用户
        login:处理登录后的逻辑<如返回 token ...> */
authRouter.post('/', verifyLoginInfo, verifyIsBlackOrNormalUser, login)


// -- 普通用户登录接口 : 商家用户也可以登录（客户端登录）
authRouter.post('/client', verifyLoginInfo, verifyIsBlackUser, verifyIsClientUser, login)




module.exports = authRouter