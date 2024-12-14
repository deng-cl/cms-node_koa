function verifyRequestParams(params) {
    try {
        Object.keys(params).forEach(key => {
            if (!params[key] || params[key] === '') {
                throw new Error()
            }
        })
        return true
    } catch (e) {
        return false
    }
}

module.exports = {
    verifyRequestParams
}