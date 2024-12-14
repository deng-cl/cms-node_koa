class HH_ERROR_TYPES {
    constructor() {
      /* 0 */ this.USERNAME_NOT_NULL = this._createError('username_not_null', '用户名不能为空')

      /* 1 */ this.PASSWORD_NOT_NULL = this._createError('password_not_null', '密码不能为空')

      /* 2 */ this.USER_NOT_EXISTS = this._createError('user_not_exists', '用户不存在')

      /* 3 */ this.PASSWORD_INCORRECT = this._createError('password_incorrect', '密码错误')

      /* 4 */ this.UNAUTHORIZED = this._createError('unauthorized', '认证失败，token无效', 401)

      /* 5 */ this.NOT_ROOT_USER = this._createError('not_root_user', '非root用户，权限不足', 403)

      /* 6 */ this.MISSING_PARAMETER = this._createError('missing_parameter', '缺少必要参数，请补充完整')

      /* 7 */ this.REGISTRATION_REJECTED = this._createError('registration_rejected', '注册失败，参数信息不完整，请补充所需参数')

      /* 8 */ this.USERNAME_ALREADY_EXISTS = this._createError('username_already_exists', '注册失败，用户名已存在')

      /* 9 */ this.PHONE_ALREADY_REGISTERED = this._createError('phone_already_registered', '注册失败，该手机号已被注册')

      /* 10 */ this.AVATAR_UPLOAD_FAILED = this._createError('avatar_upload_failed', '头像上传失败，请检查file.controller.js中的第3行', "000")

      /* 11 */ this.USERNAME_EXISTS_IN_REGISTRATION_TABLE = this._createError('username_exists_in_registration_table', '用户名已存在于注册表中，无法重复注册')

      /* 12 */ this.PHONE_EXISTS_IN_REGISTRATION_TABLE = this._createError('phone_exists_in_registration_table', '手机号已存在于注册表中，无法重新注册')

      /* 13 */ this.PRODUCT_TAG_ALREADY_EXISTS = this._createError('product_tag_already_exists', '创建失败，商品标签已存在，请勿重复创建')

      /* 14 */ this.REQUEST_PARAMS_INCOMPLETE = this._createError('request_params_incomplete', '请求参数不完整，请补充缺失的参数!')

      /* 15 */ this.REQUEST_FAILED = this._createError('request_failed', '修改失败: username | phone 或已存在')

      /* 16 */ this.PERMISSION_DENIED = this._createError('permission_denied', '权限不足', 401)

      /* 17 */ this.NOT_AUTHORIZED_FOR_PRODUCT = this._createError('not_authorized_for_product', '无权对该商品进行操作', 403)

      /* 18 */ this.MERCHANT_TEST_ACCOUNT = this._createError('merchant_test_account', '账号为商家测试账号，无法删除', 403)

      /* 19 */ this.YOUR_USERNAME_IS_BLACK_USER = this._createError('youe username is black user', '您的账号已被拉入黑名单（申诉请找管理员进行处理）')

      /* 20 */ this.Your_ACCOUNT_IS_NORMAL_USERE_NOT_AUTH = this._createError('youe account is normal user not auth', '该账号暂无权限登录后台管理系统', 403)

      /* 21 */ this.PRODUCT_CREATION_FAILURE_NON_MERCHANT_USER = this._createError('product_creation_failure_non_merchant_user', '商品创建失败:非商家用户', 403)

      /* 22 */ this.USER_TYPE_ERROR = this._createError('user_type_error', '用户类型错误，请检查您的账号或密码是否有误')

      /* 23 */ this.PARAMETER_ERROR = this._createError('parmater_error', 'ERRPR:购买失败，请联系系统管理员')

      /* 23 */ this.ERR_PARAM_UNEXPECTED = this._createError('err_param_unexpected', '参数错误，非预期参数值')

      /* 24 */ this.TAG_FOREIGN_KEY_CONSTRAINT_FAILS = this._createError('tag_foreign_key_constraint_fails', '删除失败，存在商品正在引用该标签')

      /* 25 */ this.USER_NOT_IS_NORMAL_TYPE = this._createError('user not is normal type', '申请失败，此账号非普通类型用户')
    }

    _createError(type, msg, status = 400) { // -- 创建对应格式的错误信息
        return { type, msg, status }
    }
}

module.exports = new HH_ERROR_TYPES()



