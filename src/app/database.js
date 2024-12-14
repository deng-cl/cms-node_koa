const mysql = require("mysql2")

const {
    MYSQL_HOST,
    MYSQL_PORT,
    MYSQL_DATABASE,
    MYSQL_ROOT,
    MYSQL_PASSWORD
} = require("./config")

let connections = mysql.createPool({ // 创建数据库连接池
    host: MYSQL_HOST,
    port: MYSQL_PORT,
    database: MYSQL_DATABASE,
    user: MYSQL_ROOT,
    password: MYSQL_PASSWORD
})

connections.getConnection((err, conn) => {
    if (!err) {
        console.log("数据库连接成功")
    } else {
        console.log("数据库连接失败", err)
    }
})

module.exports = connections.promise() // 导出 promise 化的 connections , 供其他文件来执行 SQL 操作