const crypto = require('crypto') // 内置库 crypto --> 用来做数据加密

const md5password = (password) => { // 加密 password
    typeof password == 'string' ? '' : password = String(password) // crypto.createHash 加密需要接收的是一个 string 类型的字符

    const md5 = crypto.createHash('md5')

    const result = md5.update(password).digest('hex')

    return result
}

module.exports = {
    md5password
}