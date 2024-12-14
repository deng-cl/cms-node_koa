const jwt = require('jsonwebtoken');

const { JWTSECRET, JWT_EXPIRESIN } = require("../app/config")

class AuthController {
    async login(ctx, next) {
        const { id, username, phone, user_type_id } = ctx.userInfo

        const token = jwt.sign({ // 生成 token
            id,
            user_type_id,
            username,
        }, JWTSECRET, {
            expiresIn: JWT_EXPIRESIN,
        });

        ctx.body = {
            state: 200,
            msg: `登录成功，欢迎${username ?? "❌"}用户回来`,
            id,
            username,
            phone,
            user_type_id,
            token
        }
    }
}

module.exports = new AuthController()