const { join } = require('path')
const multer = require('@koa/multer');

const useFileStorage = (path = "../../public/other") => {
    const storage = multer.diskStorage({
        destination: function (req, file, cb) {
            cb(null, join(__dirname, path));
        },
        filename: function (req, file, cb) {
            const type = file.mimetype.split("/")[1]
            cb(null, Date.now() + '.' + type);
        }
    })

    const upload = multer({ storage: storage })

    return upload
}

module.exports = {
    useFileStorage
}