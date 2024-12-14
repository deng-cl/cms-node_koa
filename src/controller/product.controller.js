const productService = require("../service/product.service")
const H_ERROR_TYPES = require('../constants/types-error');
const path = require('path')
const fs = require('fs')

const {
    verifyRequestParams
} = require("../utils/veryfyParams")

class ProductController {
    async createProductTag(ctx, next) { // 创建商品标签
        const { tag, msg } = ctx.request.body

        const isHas = await productService.tagIsExists(tag) // 判断是否已经存在该标签

        if (isHas) {
            return ctx.app.emit("error", ctx, H_ERROR_TYPES.PRODUCT_TAG_ALREADY_EXISTS)
        }

        const result = await productService.createProductTag(tag, msg) // 创建标签

        ctx.body = {
            state: 200,
            msg: "商品标签创建成功",
            response: result
        }
    }

    async deleteProductTag(ctx, next) { // 删除商品标签
        const { id } = ctx.params

        const result = await productService.deleteProductTagById(id, ctx)

        if (!result) return ctx.app.emit("error", ctx, H_ERROR_TYPES.TAG_FOREIGN_KEY_CONSTRAINT_FAILS)

        ctx.body = {
            state: 200,
            msg: "标签删除成功",
            response: result
        }
    }

    async updateProductTag(ctx, next) { // 修改商品标签
        const { id, tag, msg } = ctx.request.body

        await productService.updateProductTag(id, tag, msg)

        ctx.body = {
            state: 200,
            msg: "商品标签修改成功",
            new_tag_data: {
                id,
                tag,
                msg
            },
            // response: result
        }
    }

