const connection = require("../app/database")
const H_ERROR_TYPES = require('../constants/types-error');

class OrderService {
    async addOrderInfo(ctx) { // -- 添加商品信息
        const { product_name, product_desc, product_price, product_discount, total_amount, address, product_pics, buy_count, customer_id, merchant_id, commodity_id } = ctx.request.body
        const order_number = `${Date.now()}_${customer_id}`
        // console.log(order_number, product_name, product_desc, product_price, product_discount, total_amount, address, product_pics, buy_count, customer_id, commodity_id, merchant_id);
        const statemen = 'INSERT INTO orders (order_number, product_name, product_desc, product_price, product_discount, total_amount, address, product_pics, buy_count, customer_id, merchant_id,commodity_id) VALUES (?,?,?,?,?,?,?,?,?,?,?,?);'
        const result = await connection.execute(statemen, [order_number, product_name, product_desc, product_price, product_discount, total_amount, address, product_pics, buy_count, customer_id, merchant_id, commodity_id])
        return result[0]
    }

    async updateProductCount(commodity_id, buy_count, ctx) { // -- 更新对应商品的在售数量与销售量
        const statemen1 = `SELECT product_count,sales_count FROM product WHERE id = ${commodity_id};`

        const countRes = await connection.execute(statemen1)

        const { product_count, sales_count } = countRes[0][0] // -- 获取原来的商品数量与销售量

        // -- 更新原来的数量
        const newCount = product_count - Number(buy_count)
        const newSalesCount = sales_count + Number(buy_count)
        const statemen2 = `UPDATE product SET product_count = ${newCount}, sales_count=${newSalesCount} WHERE id = ${commodity_id};`

        await connection.execute(statemen2)
    }

    async updateOrderStatus(order_id, status) { // -- 修改订单状态
        const statemen = `UPDATE orders SET status = '${status}' WHERE id = ${order_id};`

        await connection.execute(statemen)
    }

    // -- get order list by statusText
    async queryOrderListByStatusText(id, statusText, limit, offset) {
        const queryStatusText = handleStatusArrayToExpectText(statusText) // -- 匹配对应的状态类型并转换成对应的查询字符

        const statemen = `SELECT * FROM orders WHERE status IN (${queryStatusText}) AND merchant_id = ${id} LIMIT ${limit} OFFSET ${offset};`

        const res = await connection.execute(statemen)

        return res[0]

        function handleStatusArrayToExpectText(statusText) { // -- 将 status 数字转换成符合 SQL IN 关键字值类型的字符串 → 如: 'v1','v2',...
            let status = ['-2', '-1', '0', '1', '2'] // -- 默认查询订单列表类型

            switch (statusText) {
                case 'pedding': // -- 待处理
                    status = ['-1', '0', '1']
                    break
                case 'fulfill': // -- 已完成
                    status = ['2']
                    break
                case 'failed': // -- 已退款
                    status = ['-2']
                    break
            }

            let retStr = ``
            status.forEach((item, index) => {
                if (status.length - 1 !== index) retStr += `'${item}',`
                else retStr += `'${item}'`
            });
            return retStr
        }
    }

    // -- ↓ get statistics data 
    async queryProductTotalAndSales(id) { // -- get product total and sales info by merchant user id
        const statement = `
            SELECT # 获取商品数量，与对应的销售总和
                COUNT(*) as total, # 商品总和
                SUM(sales_count) as slaes # 总销售量
            FROM product WHERE user_id = ${id};
        `
        const res = await connection.execute(statement)
        return res[0]?.[0]
    }

    async queryProductTotalAndSalesByTagName(id) {// -- get product total and sales info by merchant user id and classify by tag name
        const tags = await getTags() // -- get tags info

        const tagsRequest = tags.map(item => {
            return connection.execute(`
                SELECT # 获取商品数量，与对应的销售总和
                    COUNT(*) as total, # 商品总和
                    SUM(sales_count) as slaes # 总销售量
                FROM product WHERE user_id = ${id} AND product_tag_id = ${item.id};
            `)
        })

        const res = (await Promise.all(tagsRequest)).map((item, index) => { // -- 根据标签类型获取商品总量与销售量
            return {
                tag_id: tags[index]?.id,
                tag_name: tags[index]?.tag_name,
                statistics: item[0]?.[0]
            }
        })

        return res

        // -- get tags 
        async function getTags() {
            const statement = `SELECT id, tag_name FROM product_tag;` // -- 查询所有商品标签 → 后续根据商品标签查询对应商品的数量与销售量
            const res = await connection.execute(statement)
            return res[0]
        }
    }

