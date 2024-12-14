require('dotenv').config() /* 使用 dotenv 库 --> 自动注入 .env 环境变量 */


module.exports = {
    APP_HOST,
    APP_PORT,
    MYSQL_HOST,
    MYSQL_PORT,
    MYSQL_DATABASE,
    MYSQL_ROOT,
    MYSQL_PASSWORD,
    JWTSECRET,
    JWT_EXPIRESIN
} = process.env
