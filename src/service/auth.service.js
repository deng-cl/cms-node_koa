const connection = require('../app/database')

class AuthService {
    async checkResource(username) {
        try {
            const statemen = 'SELECT * FROM user WHERE username = ? ;'

            const result = await connection.execute(statemen, [username])

            return result[0]

        } catch (error) {
            console.log("auth-service.js -- 12", error);
        }
    }

    async verifyIsBlackOrNormalUser(username) {
        try {
            const statemen = 'SELECT enable, user_type_id FROM user WHERE username = ? ;'

            const result = await connection.execute(statemen, [username])

            return result[0]

        } catch (error) {
            console.log("auth-service.js -- 27", error);
        }
    }
}


module.exports = new AuthService()