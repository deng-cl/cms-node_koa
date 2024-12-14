const connection = require("../app/database")

class FileService {
    async getUserAvatarById(userId) { /* 根据用户 ID 查询头像信息 */
        const statemen = 'SELECT * FROM user_avatar WHERE user_id = ?;'

        const result = await connection.execute(statemen, [userId])

        return result[0]
    }

    async removeAvatarInfoByUserId(userId) { /* 根据用户 ID 删除用户头像信息 */
        const statemen = 'DELETE FROM user_avatar WHERE user_id = ?;'

        const result = await connection.execute(statemen, [userId])

        return result
    }

    async storageAvatarInfoByUserID(userId, avatar_url, mimetype){ /* 根据用户 ID 存储头像信息 */
        const statemen = 'INSERT INTO user_avatar (avatar_url,mimetype,user_id) VALUES (?,?,?);'

        const result = await connection.execute(statemen, [avatar_url, mimetype, userId])

        return result[0]
    }
}

module.exports = new FileService()