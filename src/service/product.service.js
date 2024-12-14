
const connection = require('../app/database')

class ProductService {
    async tagIsExists(tag) { // 查找是否已经存在该标签
        const statemen = 'SELECT * FROM product_tag WHERE tag_name = ?;'

        const result = await connection.execute(statemen, [tag])

        return result[0].length !== 0
    }
    async createProductTag(tag, msg) { // 创建商品标签 --> 向数据库中的商品表写入数据
        const statemen = 'INSERT INTO product_tag (tag_name,tag_msg) VALUE(?,?);'

        const result = await connection.execute(statemen, [tag, msg])

        return result[0]
    }

    async deleteProductTagById(id) {
        try {
            const statemen = 'DELETE FROM product_tag WHERE id = ?;'

            const result = await connection.execute(statemen, [id])

            return result[0]
        } catch (error) {
            if (error.message == 'Cannot delete or update a parent row: a foreign key constraint fails (`cms`.`product`, CONSTRAINT `product_ibfk_1` FOREIGN KEY (`product_tag_id`) REFERENCES `product_tag` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE)') {
                return false
            } else {
                throw new SyntaxError(error.message)
            }
        }
    }

    async updateProductTag(id, tag, msg) { // 根据商品标签 id 修改标签信息
        const statemen = 'UPDATE product_tag SET tag_name = ?,tag_msg = ? WHERE id = ?;'

        const result = await connection.execute(statemen, [tag, msg, id])

        return result[0]
    }

