const userService = require('../service/user.service')
const H_ERROR_TYPES = require("../constants/types-error")
const {
    verifyRequestParams
} = require('../utils/veryfyParams')
class UserController {
    async registereMerchant(ctx, next) {
        try {
            // 1. 商家信息表基本信息写入
            const userMsg = await userService.createMerchantInfo(ctx)

            // 2. 获取上面创建的商家用户的信息表信息 ID & user_type_id = 2 <商家为2>
            ctx.request.body.user_msg_id = userMsg.insertId
            ctx.request.body.user_type_id = 2

            // 创建用户 --> 写入用户表
            await userService.createMerchantUser(ctx)

            const { username, phone } = ctx.request.body

            ctx.body = {
                state: 200,
                msg: "registry merchant success!",
                username,
                phone
            }
        } catch (e) {
            console.log("user.controller.js 创建商检用户错误", e)
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.REGISTRATION_REJECTED);
        }
    }

    async handleNormalUserToMerchant(ctx, next) { // -- 同意申请为商家用户: 将普通用户注册修改为商家用户
        const { id, username, id_card, shop_name } = ctx.request.body

        try {
            const flag = await userService.handleNormalUserToMerchant(username, id_card, shop_name) // -- 更新信息

            if (flag) {
                await userService.upMerchantUserState(id) // -- 修改注册表中用户的状态
                ctx.body = {
                    state: 200,
                    msg: "用户类型更新成功"
                }
            }
        } catch (err) {
            ctx.body = {
                state: 400,
                msg: "未知错误，请联系管理员"
            }
        }
    }

    async registereNormal(ctx, next) {
        try {
            // 1. 普通信息表基本信息写入
            const userMsg = await userService.createNormalInfo(ctx)

            // 2. 获取上面创建的普通用户的信息表信息 ID & user_type_id = 3 <普通用户为3>
            ctx.request.body.user_msg_id = userMsg.insertId
            ctx.request.body.user_type_id = 3

            // 创建用户 --> 写入用户表
            await userService.createMerchantUser(ctx)

            const { username, phone } = ctx.request.body

            ctx.body = {
                state: 200,
                msg: "registry normal success!",
                username,
                phone
            }
        } catch (e) {
            console.log("user.controller.js 创建普通用户错误", e)
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.REGISTRATION_REJECTED);
        }
    }

    async getMenuListByUserTypeId(ctx, next) { // 根据用户类型 id 来获取对应类型的用户菜单导航
        // 1. 获取用户类型 id
        const { user_type_id } = ctx.userInfo

        // 2. 获取对应的功能菜单列表
        const menuInfo = await userService.getMenuListInfo(user_type_id)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: menuInfo
        }
    }

    async sendInfoInRoot(ctx, next) { // 商家用户注册申请
        // 将数据写入数据库中 --> 商家用户注册申请表
        try {
            await userService.insertMerchantRegisInfo(ctx)
            const { nickname, username, phone, shop_name } = ctx.registryInfo

            ctx.body = {
                state: 200,
                msg: '已提交用户注册信息',
                username,
                nickname,
                phone,
                shop_name
            }
        } catch (e) {
            console.log(e);
        }
    }

    async queryIsInRegisry(ctx, next) {
        const { username } = ctx.userInfo

        const res = await userService.queryIsInRegisry(username)

        ctx.body = {
            state: 200,
            msg: '查询成功',
            data: res
        }
    }

    async deleteUserInfo(ctx, next) { // 用户删除
        try {
            const id = ctx.params.user_id // 获取用户 ID

            if (id == 2) {
                throw new Error()
            } else {
                await userService.deleteUserById(id)

                ctx.body = {
                    msg: "delete success"
                }
            }
        } catch (e) {
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.MERCHANT_TEST_ACCOUNT);
        }
    }

    async queryMerchantList(ctx, next) { // 查询商家用户列表
        const { limit = 8, offset = 0 } = ctx.query

        try {
            const result = await userService.queryMerchantUserList(limit, offset)

            ctx.body = {
                state: 200,
                msg: "请求成功",
                size: result.length,
                data: result
            }
        } catch (e) {
            console.log("user.controller.js --> queryMerchantList", e);
        }
    }

    async queryUserListByLike(ctx, next) { // 获取商家或普通用户列表 --> 模糊查询
        const { user_type = '2' } = ctx.params // 用户类型

        const { username = '', phone = '', name = '', shop_name = '', enable = '', limit = 999999999, offset = 0, createTime = ["2003-12-25", "2103-12-25"] } = ctx.request.body

        const getTotalRresult = await userService.queryUserTotalByTypeId(username, phone, name, shop_name, enable, user_type, createTime) // 查询某类型用户的总数

        const result = await userService.queryUserListByLike(username, phone, name, shop_name, enable, limit, offset, user_type, createTime) // 数据列表查询

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: {
                total: getTotalRresult[0].total, // 用户总数
                size: result.length, // 本次返回的列表数量
                data: result // 本次查询所返回的用户列表
            }
        }
    }

    async queryUser3All(ctx, next) { // 查询普通用户列表 --> All/分页查询
        const { limit = 9999999999, offset = 0 } = ctx.query

        const result = await userService.queryUser3All(limit, offset)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            size: result.length,
            data: result
        }
    }

    async queryUserInfoById(ctx, next) { // 根据用户 id 查询对应用户基本信息
        const { id } = ctx.params

        const result = await userService.queryUserInfoById(id)

        if (!result?.length) { // -- length:0 / not length property
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.USER_NOT_EXISTS)
        }

        ctx.body = {
            state: 200,
            msg: "请求成功",
            size: 1,
            data: result
        }
    }

    async queryUserInfoByLoginToken(ctx, next) {
        const id = ctx.userInfo?.id

        if (!id) return ctx.app.emit('error', ctx, H_ERROR_TYPES.UNAUTHORIZED)

        const result = await userService.queryUserInfoById(id)

        if (!result?.length) { // -- length:0 / not length property
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.USER_NOT_EXISTS)
        }

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result[0]
        }
    }

    async deleteUserById(ctx, next) {
        const { id } = ctx.params

        const result = await userService.deleteUserById(id)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            response: result
        }
    }

    async queryMerchantRegisterInfo(ctx, next) { // 查询商家用户注册信息列表

        const { username = "", name = "", phone = '', id_card = '', state = '', limit = 999999999999, offset = 0, createTime = ["2003-12-25", "2103-12-25"] } = ctx.request.body

        const result = await userService.queryMerchantRegisterInfo(username, name, phone, id_card, state, limit, offset, createTime)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: {
                ...result
            }
        }
    }

    async updateUserEnableById(ctx, next) { // 根据用户 id 修改对应用户的状态 enable
        const { id, enable } = ctx.request.body // 获取对应的用户 id 与多要修改的状态 enable

        const result = await userService.updateUserEnableById(id, enable)

        ctx.body = {
            state: 200,
            msg: "状态修改成功",
            response: result
        }
    }

    async updateUserInfoById(ctx, next) { // 根据 user id 修改某个 user 用户的基本信息
        const { id, nickname, sex, age, name, id_card, username, phone, shop_name } = ctx.request.body // 获取请求参数
        console.log(id, nickname, sex, age, name, id_card, username, phone, shop_name);

        if (!verifyRequestParams({ id, nickname, sex, age, name, username, phone })) {// 参数完整性校验 --> 校验不通过，参数缺少
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.REQUEST_PARAMS_INCOMPLETE);
        }

        const result = await userService.updateUserInfoById(id, nickname, sex, age, name, id_card, username, phone, shop_name) // 修改用户信息

        if (result.error) {
            if (result.msg === 'ID_NOT_FOUND') return ctx.app.emit('error', ctx, H_ERROR_TYPES.USER_NOT_EXISTS);
            else return ctx.app.emit('error', ctx, H_ERROR_TYPES.REQUEST_FAILED);
        }

        ctx.body = {
            state: 200,
            msg: "以为您已更新用户信息!"
        }
    }

    async queryUserAvatar(ctx, next) { // 根据登录状态 --> 获取对应的用户头像信息
        const { id } = ctx.userInfo // 获取当前登录 ID

        const result = await userService.queryUserAvatar(id)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result[0]
        }
    }

    async queryUserTypeList(ctx, next) { // 获取用户类型信息
        const result = await userService.queryUserTypeList()

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result
        }
    }

    async queryUserCount(ctx, next) { // 获取用户数量信息
        const result = await userService.queryUserCount()

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result
        }
    }
    async queryUserDisableUser(ctx, next) { // 获取禁用用户列表（黑名单）
        const { limit = 999999999, offset = 0 } = ctx.query

        const userTotalResult = await userService.queryUserCount()

        const result = await userService.queryUserDisableUser(limit, offset)

        ctx.body = {
            state: 200,
            msg: "请求成功",

            data: {
                total: userTotalResult[0]?.disable, // 用户总数
                size: result.length, // 本次返回的列表数量
                data: result // 本次查询所返回的用户列表
            },
        }
    }


    async queryUserDetailById(ctx, next) {
        const { id } = ctx.params

        try {
            const result = await userService.queryUserDetailById(id)

            ctx.body = {
                state: 200,
                msg: "请求成功",
                data: result
            }
        } catch (e) {
            ctx.body = {
                state: 401,
                msg: "请求失败: 用户 id 异常",
            }
        }
    }
}

module.exports = new UserController()