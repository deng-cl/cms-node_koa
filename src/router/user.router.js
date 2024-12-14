const Router = require("koa-router")
const userRouter = new Router({ prefix: "/user" })

const {
    verifyLoginState
} = require('../middleware/auth.middleware')

const {
    verifyIsRoot,
    verifyUserExists,
    verifyIsNormalUser,
    verifyUserRegisExists,
    verifyMerchantInfo,
    queryAndverifyMerchantInfo,
    verifyNormalInfo
} = require("../middleware/user.middleware")

const {
    registereMerchant,
    handleNormalUserToMerchant,
    registereNormal,
    getMenuListByUserTypeId,
    sendInfoInRoot,
    deleteUserInfo,
    queryMerchantList,
    queryUserListByLike,
    queryUser3All,
    queryUserInfoById,
    queryUserInfoByLoginToken,
    updateUserInfoById,
    deleteUserById,
    queryMerchantRegisterInfo,
    updateUserEnableById,
    queryUserAvatar,
    queryUserTypeList,
    queryUserCount,
    queryUserDisableUser,
    queryUserDetailById,
    queryIsInRegisry
} = require('../controller/user.controller')

/* root 用户: 商家用户注册 --> 
    verifyLoginState:校验当前登录状态  
    verifyIsRoot:校验当前是否位root用户登录 
    verifyUserExists:查找是否存在该用户
    verifyMerchantInfo:验证商家注册信息的完整性 
    registereMerchant:注册商家 */
userRouter.post('/registry/merchant', verifyLoginState, verifyIsRoot, verifyUserExists, verifyMerchantInfo, registereMerchant)
/** root 用户: 同意普通用户申请为商家用户
    verifyLoginState, verifyIsRoot, verifyMerchantInfo
    handleNormalUserToMerchant: 将普通用户注册修改为商家用户
 */
userRouter.post('/registry/normal/to/merchant', verifyLoginState, verifyIsRoot, verifyMerchantInfo, handleNormalUserToMerchant)


// 注册普通用户
userRouter.post('/registry/normal', verifyUserExists, verifyNormalInfo, registereNormal)

/** 商家用户注册信息提交至 root 用户接口
    verifyLoginState:校验当前登录状态  
    verifyIsNormalUser: 判断是否存在普通用户，如果不存在，提示先注册普通用户，才能申请为商家用户
    verifyUserRegisExists:查找在用户注册表中是否存在该用户
    🚮废弃: verifyMerchantInfo:验证商家注册信息的完整性 
    queryAndverifyMerchantInfo:查找并校验数据的可行性
 */
userRouter.post('/merchant', verifyLoginState, verifyIsNormalUser, verifyUserRegisExists, queryAndverifyMerchantInfo, sendInfoInRoot)
// -- 根据 username 查找商家注册表中是否已经有对应的商家注册信息
userRouter.get("/merchant/inregisry", verifyLoginState, queryIsInRegisry)


/** root 用户: 删除用户信息（商家用户/普通用户） --> 
    verifyLoginState:校验当前登录状态  
    verifyIsRoot:校验当前是否位root用户登录,
    deleteUserInfo: 根据用户id删除用户信息
 */
userRouter.delete('/delete/:user_id', verifyLoginState, verifyIsRoot, deleteUserInfo)

/** 获取功能菜单导航列表 -->
 *  verifyLoginState:校验当前登录状态  
 */
userRouter.get('/get/menu', verifyLoginState, getMenuListByUserTypeId)

/** 查询商家用户列表 merchant_list --> 参数: limit=查询的数量 & offset=偏移量;
 *  requestMerchantList: 查询商家用户列表
 */
userRouter.get('/merchant_list', verifyLoginState, verifyIsRoot, queryMerchantList)

/** 查询商家或普通用户列表 --> 多条件字段模糊查询 + 分页
 *  queryUserListByLike: 模糊查询商家或用户用户列表
 */
userRouter.post('/user_list/like/:user_type', verifyLoginState, verifyIsRoot, queryUserListByLike)

/** 查询普通用户列表（All+分页查询 --> 有 limit 参数就分页，没有这就 All）
 *  queryUser3All All/分页查询普通用户列表
 */
userRouter.post('/user_3/all', verifyLoginState, verifyIsRoot, queryUser3All)

/** 根据 user id 查询某个 user 用户的基本信息
 */
userRouter.get('/userinfo/:id', verifyLoginState, queryUserInfoById)

/* 获取用户信息，根据登录信息获取对应用户信息 */
userRouter.get('/userinfo', verifyLoginState, queryUserInfoByLoginToken)

/** 根据 user id 修改某个 user 用户的基本信息
 */
userRouter.put('/userinfo', verifyLoginState, updateUserInfoById)


/** 
 * 查询商家用户注册信息列表
 */
userRouter.post("/merchant/register", verifyLoginState, verifyIsRoot, queryMerchantRegisterInfo)

// 修改用户状态 -- enable
userRouter.put("/merchant/up_enable", verifyLoginState, verifyIsRoot, updateUserEnableById)


// 获取用户头像信息
userRouter.get('/avatar', verifyLoginState, queryUserAvatar)


// 查询
userRouter.get('/type/info', verifyLoginState, verifyIsRoot, queryUserTypeList) // 获取用户类型数据信息
userRouter.get('/count/info', verifyLoginState, verifyIsRoot, queryUserCount) // 获取用户数量信息（总数...）


// -- 黑名单处理(查询禁用用户)
userRouter.get('/disable/list', verifyLoginState, verifyIsRoot, queryUserDisableUser) // 获取用户类型数据信息

// -- 根据用户 id 获取用户的详情信息(root 用户)
userRouter.get('/detail/:id', verifyLoginState, verifyIsRoot, queryUserDetailById) // 获取用户类型数据信息


module.exports = userRouter 