    async queryProductAndSalesCount(id) {
        const statisticsByAllProduct = await this.queryProductTotalAndSales(id)
        const statisticsByTagname = await this.queryProductTotalAndSalesByTagName(id)

        return [
            { // -- 所有商品与销售量
                isAll: true,
                statistics: statisticsByAllProduct
            },
            ...statisticsByTagname // -- 标签分类统计
        ]
    }

    async queryOrderStatusStatistics(id) { // -- get order statuses count
        const [pedding, fulfill, failed] = await Promise.all([
            connection.execute(`SELECT COUNT(*) as count FROM orders WHERE status IN ('-1','0','1') AND merchant_id = ${id};`), // -- 获取待完成 pending 状态的订单数量（包括 -1 用户退款申请未通过的）
            connection.execute(`SELECT COUNT(*) as count FROM orders WHERE status = '2' AND merchant_id = ${id};`), // -- 获取已完成 fulfill 状态的订单数量
            connection.execute(`SELECT COUNT(*) as count FROM orders WHERE status = '-2' AND merchant_id = ${id};`) // -- 获取已退款 failed 状态的订单数量
        ])

        return {
            pedding: pedding[0]?.[0]?.count,
            fulfill: fulfill[0]?.[0]?.count,
            failed: failed[0]?.[0]?.count
        }
    }

    async queryMerchantOrderCount(id) { // -- 获取商家订单量
        const statemen = `SELECT COUNT(*) AS count FROM orders WHERE merchant_id = ${id}; # 获取商家订单量`

        const res = await connection.execute(statemen)

        return res[0]?.[0]?.count
    }

    async querySaleAmount(id) { // -- 获取销售总额（已完成）
        const res = await connection.execute(`SELECT SUM(total_amount) as sales_amount FROM orders WHERE merchant_id = ${id} AND status = '2';`)
        return res[0]?.[0]?.sales_amount
    }

    async queryProductStatisticsData(id) {
        const normalStatistic = await this.queryProductAndSalesCount(id)
        const statusStatistic = (await this.queryOrderStatusStatistics(id)) ?? null
        const orderCount = (await this.queryMerchantOrderCount(id)) ?? null
        const salesAmount = (await this.querySaleAmount(id)) ?? null

        return {
            normalStatistic,
            statusStatistic,
            orderCount,
            salesAmount
        }
    }

    // -- ↓ get order list by link query
    async queryOrderListByLike(id, product_name, product_desc, statusText, createTime, limit, offset) {
        const queryStatusText = handleStatusArrayToExpectText(statusText) // -- 匹配对应的状态类型并转换成对应的查询字符

        const statemen = `
            SELECT * FROM orders   # -- 获取对应状态的订单列表 - 模糊查找
            WHERE
                merchant_id = ${id} AND
                product_name LIKE "%${product_name}%" AND
                product_desc LIKE "%${product_desc}%" AND
                status IN (${queryStatusText}) AND
	            createAt BETWEEN "${createTime[0]} 00:00:00" AND  "${createTime[1]} 23:59:59"
                LIMIT ${limit} OFFSET ${offset}
            ;
        `

        const totalRes = await connection.execute(`
            SELECT COUNT(*) AS total FROM orders  
            WHERE
                merchant_id = ${id} AND
                product_name LIKE "%${product_name}%" AND
                product_desc LIKE "%${product_desc}%" AND
                status IN (${queryStatusText}) AND
	            createAt BETWEEN "${createTime[0]} 00:00:00" AND  "${createTime[1]} 23:59:59"
            ;
        `)

        const res = await connection.execute(statemen)

        return {
            total: totalRes[0]?.[0].total ?? 0,
            size: res[0]?.length ?? 0,
            data: res[0]
        }

        function handleStatusArrayToExpectText(statusText) { // -- 将 status 数字转换成符合 SQL IN 关键字值类型的字符串 → 如: 'v1','v2',...
            let status = ['-2', '-1', '0', '1', '2'] // -- 默认查询订单列表类型

            switch (statusText) {
                case 'pedding': // -- 待处理
                    status = ['-1', '0', '1']
                    break
                case 'fulfill': // -- 已完成
                    status = ['2']
                    break
                case 'failed': // -- 已退款
                    status = ['-2']
                    break
            }

            let retStr = ``
            status.forEach((item, index) => {
                if (status.length - 1 !== index) retStr += `'${item}',`
                else retStr += `'${item}'`
            });
            return retStr
        }
    }

    async queryOrderListOfClient(id) {
        const statemen = `
            SELECT * FROM orders   
            WHERE customer_id = ${id} ORDER BY createAt DESC;
        ` // -- 获取订单列表，根据订单创建时间进行降序查找

        const res = await connection.execute(statemen)

        return res[0]
    }
}

module.exports = new OrderService()