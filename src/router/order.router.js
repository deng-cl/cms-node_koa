const Router = require("koa-router")
const orderRouter = new Router({ prefix: "/order" })
// -------------------------------------------------------------------------------------
const { verifyLoginState } = require("../middleware/auth.middleware")

const { handleOrderInfo, handleOrderStatus } = require("../middleware/order.middleware")

const { submitOrder, updateOrderStatus, queryStatisticsData, queryOrderListByStatusText, queryOrderListByLike, queryOrderListOfClient } = require("../controller/order.controller")



// -- 订单的提交
orderRouter.post("/submit", verifyLoginState, handleOrderInfo, submitOrder)

// -- 修改订单状态（后续可以在前台通过当前登录的用户 id 是否为当前订单的用户来进行是否有权限来修改订单状态）
orderRouter.put('/status', verifyLoginState, handleOrderStatus, updateOrderStatus) // -- status → 0 待完成（用户下单）: 1 已发货（商家发货）: 2 已完成（用户确认收货）: -1 退款申请（用户申请退款）: -2 退款成功（商家同意退款）

// -- 获取统计数据 → 商品数量 + 商品销售量 / 订单状态统计
orderRouter.get('/view', verifyLoginState, queryStatisticsData)

// -- 获取订单列表 - 客户端（根据用户登录信息，获取当前登录用户的订单数据）
orderRouter.get("/client", verifyLoginState, queryOrderListOfClient)

// -- 查询订单信息 - 模糊查询
orderRouter.post("/", verifyLoginState, queryOrderListByLike)

// -- 查询订单信息（通过传递 parma 参数 statusText 来查询对应状态的订单信息 : 也可以通过 query 中的 limit/offset 来进行分页查找） : statusText → 'pedding' | 'fulfill' | 'failed'
orderRouter.get("/:statusText?", verifyLoginState, queryOrderListByStatusText)


module.exports = orderRouter