    async queryTagList(ctx, next) { // 查询商品标签列表
        const result = await productService.queryTagList()

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result
        }
    }

    async queryProductTagList(ctx, next) { // 查询商品标签列表 --> 分页查询
        const { limit = 8, offset = 0 } = ctx.query

        const result = await productService.queryProductTagList(limit, offset)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result
        }
    }

    async queryProductTagListAll(ctx, next) { // 查询所有商品标签列表
        const result = await productService.queryProductTagListAll()

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result
        }
    }

    async queryProductTagListByLike(ctx, next) { // 查询商品标签 --> 模糊查询
        const { tag = '', msg = '', limit = 99999999999999, offset = 0 } = ctx.request.body

        const result = await productService.queryProductTagListByLike(tag, msg, limit, offset)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: {
                ...result
            }
        }
    }

    async queryProductList(ctx, next) { // -- 在客户端获取所有商品信息（用于给用户进行展示、购买等）
        const { limit = 999999, offset = 0, } = ctx.query

        const { tagId } = ctx.params

        const result = await productService.queryProductList(limit, offset, tagId)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: {
                ...result
            }
        }
    }

    async queryProductSingle(ctx, next) {
        const { id } = ctx.params

        const result = await productService.queryProductSingleById(id)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result?.[0]
        }
    }

    async queryProductListLimit(ctx, next) { // 获取商品信息列表接口 --> 分页查询
        const { limit = 8, offset = 0 } = ctx.query

        const result = await productService.queryProductListLimit(limit, offset)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            size: result.length,
            data: result
        }
    }

    async queryProductListAll(ctx, next) { // 获取所有商品信息接口 --> All
        const result = await productService.queryProductListAll()

        ctx.body = {
            state: 200,
            msg: "请求成功",
            size: result.length,
            data: result
        }
    }

    async queryProductListOrderBy(ctx, next) {
        const { type = "", limit = 8, offset = 0 } = ctx.query

        const result = await productService.queryProductListOrderBy(type, limit, offset)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            size: result.length,
            data: result
        }
    }

    async queryProductListOrderByAndLike(ctx, next) {
        //多表商品列表模糊查询 🔺模糊查询: 标签名称 + 商家昵称 + 是否为上架商品 🔺条件查询: 最小价格与最大价格

        const { /* 用户 ID */id, /* 用户类型 ID */user_type_id } = ctx.userInfo

        const isRoot = user_type_id === 1

        const { tag_name = '', product_name = '', product_desc = '', isShow = "", min_price = 0, max_price = 9999999999999, limit = 8, offset = 0, createTime = ["2003-12-25", "2103-12-25"] } = ctx.request.body

        const result = await productService.queryProductListOrderByAndLike(tag_name, product_name, product_desc, isShow, min_price, max_price, limit, offset, createTime, id, isRoot)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: {
                ...result
            }
        }
    }

    async updateShopState(ctx, next) {
        const { id, state } = ctx.request.body

        const result = await productService.updateShopState(id, state) // 修改商品状态

        ctx.body = {
            state: 200,
            msg: "商品状态修改成功",
            response: result
        }
    }

    async createProductInfo(ctx, next) { // 创建商品基本信息
        const { product_name, product_desc, product_price, product_discount, product_count, tag_name } = ctx.request.body
        const user_id = ctx.userInfo.id
        const user_type = ctx.userInfo?.user_type_id

        if (user_type == 2) { // -- 判断是否为商家用户
            const tag_id = (await productService.getTagID(tag_name))[0].id // 根据 tag_name 查询对应的 tag_id

            const flag = verifyRequestParams({ product_name, product_desc, product_price, product_discount, product_count, tag_id })  // 校验参数的完整性

            if (!flag) {
                return ctx.app.emit("error", ctx, H_ERROR_TYPES.MISSING_PARAMETER)
            }

            const result = await productService.createProductInfo(product_name, product_desc, product_price, product_discount, product_count, tag_id, user_id)

            ctx.body = {
                state: 200,
                msg: "商品创建成功!",
                response: result
            }
        } else {
            return ctx.app.emit("error", ctx, H_ERROR_TYPES.PRODUCT_CREATION_FAILURE_NON_MERCHANT_USER)
        }
    }

    async createProductPicture(ctx, next) { // 上传商品图片信息
        const { product_id } = ctx.params // 商品 ID

        const pic_list_info = [] // 上传图片的信息存储

        console.log(ctx.files)

        ctx.files && ctx.files.forEach(file => { // 存储每一个文件的信息
            pic_list_info.push({
                filename: "/product/" + file.filename,
                mimetype: file.mimetype,
                size: file.size
            })
        })

        // 删除之前的商品详情图
        try {
            const before_pics = await productService.getBeforeProductPics(product_id) // 获取商品之前所有详情图信息
            if (before_pics) {
                before_pics.forEach(async before_file => {
                    // <1> 该用户在服务器中已有图片信息 --> 覆盖旧详情图信息 <数据库>
                    await productService.removeProductPics(before_file.url)

                    // <2> 删除本地图片数据
                    const filePath = path.join(__dirname, "../../public/" + before_file.url); // 文件路径  
                    fs.unlink(filePath, (err) => { // 删除某一路径下的文件
                        if (err) {
                            console.error(`Error deleting file: ${err}`);
                            return;
                        }
                    });
                })
            }
        } catch (e) {
            console.log("product.controller.js: createProductPicture --> 删除之前的商品详情图 ", e)
        }

        // 存储新商品详情图信息
        try {
            pic_list_info.forEach(async file => {
                await productService.storageProductPicsInfoByProductID(product_id, file.filename, file.mimetype, file.size)
            })
        } catch (e) {
            console.log("product.controller.js: createProductPicture --> 存储新详情图信息 ", e)
        }

        ctx.body = {
            state: 200,
            msg: "商品详情图上传成功",
            size: pic_list_info.length
        }
    }


    async deleteProductById(ctx, next) {
        const { product_id } = ctx.params // 商品 ID

        await productService.deleteProductInfo(product_id) // 根据商品 ID 删除对应商品信息

        ctx.body = {
            state: 200,
            msg: "商品删除成功"
        }
    }

    async updateProductInfoById(ctx, next) { // 修改商品基本信息
        const { product_id } = ctx.params // 商品 ID
        const { product_name, product_desc, product_price, product_discount, product_count, isShow = 'true', tag_name } = ctx.request.body

        const flag = verifyRequestParams({ product_name, product_desc, product_price, product_discount, product_count, product_id, tag_name }) // 校验参数完整性

        if (!flag) {
            return ctx.app.emit("error", ctx, H_ERROR_TYPES.MISSING_PARAMETER)
        }

        const tag_id = (await productService.getTagID(tag_name))[0].id // 根据 tag_name 查询对应的 tag_id
        const result = await productService.updateProductInfo(product_name, product_desc, product_price, product_discount, product_count, isShow, product_id, tag_id) // 修改商品基本信息

        ctx.body = {
            state: 200,
            msg: "已为您更新商品信息",
            response: result
        }
    }

    async updateProductPictureById(ctx, next) { // 修改商品详情图信息
        const { product_id } = ctx.params // 商品 ID
        let params = [] // 获取 formData 额外参数 <🔺继续保留的详情图信息>
        if (ctx.request.body.params) {
            params = JSON.parse(ctx.request.body.params)
        }

        const files = ctx.files // 新图片信息

        // 1. 删除旧的详情图信息
        const del_before_pics = await productService.deleteProductPictureById(params, product_id) // 删除详情图数据表信息 --> 返回一个数组，里面的每一项为需要删除本地详情图的 filenane

        del_before_pics.forEach(filename => { // 删除本地旧的详情图照片
            if (filename) {
                const filePath = path.join(__dirname, "../../public/product/" + filename); // 文件路径  
                fs.unlink(filePath, (err) => { // 删除某一路径下的文件
                    if (err) {
                        console.error(`Error deleting file: ${err}`);
                        return;
                    }
                });
            }
        })

        // 2. 更新新的商品详情图信息
        try {
            files.forEach(async fileInfo => {
                await productService.storageProductPicsInfoByProductID(product_id, `/product/${fileInfo.filename}`, fileInfo.mimetype, fileInfo.size)
            })
        } catch (e) {
            console.log("product.controller.js: updateProductPictureById --> 存储新详情图信息 ", e)
        }

        ctx.body = {
            state: 200,
            msg: "已为您更新商品详情图信息"
        }
    }


    async queryShopCountAll(ctx, next) { // 获取商品总量
        const user_id = ctx.userInfo.id

        const isRoot = ctx.userInfo.user_type_id === 1 // 判断是否为 Root 用户 <非Root只能获取到自家的商品数量>

        const result = await productService.queryShopCountAll(isRoot, user_id)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result[0]
        }
    }

    async queryShopCountByTagType(ctx, next) { // 根据商品标签获取对应商品数量
        const tag_name = ctx.request.query?.tag_name ?? ctx.request.body.tag_name

        const user_id = ctx.userInfo.id

        const isRoot = ctx.userInfo.user_type_id === 1 // 判断是否为 Root 用户 <非Root只能获取到自家的商品数量>

        const result = await productService.queryShopCountByTagType(tag_name, isRoot, user_id)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result
        }
    }

    async handleProductSearch(ctx, next) { // -- 客户端: 商品搜索
        const { searchText = "" } = ctx.params

        const { limit = 99999999999, offset = 0 } = ctx.query

        const result = await productService.searchProducts(searchText, limit, offset)

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: {
                ...result
            }
        }
    }

    async queryDiscountProduct(ctx, next) { // -- 查询存在优惠折扣的商品列表

        const result = await productService.queryDiscountProduct()

        ctx.body = {
            state: 200,
            msg: "请求成功",
            data: result
        }
    }
}

module.exports = new ProductController()
