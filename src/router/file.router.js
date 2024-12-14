const Router = require('koa-router')
const fileRouter = new Router({ prefix: '/file' })
const { storageAvatarInfoByUserID } = require("../controller/file.controller")
const { verifyLoginState } = require('../middleware/auth.middleware')

const { useFileStorage } = require('../utils/useFileStorage')
const upload = useFileStorage("../../public/images")

/** 用户头像上传接口
    verifyLoginState : 验证用户登录状态
    upload.single('avatar') : 头像图片存储
    storageAvatarInfoByUserID : 存储头像信息
 */
fileRouter.post('/avatar', verifyLoginState, upload.single('avatar'), storageAvatarInfoByUserID);

module.exports = fileRouter