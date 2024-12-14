const path = require('path')
const fs = require('fs')

const H_ERROR_TYPES = require('../constants/types-error')
const productService = require('../service/product.service')

class ProductMiddleware {
    async verifyProductIsNowUser(ctx, next) { // 校验当前要操作的商品是否属于当前登录的用户
        const { product_id } = ctx.params // 获取商品 ID
        const userId = ctx.userInfo.id // 获取登录用户 id 

        const result = await productService.getUserIdByProductID(product_id) // 根据商品 ID 获取对应的所属用户 ID <顺带的获取对应的详情图列表 --> 用户后续中间件删除本地图片>

        if (result[0].user_id !== userId) { // 判断当前登录用户是否为对应该商品的所属用户 --> 非所属用户
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.NOT_AUTHORIZED_FOR_PRODUCT);
        }

        ctx.delete_pics = result[0].pics // 将商品详情图信息存储至 ctx.delete_pics 中

        await next()
    }


    async deleteProductPicsOfLocal(ctx, next) { // 删除商品本地详情图
        const pics = ctx.delete_pics // 获取该商品的详情图信息 --> delete_pics 来自上一个中间件存储
        const pics_name = [] // 存储 ↓ 遍历出对应的所有详情图的名称信息
        pics.forEach(item => { // 遍历出所有详情图的名称
            if (item.imgUrl) {
                pics_name.push(item.imgUrl?.split('/').at(-1) /* 截取对应的文件名称 */)
            }
        })

        pics_name.forEach(filename => { // 遍历删除本地详情图文件
            fs.unlink(path.join(__dirname, "../../public/product/", filename), (err) => {
                if (err) {
                    console.log("error", err)
                }
            })
        })

        await next()
    }
}


module.exports = new ProductMiddleware()