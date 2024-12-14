/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:3306
 Source Schema         : cms

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 14/12/2024 20:21:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `address_1` varchar(100) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `address_2` varchar(100) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `address_3` varchar(100) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, '广东省肇庆市', '广东省河源市源城区河源职业技术学院', NULL, 1, '2024-03-16 11:13:42', '2024-11-22 21:19:08');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `menu_list` json NULL,
  `user_type_id` int NULL DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_type_id`(`user_type_id` ASC) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 79 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (70, '{\"id\": 1, \"icon\": \"el-icon-monitor\", \"children\": [{\"path\": \"system_overview\", \"title\": \"系统总览\"}, {\"path\": \"tag_comfig\", \"title\": \"商品标签\", \"permission\": {\"query\": {\"msg\": \"system:tag:query\", \"name\": \"查询标签\"}, \"create\": {\"msg\": \"system:tag:create\", \"name\": \"创建标签\"}, \"delete\": {\"msg\": \"system:tag:delete\", \"name\": \"删除标签\"}, \"update\": {\"msg\": \"system:tag:update\", \"name\": \"修改标签\"}}}, {\"path\": \"data_overview\", \"title\": \"数据总览\"}, {\"path\": \"menu\", \"title\": \"菜单管理\"}], \"parent_title\": \"系统管理\"}', 1, '2024-03-27 19:23:33', '2024-04-11 11:02:39');
INSERT INTO `menu` VALUES (71, '{\"id\": 2, \"icon\": \"el-icon-user\", \"children\": [{\"path\": \"merchant_user\", \"title\": \"商家用户\", \"permission\": {\"query\": {\"msg\": \"user:merchant:query\", \"name\": \"查询商家\"}, \"create\": {\"msg\": \"user:merchant:create\", \"name\": \"创建商家\"}, \"enable\": {\"msg\": \"user:merchant:enable\", \"name\": \"启用商家\"}, \"disable\": {\"msg\": \"user:merchant:disable\", \"name\": \"禁用商家\"}}}, {\"path\": \"normal_user\", \"title\": \"普通用户\", \"permission\": {\"query\": {\"msg\": \"user:normal:query\", \"name\": \"查询普通用户\"}, \"create\": {\"msg\": \"user:normal:create\", \"name\": \"创建普通用户\"}, \"enable\": {\"msg\": \"user:normal:enable\", \"name\": \"启用普通用户\"}, \"disable\": {\"msg\": \"user:normal:disable\", \"name\": \"禁用普通用户\"}}}, {\"path\": \"merchant_regis\", \"title\": \"商家注册\", \"permission\": {\"query\": {\"msg\": \"user:merchant_regis:query\", \"name\": \"查询注册商家\"}, \"multi_pass\": {\"msg\": \"user:merchant_regis:multi_pass\", \"name\": \"批量通过注册\"}, \"single_pass\": {\"msg\": \"user:merchant_regis:single_pass\", \"name\": \"单个通过注册\"}}}, {\"path\": \"black_list\", \"title\": \"黑名单用户\"}], \"parent_title\": \"用户管理\"}', 1, '2024-03-27 19:23:33', '2024-04-06 16:03:02');
INSERT INTO `menu` VALUES (72, '{\"id\": 3, \"icon\": \"el-icon-goods\", \"children\": [{\"path\": \"shop_info/1\", \"title\": \"全部商品\", \"permission\": {\"query\": {\"msg\": \"shop:shop:query\", \"name\": \"查询商品\"}, \"multi_enable\": {\"msg\": \"shop:shop:multi_enable\", \"name\": \"批量上架\"}, \"multi_disable\": {\"msg\": \"shop:shop:multi_disable\", \"name\": \"批量下架\"}}}], \"parent_title\": \"商品管理\"}', 1, '2024-03-27 19:23:33', '2024-11-09 17:17:18');
INSERT INTO `menu` VALUES (73, '{\"id\": 4, \"icon\": \"el-icon-UserFilled\", \"children\": [{\"path\": \"user_info\", \"title\": \"个人信息管理\", \"permission\": {\"update\": {\"msg\": \"user_info:user_info:update\", \"name\": \"修改个人信息\"}}}], \"parent_title\": \"信息管理\"}', 1, '2024-03-27 19:23:33', '2024-04-06 16:20:03');
INSERT INTO `menu` VALUES (74, '{\"id\": 1, \"icon\": \"el-icon-monitor\", \"children\": [{\"path\": \"system_overview\", \"title\": \"系统总览\"}, {\"path\": \"shop_overview\", \"title\": \"商品总览\"}, {\"path\": \"menu\", \"title\": \"菜单管理\"}], \"parent_title\": \"系统管理\"}', 2, '2024-03-27 19:23:33', '2024-04-11 08:17:18');
INSERT INTO `menu` VALUES (75, '{\"id\": 2, \"icon\": \"el-icon-shop\", \"children\": [{\"path\": \"shop_info/2\", \"title\": \"商品信息\", \"permission\": {\"query\": {\"msg\": \"shop_store:shop_info:query\", \"name\": \"查询商品\"}, \"create\": {\"msg\": \"shop_store:shop_info:create\", \"name\": \"创建商品\"}, \"delete\": {\"msg\": \"shop_store:shop_info:delete\", \"name\": \"删除商品\"}, \"update\": {\"msg\": \"shop_store:shop_info:update\", \"name\": \"修改商品\"}, \"multi_enable\": {\"msg\": \"shop_store:shop_info:multi_enable\", \"name\": \"批量上架商品\"}, \"multi_disanle\": {\"msg\": \"shop_store:shop_info:multi_disanle\", \"name\": \"批量下架商品\"}}}], \"parent_title\": \"店铺管理\"}', 2, '2024-03-27 19:23:33', '2024-12-01 22:52:30');
INSERT INTO `menu` VALUES (76, '{\"id\": 3, \"icon\": \"el-icon-ShoppingCartFull\", \"children\": [{\"path\": \"order\", \"title\": \"全部订单\", \"permission\": {\"query\": {\"msg\": \"order:order_index:query\", \"name\": \"查询订单信息\"}, \"update\": {\"msg\": \"order:order_pedding:update\", \"name\": \"修改订单状态\"}}}], \"parent_title\": \"订单管理\"}', 2, '2024-03-27 19:23:33', '2024-12-02 14:45:01');
INSERT INTO `menu` VALUES (77, '{\"id\": 4, \"icon\": \"el-icon-UserFilled\", \"children\": [{\"path\": \"user_info\", \"title\": \"个人信息管理\", \"permission\": {\"update\": {\"msg\": \"user_info:user_info:update\", \"name\": \"修改个人信息\"}}}], \"parent_title\": \"信息管理\"}', 2, '2024-03-27 19:23:33', '2024-04-06 16:19:58');

-- ----------------------------
-- Table structure for merchant_regis_application
-- ----------------------------
DROP TABLE IF EXISTS `merchant_regis_application`;
CREATE TABLE `merchant_regis_application`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nickname` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT 'H',
  `name` varchar(25) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `age` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `sex` enum('男','女','未知物种') CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT '未知物种',
  `id_card` varchar(22) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `phone` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `username` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `password` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `shop_name` varchar(30) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT '小 H 忠实粉丝',
  `state` enum('true','false') CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT 'false',
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of merchant_regis_application
-- ----------------------------
INSERT INTO `merchant_regis_application` VALUES (38, 'long', 'xiao long', '18', '女', '441224200207182755', '13425383532', '12345678', 'e10adc3949ba59abbe56e057f20f883e', '小孔电子产品专卖店', 'false', '2024-12-14 20:14:33', '2024-12-14 20:14:33');

-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `product_desc` varchar(120) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `product_price` int NULL DEFAULT NULL,
  `product_discount` varchar(2) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `product_count` int NOT NULL DEFAULT 0 COMMENT '产品数量',
  `product_actually_price` int NULL DEFAULT NULL COMMENT '实付价格（需在应用层或触发器中计算）',
  `product_state` enum('-1','0','1') CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '-1=退款, 0=待完成, 1=已完成',
  `user_id` int NULL DEFAULT NULL,
  `c_user_id` int NULL DEFAULT NULL COMMENT '关联商家用户表ID',
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `c_user_id`(`c_user_id` ASC) USING BTREE,
  CONSTRAINT `order_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `order_info_ibfk_2` FOREIGN KEY (`c_user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_info
-- ----------------------------

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_number` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL COMMENT '订单号',
  `product_name` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL COMMENT '商品名称',
  `product_desc` varchar(120) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '商品描述',
  `product_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `product_discount` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL COMMENT '折扣百分比',
  `product_pics` json NULL COMMENT '商品详情图',
  `buy_count` int NOT NULL DEFAULT 0 COMMENT '购买数量',
  `total_amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '实付价格',
  `address` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL COMMENT '订单地址',
  `status` enum('-2','-1','0','1','2') CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT '0' COMMENT '-2 退款成功（商家同意退款）, -1 退款申请（用户申请退款）, 0 待完成（用户下单）, 1 已发货（商家发货）, 2 已完成（用户收货）',
  `customer_id` int NULL DEFAULT NULL,
  `merchant_id` int NULL DEFAULT NULL,
  `commodity_id` int NULL DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `customer_id`(`customer_id` ASC) USING BTREE,
  INDEX `merchant_id`(`merchant_id` ASC) USING BTREE,
  INDEX `commodity_id`(`commodity_id` ASC) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`merchant_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`commodity_id`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (24, '1734078760933_96', 'Redmi Note 14 Pro+', 'Redmi Note 14 Pro+ - 12GB+256GB', 2499.00, '1', '[\"/product/1732803562649.png\", \"/product/1732803562650.png\"]', 2, 4998.00, '北京市 北京市 东城区→2432423→小孔→13425383777', '2', 96, 2, 43, '2024-12-13 16:32:40', '2024-12-13 16:33:55');
