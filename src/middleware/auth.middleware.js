const H_ERROR_TYPES = require('../constants/types-error');

const authService = require('../service/auth.service')

const { JWTSECRET } = require("../app/config")

const jwt = require('jsonwebtoken')

const {
    md5password
} = require("../utils/passHandle-md5")

class AuthMiddleware {
    async verifyLoginInfo(ctx, next) { /* 用户登录信息校验 */

        let { username, password } = ctx.request.body

        // 1. 判断用户名或密码是否为空
        try {
            if (!username) { /* 用户名为空 */
                return ctx.app.emit('error', ctx, H_ERROR_TYPES.USERNAME_NOT_NULL);
            }
            if (!password) { /* 密码不能为空 */
                return ctx.app.emit('error', ctx, H_ERROR_TYPES.PASSWORD_NOT_NULL)
            }
        } catch (error) {
            console.log("auth-middleware.js -> ...");
        }

        // 2. 校验数据库张是否存在该用户
        const userInfo = await authService.checkResource(username)


        if (userInfo.length === 0) { /* 用户不存在 */
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.USER_NOT_EXISTS)
        }

        // 3. 判断密码是否正确
        if (md5password(password) === userInfo[0].password) { // md5 转码加密 -- 因为数据库中的密码是先通过 md5 转换后再进行存储的，所以再比对时也需要进行转换
            ctx.userInfo = userInfo[0] // 用户信息校验成功 -- 将用户信息存储到 ctx 中 --> 供后面的中间件使用
            await next()
        } else {
            ctx.app.emit('error', ctx, H_ERROR_TYPES.PASSWORD_INCORRECT)
        }
    }

    async verifyIsBlackOrNormalUser(ctx, next) { // -- 判断是否为黑名单用户
        let { username } = ctx.request.body

        const isBlackInfo = await authService.verifyIsBlackOrNormalUser(username)

        if (isBlackInfo[0].user_type_id === 3) {
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.Your_ACCOUNT_IS_NORMAL_USERE_NOT_AUTH)
        }

        if (isBlackInfo[0]?.enable == "false") {
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.YOUR_USERNAME_IS_BLACK_USER)
        }

        else await next()
    }

    async verifyIsBlackUser(ctx, next) { // -- 判断是否为黑名单用户
        let { username } = ctx.request.body

        const isBlackInfo = await authService.verifyIsBlackOrNormalUser(username)

        ctx.user_type_id = isBlackInfo[0].user_type_id // -- 存储用户类型，用于再下面的 verifyIsNormalUser 中进行使用

        if (isBlackInfo[0]?.enable == "false") {
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.YOUR_USERNAME_IS_BLACK_USER)
        }

        else await next()
    }

    async verifyIsClientUser(ctx, next) { // -- 判断是否为普通用户 → 此方法用于普通用户端的登录接口，如果非普通用户 → 登录失败: 用户类型错误
        // if (ctx.user_type_id !== 3) return ctx.app.emit('error', ctx, H_ERROR_TYPES.USER_TYPE_ERROR)
        if (ctx.user_type_id === 0) return ctx.app.emit('error', ctx, H_ERROR_TYPES.USER_TYPE_ERROR)
        await next()
    }

    async verifyLoginState(ctx, next) { /* 校验当前的登录状态 */
        // 1.获取 token 信息
        const authorization = ctx.headers.authorization

        // // 2.验证 token 
        try {
            if (!authorization) throw new Error(H_ERROR_TYPES.UNAUTHORIZED) // token 为 undefined 时

            const token = authorization.replace("Bearer ", "") // 截取 token 

            const result = jwt.decode(token, JWTSECRET, (err) => {
                if (err) {
                    throw new Error(err)
                }
            })

            ctx.userInfo = result // 将授权成功的用户信息，放入 ctx.userInfo 中，供后续中间件使用
            await next()
        } catch (e) { // 当 jwt 解析 token 失败时，会抛出错误 --> 所以需要使用 try catch 来捕获该 token 验证失败的错误
            console.log("auth-middlewarejs token catch", e);
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.UNAUTHORIZED)
        }
    }
}

module.exports = new AuthMiddleware() 