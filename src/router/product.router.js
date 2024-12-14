const Router = require("koa-router")
const productRouter = new Router({ prefix: "/product" })

const {
    verifyLoginState
} = require('../middleware/auth.middleware')

const {
    verifyIsRoot,
} = require('../middleware/user.middleware')

const {
    verifyProductIsNowUser,
    deleteProductPicsOfLocal
} = require("../middleware/product.middleware")

const {
    createProductTag,
    deleteProductTag,
    updateProductTag,
    queryProductTagList,
    queryProductTagListAll,
    queryProductTagListByLike,
    queryProductList,
    queryProductListLimit,
    queryProductListAll,
    queryProductListOrderBy,
    queryProductListOrderByAndLike,
    updateShopState,
    createProductInfo,
    createProductPicture,
    deleteProductById,
    updateProductInfoById,
    updateProductPictureById,
    queryShopCountAll,
    queryShopCountByTagType,
    handleProductSearch,
    queryTagList,
    queryProductSingle,
    queryDiscountProduct
} = require('../controller/product.controller')

const { useFileStorage } = require('../utils/useFileStorage')

const upload = useFileStorage("../../public/product")

// 🔺商品标签接口 -------------------------------------------------------------------- ↓
productRouter.post("/create/tag", verifyLoginState, verifyIsRoot, createProductTag) // 创建商品标签

productRouter.delete("/delete/tag/:id", verifyLoginState, verifyIsRoot, deleteProductTag) // 删除商品标签

productRouter.put("/update/tag", verifyLoginState, verifyIsRoot, updateProductTag) // 删除商品标签

productRouter.get("/query/tag_list", verifyLoginState, verifyIsRoot, queryProductTagList) // 根据查询字符串参数（limit，offset），查询商品标签列表 --> 分页查询

productRouter.get("/query/tag_list_all", verifyLoginState, /* verifyIsRoot: 获取标签信息无需 Root 用户验证 */ queryProductTagListAll) // 查询所有商品标签

productRouter.post("/query/tag_list_like", verifyLoginState, verifyIsRoot, queryProductTagListByLike) // 查询商品标签列表（分页模糊查询）

productRouter.get('/tags', queryTagList)

// 🔺商品接口 -------------------------------------------------------------------- ↓
// 查询
productRouter.get("/datelist", verifyLoginState, verifyIsRoot, queryProductListLimit) // 获取商品信息列表接口 --> 分页查询
productRouter.get("/datelist/all", verifyLoginState, verifyIsRoot, queryProductListAll) // 获取所有商品信息接口 --> All
productRouter.get("/datelist/order_by", verifyLoginState, verifyIsRoot, queryProductListOrderBy) // 根据销量排序获取商品信息列表接口 --> 分页查询
productRouter.post("/datelist/order_by/like", verifyLoginState, queryProductListOrderByAndLike) // (🔺现用此接口)根据销量排序获取商品信息列表接口 --> 分页查询 + 模糊查询 <多表商品列表模糊查询 🔺模糊查询: 标签名称 + 商家昵称 + 是否为上架商品 🔺条件查询: 最小价格与最大价格>
productRouter.get("/count/info", verifyLoginState, queryShopCountAll) // 获取商品总数
productRouter.get("/count/by_tag_type", verifyLoginState, queryShopCountByTagType) // 根据商品标签类型获取对应商品的数量


// 删除
productRouter.delete("/delete/:product_id", verifyLoginState,/* 判断商品是否属于该用户 */ verifyProductIsNowUser,/* 当商品存在对应详情图时删除对应本地图片 */ deleteProductPicsOfLocal, deleteProductById) // 根据商品 ID 删除对应商品信息

// 修改
productRouter.put("/update/state", verifyLoginState, updateShopState)  // 修改商品状态
productRouter.put('/update/info/:product_id', verifyLoginState, verifyProductIsNowUser, updateProductInfoById) // 根据商品 ID 修改对应商品基本信息
productRouter.put('/update/picture/:product_id', verifyLoginState, verifyProductIsNowUser, upload.array('product', 9), updateProductPictureById) // 根据商品 ID 修改对应商品详情图


// 创建
productRouter.post("/create/info", verifyLoginState, createProductInfo) // 创建商品基本信息
productRouter.post("/create/picture/:product_id", verifyLoginState, upload.array('product', 9), createProductPicture) // 创建商品图像信息 --> 与上面的接口对应 <🔺也可以用作修改商品详情图>


// -- 客户端接口
productRouter.get("/list/:tagId?", queryProductList) // -- (获取商品列表) normal: 在客户端获取所有商品信息（用于给用户进行展示、购买等） → query 参数： limit/offset
productRouter.get("/single/:id?", queryProductSingle) // -- 获取单个商品数据
productRouter.get('/search/:searchText?', handleProductSearch) // -- query 参数： limit/offset（limit默认值: 99999999999）
productRouter.get('/discount', queryDiscountProduct) // -- 查询有优惠折扣的商品列表



module.exports = productRouter
