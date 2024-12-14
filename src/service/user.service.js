const connection = require("../app/database")
const {
    md5password
} = require('../utils/passHandle-md5')

class UserService {
    async isExitsByUsername(username) { /* 根据username判断用户名是否已经被注册 */
        const statemen = 'SELECT * FROM user WHERE username = ?;'

        const result = await connection.execute(statemen, [username])

        return result[0].length === 0 ? false : true
    }

    async isExitsByPhone(phone) { /* 根据手机判断是否已经存在该用户 */
        const statemen = 'SELECT * FROM user WHERE phone = ?;'

        const result = await connection.execute(statemen, [phone])

        return result[0].length === 0 ? false : true
    }

    async isMerchantRegisExitsByUsername(username) { /* 根据手机判断是否已存在在用户注册表中 */
        const statemen = 'SELECT * FROM merchant_regis_application WHERE username = ?;'

        const result = await connection.execute(statemen, [username])

        return result[0].length === 0 ? false : true
    }

    async isMerchantRegisExitsByPhone(phone) { /* 根据username判断用户名是否已存在在用户注册表中 */
        const statemen = 'SELECT * FROM merchant_regis_application WHERE phone = ?;'

        const result = await connection.execute(statemen, [phone])

        return result[0].length === 0 ? false : true
    }

    async createMerchantInfo(ctx) { /* 写入商家用户注册基本信息 <用户信息表> */
        const { nickname, age, sex, name, id_card, shop_name } = ctx.request.body

        const statemen = 'INSERT INTO user_msg (nickname, age, sex, name, id_card, shop_name) VALUES (?,?,?,?,?,?);'

        const result = await connection.execute(statemen, [nickname, age, sex, name, id_card, shop_name])

        return result[0]
    }

    async createNormalInfo(ctx) { /* 写入普通用户注册基本信息 <用户信息表> */
        const { nickname, age, sex, name } = ctx.request.body

        const statemen = 'INSERT INTO user_msg (nickname, age, sex, name) VALUES (?,?,?,?);'

        const result = await connection.execute(statemen, [nickname, age, sex, name,])

        return result[0]
    }

    async createMerchantUser(ctx) { /* 写入商家用户的信息 <用户表> */
        let { username, phone, password, user_msg_id, user_type_id } = ctx.request.body

        password = md5password(password) // md5 转码加密密码存储

        const statemen = 'INSERT INTO user (username, phone, password, user_msg_id, user_type_id) VALUES (?,?,?,?,?);'

        const result = await connection.execute(statemen, [username, phone, password, user_msg_id, user_type_id])

        return result[0]
    }

    async handleNormalUserToMerchant(username, id_card, shop_name) {
        try {
            // -- 根据 username 查找对应的 msgId 修改对应 msgId 行的信息
            const msgId = (await connection.execute(`SELECT user_msg_id FROM user WHERE username = ${username};`))[0][0]?.user_msg_id

            if (msgId) {
                // -- 修改用户类型（修改为商家用户）
                await connection.execute(`UPDATE user SET user_type_id = 2 WHERE username = "${username}";`)

                // -- 更新用户信息
                await connection.execute(
                    `UPDATE user_msg SET id_card = ${id_card}, shop_name = "${shop_name}" WHERE id = ${msgId};`
                )
                return true
            }
            return false
        } catch (err) {
            console.log("user.service.js → handleNormalUserToMerchant:", err);
            return false
        }
    }

    async getMenuListInfo(user_type_id) { // 根据 user_type_id 查找对应功能菜单列表
        const statemen = 'SELECT (menu_list) FROM menu WHERE user_type_id = ?;'

        const result = await connection.execute(statemen, [user_type_id])

        const formatList = []

        result[0].forEach(item => {
            formatList.push(item.menu_list)
        })

        result[0] = formatList

        return result[0]
    }

    async insertMerchantRegisInfo(ctx) { // 商家用户注册申请 --> 数据库写入
        // 1. 获取对应用户参数
        const { nickname = "H", sex = "未知", age, name, id_card, username, phone, password, shop_name = "小 H 的忠实粉丝" } = ctx.registryInfo
        // 2. 写入注册表
        const statemen = 'INSERT INTO merchant_regis_application (nickname, sex,age,name,id_card,username,phone,password,shop_name) VALUES(?, ?, ?, ?, ?, ?,?,?, ?);'

        const result = await connection.execute(statemen, [nickname, sex, age, name, id_card, username, phone, password, shop_name])

        return result[0]
    }

    async queryIsInRegisry(username) {
        const statemen = `SELECT * FROM merchant_regis_application WHERE username = ${username}`

        const result = await connection.execute(statemen)

        return result[0]
    }

    async deleteUserById(id) { // 根据 id 删除对应用户
        const statemen = 'DELETE FROM user WHERE id = ?;'

        const result = await connection.execute(statemen, [id])

        return result[0]
    }

