const fs = require('fs');
const path = require('path')
const fileService = require("../service/file.service")
const H_ERROR_TYPES = require('../constants/types-error');


class FileController {
    async storageAvatarInfoByUserID(ctx, nent) {
        // console.log(8923482094890, ctx.file, ctx.files);
        // 1. 获取头像上传的基本数据...
        const userId = ctx.userInfo.id
        const { mimetype, filename } = ctx.file
        const avatar_url = "/images/" + filename // 因为服务器地址可能会发送改变所以，不能再后端直接用服务器地址作为文件信息保存

        // 2. 判断是否已存在用户头像 --> 已存在用户头像 --> 将旧的头像进行删除
        const userAvatarInfo = await fileService.getUserAvatarById(userId)
        if (userAvatarInfo) {
            // 2.1 该用户在服务器中已有头像信息 --> 覆盖旧头像信息 <数据库>
            await fileService.removeAvatarInfoByUserId(userId)

            // 2.2 删除本地图片数据
            const oldFilename = userAvatarInfo[0]?.avatar_url?.split("/").at(-1)
            const filePath = path.join(__dirname, "../../public/images/" + oldFilename); // 文件路径

            fs.unlink(filePath, (err) => { // 删除某一路径下的文件
                if (err) {
                    console.error(`Error deleting file: ${err}`);
                    return;
                }
            });
        }

        // 3. 存储头像信息至服务器<数据库>
        const result = await fileService.storageAvatarInfoByUserID(userId, avatar_url, mimetype)

        if (result) {
            ctx.body = {
                state: 200,
                msg: "头像上传成功",
                insert_id: result.insertId,
                avatar_url,
                mimetype,
                user_id: userId
            }
        } else {
            return ctx.app.emit("error", ctx, H_ERROR_TYPES.AVATAR_UPLOAD_FAILED)
        }
    }
}
module.exports = new FileController()