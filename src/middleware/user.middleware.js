
const H_ERROR_TYPES = require('../constants/types-error')
const userService = require('../service/user.service')

class UserMiddleware {
    async verifyIsRoot(ctx, next) { // 验证当前登录用户类型是否位 root
        const { user_type_id } = ctx.userInfo
        if (user_type_id != 1) { /* 非 root 用户 --> 无权限商家用户的创建 */
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.NOT_ROOT_USER);
        }

        await next()
    }

    async verifyUserExists(ctx, next) { /* 根据 phone 判断用户是否已注册 */
        const { phone = 'false', username = 'false' } = ctx.request.body

        if (phone === 'false' || username === 'false') { // 参数不全
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.REGISTRATION_REJECTED)
        }

        const usernameExists = await userService.isExitsByUsername(username)

        if (usernameExists) { /* 用户名已存在，无法注册失败 */
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.USERNAME_ALREADY_EXISTS)
        }

        const phoneExists = await userService.isExitsByPhone(phone)

        if (phoneExists) { /* 手机号已注册过，无法注册失败 */
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.PHONE_ALREADY_REGISTERED)
        }

        await next()
    }

    async verifyIsNormalUser(ctx, next) { // -- 判断是否存在普通用户，如果不存在，提示先注册普通用户，才能申请为商家用户
        const { user_type_id, id } = ctx.userInfo

        if (user_type_id !== 3) return ctx.app.emit('error', ctx, H_ERROR_TYPES.USER_NOT_IS_NORMAL_TYPE)

        await next()
    }

    async verifyMerchantInfo(ctx, next) { /* 校验商家注册的参数完整性 */

        const { nickname, name, id_card, shop_name, username, phone, password } = ctx.request.body

        if (!(nickname && name && id_card && username && phone && password)) { // 校验注册参数是否完整
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.MISSING_PARAMETER)
        }

        ctx.registryInfo = ctx.request.body

        await next()
    }

    async verifyUserRegisExists(ctx, next) {
        // -- 根据登录信息，获取用户 id → 用来后续将信息写入商家注册信息表中
        const userinfo = (await userService.queryUserInfoById(ctx.userInfo.id))[0]

        const { phone, username } = userinfo

        const usernameExists = await userService.isMerchantRegisExitsByUsername(username)

        if (usernameExists) { /* 用户名已存在注册表中，无法注册相同的用户名 */
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.USERNAME_EXISTS_IN_REGISTRATION_TABLE)
        }

        const phoneExists = await userService.isMerchantRegisExitsByPhone(phone)

        if (phoneExists) { /* 手机号已存在注册表中，无法重新注册 */
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.PHONE_EXISTS_IN_REGISTRATION_TABLE)
        }

        await next()
    }

    async queryAndverifyMerchantInfo(ctx, next) { /* 校验商家注册的参数完整性 */
        // -- 根据登录信息，获取用户 id → 用来后续将信息写入商家注册信息表中
        const userinfo = (await userService.queryUserInfoById(ctx.userInfo.id))[0]
        const { nickname, name, username, phone, password } = userinfo

        const { id_card, shop_name } = ctx.request.body // -- 必传参数

        if (!(nickname && name && id_card && shop_name && username && phone && password)) { // 校验注册参数是否完整
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.MISSING_PARAMETER)
        }

        ctx.registryInfo = { ...ctx.request.body, ...userinfo }

        console.log("ctx.registryInfo:", ctx.registryInfo);

        await next()
    }

    async verifyNormalInfo(ctx, next) { /* 校验普通用户注册的参数完整性 */

        const { nickname, name, username, phone, password } = ctx.request.body

        if (!(nickname && name && username && phone && password)) { // 校验注册参数是否完整
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.MISSING_PARAMETER)
        }

        ctx.registryInfo = ctx.request.body

        await next()
    }
}


module.exports = new UserMiddleware()