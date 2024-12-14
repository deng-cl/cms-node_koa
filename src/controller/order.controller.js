const orderService = require("../service/order.service")

class OrderController {
    async submitOrder(ctx, next) { // -- 订单提交
        const { order_number, product_name, product_desc, product_price, product_discount, product_total_amount, buy_count, product_pic } = ctx.request.body

        ctx.body = {
            state: 200,
            msg: "订单提交成功",
            data: { order_number, product_name, product_desc, product_price, product_discount, product_total_amount, buy_count, product_pic }
        }
    }

    async updateOrderStatus(ctx, next) { // -- 修改商品状态
        ctx.body = {
            state: 200,
            msg: "已更新商品状态"
        }
    }

    async queryStatisticsData(ctx, next) { // -- 获取商品统计数据
        const res = await orderService.queryProductStatisticsData(ctx.userInfo.id)

        ctx.body = {
            state: 200,
            msg: "数据请求成功",
            data: res
        }
    }

    async queryOrderListByStatusText(ctx, next) {
        const { statusText } = ctx.params
        const { limit = 20, offset = 0 } = ctx.query

        if (!['pedding', 'fulfill', 'failed', undefined, ""].includes(statusText)) {
            ctx.body = {
                status: 400,
                msg: `参数错误: '${statusText}' 并非预期的 'pedding' | 'fulfill' | 'failed' 参数`
            }
            return
        }

        const res = await orderService.queryOrderListByStatusText(ctx.userInfo.id, statusText, limit, offset)

        ctx.body = {
            state: 200,
            msg: "数据请求成功",
            data: res
        }
    }

    async queryOrderListByLike(ctx, next) { // -- 查询订单列表 - 模糊查询
        const { product_name = "", product_desc = "", statusText = "", limit = 20, offset = 0, createTime = ["2003-12-25", "2103-12-25"] } = ctx.request.body

        if (!['pedding', 'fulfill', 'failed', undefined, ""].includes(statusText)) {
            ctx.body = {
                status: 400,
                msg: `参数错误: '${statusText}' 并非预期的 'pedding' | 'fulfill' | 'failed' 参数`
            }
            return
        }

        const res = await orderService.queryOrderListByLike(ctx.userInfo.id, product_name, product_desc, statusText, createTime, limit, offset)

        ctx.body = {
            state: 200,
            msg: "数据请求成功",
            data: res
        }
    }

    async queryOrderListOfClient(ctx, next) { // -- 
        const res = await orderService.queryOrderListOfClient(ctx.userInfo.id)

        ctx.body = {
            state: 200,
            msg: "数据请求成功",
            data: res
        }

    }
}

module.exports = new OrderController()