INSERT INTO `orders` VALUES (25, '1734078804432_96', '小米路由器AX3000', 'WiFi6畅销款，满足常规家用网速升级，信号放大需求 | 3000兆级无线速率 | 多机型混合Mesh组网，全屋无死角覆盖', 299.00, '1', '[\"/product/1732857356313.png\"]', 10, 2990.00, '北京市 北京市 东城区→2432423→小孔→13425383777', '0', 96, 2, 136, '2024-12-13 16:33:24', '2024-12-14 17:27:58');
INSERT INTO `orders` VALUES (26, '1734078804434_96', 'Redmi Book 16 2024', '配置: i5-13500H/2.5K/120Hz/16GB+1TB/星辰灰', 4999.00, '1', '[\"/product/1732806045922.png\"]', 1, 4999.00, '北京市 北京市 东城区→2432423→小孔→13425383777', '1', 96, 2, 72, '2024-12-13 16:33:24', '2024-12-13 20:52:50');
INSERT INTO `orders` VALUES (27, '1734078804437_96', 'Redmi K70 至尊版', 'Redmi K70 至尊版 - 12GB+256GB ', 2599.00, '1', '[\"/product/1732800396719.png\", \"/product/1732800396721.png\"]', 2, 5198.00, '北京市 北京市 东城区→2432423→小孔→13425383777', '0', 96, 2, 30, '2024-12-13 16:33:24', '2024-12-13 16:33:24');
INSERT INTO `orders` VALUES (28, '1734078804441_96', 'Xiaomi 14 Ultra', 'Xiaomi 14 Ultra - 16GB-1TB', 6499.00, '0.8', '[\"/product/1732803618815.png\"]', 2, 10398.40, '北京市 北京市 东城区→2432423→小孔→13425383777', '-1', 96, 2, 44, '2024-12-13 16:33:24', '2024-12-13 16:34:59');
INSERT INTO `orders` VALUES (29, '1734078804435_96', 'REDMI K80 Pro', 'REDMI K80 Pro - 12GB+256GB', 3699.00, '0.9', '[\"/product/1732800807473.png\", \"/product/1732801035976.png\"]', 1, 3329.10, '北京市 北京市 东城区→2432423→小孔→13425383777', '2', 96, 2, 32, '2024-12-13 16:33:24', '2024-12-13 16:34:53');
INSERT INTO `orders` VALUES (30, '1734078804438_96', 'Xiaomi Pad 6S Pro 12.4', '配置: 8GB+128GB', 2999.00, '1', '[\"/product/1732810950238.png\", \"/product/1732810950239.png\"]', 1, 2999.00, '北京市 北京市 东城区→2432423→小孔→13425383777', '-2', 96, 2, 114, '2024-12-13 16:33:24', '2024-12-13 16:34:41');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `product_desc` varchar(120) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `product_price` double NULL DEFAULT NULL,
  `product_discount` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `product_count` int NULL DEFAULT NULL,
  `sales_count` int NULL DEFAULT 0,
  `product_is_show` enum('true','false') CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT 'true',
  `product_tag_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_tag_id`(`product_tag_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`product_tag_id`) REFERENCES `product_tag` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 149 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (30, 'Redmi K70 至尊版', 'Redmi K70 至尊版 - 12GB+256GB ', 2599, '1', 286, 2, 'true', 31, 2, '2024-11-28 21:26:36', '2024-12-13 16:33:24');
INSERT INTO `product` VALUES (31, 'REDMI K80', 'REDMI K80 - 12GB+256GB', 2499, '1', 262, 0, 'true', 31, 2, '2024-11-28 21:28:30', '2024-12-13 16:30:06');
INSERT INTO `product` VALUES (32, 'REDMI K80 Pro', 'REDMI K80 Pro - 12GB+256GB', 3699, '0.9', 287, 1, 'true', 31, 2, '2024-11-28 21:29:34', '2024-12-13 16:33:24');
INSERT INTO `product` VALUES (33, 'Xiaomi 15 ', 'Xiaomi 15 - 16GB+512GB', 4999, '1', 888, 0, 'true', 31, 2, '2024-11-28 21:38:17', '2024-11-28 22:10:17');
INSERT INTO `product` VALUES (34, 'Xiaomi 15 Pro', 'Xiaomi 15 Pro - 16GB+256GB', 5799, '1', 87, 0, 'true', 31, 2, '2024-11-28 21:39:23', '2024-12-13 16:31:39');
INSERT INTO `product` VALUES (35, 'Redmi 13R 5G', 'Redmi 13R 5G - 4GB+128GB', 999, '1', 222, 0, 'true', 31, 2, '2024-11-28 22:04:22', '2024-12-13 16:31:41');
INSERT INTO `product` VALUES (36, 'Redmi 14R 5G', 'Redmi 14R 5G - 4GB+128GB', 1099, '1', 854, 0, 'true', 31, 2, '2024-11-28 22:05:30', '2024-11-28 22:10:22');
INSERT INTO `product` VALUES (37, 'Redmi K60E', 'Redmi K60E - 12GB+512GB', 2099, '1', 2343, 0, 'true', 31, 2, '2024-11-28 22:06:39', '2024-12-01 16:45:22');
INSERT INTO `product` VALUES (38, 'Redmi K70', 'Redmi K70 - 12GB+256GB', 2299, '0.9', 322, 0, 'true', 31, 2, '2024-11-28 22:07:37', '2024-11-28 22:07:37');
INSERT INTO `product` VALUES (39, 'Redmi K70E', 'Redmi K70E - 12GB+256GB', 1799, '1', 200, 0, 'true', 31, 2, '2024-11-28 22:09:13', '2024-11-28 22:09:13');
INSERT INTO `product` VALUES (40, 'Redmi Note 12 Turbo', 'Redmi Note 12 Turbo - 16GB+1TB', 2499, '0.8', 2001, 0, 'true', 31, 2, '2024-11-28 22:14:35', '2024-11-28 22:14:35');
INSERT INTO `product` VALUES (41, 'Redmi Note 12T Pro', 'Redmi Note 12T Pro - 12GB+512GB', 1699, '1', 2000, 0, 'true', 31, 2, '2024-11-28 22:15:41', '2024-11-28 22:15:41');
INSERT INTO `product` VALUES (42, 'Redmi Note 13R', 'Redmi Note 13R - 6GB+128GB', 1499, '1', 2332, 0, 'true', 31, 2, '2024-11-28 22:18:20', '2024-11-28 22:18:20');
INSERT INTO `product` VALUES (43, 'Redmi Note 14 Pro+', 'Redmi Note 14 Pro+ - 12GB+256GB', 2499, '1', 2340, 2, 'true', 31, 2, '2024-11-28 22:19:22', '2024-12-13 16:32:40');
INSERT INTO `product` VALUES (44, 'Xiaomi 14 Ultra', 'Xiaomi 14 Ultra - 16GB-1TB', 6499, '0.8', 219, 2, 'true', 31, 2, '2024-11-28 22:20:18', '2024-12-13 16:33:24');
INSERT INTO `product` VALUES (45, 'Xiaomi Civi 2', 'Xiaomi Civi 2 - 8GB+256GB', 2499, '1', 2322, 0, 'true', 31, 2, '2024-11-28 22:25:40', '2024-11-28 22:25:40');
INSERT INTO `product` VALUES (46, 'Xiaomi Civi 3', 'Xiaomi Civi 3 - 12GB+256GB', 2099, '1', 323, 0, 'true', 31, 2, '2024-11-28 22:27:36', '2024-11-28 22:27:36');
INSERT INTO `product` VALUES (47, 'Xiaomi MIX Flip', 'Xiaomi MIX Flip - 12GB+512GB', 6499, '0.9', 2323, 0, 'true', 31, 2, '2024-11-28 22:28:38', '2024-11-28 22:28:38');
INSERT INTO `product` VALUES (48, 'Xiaomi MIX Flip 随身拍套装', 'Xiaomi MIX Flip 12GB+256GB 随身拍套装', 6498, '0.8', 23, 0, 'true', 31, 2, '2024-11-28 22:29:17', '2024-11-28 22:29:17');
INSERT INTO `product` VALUES (49, 'Redmi智能电视 X 2025款 - 55英寸', 'Redmi智能电视 X 2025款 - 55英寸', 2179, '1', 321, 0, 'true', 32, 2, '2024-11-28 22:38:44', '2024-11-28 22:38:44');
INSERT INTO `product` VALUES (50, 'Redmi智能电视 X 2025款 - 65英寸', 'Redmi智能电视 X 2025款 - 65英寸', 2179, '1', 123, 0, 'true', 32, 2, '2024-11-28 22:39:21', '2024-11-28 22:39:21');
INSERT INTO `product` VALUES (51, 'Redmi智能电视 X 2025款 - 75英寸', 'Redmi智能电视 X 2025款 - 75英寸', 3799, '1', 3123, 0, 'true', 32, 2, '2024-11-28 22:39:57', '2024-11-28 22:39:57');
INSERT INTO `product` VALUES (52, 'Redmi A系列电视 2025款 75英寸', 'Redmi A系列电视 2025款 75英寸', 2799, '1', 231, 0, 'true', 32, 2, '2024-11-28 22:41:12', '2024-11-28 22:41:12');
INSERT INTO `product` VALUES (53, 'Redmi A系列电视 2025款 65英寸', 'Redmi A系列电视 2025款 65英寸', 2199, '1', 1231, 0, 'true', 32, 2, '2024-11-28 22:42:05', '2024-11-28 22:42:05');
INSERT INTO `product` VALUES (54, 'Redmi智能电视 A Pro系列 75英寸', 'Redmi智能电视 A Pro系列 75英寸', 3299, '1', 312, 0, 'true', 32, 2, '2024-11-28 22:42:56', '2024-11-28 22:42:56');
INSERT INTO `product` VALUES (55, '小米电视 S Mini LED系列 75英寸', '小米电视 S Mini LED系列 75英寸', 4599, '1', 231, 0, 'true', 32, 2, '2024-11-28 22:43:47', '2024-11-28 22:43:47');
INSERT INTO `product` VALUES (56, 'Redmi 电视MAX系列 85英寸', 'Redmi 电视MAX系列 85英寸', 4499, '1', 312, 0, 'true', 32, 2, '2024-11-28 22:44:37', '2024-11-28 22:44:37');
INSERT INTO `product` VALUES (57, 'Redmi 电视MAX系列 100英寸', 'Redmi 电视MAX系列 100英寸', 8199, '0.99', 27, 0, 'true', 32, 2, '2024-11-28 22:45:13', '2024-12-13 16:31:50');
INSERT INTO `product` VALUES (58, '小米透明OLED电视 55英寸', '小米透明OLED电视 55英寸', 49999, '1', 321, 0, 'true', 32, 2, '2024-11-28 22:46:23', '2024-11-28 22:46:23');
INSERT INTO `product` VALUES (59, '小米电视S Pro Mini LED系列 65英寸', '小米电视S Pro Mini LED系列 65英寸', 4599, '1', 888, 0, 'true', 32, 2, '2024-11-28 22:47:17', '2024-11-28 22:47:17');
INSERT INTO `product` VALUES (60, '小米电视A系列 32英寸', '小米电视A系列 32英寸', 649, '1', 132, 0, 'true', 32, 2, '2024-11-28 22:48:39', '2024-11-28 22:48:39');
INSERT INTO `product` VALUES (61, '小米电视A系列 43英寸', '小米电视A系列 32英寸', 949, '1', 312, 0, 'true', 32, 2, '2024-11-28 22:49:18', '2024-11-28 22:49:18');
INSERT INTO `product` VALUES (62, '小米电视A系列 50英寸', '小米电视A系列 50英寸', 1599, '1', 323, 0, 'true', 32, 2, '2024-11-28 22:49:46', '2024-11-28 22:49:46');
INSERT INTO `product` VALUES (63, '小米电视A系列 65英寸', '小米电视A系列 65英寸', 2249, '1', 322, 0, 'true', 32, 2, '2024-11-28 22:50:28', '2024-11-28 22:50:28');
INSERT INTO `product` VALUES (64, '小米电视A系列 70英寸', '小米电视A系列 70英寸', 2699, '1', 232, 0, 'true', 32, 2, '2024-11-28 22:51:12', '2024-11-28 22:51:12');
INSERT INTO `product` VALUES (65, '小米电视A系列 75英寸', '小米电视A系列 75英寸', 2949, '1', 321, 0, 'true', 32, 2, '2024-11-28 22:51:58', '2024-11-28 22:51:58');
INSERT INTO `product` VALUES (66, 'Redmi 智能电视 X 55英寸 2025', 'Redmi 智能电视 X 55英寸 2025', 2179, '1', 322, 0, 'true', 32, 2, '2024-11-28 22:52:34', '2024-11-28 22:52:34');
INSERT INTO `product` VALUES (67, '小米电视 S Pro 75 Mini LED 2025款', '小米电视 S Pro 75 Mini LED 2025款', 6499, '1', 1231, 0, 'true', 32, 2, '2024-11-28 22:53:55', '2024-11-28 22:53:55');
INSERT INTO `product` VALUES (68, 'Redmi 智能电视 X 85英寸 2025', 'Redmi 智能电视 X 85英寸 2025', 4799, '1', 3213, 0, 'true', 32, 2, '2024-11-28 22:54:45', '2024-11-28 22:54:45');
INSERT INTO `product` VALUES (69, 'Redmi 智能电视 X 65英寸 2025', 'Redmi 智能电视 X 65英寸 2025', 2799, '1', 1233, 0, 'true', 32, 2, '2024-11-28 22:55:15', '2024-11-28 22:55:15');
INSERT INTO `product` VALUES (70, 'Redmi 智能电视 X 75英寸 2025', 'Redmi 智能电视 X 75英寸 2025', 2799, '1', 1323, 0, 'true', 32, 2, '2024-11-28 22:55:36', '2024-11-28 22:55:36');
INSERT INTO `product` VALUES (71, '小米电视 ES系列 65英寸', '小米电视 ES系列 65英寸', 2399, '1', 3232, 0, 'true', 32, 2, '2024-11-28 22:57:10', '2024-11-28 22:57:10');
INSERT INTO `product` VALUES (72, 'Redmi Book 16 2024', '配置: i5-13500H/2.5K/120Hz/16GB+1TB/星辰灰', 4999, '1', 3232, 1, 'true', 33, 2, '2024-11-28 23:00:45', '2024-12-13 16:33:24');
INSERT INTO `product` VALUES (73, 'Redmi Book 16 2024', '配置: i5-13500H/2.5K/120Hz/16GB+512GB/星辰灰', 4599, '1', 2321, 0, 'true', 33, 2, '2024-11-28 23:01:33', '2024-12-13 16:31:54');
INSERT INTO `product` VALUES (74, 'Redmi Book 16 2024', '配置: i5-12450H/FHD+/16GB+512GB/星辰灰', 3399, '1', 3213, 0, 'true', 33, 2, '2024-11-28 23:02:03', '2024-11-28 23:02:03');
INSERT INTO `product` VALUES (75, 'Redmi Book 16 2024', '配置: i5-12450H/FHD+/16GB+1TB/星辰灰', 3599, '1', 3213, 0, 'true', 33, 2, '2024-11-28 23:02:44', '2024-11-28 23:02:44');
INSERT INTO `product` VALUES (76, 'Redmi Book 16 2024', '配置: i5-13420H/FHD+/16+1TB/星辰灰', 3999, '1', 3232, 0, 'true', 33, 2, '2024-11-28 23:03:18', '2024-11-28 23:03:18');
INSERT INTO `product` VALUES (77, 'Redmi Book 16 2024', '配置: i5-13420H/FHD+/16+512G/星辰灰', 3799, '1', 3232, 0, 'true', 33, 2, '2024-11-28 23:03:48', '2024-11-28 23:03:48');
INSERT INTO `product` VALUES (78, 'Redmi Book 16 2024', '配置: i7-13620H/2.5K/16+1TB/星辰灰', 5299, '1', 3132, 0, 'true', 33, 2, '2024-11-28 23:04:28', '2024-11-28 23:04:28');
INSERT INTO `product` VALUES (79, 'Redmi G Pro 游戏本 2024 i7', '配置: 标准版', 8299, '1', 1233, 0, 'true', 33, 2, '2024-11-28 23:05:34', '2024-11-28 23:05:34');
INSERT INTO `product` VALUES (80, 'Redmi G Pro 游戏本 2024 i7', '配置: Redmi G Pro 游戏本显示器套装 i7+27英寸', 9698, '1', 3123, 0, 'true', 33, 2, '2024-11-28 23:06:20', '2024-11-28 23:06:20');
INSERT INTO `product` VALUES (81, 'Redmi Book Pro 14 2024', '配置: Ultra5/16G/512G/2.8K/120Hz/星辰灰', 4999, '1', 3231, 0, 'true', 33, 2, '2024-11-28 23:07:24', '2024-11-28 23:07:24');
INSERT INTO `product` VALUES (82, 'Redmi Book Pro 14 2024', '配置: Ultra5/16G/1T/2.8K/120Hz星辰灰', 5199, '1', 323, 0, 'true', 33, 2, '2024-11-28 23:07:50', '2024-11-28 23:07:50');
INSERT INTO `product` VALUES (83, 'Redmi Book Pro 14 2024', '配置: Ultra5/32G/1T/2.8K/120Hz晴空蓝', 5899, '1', 1312, 0, 'true', 33, 2, '2024-11-28 23:08:37', '2024-11-28 23:08:37');
INSERT INTO `product` VALUES (85, 'Redmi Book Pro 14 2024', '配置: Ultra7/32G/1T/2.8K/120Hz晴空蓝', 6899, '1', 323, 0, 'true', 33, 2, '2024-11-28 23:14:43', '2024-11-28 23:14:43');
INSERT INTO `product` VALUES (86, 'Redmi Book Pro 16 2024', '配置: Ultra5/32G/1T/3.1K/165Hz/星辰灰', 6399, '1', 323, 0, 'true', 33, 2, '2024-11-28 23:15:43', '2024-11-28 23:15:43');
INSERT INTO `product` VALUES (87, 'Redmi Book Pro 16 2024', '配置: Ultra7/32G/1T/3.1K/165Hz/星辰灰', 7399, '1', 1312, 0, 'true', 33, 2, '2024-11-28 23:16:20', '2024-11-28 23:16:20');
INSERT INTO `product` VALUES (88, 'Redmi Book 16 2024', '配置:  i7-12700H/16G/512G/2.8k/120Hz/金属-银色', 4399, '1', 323, 0, 'true', 33, 2, '2024-11-28 23:18:25', '2024-11-28 23:18:25');
INSERT INTO `product` VALUES (89, 'Xiaomi Book Pro 14 2022', '配置: i7-1260P/16GB/512GB/RTX 2050/灰色', 6499, '1', 323, 0, 'true', 33, 2, '2024-11-28 23:19:16', '2024-11-28 23:19:16');
INSERT INTO `product` VALUES (90, 'Xiaomi Book Pro 16 2022', '配置: i7-1260P/16GB/512GB/RTX2050/月岩灰', 6799, '1', 323, 0, 'true', 33, 2, '2024-11-28 23:20:20', '2024-11-28 23:20:20');
INSERT INTO `product` VALUES (91, 'Xiaomi Book Pro 16 2022', '配置: i7-1260P/16GB/512GB/RTX2050/新月银', 6799, '1', 322, 0, 'true', 33, 2, '2024-11-28 23:21:00', '2024-11-28 23:21:00');
INSERT INTO `product` VALUES (92, 'Redmi Book Pro 15 2023 锐龙版', '配置: R7-7840HS/16G/512G 灰色', 4399, '1', 3123, 0, 'true', 33, 2, '2024-11-28 23:22:10', '2024-11-28 23:22:10');
INSERT INTO `product` VALUES (93, 'Redmi Book 15E i7', '配置: 灰色', 2999, '1', 3233, 0, 'true', 33, 2, '2024-11-28 23:22:51', '2024-11-28 23:22:51');
INSERT INTO `product` VALUES (94, 'Xiaomi Book Pro 14 锐龙版', '配置: R5 6600H/16GB/512GB/UMA/14\" 2880*1800 90Hz/Gray', 3799, '1', 323, 0, 'true', 33, 2, '2024-11-28 23:23:35', '2024-11-28 23:23:35');
INSERT INTO `product` VALUES (95, 'Xiaomi Book Pro 14 锐龙版', '配置: R7 6800H/16GB/512GB/UMA/14\" 2880*1800 90Hz/Gray', 3799, '1', 644, 0, 'true', 33, 2, '2024-11-28 23:24:09', '2024-11-28 23:58:12');
INSERT INTO `product` VALUES (96, '「新秀无畏」系列笔记本定制贴纸', '机车少女（适用机型 \"RedmiBook Pro 15\" | \"小米笔记本Pro 15 OLED\"）', 99, '1', 3113, 0, 'true', 33, 2, '2024-11-28 23:25:43', '2024-11-28 23:58:08');
INSERT INTO `product` VALUES (97, '「新秀无畏」系列笔记本定制贴纸', '宇航员（适用机型 \"RedmiBook Pro 15\"）', 99, '1', 3233, 0, 'true', 33, 2, '2024-11-28 23:26:38', '2024-11-28 23:26:38');
INSERT INTO `product` VALUES (98, 'Xiaomi Pad 7 Pro', '配置: 8GB+256GB', 2799, '1', 3230, 0, 'true', 34, 2, '2024-11-28 23:30:01', '2024-12-13 16:30:26');
INSERT INTO `product` VALUES (99, 'Xiaomi Pad 7 Pro', '配置: 8GB+128GB', 2399, '1', 3232, 0, 'true', 34, 2, '2024-11-28 23:30:01', '2024-11-28 23:50:25');
INSERT INTO `product` VALUES (100, 'Xiaomi Pad 7 Pro', '配置: 12GB+256GB', 3099, '1', 434, 0, 'true', 34, 2, '2024-11-28 23:30:01', '2024-11-28 23:57:55');
INSERT INTO `product` VALUES (101, 'Xiaomi Pad 7 Pro', '配置: 12GB+512GB', 3499, '1', 3121, 0, 'true', 34, 2, '2024-11-28 23:30:01', '2024-11-28 23:57:57');
INSERT INTO `product` VALUES (102, 'Xiaomi Pad 7 Pro', '配置: 8GB+256GB 柔光版', 2999, '1', 2223, 0, 'true', 34, 2, '2024-11-28 23:30:01', '2024-11-28 23:58:00');
INSERT INTO `product` VALUES (103, 'Xiaomi Pad 7 Pro', '配置: 12GB+256GB 柔光版', 3299, '1', 1133, 0, 'true', 34, 2, '2024-11-28 23:30:01', '2024-11-28 23:58:02');
INSERT INTO `product` VALUES (104, 'Xiaomi Pad 7 Pro', '配置: 12GB+512GB 柔光版', 3699, '1', 663, 0, 'true', 34, 2, '2024-11-28 23:30:01', '2024-11-28 23:58:04');
INSERT INTO `product` VALUES (105, 'Xiaomi Pad 7', '配置: 8GB+256GB', 2299, '1', 1293, 0, 'true', 34, 2, '2024-11-29 00:04:44', '2024-11-29 00:04:44');
INSERT INTO `product` VALUES (106, 'Xiaomi Pad 7', '配置: 8GB+128GB', 1999, '1', 1233, 0, 'true', 34, 2, '2024-11-29 00:05:33', '2024-11-29 00:06:48');
INSERT INTO `product` VALUES (107, 'Xiaomi Pad 7', '配置: 12GB+256GB', 2599, '1', 884, 0, 'true', 34, 2, '2024-11-29 00:05:33', '2024-11-29 00:06:51');
INSERT INTO `product` VALUES (108, 'Xiaomi Pad 7', '配置: 8GB+256GB 柔光版', 2499, '1', 2344, 0, 'true', 34, 2, '2024-11-29 00:05:34', '2024-11-29 00:06:54');
INSERT INTO `product` VALUES (109, 'Xiaomi Pad 7', '配置: 12GB+256GB 柔光版', 2799, '1', 244, 0, 'true', 34, 2, '2024-11-29 00:05:34', '2024-11-29 00:06:57');
INSERT INTO `product` VALUES (110, 'Redmi Pad Pro系列', '配置: 6GB+128GB', 1499, '1', 483, 0, 'true', 34, 2, '2024-11-29 00:15:00', '2024-11-29 00:16:47');
INSERT INTO `product` VALUES (111, 'Redmi Pad Pro系列', '配置: 8GB+128GB', 1599, '1', 588, 0, 'true', 34, 2, '2024-11-29 00:16:16', '2024-11-29 00:16:58');
INSERT INTO `product` VALUES (112, 'Redmi Pad Pro系列', '配置: 8GB+256GB', 1699, '1', 23, 0, 'true', 34, 2, '2024-11-29 00:16:16', '2024-11-29 00:17:01');
INSERT INTO `product` VALUES (113, 'Xiaomi Pad 6S Pro 12.4', '配置: 8GB+256GB', 3299, '1', 323, 0, 'true', 34, 2, '2024-11-29 00:19:16', '2024-11-29 00:19:16');
INSERT INTO `product` VALUES (114, 'Xiaomi Pad 6S Pro 12.4', '配置: 8GB+128GB', 2999, '1', 392, 1, 'true', 34, 2, '2024-11-29 00:20:24', '2024-12-13 16:33:24');
INSERT INTO `product` VALUES (115, 'Xiaomi Pad 6S Pro 12.4', '配置: 12GB+256GB', 3599, '1', 424, 0, 'true', 34, 2, '2024-11-29 00:20:25', '2024-11-29 00:21:09');
INSERT INTO `product` VALUES (116, 'Xiaomi Pad 6S Pro 12.4', '配置: 12GB+512GB', 3999, '1', 1333, 0, 'true', 34, 2, '2024-11-29 00:20:25', '2024-11-29 00:21:26');
INSERT INTO `product` VALUES (117, 'Xiaomi Pad 6S Pro 12.4', '配置: 16GB+1TB', 4499, '1', 23, 0, 'true', 34, 2, '2024-11-29 00:20:26', '2024-11-29 00:21:43');
INSERT INTO `product` VALUES (118, '米家踢脚线电暖器E', '对流循环均衡供暖 | 智能恒温节能 | 居浴两用', 499, '1', 3233, 0, 'true', 37, 2, '2024-11-29 12:46:22', '2024-11-29 12:46:22');
INSERT INTO `product` VALUES (119, '米家桌面暖风机', 'PTC即开即热 / 广角柔风 / Mini轻巧身材 / 倾倒保护 / 双重热保护 / V-0级防火材质', 129, '1', 9383, 0, 'true', 37, 2, '2024-11-29 12:48:32', '2024-11-29 12:49:37');
INSERT INTO `product` VALUES (120, '米家石墨烯踢脚线电暖器', '全屋对流取暖 | 石墨烯速热科技 | 智能恒温 | 智能控制', 749, '1', 1244, 0, 'true', 37, 2, '2024-11-29 12:48:33', '2024-11-29 12:50:04');
INSERT INTO `product` VALUES (121, '米家踢脚线电暖器1S', '全屋热循环 | 暖流加速 | 智能恒温 | 智能控制 | 2200W大功率 | IPX4级防水', 699, '1', 1283, 0, 'true', 37, 2, '2024-11-29 12:48:44', '2024-11-29 12:50:36');
INSERT INTO `product` VALUES (122, '米家智能电暖器', '智能舒适控制 / 2200W对流速热 / 居浴两用', 409, '1', 2201, 0, 'true', 37, 2, '2024-11-29 12:48:44', '2024-11-29 12:51:00');
INSERT INTO `product` VALUES (123, '米家石墨烯折叠踢脚线电暖器 超薄版', '0°-180°百变折叠|石墨烯速热|1.29m超长发热体|智能恒温|智能操控，小爱同学+米家APP控制', 899, '1', 3134, 0, 'true', 37, 2, '2024-11-29 12:48:45', '2024-11-29 12:51:34');
INSERT INTO `product` VALUES (124, '米家石墨烯踢脚线电暖器 超薄款', '7cm超薄机身| 全屋对流| 石墨烯速热| 智能恒温,低噪省电', 709, '1', 2225, 0, 'true', 37, 2, '2024-11-29 12:48:46', '2024-11-29 12:52:00');
INSERT INTO `product` VALUES (125, '米家石墨烯踢脚线电暖器 2 折叠版', '随心折叠 速热取暖｜石墨烯速热｜无级变频恒温', 799, '1', 139, 0, 'true', 37, 2, '2024-11-29 12:48:46', '2024-11-29 12:52:17');
INSERT INTO `product` VALUES (126, '米家石墨烯油汀取暖器', '3.1平方米超大散热面积丨石墨烯涂层覆盖丨智能控制舒适节能', 579, '1', 223, 0, 'true', 37, 2, '2024-11-29 12:48:47', '2024-11-29 12:54:22');
INSERT INTO `product` VALUES (127, '米家暖风机', '2000W功率，即开即热｜70°广角送风｜多重安全防护', 209, '1', 874, 0, 'true', 37, 2, '2024-11-29 12:48:47', '2024-11-29 12:55:06');
INSERT INTO `product` VALUES (128, '米家石墨烯踢脚线电暖器 2 加湿版', '取暖加湿双效合一｜石墨烯5秒速热｜居浴两用 干衣好帮手', 579, '1', 1329, 0, 'true', 37, 2, '2024-11-29 12:48:48', '2024-11-29 12:55:29');
INSERT INTO `product` VALUES (129, '米家石墨烯踢脚线电暖器 仿真火焰版', '加湿+火焰效果 | 悬浮外观 | 双核石墨烯速热 | 智能变频恒温', 1279, '1', 1293, 0, 'true', 37, 2, '2024-11-29 12:48:49', '2024-11-29 12:57:05');
INSERT INTO `product` VALUES (130, '米家电暖器 温控版', '2200W 强劲功率，三挡调温恒温保持，高效铝片发热体，对流循环加热不干燥', 309, '1', 983, 0, 'true', 37, 2, '2024-11-29 12:48:49', '2024-11-29 12:58:12');
INSERT INTO `product` VALUES (131, '米家石墨烯踢脚线电暖器 2', '米家石墨烯踢脚线电暖器 2', 279, '1', 2039, 0, 'true', 37, 2, '2024-11-29 12:48:50', '2024-11-29 12:58:06');
INSERT INTO `product` VALUES (132, '米家石墨烯暖风机', '2000W功率｜智能恒温，热风，暖风，自然风四种模式｜石墨烯喷涂', 279, '1', 827, 0, 'true', 37, 2, '2024-11-29 12:48:50', '2024-11-29 12:56:08');
INSERT INTO `product` VALUES (133, '米家踢脚线电暖器 2', '大旋钮控制，高低两挡可调｜2200W大功率速热｜IPX4防水｜多重安全防护', 289, '1', 1353, 0, 'true', 37, 2, '2024-11-29 12:48:51', '2024-11-29 12:58:37');
INSERT INTO `product` VALUES (134, '米家石墨烯智能电暖器', '4秒通电即热 | 暖身暖屋 | 居浴两用', 479, '1', 2933, 0, 'true', 37, 2, '2024-11-29 12:48:51', '2024-11-29 12:59:06');
INSERT INTO `product` VALUES (135, '米家智能电热毯', '米家App远程预约，提前暖床｜入睡后自动调温｜左右分区控温，八重安全保护', 219, '1', 291, 0, 'true', 37, 2, '2024-11-29 12:48:52', '2024-11-29 12:59:28');
INSERT INTO `product` VALUES (136, '小米路由器AX3000', 'WiFi6畅销款，满足常规家用网速升级，信号放大需求 | 3000兆级无线速率 | 多机型混合Mesh组网，全屋无死角覆盖', 299, '1', 754, 10, 'true', 36, 2, '2024-11-29 13:15:56', '2024-12-13 22:44:02');
INSERT INTO `product` VALUES (137, 'Redmi路由器AX5400', '5400兆级无线速率 | 4K QAM，疾速增强 | 新一代高通路由芯片 | 6根高增益天线，信号增强 | 512MB大内存 | 多型号Mesh组网', 249, '1', 234, 0, 'true', 36, 2, '2024-11-29 13:16:42', '2024-11-29 13:20:58');
INSERT INTO `product` VALUES (138, 'Xiaomi全屋路由 BE3600Pro 套装', '四核WiFi7，MLO双频聚合，4核处理器，全2.5G网口，6路独立信号放大器，小米自研Mesh，全屋智能联动', 499, '1', 211, 0, 'true', 36, 2, '2024-11-29 13:16:43', '2024-11-29 13:24:25');
INSERT INTO `product` VALUES (139, 'Xiaomi全屋路由 子路由', '全屋WiFi 6，无线有线千兆畅连 | 自适应千兆网口 | 配备蓝牙Mesh网关，全屋智能设备，一键畅连 | 可搭配所有支持小米Mesh功能的路由器使用', 229, '1', 442, 0, 'true', 36, 2, '2024-11-29 13:16:43', '2024-11-29 13:20:54');
INSERT INTO `product` VALUES (140, 'Xiaomi路由器AX1500', '全千兆自适应网口 | 多设备Mesh组网 | 小米畅快连 | 支持IPTV | 小米/Redmi手机专属加速', 139, '1', 655, 0, 'true', 36, 2, '2024-11-29 13:16:44', '2024-11-29 13:20:52');
INSERT INTO `product` VALUES (141, 'Xiaomi全屋路由 BE3600Pro', '全屋覆盖，智能连接，内置蓝牙网关，高通4核处理器', 349, '1', 246, 0, 'true', 36, 2, '2024-11-29 13:16:44', '2024-11-29 13:20:47');
INSERT INTO `product` VALUES (142, 'Redmi路由器AX1800', '疾速WiFi 6 | 全千兆网口 | 多机型Mesh组网，全屋无死角覆盖', 109, '1', 1687, 0, 'true', 36, 2, '2024-11-29 13:16:45', '2024-11-29 13:20:50');
INSERT INTO `product` VALUES (143, 'Xiaomi路由器 AX3000E', '满血WiFi6，3000兆级无线速率，4路信号放大器，支持网口聚合，全屋智能联动', 179, '1', 2244, 0, 'true', 36, 2, '2024-11-29 13:16:46', '2024-11-29 13:20:41');
INSERT INTO `product` VALUES (144, '小米路由器4C', '高增益天线，信号更强 | 64MB 内存，运行稳定 | APP智能管理 | 红包 WiFi，帮你赚钱', 79, '1', 4553, 0, 'true', 36, 2, '2024-11-29 13:16:46', '2024-11-29 13:20:38');
INSERT INTO `product` VALUES (145, '小米WiFi放大器 Pro', '智能设备上网伴侣 | 2X2外置天线 | 极速配对 | 300Mbps强电版', 69, '1', 674, 0, 'true', 36, 2, '2024-11-29 13:16:46', '2024-11-29 13:20:44');
INSERT INTO `product` VALUES (146, 'Xiaomi全屋路由 BE3600Pro 套装', '全屋覆盖，智能连接，内置小米中枢网关，实力双路由，出厂预配对，高通4核处理器', 699, '1', 2344, 0, 'true', 36, 2, '2024-11-29 13:16:47', '2024-11-29 13:20:30');
INSERT INTO `product` VALUES (148, 'Xiaomi路由器 4A 千兆版', '双频合一，1200兆级无线速率，4个高性能放大器，4根高增益天线，小米自研Mesh组网，3个千兆盲插网口', 99, '1', 4232, 0, 'true', 36, 2, '2024-11-29 13:16:48', '2024-11-29 13:20:29');

-- ----------------------------
-- Table structure for product_pic
-- ----------------------------
DROP TABLE IF EXISTS `product_pic`;
CREATE TABLE `product_pic`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_pic_url` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `product_id` int NULL DEFAULT NULL,
  `size` int NULL DEFAULT NULL,
  `mimetype` varchar(30) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `product_pic_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 350 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_pic
-- ----------------------------
INSERT INTO `product_pic` VALUES (75, '/product/1732800396719.png', 30, 107509, 'image/png', '2024-11-28 21:26:36', '2024-11-28 21:26:36');
INSERT INTO `product_pic` VALUES (76, '/product/1732800396721.png', 30, 126731, 'image/png', '2024-11-28 21:26:36', '2024-11-28 21:26:36');
INSERT INTO `product_pic` VALUES (77, '/product/1732800510054.png', 31, 48834, 'image/png', '2024-11-28 21:28:30', '2024-11-28 21:28:30');
INSERT INTO `product_pic` VALUES (78, '/product/1732800510056.png', 31, 55512, 'image/png', '2024-11-28 21:28:30', '2024-11-28 21:28:30');
INSERT INTO `product_pic` VALUES (84, '/product/1732800807473.png', 32, 48834, 'image/png', '2024-11-28 21:33:27', '2024-11-28 21:33:27');
INSERT INTO `product_pic` VALUES (85, '/product/1732801035976.png', 32, 46787, 'image/png', '2024-11-28 21:37:15', '2024-11-28 21:37:15');
INSERT INTO `product_pic` VALUES (86, '/product/1732801097329.png', 33, 144144, 'image/png', '2024-11-28 21:38:17', '2024-11-28 21:38:17');
INSERT INTO `product_pic` VALUES (87, '/product/1732801097332.png', 33, 120280, 'image/png', '2024-11-28 21:38:17', '2024-11-28 21:38:17');
INSERT INTO `product_pic` VALUES (88, '/product/1732801163862.png', 34, 102618, 'image/png', '2024-11-28 21:39:23', '2024-11-28 21:39:23');
INSERT INTO `product_pic` VALUES (89, '/product/1732801163863.png', 34, 101487, 'image/png', '2024-11-28 21:39:23', '2024-11-28 21:39:23');
INSERT INTO `product_pic` VALUES (90, '/product/1732802662822.png', 35, 98507, 'image/png', '2024-11-28 22:04:22', '2024-11-28 22:04:22');
INSERT INTO `product_pic` VALUES (91, '/product/1732802662823.png', 35, 104004, 'image/png', '2024-11-28 22:04:22', '2024-11-28 22:04:22');
INSERT INTO `product_pic` VALUES (92, '/product/1732802662825.png', 35, 112642, 'image/png', '2024-11-28 22:04:22', '2024-11-28 22:04:22');
INSERT INTO `product_pic` VALUES (93, '/product/1732802662824.png', 35, 100986, 'image/png', '2024-11-28 22:04:22', '2024-11-28 22:04:22');
INSERT INTO `product_pic` VALUES (94, '/product/1732802730046.png', 36, 106646, 'image/png', '2024-11-28 22:05:30', '2024-11-28 22:05:30');
INSERT INTO `product_pic` VALUES (95, '/product/1732802730047.png', 36, 135464, 'image/png', '2024-11-28 22:05:30', '2024-11-28 22:05:30');
INSERT INTO `product_pic` VALUES (96, '/product/1732802730049.png', 36, 118191, 'image/png', '2024-11-28 22:05:30', '2024-11-28 22:05:30');
INSERT INTO `product_pic` VALUES (97, '/product/1732802730051.png', 36, 116829, 'image/png', '2024-11-28 22:05:30', '2024-11-28 22:05:30');
INSERT INTO `product_pic` VALUES (98, '/product/1732802730054.png', 36, 127910, 'image/png', '2024-11-28 22:05:30', '2024-11-28 22:05:30');
INSERT INTO `product_pic` VALUES (99, '/product/1732802799714.png', 37, 298182, 'image/png', '2024-11-28 22:06:39', '2024-11-28 22:06:39');
INSERT INTO `product_pic` VALUES (100, '/product/1732802799717.png', 37, 79233, 'image/png', '2024-11-28 22:06:39', '2024-11-28 22:06:39');
INSERT INTO `product_pic` VALUES (101, '/product/1732802799718.png', 37, 94549, 'image/png', '2024-11-28 22:06:39', '2024-11-28 22:06:39');
INSERT INTO `product_pic` VALUES (102, '/product/1732802857032.png', 38, 142801, 'image/png', '2024-11-28 22:07:37', '2024-11-28 22:07:37');
INSERT INTO `product_pic` VALUES (103, '/product/1732802857034.png', 38, 115420, 'image/png', '2024-11-28 22:07:37', '2024-11-28 22:07:37');
INSERT INTO `product_pic` VALUES (104, '/product/1732802953510.png', 39, 105501, 'image/png', '2024-11-28 22:09:13', '2024-11-28 22:09:13');
INSERT INTO `product_pic` VALUES (105, '/product/1732802953511.png', 39, 93750, 'image/png', '2024-11-28 22:09:13', '2024-11-28 22:09:13');
INSERT INTO `product_pic` VALUES (106, '/product/1732803275232.png', 40, 97064, 'image/png', '2024-11-28 22:14:35', '2024-11-28 22:14:35');
INSERT INTO `product_pic` VALUES (107, '/product/1732803275233.png', 40, 71766, 'image/png', '2024-11-28 22:14:35', '2024-11-28 22:14:35');
INSERT INTO `product_pic` VALUES (108, '/product/1732803275233.png', 40, 89787, 'image/png', '2024-11-28 22:14:35', '2024-11-28 22:14:35');
INSERT INTO `product_pic` VALUES (109, '/product/1732803275234.png', 40, 109818, 'image/png', '2024-11-28 22:14:35', '2024-11-28 22:14:35');
INSERT INTO `product_pic` VALUES (110, '/product/1732803341751.png', 41, 128879, 'image/png', '2024-11-28 22:15:41', '2024-11-28 22:15:41');
INSERT INTO `product_pic` VALUES (111, '/product/1732803341752.png', 41, 102216, 'image/png', '2024-11-28 22:15:41', '2024-11-28 22:15:41');
INSERT INTO `product_pic` VALUES (112, '/product/1732803341753.png', 41, 116014, 'image/png', '2024-11-28 22:15:41', '2024-11-28 22:15:41');
INSERT INTO `product_pic` VALUES (115, '/product/1732803431256.png', 41, 118122, 'image/png', '2024-11-28 22:17:11', '2024-11-28 22:17:11');
INSERT INTO `product_pic` VALUES (116, '/product/1732803500459.png', 42, 83454, 'image/png', '2024-11-28 22:18:20', '2024-11-28 22:18:20');
INSERT INTO `product_pic` VALUES (117, '/product/1732803500459.png', 42, 81138, 'image/png', '2024-11-28 22:18:20', '2024-11-28 22:18:20');
INSERT INTO `product_pic` VALUES (118, '/product/1732803562649.png', 43, 114599, 'image/png', '2024-11-28 22:19:22', '2024-11-28 22:19:22');
INSERT INTO `product_pic` VALUES (119, '/product/1732803562650.png', 43, 99099, 'image/png', '2024-11-28 22:19:22', '2024-11-28 22:19:22');
INSERT INTO `product_pic` VALUES (120, '/product/1732803618815.png', 44, 79991, 'image/png', '2024-11-28 22:20:18', '2024-11-28 22:20:18');
INSERT INTO `product_pic` VALUES (121, '/product/1732803940507.png', 45, 122628, 'image/png', '2024-11-28 22:25:40', '2024-11-28 22:25:40');
INSERT INTO `product_pic` VALUES (122, '/product/1732803940509.png', 45, 100341, 'image/png', '2024-11-28 22:25:40', '2024-11-28 22:25:40');
INSERT INTO `product_pic` VALUES (123, '/product/1732803940508.png', 45, 127735, 'image/png', '2024-11-28 22:25:40', '2024-11-28 22:25:40');
INSERT INTO `product_pic` VALUES (124, '/product/1732803940510.png', 45, 112438, 'image/png', '2024-11-28 22:25:40', '2024-11-28 22:25:40');
INSERT INTO `product_pic` VALUES (125, '/product/1732803940511.png', 45, 100718, 'image/png', '2024-11-28 22:25:40', '2024-11-28 22:25:40');
INSERT INTO `product_pic` VALUES (126, '/product/1732804056565.png', 46, 86983, 'image/png', '2024-11-28 22:27:36', '2024-11-28 22:27:36');
INSERT INTO `product_pic` VALUES (127, '/product/1732804056565.png', 46, 102291, 'image/png', '2024-11-28 22:27:36', '2024-11-28 22:27:36');
INSERT INTO `product_pic` VALUES (128, '/product/1732804118851.png', 47, 121384, 'image/png', '2024-11-28 22:28:38', '2024-11-28 22:28:38');
INSERT INTO `product_pic` VALUES (129, '/product/1732804118847.png', 47, 149198, 'image/png', '2024-11-28 22:28:38', '2024-11-28 22:28:38');
INSERT INTO `product_pic` VALUES (130, '/product/1732804118852.png', 47, 131588, 'image/png', '2024-11-28 22:28:38', '2024-11-28 22:28:38');
INSERT INTO `product_pic` VALUES (131, '/product/1732804118850.png', 47, 133740, 'image/png', '2024-11-28 22:28:38', '2024-11-28 22:28:38');
INSERT INTO `product_pic` VALUES (132, '/product/1732804157889.png', 48, 256022, 'image/png', '2024-11-28 22:29:17', '2024-11-28 22:29:17');
INSERT INTO `product_pic` VALUES (133, '/product/1732804724478.jpeg', 49, 84932, 'image/jpeg', '2024-11-28 22:38:44', '2024-11-28 22:38:44');
INSERT INTO `product_pic` VALUES (134, '/product/1732804761179.jpeg', 50, 83969, 'image/jpeg', '2024-11-28 22:39:21', '2024-11-28 22:39:21');
INSERT INTO `product_pic` VALUES (135, '/product/1732804797206.jpeg', 51, 83969, 'image/jpeg', '2024-11-28 22:39:57', '2024-11-28 22:39:57');
INSERT INTO `product_pic` VALUES (136, '/product/1732804872159.png', 52, 101977, 'image/png', '2024-11-28 22:41:12', '2024-11-28 22:41:12');
INSERT INTO `product_pic` VALUES (137, '/product/1732804925584.png', 53, 101977, 'image/png', '2024-11-28 22:42:05', '2024-11-28 22:42:05');
INSERT INTO `product_pic` VALUES (138, '/product/1732804976744.png', 54, 60719, 'image/png', '2024-11-28 22:42:56', '2024-11-28 22:42:56');
INSERT INTO `product_pic` VALUES (139, '/product/1732805027770.png', 55, 291847, 'image/png', '2024-11-28 22:43:47', '2024-11-28 22:43:47');
INSERT INTO `product_pic` VALUES (140, '/product/1732805113682.png', 57, 102719, 'image/png', '2024-11-28 22:45:13', '2024-11-28 22:45:13');
INSERT INTO `product_pic` VALUES (141, '/product/1732805121030.png', 56, 102719, 'image/png', '2024-11-28 22:45:21', '2024-11-28 22:45:21');
INSERT INTO `product_pic` VALUES (142, '/product/1732805183782.jpeg', 58, 40272, 'image/jpeg', '2024-11-28 22:46:23', '2024-11-28 22:46:23');
INSERT INTO `product_pic` VALUES (143, '/product/1732805237108.jpeg', 59, 170236, 'image/jpeg', '2024-11-28 22:47:17', '2024-11-28 22:47:17');
INSERT INTO `product_pic` VALUES (144, '/product/1732805319750.png', 60, 105638, 'image/png', '2024-11-28 22:48:39', '2024-11-28 22:48:39');
INSERT INTO `product_pic` VALUES (145, '/product/1732805358228.png', 61, 105638, 'image/png', '2024-11-28 22:49:18', '2024-11-28 22:49:18');
INSERT INTO `product_pic` VALUES (146, '/product/1732805386248.png', 62, 105638, 'image/png', '2024-11-28 22:49:46', '2024-11-28 22:49:46');
INSERT INTO `product_pic` VALUES (147, '/product/1732805428273.jpeg', 63, 242576, 'image/jpeg', '2024-11-28 22:50:28', '2024-11-28 22:50:28');
INSERT INTO `product_pic` VALUES (148, '/product/1732805472772.jpeg', 64, 65347, 'image/jpeg', '2024-11-28 22:51:12', '2024-11-28 22:51:12');
INSERT INTO `product_pic` VALUES (149, '/product/1732805518233.jpeg', 65, 242576, 'image/jpeg', '2024-11-28 22:51:58', '2024-11-28 22:51:58');
INSERT INTO `product_pic` VALUES (150, '/product/1732805554753.jpeg', 66, 84932, 'image/jpeg', '2024-11-28 22:52:34', '2024-11-28 22:52:34');
INSERT INTO `product_pic` VALUES (151, '/product/1732805635386.jpeg', 67, 170236, 'image/jpeg', '2024-11-28 22:53:55', '2024-11-28 22:53:55');
INSERT INTO `product_pic` VALUES (152, '/product/1732805685462.jpeg', 68, 84932, 'image/jpeg', '2024-11-28 22:54:45', '2024-11-28 22:54:45');
INSERT INTO `product_pic` VALUES (153, '/product/1732805715883.jpeg', 69, 84932, 'image/jpeg', '2024-11-28 22:55:15', '2024-11-28 22:55:15');
INSERT INTO `product_pic` VALUES (154, '/product/1732805736549.jpeg', 70, 84932, 'image/jpeg', '2024-11-28 22:55:36', '2024-11-28 22:55:36');
INSERT INTO `product_pic` VALUES (155, '/product/1732805830687.jpeg', 71, 53702, 'image/jpeg', '2024-11-28 22:57:10', '2024-11-28 22:57:10');
INSERT INTO `product_pic` VALUES (156, '/product/1732805830687.jpeg', 71, 51175, 'image/jpeg', '2024-11-28 22:57:10', '2024-11-28 22:57:10');
INSERT INTO `product_pic` VALUES (157, '/product/1732805830688.jpeg', 71, 55397, 'image/jpeg', '2024-11-28 22:57:10', '2024-11-28 22:57:10');
INSERT INTO `product_pic` VALUES (158, '/product/1732806045922.png', 72, 68541, 'image/png', '2024-11-28 23:00:45', '2024-11-28 23:00:45');
INSERT INTO `product_pic` VALUES (159, '/product/1732806093134.png', 73, 68541, 'image/png', '2024-11-28 23:01:33', '2024-11-28 23:01:33');
INSERT INTO `product_pic` VALUES (160, '/product/1732806123869.png', 74, 68541, 'image/png', '2024-11-28 23:02:03', '2024-11-28 23:02:03');
INSERT INTO `product_pic` VALUES (161, '/product/1732806164498.png', 75, 68541, 'image/png', '2024-11-28 23:02:44', '2024-11-28 23:02:44');
INSERT INTO `product_pic` VALUES (162, '/product/1732806198894.png', 76, 68541, 'image/png', '2024-11-28 23:03:18', '2024-11-28 23:03:18');
INSERT INTO `product_pic` VALUES (163, '/product/1732806229004.png', 77, 68541, 'image/png', '2024-11-28 23:03:49', '2024-11-28 23:03:49');
INSERT INTO `product_pic` VALUES (164, '/product/1732806268789.png', 78, 68541, 'image/png', '2024-11-28 23:04:28', '2024-11-28 23:04:28');
INSERT INTO `product_pic` VALUES (165, '/product/1732806334378.png', 79, 71806, 'image/png', '2024-11-28 23:05:34', '2024-11-28 23:05:34');
INSERT INTO `product_pic` VALUES (166, '/product/1732806380416.png', 80, 71806, 'image/png', '2024-11-28 23:06:20', '2024-11-28 23:06:20');
INSERT INTO `product_pic` VALUES (167, '/product/1732806444182.png', 81, 60366, 'image/png', '2024-11-28 23:07:24', '2024-11-28 23:07:24');
INSERT INTO `product_pic` VALUES (168, '/product/1732806470575.png', 82, 60366, 'image/png', '2024-11-28 23:07:50', '2024-11-28 23:07:50');
INSERT INTO `product_pic` VALUES (169, '/product/1732806517373.png', 83, 60366, 'image/png', '2024-11-28 23:08:37', '2024-11-28 23:08:37');
INSERT INTO `product_pic` VALUES (172, '/product/1732806883786.png', 85, 60366, 'image/png', '2024-11-28 23:14:43', '2024-11-28 23:14:43');
INSERT INTO `product_pic` VALUES (173, '/product/1732806943316.png', 86, 66115, 'image/png', '2024-11-28 23:15:43', '2024-11-28 23:15:43');
INSERT INTO `product_pic` VALUES (174, '/product/1732806980881.png', 87, 66115, 'image/png', '2024-11-28 23:16:20', '2024-11-28 23:16:20');
INSERT INTO `product_pic` VALUES (175, '/product/1732807105217.png', 88, 68541, 'image/png', '2024-11-28 23:18:25', '2024-11-28 23:18:25');
INSERT INTO `product_pic` VALUES (176, '/product/1732807156457.jpeg', 89, 118948, 'image/jpeg', '2024-11-28 23:19:16', '2024-11-28 23:19:16');
INSERT INTO `product_pic` VALUES (177, '/product/1732807220648.png', 90, 74832, 'image/png', '2024-11-28 23:20:20', '2024-11-28 23:20:20');
INSERT INTO `product_pic` VALUES (178, '/product/1732807260789.png', 91, 74832, 'image/png', '2024-11-28 23:21:00', '2024-11-28 23:21:00');
INSERT INTO `product_pic` VALUES (179, '/product/1732807330394.png', 92, 137994, 'image/png', '2024-11-28 23:22:10', '2024-11-28 23:22:10');
INSERT INTO `product_pic` VALUES (180, '/product/1732807371666.png', 93, 232292, 'image/png', '2024-11-28 23:22:51', '2024-11-28 23:22:51');
INSERT INTO `product_pic` VALUES (181, '/product/1732807415965.png', 94, 78381, 'image/png', '2024-11-28 23:23:35', '2024-11-28 23:23:35');
INSERT INTO `product_pic` VALUES (182, '/product/1732807449379.png', 95, 78381, 'image/png', '2024-11-28 23:24:09', '2024-11-28 23:24:09');
INSERT INTO `product_pic` VALUES (183, '/product/1732807543966.png', 96, 449622, 'image/png', '2024-11-28 23:25:43', '2024-11-28 23:25:43');
INSERT INTO `product_pic` VALUES (184, '/product/1732807598298.png', 97, 501468, 'image/png', '2024-11-28 23:26:38', '2024-11-28 23:26:38');
INSERT INTO `product_pic` VALUES (188, '/product/1732807831627.png', 98, 120364, 'image/png', '2024-11-28 23:30:31', '2024-11-28 23:30:31');
INSERT INTO `product_pic` VALUES (189, '/product/1732807831627.png', 98, 121046, 'image/png', '2024-11-28 23:30:31', '2024-11-28 23:30:31');
INSERT INTO `product_pic` VALUES (190, '/product/1732807831628.png', 98, 121876, 'image/png', '2024-11-28 23:30:31', '2024-11-28 23:30:31');
INSERT INTO `product_pic` VALUES (191, '/product/1732809132939.png', 99, 120364, 'image/png', '2024-11-28 23:52:12', '2024-11-28 23:52:12');
INSERT INTO `product_pic` VALUES (192, '/product/1732809132941.png', 99, 121046, 'image/png', '2024-11-28 23:52:12', '2024-11-28 23:52:12');
INSERT INTO `product_pic` VALUES (193, '/product/1732809132942.png', 99, 121876, 'image/png', '2024-11-28 23:52:12', '2024-11-28 23:52:12');
INSERT INTO `product_pic` VALUES (200, '/product/1732809172741.png', 101, 120364, 'image/png', '2024-11-28 23:52:52', '2024-11-28 23:52:52');
INSERT INTO `product_pic` VALUES (201, '/product/1732809172741.png', 101, 121046, 'image/png', '2024-11-28 23:52:52', '2024-11-28 23:52:52');
INSERT INTO `product_pic` VALUES (202, '/product/1732809172742.png', 101, 121876, 'image/png', '2024-11-28 23:52:52', '2024-11-28 23:52:52');
INSERT INTO `product_pic` VALUES (203, '/product/1732809180333.png', 102, 120364, 'image/png', '2024-11-28 23:53:00', '2024-11-28 23:53:00');
INSERT INTO `product_pic` VALUES (204, '/product/1732809180333.png', 102, 121046, 'image/png', '2024-11-28 23:53:00', '2024-11-28 23:53:00');
INSERT INTO `product_pic` VALUES (205, '/product/1732809180334.png', 102, 121876, 'image/png', '2024-11-28 23:53:00', '2024-11-28 23:53:00');
INSERT INTO `product_pic` VALUES (209, '/product/1732809192610.png', 104, 120364, 'image/png', '2024-11-28 23:53:12', '2024-11-28 23:53:12');
INSERT INTO `product_pic` VALUES (210, '/product/1732809192610.png', 104, 121046, 'image/png', '2024-11-28 23:53:12', '2024-11-28 23:53:12');
INSERT INTO `product_pic` VALUES (211, '/product/1732809192611.png', 104, 121876, 'image/png', '2024-11-28 23:53:12', '2024-11-28 23:53:12');
INSERT INTO `product_pic` VALUES (218, '/product/1732809216445.png', 103, 120364, 'image/png', '2024-11-28 23:53:36', '2024-11-28 23:53:36');
INSERT INTO `product_pic` VALUES (219, '/product/1732809227391.png', 103, 121046, 'image/png', '2024-11-28 23:53:47', '2024-11-28 23:53:47');
INSERT INTO `product_pic` VALUES (220, '/product/1732809227392.png', 103, 121876, 'image/png', '2024-11-28 23:53:47', '2024-11-28 23:53:47');
INSERT INTO `product_pic` VALUES (221, '/product/1732809884686.png', 105, 117292, 'image/png', '2024-11-29 00:04:44', '2024-11-29 00:04:44');
INSERT INTO `product_pic` VALUES (222, '/product/1732809884686.png', 105, 120291, 'image/png', '2024-11-29 00:04:44', '2024-11-29 00:04:44');
INSERT INTO `product_pic` VALUES (223, '/product/1732809884687.png', 105, 119381, 'image/png', '2024-11-29 00:04:44', '2024-11-29 00:04:44');
INSERT INTO `product_pic` VALUES (224, '/product/1732810038706.png', 106, 117292, 'image/png', '2024-11-29 00:07:18', '2024-11-29 00:07:18');
INSERT INTO `product_pic` VALUES (225, '/product/1732810038706.png', 106, 120291, 'image/png', '2024-11-29 00:07:18', '2024-11-29 00:07:18');
INSERT INTO `product_pic` VALUES (226, '/product/1732810038707.png', 106, 119381, 'image/png', '2024-11-29 00:07:18', '2024-11-29 00:07:18');
INSERT INTO `product_pic` VALUES (227, '/product/1732810045414.png', 107, 117292, 'image/png', '2024-11-29 00:07:25', '2024-11-29 00:07:25');
INSERT INTO `product_pic` VALUES (228, '/product/1732810045415.png', 107, 119381, 'image/png', '2024-11-29 00:07:25', '2024-11-29 00:07:25');
INSERT INTO `product_pic` VALUES (229, '/product/1732810045414.png', 107, 120291, 'image/png', '2024-11-29 00:07:25', '2024-11-29 00:07:25');
INSERT INTO `product_pic` VALUES (230, '/product/1732810051927.png', 108, 117292, 'image/png', '2024-11-29 00:07:31', '2024-11-29 00:07:31');
INSERT INTO `product_pic` VALUES (231, '/product/1732810051927.png', 108, 120291, 'image/png', '2024-11-29 00:07:31', '2024-11-29 00:07:31');
INSERT INTO `product_pic` VALUES (232, '/product/1732810051928.png', 108, 119381, 'image/png', '2024-11-29 00:07:31', '2024-11-29 00:07:31');
INSERT INTO `product_pic` VALUES (233, '/product/1732810058304.png', 109, 117292, 'image/png', '2024-11-29 00:07:38', '2024-11-29 00:07:38');
INSERT INTO `product_pic` VALUES (234, '/product/1732810058305.png', 109, 120291, 'image/png', '2024-11-29 00:07:38', '2024-11-29 00:07:38');
INSERT INTO `product_pic` VALUES (235, '/product/1732810058306.png', 109, 119381, 'image/png', '2024-11-29 00:07:38', '2024-11-29 00:07:38');
INSERT INTO `product_pic` VALUES (236, '/product/1732810173000.webp', 98, 7016, 'image/webp', '2024-11-29 00:09:33', '2024-11-29 00:09:33');
INSERT INTO `product_pic` VALUES (237, '/product/1732810179439.webp', 99, 7016, 'image/webp', '2024-11-29 00:09:39', '2024-11-29 00:09:39');
INSERT INTO `product_pic` VALUES (242, '/product/1732810215152.png', 100, 120291, 'image/png', '2024-11-29 00:10:15', '2024-11-29 00:10:15');
INSERT INTO `product_pic` VALUES (243, '/product/1732810215152.webp', 100, 7016, 'image/webp', '2024-11-29 00:10:15', '2024-11-29 00:10:15');
INSERT INTO `product_pic` VALUES (244, '/product/1732810215153.png', 100, 119381, 'image/png', '2024-11-29 00:10:15', '2024-11-29 00:10:15');
INSERT INTO `product_pic` VALUES (245, '/product/1732810215151.png', 100, 117292, 'image/png', '2024-11-29 00:10:15', '2024-11-29 00:10:15');
INSERT INTO `product_pic` VALUES (246, '/product/1732810241275.webp', 101, 7016, 'image/webp', '2024-11-29 00:10:41', '2024-11-29 00:10:41');
INSERT INTO `product_pic` VALUES (247, '/product/1732810247956.webp', 102, 7016, 'image/webp', '2024-11-29 00:10:47', '2024-11-29 00:10:47');
INSERT INTO `product_pic` VALUES (248, '/product/1732810253748.webp', 103, 7016, 'image/webp', '2024-11-29 00:10:53', '2024-11-29 00:10:53');
INSERT INTO `product_pic` VALUES (249, '/product/1732810261680.webp', 104, 7016, 'image/webp', '2024-11-29 00:11:01', '2024-11-29 00:11:01');
INSERT INTO `product_pic` VALUES (250, '/product/1732810267813.webp', 105, 7016, 'image/webp', '2024-11-29 00:11:07', '2024-11-29 00:11:07');
INSERT INTO `product_pic` VALUES (251, '/product/1732810274247.webp', 106, 7016, 'image/webp', '2024-11-29 00:11:14', '2024-11-29 00:11:14');
INSERT INTO `product_pic` VALUES (252, '/product/1732810282128.webp', 107, 7016, 'image/webp', '2024-11-29 00:11:22', '2024-11-29 00:11:22');
INSERT INTO `product_pic` VALUES (253, '/product/1732810288970.webp', 108, 7016, 'image/webp', '2024-11-29 00:11:28', '2024-11-29 00:11:28');
INSERT INTO `product_pic` VALUES (254, '/product/1732810295811.webp', 109, 7016, 'image/webp', '2024-11-29 00:11:35', '2024-11-29 00:11:35');
INSERT INTO `product_pic` VALUES (255, '/product/1732810500862.png', 110, 179606, 'image/png', '2024-11-29 00:15:00', '2024-11-29 00:15:00');
INSERT INTO `product_pic` VALUES (256, '/product/1732810500864.png', 110, 122708, 'image/png', '2024-11-29 00:15:00', '2024-11-29 00:15:00');
INSERT INTO `product_pic` VALUES (257, '/product/1732810637992.png', 111, 179606, 'image/png', '2024-11-29 00:17:18', '2024-11-29 00:17:18');
INSERT INTO `product_pic` VALUES (258, '/product/1732810637994.png', 111, 122708, 'image/png', '2024-11-29 00:17:18', '2024-11-29 00:17:18');
INSERT INTO `product_pic` VALUES (259, '/product/1732810647024.png', 112, 179606, 'image/png', '2024-11-29 00:17:27', '2024-11-29 00:17:27');
INSERT INTO `product_pic` VALUES (260, '/product/1732810647025.png', 112, 122708, 'image/png', '2024-11-29 00:17:27', '2024-11-29 00:17:27');
INSERT INTO `product_pic` VALUES (263, '/product/1732810950238.png', 114, 71232, 'image/png', '2024-11-29 00:22:30', '2024-11-29 00:22:30');
INSERT INTO `product_pic` VALUES (264, '/product/1732810950239.png', 114, 92753, 'image/png', '2024-11-29 00:22:30', '2024-11-29 00:22:30');
INSERT INTO `product_pic` VALUES (267, '/product/1732810967355.png', 113, 71232, 'image/png', '2024-11-29 00:22:47', '2024-11-29 00:22:47');
INSERT INTO `product_pic` VALUES (268, '/product/1732810975536.png', 113, 92753, 'image/png', '2024-11-29 00:22:55', '2024-11-29 00:22:55');
INSERT INTO `product_pic` VALUES (269, '/product/1732810985329.png', 115, 92753, 'image/png', '2024-11-29 00:23:05', '2024-11-29 00:23:05');
INSERT INTO `product_pic` VALUES (270, '/product/1732810985329.png', 115, 71232, 'image/png', '2024-11-29 00:23:05', '2024-11-29 00:23:05');
INSERT INTO `product_pic` VALUES (271, '/product/1732810991652.png', 116, 71232, 'image/png', '2024-11-29 00:23:11', '2024-11-29 00:23:11');
INSERT INTO `product_pic` VALUES (272, '/product/1732810991652.png', 116, 92753, 'image/png', '2024-11-29 00:23:11', '2024-11-29 00:23:11');
INSERT INTO `product_pic` VALUES (273, '/product/1732810997508.png', 117, 71232, 'image/png', '2024-11-29 00:23:17', '2024-11-29 00:23:17');
INSERT INTO `product_pic` VALUES (274, '/product/1732810997508.png', 117, 92753, 'image/png', '2024-11-29 00:23:17', '2024-11-29 00:23:17');
INSERT INTO `product_pic` VALUES (280, '/product/1732855612818.jpeg', 118, 47964, 'image/jpeg', '2024-11-29 12:46:52', '2024-11-29 12:46:52');
INSERT INTO `product_pic` VALUES (281, '/product/1732855612818.jpeg', 118, 59660, 'image/jpeg', '2024-11-29 12:46:52', '2024-11-29 12:46:52');
INSERT INTO `product_pic` VALUES (285, '/product/1732855627522.jpeg', 118, 71904, 'image/jpeg', '2024-11-29 12:47:07', '2024-11-29 12:47:07');
INSERT INTO `product_pic` VALUES (286, '/product/1732855627523.jpeg', 118, 52721, 'image/jpeg', '2024-11-29 12:47:07', '2024-11-29 12:47:07');
INSERT INTO `product_pic` VALUES (287, '/product/1732855636694.jpeg', 118, 40624, 'image/jpeg', '2024-11-29 12:47:16', '2024-11-29 12:47:16');
INSERT INTO `product_pic` VALUES (288, '/product/1732856424835.jpeg', 119, 109107, 'image/jpeg', '2024-11-29 13:00:24', '2024-11-29 13:00:24');
INSERT INTO `product_pic` VALUES (289, '/product/1732856424836.jpeg', 119, 82517, 'image/jpeg', '2024-11-29 13:00:24', '2024-11-29 13:00:24');
INSERT INTO `product_pic` VALUES (290, '/product/1732856424837.jpeg', 119, 107155, 'image/jpeg', '2024-11-29 13:00:24', '2024-11-29 13:00:24');
INSERT INTO `product_pic` VALUES (291, '/product/1732856424833.jpeg', 119, 105596, 'image/jpeg', '2024-11-29 13:00:24', '2024-11-29 13:00:24');
INSERT INTO `product_pic` VALUES (292, '/product/1732856424834.jpeg', 119, 110311, 'image/jpeg', '2024-11-29 13:00:24', '2024-11-29 13:00:24');
INSERT INTO `product_pic` VALUES (297, '/product/1732856469815.jpeg', 120, 24923, 'image/jpeg', '2024-11-29 13:01:09', '2024-11-29 13:01:09');
INSERT INTO `product_pic` VALUES (298, '/product/1732856469815.jpeg', 120, 42678, 'image/jpeg', '2024-11-29 13:01:09', '2024-11-29 13:01:09');
INSERT INTO `product_pic` VALUES (299, '/product/1732856469816.jpeg', 120, 38803, 'image/jpeg', '2024-11-29 13:01:09', '2024-11-29 13:01:09');
INSERT INTO `product_pic` VALUES (300, '/product/1732856469815.jpeg', 120, 34326, 'image/jpeg', '2024-11-29 13:01:09', '2024-11-29 13:01:09');
INSERT INTO `product_pic` VALUES (301, '/product/1732856491779.jpeg', 121, 29491, 'image/jpeg', '2024-11-29 13:01:31', '2024-11-29 13:01:31');
INSERT INTO `product_pic` VALUES (302, '/product/1732856491780.jpeg', 121, 36705, 'image/jpeg', '2024-11-29 13:01:31', '2024-11-29 13:01:31');
INSERT INTO `product_pic` VALUES (303, '/product/1732856491780.jpeg', 121, 36560, 'image/jpeg', '2024-11-29 13:01:31', '2024-11-29 13:01:31');
INSERT INTO `product_pic` VALUES (304, '/product/1732856491781.jpeg', 121, 31284, 'image/jpeg', '2024-11-29 13:01:31', '2024-11-29 13:01:31');
INSERT INTO `product_pic` VALUES (305, '/product/1732856491781.jpeg', 121, 38741, 'image/jpeg', '2024-11-29 13:01:31', '2024-11-29 13:01:31');
INSERT INTO `product_pic` VALUES (306, '/product/1732856513145.jpeg', 122, 66056, 'image/jpeg', '2024-11-29 13:01:53', '2024-11-29 13:01:53');
INSERT INTO `product_pic` VALUES (307, '/product/1732856536986.jpeg', 123, 49555, 'image/jpeg', '2024-11-29 13:02:16', '2024-11-29 13:02:16');
INSERT INTO `product_pic` VALUES (309, '/product/1732856623433.png', 125, 55725, 'image/png', '2024-11-29 13:03:43', '2024-11-29 13:03:43');
INSERT INTO `product_pic` VALUES (310, '/product/1732856648344.png', 124, 63666, 'image/png', '2024-11-29 13:04:08', '2024-11-29 13:04:08');
INSERT INTO `product_pic` VALUES (311, '/product/1732856682747.png', 126, 85319, 'image/png', '2024-11-29 13:04:42', '2024-11-29 13:04:42');
INSERT INTO `product_pic` VALUES (312, '/product/1732856755063.png', 127, 72885, 'image/png', '2024-11-29 13:05:55', '2024-11-29 13:05:55');
INSERT INTO `product_pic` VALUES (313, '/product/1732856767080.png', 128, 85352, 'image/png', '2024-11-29 13:06:07', '2024-11-29 13:06:07');
INSERT INTO `product_pic` VALUES (314, '/product/1732856775570.png', 129, 186386, 'image/png', '2024-11-29 13:06:15', '2024-11-29 13:06:15');
INSERT INTO `product_pic` VALUES (321, '/product/1732856830030.jpeg', 130, 62802, 'image/jpeg', '2024-11-29 13:07:10', '2024-11-29 13:07:10');
INSERT INTO `product_pic` VALUES (322, '/product/1732856830030.jpeg', 130, 60963, 'image/jpeg', '2024-11-29 13:07:10', '2024-11-29 13:07:10');
INSERT INTO `product_pic` VALUES (323, '/product/1732856846130.jpeg', 130, 62802, 'image/jpeg', '2024-11-29 13:07:26', '2024-11-29 13:07:26');
INSERT INTO `product_pic` VALUES (324, '/product/1732856846129.jpeg', 130, 64145, 'image/jpeg', '2024-11-29 13:07:26', '2024-11-29 13:07:26');
INSERT INTO `product_pic` VALUES (325, '/product/1732856903053.png', 131, 87128, 'image/png', '2024-11-29 13:08:23', '2024-11-29 13:08:23');
INSERT INTO `product_pic` VALUES (326, '/product/1732856920437.png', 132, 72885, 'image/png', '2024-11-29 13:08:40', '2024-11-29 13:08:40');
INSERT INTO `product_pic` VALUES (327, '/product/1732857356313.png', 136, 129897, 'image/png', '2024-11-29 13:15:56', '2024-11-29 13:15:56');
INSERT INTO `product_pic` VALUES (331, '/product/1732857713264.jpeg', 137, 28018, 'image/jpeg', '2024-11-29 13:21:53', '2024-11-29 13:21:53');
INSERT INTO `product_pic` VALUES (332, '/product/1732857713263.jpeg', 137, 32698, 'image/jpeg', '2024-11-29 13:21:53', '2024-11-29 13:21:53');
INSERT INTO `product_pic` VALUES (333, '/product/1732857713263.jpeg', 137, 61741, 'image/jpeg', '2024-11-29 13:21:53', '2024-11-29 13:21:53');
INSERT INTO `product_pic` VALUES (336, '/product/1732857786804.jpeg', 139, 14655, 'image/jpeg', '2024-11-29 13:23:06', '2024-11-29 13:23:06');
INSERT INTO `product_pic` VALUES (337, '/product/1732857796565.png', 140, 195340, 'image/png', '2024-11-29 13:23:16', '2024-11-29 13:23:16');
INSERT INTO `product_pic` VALUES (339, '/product/1732857851022.png', 141, 118475, 'image/png', '2024-11-29 13:24:11', '2024-11-29 13:24:11');
INSERT INTO `product_pic` VALUES (340, '/product/1732857865516.png', 138, 110593, 'image/png', '2024-11-29 13:24:25', '2024-11-29 13:24:25');
INSERT INTO `product_pic` VALUES (341, '/product/1732857878329.png', 142, 138010, 'image/png', '2024-11-29 13:24:38', '2024-11-29 13:24:38');
INSERT INTO `product_pic` VALUES (342, '/product/1732857893918.png', 143, 129529, 'image/png', '2024-11-29 13:24:53', '2024-11-29 13:24:53');
INSERT INTO `product_pic` VALUES (343, '/product/1732857909104.jpeg', 144, 212945, 'image/jpeg', '2024-11-29 13:25:09', '2024-11-29 13:25:09');
INSERT INTO `product_pic` VALUES (344, '/product/1732857909099.jpeg', 144, 199364, 'image/jpeg', '2024-11-29 13:25:09', '2024-11-29 13:25:09');
INSERT INTO `product_pic` VALUES (345, '/product/1732857909103.jpeg', 144, 172564, 'image/jpeg', '2024-11-29 13:25:09', '2024-11-29 13:25:09');
INSERT INTO `product_pic` VALUES (346, '/product/1732857909106.jpeg', 144, 199364, 'image/jpeg', '2024-11-29 13:25:09', '2024-11-29 13:25:09');
INSERT INTO `product_pic` VALUES (347, '/product/1732857923314.jpeg', 145, 50427, 'image/jpeg', '2024-11-29 13:25:23', '2024-11-29 13:25:23');
INSERT INTO `product_pic` VALUES (348, '/product/1732857931875.png', 146, 110593, 'image/png', '2024-11-29 13:25:31', '2024-11-29 13:25:31');
INSERT INTO `product_pic` VALUES (349, '/product/1732857943719.png', 148, 151418, 'image/png', '2024-11-29 13:25:43', '2024-11-29 13:25:43');

-- ----------------------------
-- Table structure for product_tag
-- ----------------------------
DROP TABLE IF EXISTS `product_tag`;
CREATE TABLE `product_tag`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `tag_msg` varchar(100) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tag_name`(`tag_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of product_tag
-- ----------------------------
INSERT INTO `product_tag` VALUES (31, '手机', 'Xiaomi/Redmi 手机', '2024-11-28 13:42:18', '2024-11-28 13:42:49');
INSERT INTO `product_tag` VALUES (32, '电视', '小米电视', '2024-11-28 13:42:29', '2024-11-28 13:43:01');
INSERT INTO `product_tag` VALUES (33, '笔记本', '小米笔记本', '2024-11-28 13:43:15', '2024-11-28 13:43:15');
INSERT INTO `product_tag` VALUES (34, '平板', '小米平板', '2024-11-28 13:43:28', '2024-11-29 00:26:28');
INSERT INTO `product_tag` VALUES (36, '路由器', '小米路由器', '2024-11-28 13:44:11', '2024-11-28 13:44:11');
INSERT INTO `product_tag` VALUES (37, '家电', '小米家电', '2024-11-29 12:38:41', '2024-11-29 12:38:41');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `password` varchar(100) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `enable` enum('true','false') CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT 'true',
  `user_msg_id` int NULL DEFAULT NULL,
  `user_type_id` int NULL DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone` ASC) USING BTREE,
  UNIQUE INDEX `phone_2`(`phone` ASC) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `user_msg_id`(`user_msg_id` ASC) USING BTREE,
  INDEX `user_type_id`(`user_type_id` ASC) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_msg_id`) REFERENCES `user_msg` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`user_type_id`) REFERENCES `user_type` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 106 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '13425383533', 'e10adc3949ba59abbe56e057f20f883e', 'true', 1, 1, '2024-03-16 11:12:04', '2024-11-22 20:08:56');
INSERT INTO `user` VALUES (2, '123456', '13425382424', 'e10adc3949ba59abbe56e057f20f883e', 'true', 2, 2, '2024-03-16 11:25:12', '2024-12-11 16:14:29');
INSERT INTO `user` VALUES (96, '12345678', '13425383532', 'e10adc3949ba59abbe56e057f20f883e', 'true', 105, 3, '2024-11-23 14:23:46', '2024-12-14 19:12:27');
INSERT INTO `user` VALUES (99, '1234567', '13452345766', 'e10adc3949ba59abbe56e057f20f883e', 'false', 106, 2, '2024-11-26 10:16:33', '2024-11-26 10:16:38');
INSERT INTO `user` VALUES (100, '1234567890', '13425383530', 'e10adc3949ba59abbe56e057f20f883e', 'true', 107, 2, '2024-11-28 20:55:12', '2024-11-28 20:55:12');
INSERT INTO `user` VALUES (101, '39029388373', '1348737364', 'e10adc3949ba59abbe56e057f20f883e', 'true', 108, 3, '2024-12-13 22:11:45', '2024-12-13 22:11:45');
INSERT INTO `user` VALUES (102, '111111', '13425387222', 'e10adc3949ba59abbe56e057f20f883e', 'true', 109, 3, '2024-12-13 22:22:56', '2024-12-13 22:22:56');
INSERT INTO `user` VALUES (105, '2180733045', '13472793722', 'e10adc3949ba59abbe56e057f20f883e', 'true', 112, 2, '2024-12-14 19:13:36', '2024-12-14 19:13:36');

-- ----------------------------
-- Table structure for user_avatar
-- ----------------------------
DROP TABLE IF EXISTS `user_avatar`;
CREATE TABLE `user_avatar`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `avatar_url` varchar(200) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL DEFAULT '/images/avatar.png',
  `user_id` int NULL DEFAULT NULL,
  `mimetype` varchar(50) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `user_avatar_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_avatar
-- ----------------------------
INSERT INTO `user_avatar` VALUES (47, '/images/1732346717437.jpeg', 1, 'image/jpeg', '2024-11-23 15:25:17', '2024-11-23 15:25:17');
INSERT INTO `user_avatar` VALUES (66, '/images/1733905393658.png', 2, 'image/png', '2024-12-11 16:23:13', '2024-12-11 16:23:13');
INSERT INTO `user_avatar` VALUES (67, '/images/1733937791560.png', 96, 'image/png', '2024-12-12 01:23:11', '2024-12-12 01:23:11');
INSERT INTO `user_avatar` VALUES (68, '/images/1734099800978.jpeg', 102, 'image/jpeg', '2024-12-13 22:23:20', '2024-12-13 22:23:20');

-- ----------------------------
-- Table structure for user_msg
-- ----------------------------
DROP TABLE IF EXISTS `user_msg`;
CREATE TABLE `user_msg`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nickname` varchar(80) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `age` varchar(4) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `sex` enum('男','女','未知') CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT '未知',
  `name` varchar(80) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `id_card` varchar(30) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT '',
  `shop_name` varchar(30) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT '',
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 113 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_msg
-- ----------------------------
INSERT INTO `user_msg` VALUES (1, '小孔', '21', '男', '孔祥煌', 'null', '', '2024-03-16 11:07:42', '2024-11-22 19:59:31');
INSERT INTO `user_msg` VALUES (2, 'D', '33', '男', 'Deng', '441224202409087932', 'null', '2024-03-16 11:24:06', '2024-12-13 22:21:29');
INSERT INTO `user_msg` VALUES (104, '小孔', '21', '男', '孔祥煌', 'null', '', '2024-11-23 14:22:58', '2024-11-23 14:44:48');
INSERT INTO `user_msg` VALUES (105, 'long', '18', '女', 'xiao long', '441224200207182755', '小孔电子产品专卖店', '2024-11-23 14:23:46', '2024-12-14 18:22:31');
INSERT INTO `user_msg` VALUES (106, 'deng-cl', '18', '未知', '小孔', '441224188807106282', 'xiao kong', '2024-11-26 10:16:33', '2024-11-26 10:16:33');
INSERT INTO `user_msg` VALUES (107, 'deng-cl', '22', '男', '孔祥炼', '441224200212125418', '小炼智能设备代理店', '2024-11-28 20:55:12', '2024-11-28 20:55:12');
INSERT INTO `user_msg` VALUES (108, 'long', '18', '女', 'xiao long', '', '', '2024-12-13 22:11:45', '2024-12-13 22:11:45');
INSERT INTO `user_msg` VALUES (109, '小孔-2号', '18', '男', '小孔', '', '', '2024-12-13 22:22:56', '2024-12-13 22:22:56');
INSERT INTO `user_msg` VALUES (110, 'long', '18', '女', 'xiao long', '4412242003331324123', '小 long 杂货铺', '2024-12-14 17:51:59', '2024-12-14 17:51:59');
INSERT INTO `user_msg` VALUES (111, 'long', '18', '女', 'xiao long', '4412242003331324123', '小 long 杂货铺', '2024-12-14 17:52:58', '2024-12-14 17:52:58');
INSERT INTO `user_msg` VALUES (112, 'deng-cl', '22', '男', '孔祥炼', '441224200207193761', 'XXXX', '2024-12-14 19:13:36', '2024-12-14 19:13:36');

-- ----------------------------
-- Table structure for user_type
-- ----------------------------
DROP TABLE IF EXISTS `user_type`;
CREATE TABLE `user_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_type` enum('root','user','merchant') CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `title` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = gb2312 COLLATE = gb2312_chinese_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_type
-- ----------------------------
INSERT INTO `user_type` VALUES (1, 'root', '超级管理员', '2024-03-16 11:04:36', '2024-04-11 08:43:49');
INSERT INTO `user_type` VALUES (2, 'merchant', '商家用户', '2024-03-16 11:04:54', '2024-04-11 09:39:49');
INSERT INTO `user_type` VALUES (3, 'user', '普通用户', '2024-03-16 11:05:03', '2024-04-11 08:43:59');

SET FOREIGN_KEY_CHECKS = 1;