    async queryMerchantUserList(limit, offset) { // 查询商家用户列表 --> 分页查询
        const statemen = `
            SELECT  # 所要查询的字段
                U.id,U.username,U.phone ,U.enable,M.nickname, M.age, M.sex, M.name,M.shop_name,
                U.user_type_id,U.user_msg_id,U.createAt,U.updateAt
            FROM user AS U
            LEFT JOIN user_msg as M ON U.user_msg_id = M.id # 左连接(连接user表与user_msg)
            WHERE user_type_id = 2
	        LIMIT ${limit === "" ? 9999999999999 : limit} OFFSET ${offset === "" ? 0 : offset};
        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryUserTotalByTypeId(username, phone, name, shop_name, enable, user_type, createTime) { // 根据类型 id 查询对应的用户中总数
        // const statemen = `SELECT COUNT(*) AS total FROM user WHERE user_type_id = ${user_type};`

        const statemen = `
            SELECT  # 所要查询的字段
                COUNT(*) AS total
            FROM user AS U
            LEFT JOIN user_msg as M ON U.user_msg_id = M.id # 左连接 <连接user表与user_msg>
            WHERE user_type_id = ${user_type} AND # 调价判断 --> 商家
                        username LIKE "%${username}%" AND phone LIKE "%${phone}%" AND name LIKE "%${name}%" AND shop_name LIKE "%${shop_name}%"  AND enable LIKE "%${enable}%" AND # 模糊查询（条件查询）
                        U.createAt BETWEEN "${createTime[0]} 00:00:00" AND  "${createTime[1]} 23:59:59"
            ;
        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryUserListByLike(username, phone, name, shop_name, enable, limit, offset, user_type, createTime) { // 查询商家或普通用户列表 --> 单个或多个条件字段进行模糊查询
        const statemen = `
            SELECT  # 所要查询的字段
                U.id,U.username,U.phone,U.enable,M.nickname, M.age, M.sex, M.name,M.shop_name,
                M.shop_name,UA.avatar_url,
                U.user_type_id,U.user_msg_id,U.createAt,U.updateAt
            FROM user AS U
            LEFT JOIN user_msg as M ON U.user_msg_id = M.id # 左连接 <连接user表与user_msg>
            LEFT JOIN user_avatar AS UA ON U.id = UA.user_id
            WHERE user_type_id = ${user_type} AND # 调价判断 --> 商家
                        username LIKE "%${username}%" AND phone LIKE "%${phone}%" AND name LIKE "%${name}%" AND shop_name LIKE "%${shop_name}%"  AND enable LIKE "%${enable}%" AND # 模糊查询（条件查询）
                        U.createAt BETWEEN "${createTime[0]} 00:00:00" AND  "${createTime[1]} 23:59:59"
            LIMIT ${limit === "" ? 9999999999999 : limit} OFFSET ${offset === "" ? 0 : offset};
        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryUser3All(limit, offset) { // 获取普通用户列表 --> All
        const statemen = `
            SELECT # 查询所有普通用户列表
                U.id,U.username,U.phone,U.password,
                UM.nickname,UM.sex,UM.age, UA.avatar_url,
                U.user_type_id,U.createAt,U.updateAt
            FROM user AS U
            LEFT JOIN user_msg AS UM ON U.user_msg_id = UM.id
            LEFT JOIN user_avatar AS UA ON U.id = UA.user_id
            WHERE U.user_type_id = 3
            LIMIT ${limit === "" ? 9999999999999 : limit} OFFSET ${offset === "" ? 0 : offset};
        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryUserInfoById(id) { // 根据用户 id 查询对应用户基本信息
        const statemen = `
            SELECT # 根据 id 查询对应用户信息
                U.id,U.username,U.phone,U.password,
                UM.name,UM.shop_name,
                UM.nickname,UM.id_card,UM.sex,UM.age, UA.avatar_url,
                U.user_type_id,U.createAt,U.updateAt
            FROM user AS U
            LEFT JOIN user_msg AS UM ON U.user_msg_id = UM.id
            LEFT JOIN user_avatar AS UA ON U.id = UA.user_id
            WHERE U.id = ?;
        `

        const result = await connection.execute(statemen, [id])

        return result[0]
    }

    async deleteUserById(id) {
        const statemen = 'DELETE FROM user WHERE id = ?;'

        const result = await connection.execute(statemen, [id])

        return result[0]
    }

    async queryMerchantRegisterInfo(username, name, phone, id_card, state, limit, offset, createTime) { // 查询商检注册信息列表
        const statemen1 = `
            SELECT COUNT(*) AS total FROM merchant_regis_application # 获取注册商家列表总数
	        WHERE username LIKE "%${username}%" AND name LIKE "%${name}%" AND phone LIKE "%${phone}%" AND id_card LIKE "%${id_card}%" AND state LIKE "%${state}%" AND
            createAt BETWEEN "${createTime[0]} 00:00:00" AND  "${createTime[1]} 23:59:59"
            ;  # 分页/模糊获取注册商家
        `

        const statemen2 = `
            SELECT * FROM merchant_regis_application
	        WHERE username LIKE "%${username}%" AND name LIKE "%${name}%" AND phone LIKE "%${phone}%" AND id_card LIKE "%${id_card}%" AND state LIKE "%${state}%" AND
            createAt BETWEEN "${createTime[0]} 00:00:00" AND  "${createTime[1]} 23:59:59"
            ORDER BY state DESC,createAt
            LIMIT ${limit === "" ? 9999999999999 : limit} OFFSET ${offset === "" ? 0 : offset};  # 分页/模糊获取注册商家
        `

        const getTotal = await connection.execute(statemen1)

        const getTota2 = await connection.execute(statemen2)

        const result = {
            total: getTotal[0][0].total,
            size: getTota2[0].length,
            data: getTota2[0]
        }

        return result
    }

    async upMerchantUserState(id) { // 根据商家用户注册申请表中的 id 参数，修改对应的注册状态为 true 
        const statemen = `UPDATE merchant_regis_application SET state = 'true' WHERE id = ${id};`

        const result = await connection.execute(statemen)

        return result[0]
    }

    async updateUserEnableById(id, enable) { // 根据用户 id 修改对应用户状态
        const statemen = `UPDATE user SET enable = '${enable}' WHERE id = ${id};`

        const result = await connection.execute(statemen)

        return result[0]
    }

    async updateUserInfoById(id, nickname, sex, age, name, id_card, username, phone, shop_name) { // 根据用户 ID 修改对应用户基本信息
        try {
            const getUserMsgId = `SELECT user_msg_id FROM user WHERE id = ${id}; -- 根据用户 ID 获取对应的用户信息表 ID`

            const getUserMsgIdResult = await connection.execute(getUserMsgId) // 获取用户信息表 ID 
            const { user_msg_id } = getUserMsgIdResult[0][0] // 用户信息表 ID

            const statemenUser = `UPDATE user SET username = "${username}", phone = "${phone}" WHERE id = ${id}; -- 修改用户名与所绑定的手机号`

            const statemenuserMsg = `UPDATE user_msg SET sex = "${sex}", age = "${age}",nickname = "${nickname}" ,name = "${name}",id_card = "${id_card}" , shop_name = "${shop_name}" WHERE id = ${user_msg_id}; -- 修改用户的基本信息`

            await connection.execute(statemenUser)

            await connection.execute(statemenuserMsg)

            return true
        } catch (e) {
            // console.log("user.service.js --> updateUserInfoById", e.message === "Cannot destructure property 'user_msg_id' of 'getUserMsgIdResult[0][0]' as it is undefined.");
            if (e.message === "Cannot destructure property 'user_msg_id' of 'getUserMsgIdResult[0][0]' as it is undefined.") {
                return {
                    error: true,
                    msg: "ID_NOT_FOUND"

                }
            } else {
                return {
                    error: true
                }
            }
        }
    }

    async queryUserAvatar(id) { // 根据用户 ID 获取对应的用户头像信息
        const statemen = 'SELECT * FROM user_avatar WHERE user_id = ?; -- 获取用于头像信息'

        const result = await connection.execute(statemen, [id])

        return result[0]
    }

    async queryUserTypeList() { // 获取用户类型列表
        const statemen = 'SELECT * FROM user_type;'

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryUserCount() { // 获取用户数量信息
        const statemen = `
            SELECT -- 获取用户总数
                COUNT(*) as total,
                (SELECT COUNT(*) FROM user WHERE user_type_id = 1) as root_total,
                (SELECT COUNT(*) FROM user WHERE user_type_id = 2) as merchant_total,
                (SELECT COUNT(*) FROM user WHERE user_type_id = 3) as normal_total,
                (SELECT COUNT(*) FROM user WHERE enable = 'true') as enable,
                (SELECT COUNT(*) FROM user WHERE enable = 'false') as disable
            FROM user;
        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryUserDisableUser(limit, offset) {
        const statemen = `
            SELECT # 查询所有普通用户列表
                    U.id,U.username,U.phone,U.password,
                    UM.nickname,UM.sex,UM.age, UA.avatar_url,UM.name,
                    U.user_type_id,U.createAt,U.updateAt
            FROM user AS U
            LEFT JOIN user_msg AS UM ON U.user_msg_id = UM.id
            LEFT JOIN user_avatar AS UA ON U.id = UA.user_id
            WHERE U.enable = 'false'
            LIMIT ${limit} OFFSET ${offset};
        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryUserDetailById(id) {
        const statemen = `
            SELECT # 查询所有普通用户列表
                U.id,U.username,U.phone,U.password,
                UM.nickname,UM.sex,UM.age, UM.name,UM.shop_name,UA.avatar_url,
                U.user_type_id,U.createAt,U.updateAt
            FROM user AS U
            LEFT JOIN user_msg AS UM ON U.user_msg_id = UM.id
            LEFT JOIN user_avatar AS UA ON U.id = UA.user_id
            WHERE U.id = ${id};
        `

        const result = await connection.execute(statemen)

        return result[0]
    }
}

module.exports = new UserService()