    async queryTagList() { // 分页查询商品标签
        const statemen = 'SELECT * FROM product_tag;'

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryProductTagList(limit, offset) { // 分页查询商品标签
        const statemen = 'SELECT * FROM product_tag LIMIT ? OFFSET ?;'

        const result = await connection.execute(statemen, [limit, offset])

        return result[0]
    }

    async queryProductTagListAll() { // 查询所有商品标签
        const statemen = 'SELECT * FROM product_tag;'

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryProductTagListByLike(tag, msg, limit, offset) { // 根据 tag & msg，查询存在对应关键字的商品列表 --> 模糊查询
        const statemen1 = `
            SELECT COUNT(*) total FROM product_tag WHERE tag_msg LIKE '%${msg}%' AND tag_name LIKE '%${tag}%';
        `
        const statemen2 = `
            SELECT * FROM product_tag WHERE tag_msg LIKE '%${msg}%' AND tag_name LIKE '%${tag}%' LIMIT ${limit} OFFSET ${offset};;
        `

        const getTotal = await connection.execute(statemen1) // 请求数据总数

        const getData = await connection.execute(statemen2) // 请求数据列表

        const result = {
            total: getTotal[0][0].total,
            size: getData[0].length,
            data: getData[0]
        }

        return result
    }

    async queryProductListAll() { // 获取所有商品数据
        const statemen = `
            SELECT # 查询所有商品 --> 连接多表，组合查询
                PRO.id,PRO.product_name, PRO.product_desc, PRO.product_price, PRO.product_discount , PRO.product_count, # 字段查询
                PRO.product_is_show, PRO.user_id ,
                JSON_ARRAYAGG( # 查询 pic url
                    JSON_OBJECT(
                        'id',PIC.id, 'imgUrl',PIC.product_pic_url
                    )
                ) AS pics,
                PRO.createAt, PRO.updateAt
            FROM product AS PRO
            LEFT JOIN product_pic AS PIC ON PRO.id = PIC.product_id
            GROUP BY PRO.id; # 按照产品ID分组, 确保每个产品只有一个JSON数组
        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryProductListLimit(limit, offset) { // 获取商品列表 --> 分页查询
        const statemen = `
            SELECT # 查询商品列表 --> 分页查询
                PRO.id,PRO.product_name, PRO.product_desc, PRO.product_price, PRO.product_discount , PRO.product_count, # 字段查询
                PRO.product_is_show, PRO.user_id ,
                JSON_ARRAYAGG( # 查询 pic url
                    JSON_OBJECT(
                        'id',PIC.id, 'imgUrl',PIC.product_pic_url
                    )
                ) AS pics,
                PRO.createAt, PRO.updateAt
            FROM product AS PRO
            LEFT JOIN product_pic AS PIC ON PRO.id = PIC.product_id
            GROUP BY PRO.id
            LIMIT ${limit} OFFSET ${offset}; # 按照产品ID分组, 确保每个产品只有一个JSON数组

        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryProductListOrderBy(type, limit, offset) {
        const statemen = `
            SELECT # 降序分页查询
                PRO.id,PRO.product_name, PRO.product_desc, PRO.product_price, PRO.product_discount , PRO.product_count, # 字段查询
                PRO.sales_count,PRO.product_is_show, PRO.user_id ,
                JSON_ARRAYAGG( # 查询 pic url
                    JSON_OBJECT(
                        'id',PIC.id, 'imgUrl',PIC.product_pic_url
                    )
                ) AS pics,
                PRO.createAt, PRO.updateAt
            FROM product AS PRO
            LEFT JOIN product_pic AS PIC ON PRO.id = PIC.product_id
            GROUP BY PRO.id
            ORDER BY PRO.sales_count ${type} LIMIT ${limit} OFFSET ${offset}; # 按照产品ID分组, 确保每个产品只有一个JSON数组
        `

        const result = await connection.execute(statemen, [type, limit, offset])

        return result[0]
    }

    async queryProductList(limit, offset, tagId) { // -- 在客户端获取所有商品信息（用于给用户进行展示、购买等）
        const statemen1 = `SELECT COUNT(*) AS total FROM product ${tagId ? 'WHERE product_tag_id=' + tagId : ""};` // -- 获取商品总数

        const statemen2 = ` 
            SELECT 
                PRO.id,PRO.product_name, PRO.product_desc, PRO.product_price, PRO.product_discount , PRO.product_count, # 字段查询
                PRO.sales_count,PRO.product_is_show, PRO.user_id , PTA.tag_name,U.username,
                JSON_ARRAYAGG( # 查询 pic url
                        JSON_OBJECT(
                                'id',PIC.id, 'imgUrl',PIC.product_pic_url
                        )
                ) AS pics,
                PRO.createAt, PRO.updateAt
            FROM product AS PRO
            LEFT JOIN product_pic AS PIC ON PRO.id = PIC.product_id
            LEFT JOIN product_tag AS PTA ON PRO.product_tag_id = PTA.id
            LEFT JOIN user AS U ON PRO.user_id = U.id
            WHERE PRO.product_is_show = true ${tagId ? 'AND PRO.product_tag_id=' + tagId : ""}
            GROUP BY PRO.id
            ORDER BY PRO.sales_count DESC LIMIT ${limit} OFFSET ${offset};
        ` // -- 分页获取商品

        const getTotal = await connection.execute(statemen1)

        const getData = await connection.execute(statemen2)

        const result = {
            total: getTotal[0][0].total,
            size: getData[0].length,
            data: getData[0]
        }

        return result
    }

    async queryProductSingleById(id) {
        const statemen = ` 
            SELECT 
                PRO.id,PRO.product_name, PRO.product_desc, PRO.product_price, PRO.product_discount , PRO.product_count, # 字段查询
                PRO.sales_count,PRO.product_is_show, PRO.user_id , PTA.tag_name,U.username,
                JSON_ARRAYAGG( # 查询 pic url
                        JSON_OBJECT(
                                'id',PIC.id, 'imgUrl',PIC.product_pic_url
                        )
                ) AS pics,
                PRO.createAt, PRO.updateAt
            FROM product AS PRO
            LEFT JOIN product_pic AS PIC ON PRO.id = PIC.product_id
            LEFT JOIN product_tag AS PTA ON PRO.product_tag_id = PTA.id
            LEFT JOIN user AS U ON PRO.user_id = U.id
            WHERE PRO.id = ${id};
        ` // -- 分页获取商品

        const result = await connection.execute(statemen)

        return result[0]
    }

    async queryProductListOrderByAndLike(tag_name, product_name, product_desc, isShow, min_price, max_price, limit, offset, createTime, id, isRoot) {

        const notRootStatemen = `AND PRO.user_id = ${id}` // 当请求数据的不是 Root 用户时 添加该条件查询 <商家用户只能查询自家的商品>

        const statemen1 = `
            SELECT # 降序分页查询
                COUNT(*) AS total
            FROM (
                SELECT PRO.id FROM product AS PRO
                LEFT JOIN product_pic AS PIC ON PRO.id = PIC.product_id
                LEFT JOIN product_tag AS PTA ON PRO.product_tag_id = PTA.id
                LEFT JOIN (
                    SELECT
                        S.id, SM.nickname,S.phone
                    FROM user AS S LEFT JOIN user_msg  AS SM ON S.user_msg_id = SM.id
                ) AS U ON PRO.user_id = U.id
                WHERE
                    PTA.tag_name LIKE "%${tag_name}%" AND PRO.product_name LIKE "%${product_name}%" AND PRO.product_desc LIKE "%${product_desc}%" AND PRO.product_is_show LIKE "%${isShow}%" AND # 模糊查询
                    PRO.product_price >= "${min_price}" AND PRO.product_price <= "${max_price}" AND
                    PRO.createAt BETWEEN "${createTime[0]} 00:00:00" AND  "${createTime[1]} 23:59:59" ${isRoot ? '' : notRootStatemen}
                    GROUP BY PRO.id
            ) AS list
            ;
        `

        const statemen2 = `
            SELECT # 降序分页查询
                PRO.id,PRO.product_name, PRO.product_desc, PRO.product_price, PRO.product_discount , PRO.product_count, # 字段查询
                PRO.sales_count,PRO.product_is_show, PRO.user_id , PTA.tag_name,U.username,
                JSON_ARRAYAGG( # 查询 pic url
                    JSON_OBJECT(
                        'id',PIC.id, 'imgUrl',PIC.product_pic_url
                    )
                ) AS pics,
                PRO.createAt, PRO.updateAt
            FROM product AS PRO
            LEFT JOIN product_pic AS PIC ON PRO.id = PIC.product_id
            LEFT JOIN product_tag AS PTA ON PRO.product_tag_id = PTA.id
            LEFT JOIN user AS U ON PRO.user_id = U.id
            WHERE
                PTA.tag_name LIKE "%${tag_name}%" AND PRO.product_name LIKE "%${product_name}%" AND PRO.product_desc LIKE "%${product_desc}%" AND PRO.product_is_show LIKE "%${isShow}%" AND # 模糊查询
                PRO.product_price >= "${min_price}" AND PRO.product_price <= "${max_price}" AND
                PRO.createAt BETWEEN "${createTime[0]} 00:00:00" AND  "${createTime[1]} 23:59:59"  ${isRoot ? '' : notRootStatemen} # 条件查询
            GROUP BY PRO.id
            ORDER BY PRO.sales_count DESC LIMIT ${limit} OFFSET ${offset}; # 按照产品ID分组, 确保每个产品只有一个JSON数组
        `



        const getTotal = await connection.execute(statemen1)

        const getData = await connection.execute(statemen2)

        const result = {
            total: getTotal[0][0].total,
            size: getData[0].length,
            data: getData[0]
        }

        return result
    }

    async updateShopState(id, state) { // 修改商品状态
        const statemen = `UPDATE product SET product_is_show = "${state}" WHERE id = ${id};`

        const result = await connection.execute(statemen)

        return result[0]
    }

    async getTagID(tag_name) {
        const statemen = `SELECT id FROM product_tag WHERE tag_name = ?;`

        const result = await connection.execute(statemen, [tag_name]) // 根据标签名，获取对应标签 ID

        return result[0]
    }

    async createProductInfo(name, desc, price, discount, count, tag_id, user_id) { // 创建商品信息
        const statemen = `
            INSERT INTO
                product (product_name,product_desc,product_price,product_discount,product_count,product_tag_id,user_id)
            VALUES (?,?,?,?,?,?,?); -- 写入商品 信息
        `

        const result = await connection.execute(statemen, [name, desc, price, discount, count, tag_id, user_id])

        return result[0]
    }

    async getBeforeProductPics(product_id) { // 获取更新前的商品详情图信息
        const statemen = `
            SELECT product_pic_url AS url FROM product_pic WHERE product_id = ${product_id}; -- 获取某一个商品的所有详情图 url 信息
        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async removeProductPics(before_file) { // 删除更新前的商品详情图信息
        const statemen = `DELETE FROM product_pic WHERE product_pic_url = '${before_file}';`

        const result = await connection.execute(statemen)

        return result[0]
    }

    async storageProductPicsInfoByProductID(product_id, filename, mimetype, size) { // 更新商品详情图信息
        const statemen = `
            INSERT INTO product_pic (product_pic_url,mimetype,size,product_id) VALUES ("${filename}","${mimetype}",${size},${product_id}); -- 更新/写入商品详情图
        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async getUserIdByProductID(id) { // 根据商品 ID 获取对应的所属用户 ID
        const statemen = `
            SELECT -- 获取用户某一商品的所属用户 ID <加 pics 字段版>
                PRO.user_id ,
                JSON_ARRAYAGG( # 查询 pic url
                    JSON_OBJECT(
                        'id',PIC.id, 'imgUrl',PIC.product_pic_url
                    )
                ) AS pics
            FROM product AS PRO
            LEFT JOIN product_pic AS PIC ON PRO.id = PIC.product_id
            WHERE PRO.id = ${id};
        `

        const result = await connection.execute(statemen)

        return result[0]
    }

    async deleteProductInfo(id) { // 根据商品 ID 删除对应商品信息

        const statemen_del_pics = 'DELETE FROM product_pic WHERE product_id = ?; -- 根据商品 ID 删除对应商品详情图信息'

        const statemen_del_info = 'DELETE FROM product WHERE id = ?; -- 根据商品 ID 删除对应商品的基本信息'

        try {
            await connection.execute(statemen_del_pics, [id])
            await connection.execute(statemen_del_info, [id])
        } catch (e) {
            console.log("product.service.js: deleteProductInfo", e)
            return false
        }

        return true
    }

    async updateProductInfo(name, desc, price, discount, count, isShow, product_id, tag_id) { // 修改商品基本信息
        const statemen = `
            UPDATE product SET
                product_name = ?,
                product_desc = ?,
                product_price=?,
                product_discount=?,
                product_count=?,
                product_is_show =?
            WHERE id = ?; # 修改商品标签
        `

        const result = await connection.execute(statemen, [name, desc, price, discount, count, isShow, product_id])
        await connection.execute(`UPDATE product SET product_tag_id = ${tag_id} WHERE id = ${product_id};`)

        return result[0]
    }

    async deleteProductPictureById(params, product_id) { // 删除对应详情图信息
        const del_before_pics = [] // 存储需要删除前面所用的商品详情图

        const statemen_get_all_pics = `
            SELECT product_pic_url FROM product_pic WHERE product_id = ${product_id}; 
        `

        const before_pics = (await connection.execute(statemen_get_all_pics))[0] // 获取更新前的所用商品详情图信息


        let del_pics_statemen = '' // 用于存储需要删除对应的条件判断
        before_pics.forEach((item, index) => { // 遍历出需要删除的 filename
            if (!item.product_pic_url) return

            if (!params.includes(item.product_pic_url.split('/').at(-1))) { // 判断该详情图是否包含在 params<需要保留的图片信息中> --> 如果不存在，说明不需要继续保存，将其存入 del_before_pics 中
                del_before_pics.push(
                    item.product_pic_url.split('/').at(-1) // 将需要删除的 filename 存入 del_before_pics 中 --> 该函数返回 del_before_pics --> 让后面删除对应的本地文件
                )
                del_pics_statemen += `product_pic_url = '${item.product_pic_url}' ${(before_pics.length - 1) === index ? '' : 'OR'} `
            }
        })

        // 删除对应不需要的 pics 信息
        if (del_pics_statemen.length > 0) {
            del_pics_statemen = '(' + del_pics_statemen + ') AND'
        }

        const statemen_del_pics = `
            DELETE FROM product_pic WHERE ${del_pics_statemen} product_id = ${product_id};
        `

        if (del_pics_statemen.length > 0) { // 判断 --> 当存在需要删除的信息数据时，才进行删除 --> 避免 "DELETE FROM product_pic WHERE  product_id = ?;" 直接删除所有详情图信息
            await connection.execute(statemen_del_pics) // 删除详情图对应的数据表信息
        }

        console.log(statemen_del_pics)

        return del_before_pics
    }

    async queryShopCountAll(isRoot, user_id) { // 获取所有商品数量
        const statemen = `
            SELECT
                COUNT(*) total,
                (SELECT COUNT(*) total FROM product WHERE product_is_show = 'true' ${isRoot ? '' : `AND user_id = ${user_id}`}) AS enable_total,
                (SELECT COUNT(*) total FROM product WHERE product_is_show = 'false' ${isRoot ? '' : `AND user_id = ${user_id}`}) AS disable_total
            FROM product ${isRoot ? '' : `WHERE user_id = ${user_id}`};
        `

        const result = await connection.execute(statemen, [user_id])

        return result[0]
    }

    async queryShopCountByTagType(tag_name, isRoot, user_id) { // 根据商品标签获取对应商品数量

        const statemen = `
            SELECT # 根据 tag 查询 --> 商品数量
                    COUNT(*) AS total
            FROM product AS PRO
            LEFT JOIN product_tag AS PTA ON PRO.product_tag_id = PTA.id
            WHERE PTA.tag_name LIKE "%${tag_name ?? '无'}%" ${isRoot ? '' : 'AND PRO.user_id = ?'};
        `

        const result = await connection.execute(statemen, [user_id])

        return result[0]
    }

    async searchProducts(searchText, limit, offset) { // -- 搜索商品
        const statemen1 = `SELECT COUNT(*) AS total FROM product WHERE product_name LIKE "%${searchText}%";` // -- 获取商品总数

        const statemen2 = ` 
            SELECT 
                PRO.id,PRO.product_name, PRO.product_desc, PRO.product_price, PRO.product_discount , PRO.product_count, # 字段查询
                PRO.sales_count,PRO.product_is_show, PRO.user_id , PTA.tag_name,U.username,
                JSON_ARRAYAGG( # 查询 pic url
                        JSON_OBJECT(
                                'id',PIC.id, 'imgUrl',PIC.product_pic_url
                        )
                ) AS pics,
                PRO.createAt, PRO.updateAt
            FROM product AS PRO
            LEFT JOIN product_pic AS PIC ON PRO.id = PIC.product_id
            LEFT JOIN product_tag AS PTA ON PRO.product_tag_id = PTA.id
            LEFT JOIN user AS U ON PRO.user_id = U.id
            WHERE PRO.product_name LIKE "%${searchText}%"
            GROUP BY PRO.id LIMIT ${limit} OFFSET ${offset};
        ` // -- 分页获取商品

        const getTotal = await connection.execute(statemen1)

        const getData = await connection.execute(statemen2)

        const result = {
            total: getTotal[0][0].total,
            size: getData[0].length,
            data: getData[0]
        }

        return result
    }

    async queryDiscountProduct() {
        const statemen = ` 
            SELECT
                    PRO.id,PRO.product_name, PRO.product_desc, PRO.product_price, PRO.product_discount , PRO.product_count, # 字段查询
                    PRO.sales_count,PRO.product_is_show, PRO.user_id , PTA.tag_name,U.username,
                    JSON_ARRAYAGG( # 查询 pic url
                                    JSON_OBJECT(
                                                    'id',PIC.id, 'imgUrl',PIC.product_pic_url
                                    )
                    ) AS pics,
                    PRO.createAt, PRO.updateAt
            FROM product AS PRO
            LEFT JOIN product_pic AS PIC ON PRO.id = PIC.product_id
            LEFT JOIN product_tag AS PTA ON PRO.product_tag_id = PTA.id
            LEFT JOIN user AS U ON PRO.user_id = U.id
            WHERE PRO.product_discount < '1'
            GROUP BY PRO.id;
        ` // -- 获取有折扣的商品列表

        const result = await connection.execute(statemen)

        return result[0]
    }
}

module.exports = new ProductService()