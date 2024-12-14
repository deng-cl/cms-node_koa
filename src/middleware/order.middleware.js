const { verifyRequestParams } = require('../utils/veryfyParams')

const orderService = require("../service/order.service")
const H_ERROR_TYPES = require('../constants/types-error');

class OrderMiddleware {
    async handleOrderInfo(ctx, next) {
        try {
            const { product_name, total_amount, address, buy_count, customer_id, merchant_id, commodity_id } = ctx.request.body

            if (!verifyRequestParams({ product_name, total_amount, address, customer_id, merchant_id, commodity_id })) { // 参数完整性校验 --> 校验不通过，参数缺少
                return ctx.app.emit('error', ctx, H_ERROR_TYPES.REQUEST_PARAMS_INCOMPLETE);
            }
            // -- 存储订单信息
            await orderService.addOrderInfo(ctx)

            // -- 修改对应商品信息（在售数量与销售量）
            await orderService.updateProductCount(commodity_id, buy_count, ctx)

            await next()
        } catch (error) {
            console.log("ERROR:可能是 commodity_id | customer_id 的外键约束问题");
            console.log(error);
            return ctx.app.emit('error', ctx, H_ERROR_TYPES.PARAMETER_ERROR)
        }
    }

    async handleOrderStatus(ctx, next) {
        const {
            order_id,
            status
        } = ctx.request.body // 获取用户 ID

        if (![-2, -1, 0, 1, 2].includes(Number(status))) return ctx.app.emit('error', ctx, H_ERROR_TYPES.ERR_PARAM_UNEXPECTED); // -- 参数错误

        // -- 修改状态
        await orderService.updateOrderStatus(order_id, status)

        await next()
    }
}

module.exports = new OrderMiddleware()