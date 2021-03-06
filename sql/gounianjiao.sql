/*
 Navicat Premium Data Transfer

 Source Server         : gounianjiao
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : 192.168.174.110:3311
 Source Schema         : gounianjiao

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 26/10/2021 14:01:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (60, '安全座椅ertge');
INSERT INTO `category` VALUES (64, '太阳镜');
INSERT INTO `category` VALUES (68, '品牌女装');
INSERT INTO `category` VALUES (69, '时尚男鞋');
INSERT INTO `category` VALUES (71, '男士西服');
INSERT INTO `category` VALUES (72, '男士手拿包 ');
INSERT INTO `category` VALUES (73, '男表');
INSERT INTO `category` VALUES (74, '女表');
INSERT INTO `category` VALUES (75, '空调');
INSERT INTO `category` VALUES (76, '冰箱');
INSERT INTO `category` VALUES (77, '原汁机');
INSERT INTO `category` VALUES (78, '扫地机器人 ');
INSERT INTO `category` VALUES (79, '平衡车');
INSERT INTO `category` VALUES (80, '电热水器');
INSERT INTO `category` VALUES (81, '沙发');
INSERT INTO `category` VALUES (82, '马桶');
INSERT INTO `category` VALUES (83, '平板电视');

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '优惠卷id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '优惠卷名称',
  `promoteMoney` float NULL DEFAULT NULL COMMENT '减免金额',
  `get_Date` datetime(0) NULL DEFAULT NULL COMMENT '获得时间',
  `expire_Date` datetime(0) NULL DEFAULT NULL COMMENT '失效时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupon
-- ----------------------------

-- ----------------------------
-- Table structure for orderitem
-- ----------------------------
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '订单项id',
  `pid` int(0) NULL DEFAULT NULL COMMENT '产品id',
  `oid` int(0) NULL DEFAULT NULL COMMENT '订单id',
  `uid` int(0) NULL DEFAULT NULL COMMENT '用户id',
  `number` int(0) NULL DEFAULT NULL COMMENT '该订单产品数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_orderitem_user`(`uid`) USING BTREE,
  INDEX `fk_orderitem_product`(`pid`) USING BTREE,
  INDEX `fk_orderitem_order`(`oid`) USING BTREE,
  CONSTRAINT `fk_orderitem_order` FOREIGN KEY (`oid`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_orderitem_product` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_orderitem_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderitem
-- ----------------------------
INSERT INTO `orderitem` VALUES (16, 958, NULL, 11, 14);
INSERT INTO `orderitem` VALUES (17, 900, NULL, 11, 1);
INSERT INTO `orderitem` VALUES (18, 899, NULL, 12, 4);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `orderCode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单项id',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `post` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `receiver` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `userMessage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户信息',
  `createDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `payDate` datetime(0) NULL DEFAULT NULL COMMENT '支付时间',
  `deliveryDate` datetime(0) NULL DEFAULT NULL COMMENT '订单发货时间',
  `confirmDate` datetime(0) NULL DEFAULT NULL COMMENT '订单收到时间',
  `uid` int(0) NULL DEFAULT NULL COMMENT '用户id',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_order_user`(`uid`) USING BTREE,
  CONSTRAINT `fk_order_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (2, 'ecdc4e43f056401c9dbe668b570875fc', '', '', '', '', NULL, '2021-10-26 09:03:28', NULL, NULL, NULL, 11, 'waitPay');
INSERT INTO `orders` VALUES (3, '1d68a6e6200f4e55a66d6fa4162bba6e', '', '', '', '', NULL, '2021-10-26 09:05:26', NULL, NULL, NULL, 11, 'waitPay');
INSERT INTO `orders` VALUES (4, 'd54a2b9129e64d24a509820dbb3aed01', '', '', '', '', NULL, '2021-10-26 11:34:08', NULL, NULL, NULL, 12, 'waitPay');
INSERT INTO `orders` VALUES (5, '0dcd005af6ae4fd38a9eed167b61e1cd', '', '', '', '', NULL, '2021-10-26 11:34:14', NULL, NULL, NULL, 12, 'waitPay');
INSERT INTO `orders` VALUES (6, '53319d976b454a54a5e0f5f8107531af', '', '', '', '', NULL, '2021-10-26 11:34:24', NULL, NULL, NULL, 12, 'waitPay');
INSERT INTO `orders` VALUES (7, '9736e1a257bf4b46931d7ebb057d0c5d', '', '', '', '', NULL, '2021-10-26 11:34:30', NULL, NULL, NULL, 12, 'waitPay');
INSERT INTO `orders` VALUES (8, '6800dd37d67c431ea22f86c27156eb81', '', '', '', '', NULL, '2021-10-26 13:45:17', NULL, NULL, NULL, 11, 'waitPay');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '产品id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '产品名称',
  `subTitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品副标题',
  `originalPrice` float NULL DEFAULT NULL COMMENT '原价格',
  `promotePrice` float NOT NULL COMMENT '促销价格',
  `stock` int(0) NULL DEFAULT NULL COMMENT '库存',
  `cid` int(0) NULL DEFAULT NULL COMMENT '分类id',
  `createDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_product_category`(`cid`) USING BTREE,
  CONSTRAINT `fk_product_category` FOREIGN KEY (`cid`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 963 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES (87, 'Konka/康佳 LED32S1卧室32吋安卓智能无线WIFI网络液晶平板电视机', '32吋电视机 8核智能 网络 全国联保 送货上门', 1699, 1104.35, 98, 83, '2016-08-13 16:43:32');
INSERT INTO `product` VALUES (88, 'Hisense/海信 LED49EC320A 49吋led液晶电视机智能网络平板电视50', '新品特惠 十核智能 内置WiFi 咨询有惊喜', 2799, 1679.4, 90, 83, '2016-07-28 16:43:38');
INSERT INTO `product` VALUES (89, 'Hisense/海信 LED40EC520UA 40英寸4K智能平板液晶电视机WIFI网络', '周末 特惠 2189 元还送 精美礼品', 2399, 1439.4, 82, 83, '2016-07-28 16:44:18');
INSERT INTO `product` VALUES (90, 'Changhong/长虹 65S1安卓智能12核65英寸网络平板LED液晶电视机70', '屏大影院 高配12核 安卓智能', 4499.01, 3824.16, 84, 83, '2016-08-13 16:44:39');
INSERT INTO `product` VALUES (91, '夏普屏PANDA/熊猫 LE39D71S 39英寸智能WiFi液晶平板电视40 42 43', '屏大影院 高配12核 安卓智能', 2499, 1874.25, 75, 83, '2016-07-18 16:45:05');
INSERT INTO `product` VALUES (147, '乐洁士智能马桶高品质全自动遥控感应一体式智能坐便器座便器', '全国联保 清洗烘干 气泡按摩 座圈加热 断电冲水', 8960, 8512, 62, 82, '2016-08-15 00:37:21');
INSERT INTO `product` VALUES (148, '箭牌马桶/ARROW AB1118脲醛盖板连体喷射虹吸式坐便器座便器正品', '领券更优惠 品质脲醛盖 千城送装 送安装配件', 1976, 1482, 65, 82, '2016-07-29 00:37:23');
INSERT INTO `product` VALUES (149, '纳蒂兰卡1066卫浴漩冲虹吸式马桶350坑距坐便器可配智能盖座便器', '盖板易拆 送全套配件 500区县 送货入户安装', 1670, 1503, 93, 82, '2016-07-20 00:37:25');
INSERT INTO `product` VALUES (150, '德国DGPOSY超漩式彩色马桶缓降坐便器静音节水抽水马桶连体座便器', '纳米自洁釉 漩涡排污 静音节水 净重50kg', 2399, 1799.25, 79, 82, '2016-07-31 00:37:27');
INSERT INTO `product` VALUES (151, '纳蒂兰卡 1082卫浴洁具 钻石切边 坐便器 虹吸式抽水马桶 座便器', '高性价比 造型新颖 钻石品质 时尚尊贵 好评如潮', 1900, 1710, 64, 82, '2016-08-03 00:37:29');
INSERT INTO `product` VALUES (202, '新款布艺沙发 可拆洗大小户型客厅简约家居贵妃组合L型转角布沙发', '', 5198, 3638.6, 94, 81, '2016-08-20 00:45:28');
INSERT INTO `product` VALUES (203, '凯米蒂亚欧式真皮沙发组合客厅奢华转角皮艺蓝色沙发美式实木家具', '匠心独运 欧式美式设计 头层真皮 三包到家', 18398, 11038.8, 27, 81, '2016-08-19 00:45:32');
INSERT INTO `product` VALUES (204, '南台布艺沙发组合可拆洗简约现代客厅整装家具布艺沙发组合大户型', '16CM坐垫 16CM坐垫 重要的 事情 说三遍', 6576, 4274.4, 63, 81, '2016-08-16 00:45:36');
INSERT INTO `product` VALUES (205, '依然美佳欧式布艺沙发组合可拆洗新款实木雕花大户型奢华别墅家具', '高档户型客厅 精湛雕花工艺 实木框架 经典款式', 10012, 7008.4, 51, 81, '2016-08-08 00:45:39');
INSERT INTO `product` VALUES (206, '雅居汇欧式沙发组合实木雕花客厅高档奢华大户型住宅家具布艺沙发', '热卖推荐 端庄大气 四色可选 五年质保 品质服务', 32450, 22715, 51, 81, '2016-08-02 00:45:44');
INSERT INTO `product` VALUES (262, 'Vatti/华帝 DDF60-i14007 60升遥控电储水式电热水器家用速热洗澡', '热水器狂欢 专享特价 送货入户 免费安装', 2399, 1439.4, 80, 80, '2016-08-01 00:52:47');
INSERT INTO `product` VALUES (263, 'Haier/海尔 EC6005-T+  60升电热水器  洗澡淋浴 防电墙 送装同步', '3D速热 即用即洗 遥控智能控制 预约洗', 1999, 1299.35, 37, 80, '2016-08-10 00:52:49');
INSERT INTO `product` VALUES (264, '哆啦A梦weber I2-80 威博电热水器80升储水式智能速热洗澡淋浴60', '阿里智能 每天限送 20份大礼包 全国联保 包邮', 1799, 1079.4, 79, 80, '2016-08-10 00:52:52');
INSERT INTO `product` VALUES (265, 'Vanward/万和 DSCF50-C32双盾电热水器速热联保安装 洗澡 50L省电', '搪瓷超强内胆 高效节能 迅电速热 双盾保护', 999, 699.3, 17, 80, '2016-07-31 00:52:54');
INSERT INTO `product` VALUES (266, 'Haier/海尔 EC8003-I/80升洗澡淋浴/储热电热水器防电墙/送货入户', '机控遥控 一级节能 自动关机 触摸智能控制', 1799, 1169.35, 71, 80, '2016-07-14 00:52:56');
INSERT INTO `product` VALUES (317, '乐行天下R1N智能电动平衡车双轮成人思维体感车两轮儿童代步车', '12期免息 智能显示屏 APP遥控 双轮平衡', 15960, 11970, 15, 79, '2016-07-09 00:59:24');
INSERT INTO `product` VALUES (318, '乐途智能电动悬浮滑板车太空轮平行车蓝牙自平衡独轮代步车', '电动平衡 独轮滑板 蓝牙播放 新潮代步车', 3885, 3690.75, 70, 79, '2016-07-08 00:59:25');
INSERT INTO `product` VALUES (319, '瑞士米高micro g-bike+ chopper儿童平衡车二轮自行车', '', 899, 809.1, 13, 79, '2016-07-12 00:59:27');
INSERT INTO `product` VALUES (320, '力达康成人电动滑板车折叠锂电池迷你型可折叠两轮代步车', '可折叠 退货赔运费 续航50 公里更轻更远', 4160, 2912, 82, 79, '2016-08-19 00:59:28');
INSERT INTO `product` VALUES (321, '两轮平衡车双轮儿童思维漂移电动扭扭车智能滑板车成人体感代步车', '', 889, 755.65, 64, 79, '2016-08-09 00:59:29');
INSERT INTO `product` VALUES (373, '洁霸BF522多功能洗地机刷地机酒店家用地毯清洗机 擦地机抛光机', '纯铜电机 厂家直销 售后无忧', 1900, 1235, 39, 78, '2016-07-21 01:06:32');
INSERT INTO `product` VALUES (374, 'Proscenic Swan天鹅扫地机器人 智能家用擦地机拖地全自动吸尘器', '非常夏日 直降300元 WIFI智控 卷吸互换', 6580, 4935, 65, 78, '2016-07-08 01:06:34');
INSERT INTO `product` VALUES (375, '海尔拖地机器人家用全自动擦地机湿拖扫洗地电动智能懒人无线超薄', '仿人跪式 干湿两拖 自动充电 精准导航 规划清洁', 3999, 2999.25, 30, 78, '2016-07-21 01:06:37');
INSERT INTO `product` VALUES (376, '莱克扫地吸尘器 家用超薄拖地机器人WR10智能静音全自动', '新品上市 3000pa 大吸力 无惧毛发缠绕', 1299, 974.25, 11, 78, '2016-07-18 01:06:39');
INSERT INTO `product` VALUES (377, '公众智能扫地机器人家用全自动电动清洁地毯擦拖地一体机吸尘器', '扫拖一体 纤薄高效锂电 限时疯抢 不缠毛发', 2499, 2124.15, 88, 78, '2016-07-19 01:06:41');
INSERT INTO `product` VALUES (429, 'Philips/飞利浦榨汁机原汁家用HR1884多功能水果冰淇淋机慢汁机', '', 2899, 1884.35, 40, 77, '2016-07-14 01:14:03');
INSERT INTO `product` VALUES (430, 'Whirlpool/惠而浦WJU-VP152B原汁机多功能家用大口径料理榨果汁机', '整投整榨 原汁无氧化 纯铜电机 三挡压榨', 1099, 824.25, 22, 77, '2016-08-24 01:14:05');
INSERT INTO `product` VALUES (431, 'Ranbem/瑞本611原汁机大口径低慢速榨汁家用水果汁迷你豆浆机电动', '新款上市 96mm口径 45慢磨转速 出汁率高', 2680, 2278, 35, 77, '2016-07-21 01:14:08');
INSERT INTO `product` VALUES (432, 'AUX/奥克斯 AUX-Y3802原汁机低速 慢磨水果榨汁机果汁机', '', 999, 799.2, 50, 77, '2016-07-15 01:14:12');
INSERT INTO `product` VALUES (433, '惠而浦WJU-VS208J原汁机家用慢榨多功能榨汁机果汁机豆浆机炸汁机', '大功率慢榨 浓度调节 噪音小 易清洗 快捷清洗', 1499, 1124.25, 35, 77, '2016-08-12 01:14:14');
INSERT INTO `product` VALUES (449, 'MeiLing/美菱 BCD-560WUCX对开门电冰箱家用冰箱WIFI智能风冷无霜', '家用冰箱 WIFI智能 风冷无霜', 3399, 3059.1, 54, 76, '2016-08-14 01:19:59');
INSERT INTO `product` VALUES (450, 'FRESTECH/新飞 BCD-286WDKSM阿里云智能wifi风冷无霜智控两门冰箱', '阿里云智能 远程WIFI 智控 风冷无霜', 3599, 2879.2, 68, 76, '2016-08-05 01:20:00');
INSERT INTO `product` VALUES (451, 'Konka/康佳 BCD-558WEGY5SWT对开冰箱家用一级节能风冷无霜电冰箱', '阿里云智能 风冷无霜 大容量 一级能效节能', 3000, 1800, 74, 76, '2016-07-24 01:20:03');
INSERT INTO `product` VALUES (452, '【阿里智能】Galanz/格兰仕 BCD-251WTHG(T) 三门电冰箱251升风冷', '风冷无霜 一级能效 智能控温 菱格面板 立体风', 3299, 2474.25, 63, 76, '2016-07-27 01:20:05');
INSERT INTO `product` VALUES (453, 'Haier/海尔 BCD-618WDVGU1海尔变频对开门风冷智能控温双门电冰箱', '手机智能控制 玫瑰金外观 杀菌净味系统 变频', 6999, 5949.15, 22, 76, '2016-08-11 01:20:07');
INSERT INTO `product` VALUES (509, 'AUX/奥克斯 KFR-26GW/BpTYC19+1大1匹高端智能云变频冷暖挂机空调', '30秒速冷 一级能效 ECO节能 阿里智能 除湿', 3799, 2659.3, 15, 75, '2016-08-01 01:27:18');
INSERT INTO `product` VALUES (510, 'Kelon/科龙 KFR-26GW/EFQRA2(1N20) 大1匹二级变频智能冷暖挂机', '二级变频 阿里智能 高效除甲醛 快速制冷暖', 2599, 1559.4, 78, 75, '2016-08-08 01:27:20');
INSERT INTO `product` VALUES (511, 'TCL KFRd-35GW/EP13 大1.5匹冷暖电辅空调1.5P挂机定频壁挂式包邮', '快速冷暖 四重静音 每日前5名 好礼2选1', 2399, 1679.3, 64, 75, '2016-07-21 01:27:22');
INSERT INTO `product` VALUES (512, 'Panasonic/松下 KFR-36GW/BpSJ1S大1.5匹直流变频冷暖挂式空调', '原装变频压缩 机静音除雾霾 送货入户 0元分期', 3999, 3599.1, 59, 75, '2016-07-16 01:27:25');
INSERT INTO `product` VALUES (513, 'Panasonic/松下 KFR-36GW/SH2-1大1.5匹二级能效静音空调挂机', '原装压缩机 品质保证 二级能效', 3399, 3059.1, 71, 75, '2016-07-12 01:27:27');
INSERT INTO `product` VALUES (565, '正品雷克斯韩版简约时尚潮流真皮石英情侣表女士手表女表皮带防水', '时尚之选 做精致女人 精美包装 支持货到付款', 1280, 896, 82, 74, '2016-08-22 01:34:54');
INSERT INTO `product` VALUES (566, '正港手表女四叶草防水手链表简约潮流学生女表韩版时尚石英表正品', '热销万只 4.9分好评 代写贺卡 质保一年', 143.71, 114.968, 23, 74, '2016-08-25 01:34:57');
INSERT INTO `product` VALUES (567, '罗宾 钢带女表 女士腕表 水钻夜光防水石英表 潮流时尚复古手表女', '正品 水钻刻度 钢带女表 买一送三 赠送运费险', 990, 792, 54, 74, '2016-07-11 01:34:59');
INSERT INTO `product` VALUES (568, '浪铂正品长方形手表女表皮带时尚潮流石英表防水真皮学生休闲腕表', '今日拍下 自动减30 送真皮表带 石榴石手链', 998, 598.8, 81, 74, '2016-07-26 01:35:02');
INSERT INTO `product` VALUES (569, '宾格手表正品女式精钢腕表大表盘全自动机械表防水情侣表女表真皮', '陈小春代言 宾格正品 情侣手表 同款还有男表', 488, 341.6, 16, 74, '2016-07-19 01:35:05');
INSERT INTO `product` VALUES (620, '依伦新款超薄手表 男表真皮带休闲时尚男士腕表潮流防水石英表', '简约两针 深度防水 进口机芯 送真皮表带 运费险', 1280, 1024, 64, 73, '2016-08-11 01:42:48');
INSERT INTO `product` VALUES (621, '【入门】西铁城CITIZEN新品超值体验机械手表男表NH8350-59AB/EB', '全国联保 3期0利息 大气简约 新品', 1700, 1445, 60, 73, '2016-08-13 01:42:51');
INSERT INTO `product` VALUES (622, '正品手表男精钢商务休闲男士手表石英表时尚潮流夜光超薄男表防水', '机构质检 防水夜光 赠送皮表带 特价抢购', 699, 489.3, 34, 73, '2016-08-25 01:42:54');
INSERT INTO `product` VALUES (623, '正品名仕爵手表男机械表夜光精钢防水大表盘 全自动时尚潮流男表', '终身保修 正品 全自动 机械表 镂空机械表', 1900, 1140, 85, 73, '2016-08-25 01:42:57');
INSERT INTO `product` VALUES (624, '飞克手表 男表皮带手表 防水商务休闲男士手表 腕表 石英表手表', '正品进口机芯 蓝宝石镜面 指针星期显示', 1999, 1199.4, 82, 73, '2016-08-05 01:43:00');
INSERT INTO `product` VALUES (673, '劳迪莱斯男士手包休闲手拿包牛皮大容量钱包男包软面小包包手抓包', '牛皮手包 耐磨耐用 多卡位设计', 185, 157.25, 24, 72, '2016-07-21 01:50:46');
INSERT INTO `product` VALUES (674, '英伦邦纹男士手包牛皮大容量真皮手拿包手抓包双拉链商务正品软皮', '意大利牛皮 纹路自然漂亮 更耐用更尊贵 手感棒', 588, 411.6, 42, 72, '2016-08-23 01:50:48');
INSERT INTO `product` VALUES (675, '唯美诺新款男士手包男包真皮大容量小羊皮手拿包信封包软皮夹包潮', '优质羊皮 大容量 品牌做工 超软手感 终身包保修', 498, 448.2, 84, 72, '2016-07-30 01:50:52');
INSERT INTO `product` VALUES (676, '宾度 男士手包真皮大容量手拿包牛皮个性潮男包手抓包软皮信封包', '专注品质领卷 顺丰包邮 头层牛皮 大容量 软皮', 568, 511.2, 79, 72, '2016-08-04 01:50:54');
INSERT INTO `product` VALUES (677, 'MAXFEEL休闲男士手包真皮手拿包大容量信封包手抓包夹包软韩版潮', '无理由退换货 赠退货运费险', 888, 799.2, 98, 72, '2016-07-21 01:50:58');
INSERT INTO `product` VALUES (729, '【新】罗蒙羊毛西服套装男修身商务职业装2016年秋季新款#1S51126', '', 2199, 1759.2, 96, 71, '2016-08-04 01:57:55');
INSERT INTO `product` VALUES (730, '男士西服套装修身英伦竖条纹休闲西装男套装三件套新郎结婚礼服春', '今赠马甲衬衫 精致竖条纹 奢华品质 精细做工', 729, 437.4, 30, 71, '2016-07-20 01:57:57');
INSERT INTO `product` VALUES (731, '西服套装男夏季新郎结婚礼服三件套伴郎服薄款西服大码西装男套装', '亮眼帅气 优雅休闲 格调气质 时尚格子 结婚首选', 1988, 1491, 10, 71, '2016-08-10 01:57:59');
INSERT INTO `product` VALUES (732, '三件套Actionmates新款韩版修身休闲格子西服套装男士小西装礼服', '韩国进口面料 韩版立体裁剪 版型好 送领结领带', 799, 479.4, 56, 71, '2016-07-16 01:58:02');
INSERT INTO `product` VALUES (733, 'Action mates韩版修身男士西服套装发型师休闲小西装结婚礼服潮', '包邮申通 韩版修身 版型好 不容错过', 699, 419.4, 79, 71, '2016-07-07 01:58:04');
INSERT INTO `product` VALUES (784, 'DOGEXI透气真皮男鞋子雕花男士休闲鞋反绒皮英伦低帮板鞋男潮鞋秋', '牛皮鞋面 猪皮内里 标准运动鞋码', 289, 202.3, 21, 69, '2016-08-13 02:06:10');
INSERT INTO `product` VALUES (785, '花花公子男鞋夏季小白鞋男士休闲鞋白鞋板鞋白色平底百搭鞋子男潮', '天猫正品 百搭小白鞋 顺丰包邮', 330, 313.5, 44, 69, '2016-08-20 02:06:14');
INSERT INTO `product` VALUES (786, '花花公子皮鞋男士商务休闲男鞋夏季英伦真皮系带休闲鞋男板鞋子', '高端大气 商务休闲 时尚潮流 全国包邮 赠运费险', 368, 294.4, 23, 69, '2016-08-11 02:06:17');
INSERT INTO `product` VALUES (787, '酷队秋季运动鞋情侣鞋跑步鞋潮男鞋子透气休闲鞋飞织低帮潮鞋系带', '', 328, 229.6, 73, 69, '2016-08-04 02:06:20');
INSERT INTO `product` VALUES (788, '木林森夏季男鞋休闲鞋男英伦真皮男士休闲皮鞋圆头系带青年潮鞋子', '头层牛皮 时尚休闲 韩版潮流 型男必备', 326, 293.4, 96, 69, '2016-08-17 02:06:24');
INSERT INTO `product` VALUES (844, '拉夏贝尔puella普埃拉2016休闲修身五分袖一字领收腰套装20007986', '', 369, 350.55, 71, 68, '2016-08-14 02:13:28');
INSERT INTO `product` VALUES (845, '拉夏贝尔 7m莫丽菲尔2016秋新款条纹五分袖连衣裙套装女70006522', '8月3日 新品', 399, 299.25, 79, 68, '2016-07-10 02:13:30');
INSERT INTO `product` VALUES (846, '女巫2016欧洲站夏季新品欧美时尚绣花衬衣上衣九分裤两件套装高端', '女巫高端定制 欧美时尚 两件套', 928, 835.2, 29, 68, '2016-08-10 02:13:32');
INSERT INTO `product` VALUES (847, '妖精的口袋P360度漂浮秋装欧美半身裙短款外套时尚套装女两件套', '口袋特殊材质 拼接 品质扣子 水洗色 套装', 399, 319.2, 73, 68, '2016-08-18 02:13:35');
INSERT INTO `product` VALUES (848, '妖精的口袋P几枚礼物秋装甜美连帽短外套印花休闲裤时尚套装女', '帽里撞色 植绒抽绳装饰 质感吊钟 图案印花 套装', 339, 322.05, 87, 68, '2016-08-15 02:13:37');
INSERT INTO `product` VALUES (899, '新款男士偏光太阳镜日夜两用墨镜潮运动开车专用驾驶偏光镜夜视镜', '时尚新款 铝镁纤维镜架 科技动感', 580, 551, 91, 64, '2016-08-06 02:21:07');
INSERT INTO `product` VALUES (900, '变色眼镜男女款半框太阳镜大框潮流防辐射防紫外防蓝光近视镜护目', '', 200, 170, 77, 64, '2016-07-27 02:21:10');
INSERT INTO `product` VALUES (901, '帕莎Prsr太阳镜女偏光镜潮范冰冰同款女士眼镜可配近视墨镜T60017', '镜片 防紫外线 超轻材质 记忆材质', 780, 624, 86, 64, '2016-08-16 02:21:13');
INSERT INTO `product` VALUES (902, '陌森太阳眼镜男女2016偏光定制驾驶近视墨镜有带度数的莫森MS8006', '加拍镜片可配 近视： 原装无度数！ 顺丰包邮', 798, 518.7, 45, 64, '2016-08-03 02:21:17');
INSERT INTO `product` VALUES (903, '好先生同款墨镜孙红雷偏光男士太阳镜韩明星女款圆脸方框金属近视', '偏光 圆脸 方框', 150, 97.5, 84, 64, '2016-08-12 02:21:20');
INSERT INTO `product` VALUES (958, '惠尔顿儿童安全座椅isofix硬接口汽车用安全坐椅9个月-12岁酷睿宝', '双接口固定 夏克立推荐 好评如潮', 2848, 1993.6, 52, 60, '2016-07-25 02:29:07');
INSERT INTO `product` VALUES (959, '好孩子汽车儿童安全座椅goodbaby9个月－12岁宝宝座椅cs668侧碰王', '开团3秒半价 475元 提前购买 咨询客服', 1999, 1199.4, 89, 60, '2016-07-17 02:29:10');
INSERT INTO `product` VALUES (960, 'REEBABY儿童安全座椅9个月-12岁宝宝婴儿汽车用坐椅车载 3C认证', '睿睿熊定制款 合金钢骨架 全国包邮', 1280, 1216, 71, 60, '2016-07-26 02:29:13');
INSERT INTO `product` VALUES (961, 'REEBABY汽车儿童安全座椅ISOFIX 0-4-6-12岁婴儿宝宝新生儿可躺', '165度超大 躺角 0-12岁 正反双向 安装', 1680, 1344, 59, 60, '2016-08-21 02:29:16');
INSERT INTO `product` VALUES (962, '新生儿婴儿提篮式安全座椅汽车用车载儿童安全坐椅宝宝摇篮便携式', '法国畅销品牌 ITW卡扣 环保针织面料', 980, 882, 16, 60, '2016-08-09 02:29:19');

-- ----------------------------
-- Table structure for productimage
-- ----------------------------
DROP TABLE IF EXISTS `productimage`;
CREATE TABLE `productimage`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '产品图片id',
  `pid` int(0) NULL DEFAULT NULL COMMENT '产品id',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片类型',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_productimage_product`(`pid`) USING BTREE,
  CONSTRAINT `fk_productimage_product` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10199 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of productimage
-- ----------------------------
INSERT INTO `productimage` VALUES (629, 87, 'type_single');
INSERT INTO `productimage` VALUES (630, 87, 'type_single');
INSERT INTO `productimage` VALUES (631, 87, 'type_single');
INSERT INTO `productimage` VALUES (632, 87, 'type_single');
INSERT INTO `productimage` VALUES (633, 87, 'type_detail');
INSERT INTO `productimage` VALUES (634, 87, 'type_detail');
INSERT INTO `productimage` VALUES (635, 87, 'type_detail');
INSERT INTO `productimage` VALUES (636, 87, 'type_detail');
INSERT INTO `productimage` VALUES (637, 87, 'type_detail');
INSERT INTO `productimage` VALUES (638, 87, 'type_detail');
INSERT INTO `productimage` VALUES (639, 88, 'type_single');
INSERT INTO `productimage` VALUES (640, 88, 'type_single');
INSERT INTO `productimage` VALUES (641, 88, 'type_single');
INSERT INTO `productimage` VALUES (642, 88, 'type_single');
INSERT INTO `productimage` VALUES (643, 88, 'type_single');
INSERT INTO `productimage` VALUES (644, 88, 'type_detail');
INSERT INTO `productimage` VALUES (645, 88, 'type_detail');
INSERT INTO `productimage` VALUES (646, 88, 'type_detail');
INSERT INTO `productimage` VALUES (647, 88, 'type_detail');
INSERT INTO `productimage` VALUES (648, 88, 'type_detail');
INSERT INTO `productimage` VALUES (649, 88, 'type_detail');
INSERT INTO `productimage` VALUES (650, 89, 'type_single');
INSERT INTO `productimage` VALUES (651, 89, 'type_single');
INSERT INTO `productimage` VALUES (652, 89, 'type_single');
INSERT INTO `productimage` VALUES (653, 89, 'type_single');
INSERT INTO `productimage` VALUES (654, 89, 'type_single');
INSERT INTO `productimage` VALUES (655, 89, 'type_detail');
INSERT INTO `productimage` VALUES (656, 89, 'type_detail');
INSERT INTO `productimage` VALUES (657, 89, 'type_detail');
INSERT INTO `productimage` VALUES (658, 89, 'type_detail');
INSERT INTO `productimage` VALUES (659, 89, 'type_detail');
INSERT INTO `productimage` VALUES (660, 89, 'type_detail');
INSERT INTO `productimage` VALUES (661, 90, 'type_single');
INSERT INTO `productimage` VALUES (662, 90, 'type_single');
INSERT INTO `productimage` VALUES (663, 90, 'type_single');
INSERT INTO `productimage` VALUES (664, 90, 'type_single');
INSERT INTO `productimage` VALUES (665, 90, 'type_single');
INSERT INTO `productimage` VALUES (666, 90, 'type_detail');
INSERT INTO `productimage` VALUES (667, 90, 'type_detail');
INSERT INTO `productimage` VALUES (668, 90, 'type_detail');
INSERT INTO `productimage` VALUES (669, 90, 'type_detail');
INSERT INTO `productimage` VALUES (670, 90, 'type_detail');
INSERT INTO `productimage` VALUES (671, 90, 'type_detail');
INSERT INTO `productimage` VALUES (672, 91, 'type_single');
INSERT INTO `productimage` VALUES (673, 91, 'type_single');
INSERT INTO `productimage` VALUES (674, 91, 'type_single');
INSERT INTO `productimage` VALUES (675, 91, 'type_single');
INSERT INTO `productimage` VALUES (676, 91, 'type_single');
INSERT INTO `productimage` VALUES (677, 91, 'type_detail');
INSERT INTO `productimage` VALUES (678, 91, 'type_detail');
INSERT INTO `productimage` VALUES (679, 91, 'type_detail');
INSERT INTO `productimage` VALUES (680, 91, 'type_detail');
INSERT INTO `productimage` VALUES (681, 91, 'type_detail');
INSERT INTO `productimage` VALUES (682, 91, 'type_detail');
INSERT INTO `productimage` VALUES (1276, 147, 'type_single');
INSERT INTO `productimage` VALUES (1277, 147, 'type_single');
INSERT INTO `productimage` VALUES (1278, 147, 'type_single');
INSERT INTO `productimage` VALUES (1279, 147, 'type_single');
INSERT INTO `productimage` VALUES (1280, 147, 'type_single');
INSERT INTO `productimage` VALUES (1281, 147, 'type_detail');
INSERT INTO `productimage` VALUES (1282, 147, 'type_detail');
INSERT INTO `productimage` VALUES (1283, 147, 'type_detail');
INSERT INTO `productimage` VALUES (1284, 147, 'type_detail');
INSERT INTO `productimage` VALUES (1285, 147, 'type_detail');
INSERT INTO `productimage` VALUES (1286, 147, 'type_detail');
INSERT INTO `productimage` VALUES (1287, 148, 'type_single');
INSERT INTO `productimage` VALUES (1288, 148, 'type_single');
INSERT INTO `productimage` VALUES (1289, 148, 'type_single');
INSERT INTO `productimage` VALUES (1290, 148, 'type_single');
INSERT INTO `productimage` VALUES (1291, 148, 'type_single');
INSERT INTO `productimage` VALUES (1292, 148, 'type_detail');
INSERT INTO `productimage` VALUES (1293, 148, 'type_detail');
INSERT INTO `productimage` VALUES (1294, 148, 'type_detail');
INSERT INTO `productimage` VALUES (1295, 148, 'type_detail');
INSERT INTO `productimage` VALUES (1296, 148, 'type_detail');
INSERT INTO `productimage` VALUES (1297, 148, 'type_detail');
INSERT INTO `productimage` VALUES (1298, 149, 'type_single');
INSERT INTO `productimage` VALUES (1299, 149, 'type_single');
INSERT INTO `productimage` VALUES (1300, 149, 'type_single');
INSERT INTO `productimage` VALUES (1301, 149, 'type_single');
INSERT INTO `productimage` VALUES (1302, 149, 'type_single');
INSERT INTO `productimage` VALUES (1303, 149, 'type_detail');
INSERT INTO `productimage` VALUES (1304, 149, 'type_detail');
INSERT INTO `productimage` VALUES (1305, 149, 'type_detail');
INSERT INTO `productimage` VALUES (1306, 149, 'type_detail');
INSERT INTO `productimage` VALUES (1307, 149, 'type_detail');
INSERT INTO `productimage` VALUES (1308, 149, 'type_detail');
INSERT INTO `productimage` VALUES (1309, 150, 'type_single');
INSERT INTO `productimage` VALUES (1310, 150, 'type_single');
INSERT INTO `productimage` VALUES (1311, 150, 'type_single');
INSERT INTO `productimage` VALUES (1312, 150, 'type_single');
INSERT INTO `productimage` VALUES (1313, 150, 'type_single');
INSERT INTO `productimage` VALUES (1314, 150, 'type_detail');
INSERT INTO `productimage` VALUES (1315, 150, 'type_detail');
INSERT INTO `productimage` VALUES (1316, 150, 'type_detail');
INSERT INTO `productimage` VALUES (1317, 150, 'type_detail');
INSERT INTO `productimage` VALUES (1318, 150, 'type_detail');
INSERT INTO `productimage` VALUES (1319, 150, 'type_detail');
INSERT INTO `productimage` VALUES (1320, 151, 'type_single');
INSERT INTO `productimage` VALUES (1321, 151, 'type_single');
INSERT INTO `productimage` VALUES (1322, 151, 'type_single');
INSERT INTO `productimage` VALUES (1323, 151, 'type_single');
INSERT INTO `productimage` VALUES (1324, 151, 'type_single');
INSERT INTO `productimage` VALUES (1325, 151, 'type_detail');
INSERT INTO `productimage` VALUES (1326, 151, 'type_detail');
INSERT INTO `productimage` VALUES (1327, 151, 'type_detail');
INSERT INTO `productimage` VALUES (1328, 151, 'type_detail');
INSERT INTO `productimage` VALUES (1329, 151, 'type_detail');
INSERT INTO `productimage` VALUES (1330, 151, 'type_detail');
INSERT INTO `productimage` VALUES (1880, 202, 'type_single');
INSERT INTO `productimage` VALUES (1881, 202, 'type_single');
INSERT INTO `productimage` VALUES (1882, 202, 'type_single');
INSERT INTO `productimage` VALUES (1883, 202, 'type_single');
INSERT INTO `productimage` VALUES (1884, 202, 'type_single');
INSERT INTO `productimage` VALUES (1885, 202, 'type_detail');
INSERT INTO `productimage` VALUES (1886, 202, 'type_detail');
INSERT INTO `productimage` VALUES (1887, 202, 'type_detail');
INSERT INTO `productimage` VALUES (1888, 202, 'type_detail');
INSERT INTO `productimage` VALUES (1889, 202, 'type_detail');
INSERT INTO `productimage` VALUES (1890, 202, 'type_detail');
INSERT INTO `productimage` VALUES (1891, 203, 'type_single');
INSERT INTO `productimage` VALUES (1892, 203, 'type_single');
INSERT INTO `productimage` VALUES (1893, 203, 'type_single');
INSERT INTO `productimage` VALUES (1894, 203, 'type_single');
INSERT INTO `productimage` VALUES (1895, 203, 'type_single');
INSERT INTO `productimage` VALUES (1896, 203, 'type_detail');
INSERT INTO `productimage` VALUES (1897, 203, 'type_detail');
INSERT INTO `productimage` VALUES (1898, 203, 'type_detail');
INSERT INTO `productimage` VALUES (1899, 203, 'type_detail');
INSERT INTO `productimage` VALUES (1900, 203, 'type_detail');
INSERT INTO `productimage` VALUES (1901, 203, 'type_detail');
INSERT INTO `productimage` VALUES (1902, 204, 'type_single');
INSERT INTO `productimage` VALUES (1903, 204, 'type_single');
INSERT INTO `productimage` VALUES (1904, 204, 'type_single');
INSERT INTO `productimage` VALUES (1905, 204, 'type_single');
INSERT INTO `productimage` VALUES (1906, 204, 'type_single');
INSERT INTO `productimage` VALUES (1907, 204, 'type_detail');
INSERT INTO `productimage` VALUES (1908, 204, 'type_detail');
INSERT INTO `productimage` VALUES (1909, 204, 'type_detail');
INSERT INTO `productimage` VALUES (1910, 204, 'type_detail');
INSERT INTO `productimage` VALUES (1911, 204, 'type_detail');
INSERT INTO `productimage` VALUES (1912, 204, 'type_detail');
INSERT INTO `productimage` VALUES (1913, 205, 'type_single');
INSERT INTO `productimage` VALUES (1914, 205, 'type_single');
INSERT INTO `productimage` VALUES (1915, 205, 'type_single');
INSERT INTO `productimage` VALUES (1916, 205, 'type_single');
INSERT INTO `productimage` VALUES (1917, 205, 'type_single');
INSERT INTO `productimage` VALUES (1918, 205, 'type_detail');
INSERT INTO `productimage` VALUES (1919, 205, 'type_detail');
INSERT INTO `productimage` VALUES (1920, 205, 'type_detail');
INSERT INTO `productimage` VALUES (1921, 205, 'type_detail');
INSERT INTO `productimage` VALUES (1922, 205, 'type_detail');
INSERT INTO `productimage` VALUES (1923, 205, 'type_detail');
INSERT INTO `productimage` VALUES (1924, 206, 'type_single');
INSERT INTO `productimage` VALUES (1925, 206, 'type_single');
INSERT INTO `productimage` VALUES (1926, 206, 'type_single');
INSERT INTO `productimage` VALUES (1927, 206, 'type_single');
INSERT INTO `productimage` VALUES (1928, 206, 'type_single');
INSERT INTO `productimage` VALUES (1929, 206, 'type_detail');
INSERT INTO `productimage` VALUES (1930, 206, 'type_detail');
INSERT INTO `productimage` VALUES (1931, 206, 'type_detail');
INSERT INTO `productimage` VALUES (1932, 206, 'type_detail');
INSERT INTO `productimage` VALUES (1933, 206, 'type_detail');
INSERT INTO `productimage` VALUES (1934, 206, 'type_detail');
INSERT INTO `productimage` VALUES (2533, 262, 'type_single');
INSERT INTO `productimage` VALUES (2534, 262, 'type_single');
INSERT INTO `productimage` VALUES (2535, 262, 'type_single');
INSERT INTO `productimage` VALUES (2536, 262, 'type_single');
INSERT INTO `productimage` VALUES (2537, 262, 'type_single');
INSERT INTO `productimage` VALUES (2538, 262, 'type_detail');
INSERT INTO `productimage` VALUES (2539, 262, 'type_detail');
INSERT INTO `productimage` VALUES (2540, 262, 'type_detail');
INSERT INTO `productimage` VALUES (2541, 262, 'type_detail');
INSERT INTO `productimage` VALUES (2542, 262, 'type_detail');
INSERT INTO `productimage` VALUES (2543, 262, 'type_detail');
INSERT INTO `productimage` VALUES (2544, 263, 'type_single');
INSERT INTO `productimage` VALUES (2545, 263, 'type_single');
INSERT INTO `productimage` VALUES (2546, 263, 'type_single');
INSERT INTO `productimage` VALUES (2547, 263, 'type_single');
INSERT INTO `productimage` VALUES (2548, 263, 'type_single');
INSERT INTO `productimage` VALUES (2549, 263, 'type_detail');
INSERT INTO `productimage` VALUES (2550, 263, 'type_detail');
INSERT INTO `productimage` VALUES (2551, 263, 'type_detail');
INSERT INTO `productimage` VALUES (2552, 263, 'type_detail');
INSERT INTO `productimage` VALUES (2553, 263, 'type_detail');
INSERT INTO `productimage` VALUES (2554, 263, 'type_detail');
INSERT INTO `productimage` VALUES (2555, 264, 'type_single');
INSERT INTO `productimage` VALUES (2556, 264, 'type_single');
INSERT INTO `productimage` VALUES (2557, 264, 'type_single');
INSERT INTO `productimage` VALUES (2558, 264, 'type_single');
INSERT INTO `productimage` VALUES (2559, 264, 'type_single');
INSERT INTO `productimage` VALUES (2560, 264, 'type_detail');
INSERT INTO `productimage` VALUES (2561, 264, 'type_detail');
INSERT INTO `productimage` VALUES (2562, 264, 'type_detail');
INSERT INTO `productimage` VALUES (2563, 264, 'type_detail');
INSERT INTO `productimage` VALUES (2564, 264, 'type_detail');
INSERT INTO `productimage` VALUES (2565, 264, 'type_detail');
INSERT INTO `productimage` VALUES (2566, 265, 'type_single');
INSERT INTO `productimage` VALUES (2567, 265, 'type_single');
INSERT INTO `productimage` VALUES (2568, 265, 'type_single');
INSERT INTO `productimage` VALUES (2569, 265, 'type_single');
INSERT INTO `productimage` VALUES (2570, 265, 'type_single');
INSERT INTO `productimage` VALUES (2571, 265, 'type_detail');
INSERT INTO `productimage` VALUES (2572, 265, 'type_detail');
INSERT INTO `productimage` VALUES (2573, 265, 'type_detail');
INSERT INTO `productimage` VALUES (2574, 265, 'type_detail');
INSERT INTO `productimage` VALUES (2575, 265, 'type_detail');
INSERT INTO `productimage` VALUES (2576, 265, 'type_detail');
INSERT INTO `productimage` VALUES (2577, 266, 'type_single');
INSERT INTO `productimage` VALUES (2578, 266, 'type_single');
INSERT INTO `productimage` VALUES (2579, 266, 'type_single');
INSERT INTO `productimage` VALUES (2580, 266, 'type_single');
INSERT INTO `productimage` VALUES (2581, 266, 'type_single');
INSERT INTO `productimage` VALUES (2582, 266, 'type_detail');
INSERT INTO `productimage` VALUES (2583, 266, 'type_detail');
INSERT INTO `productimage` VALUES (2584, 266, 'type_detail');
INSERT INTO `productimage` VALUES (2585, 266, 'type_detail');
INSERT INTO `productimage` VALUES (2586, 266, 'type_detail');
INSERT INTO `productimage` VALUES (2587, 266, 'type_detail');
INSERT INTO `productimage` VALUES (3134, 317, 'type_single');
INSERT INTO `productimage` VALUES (3135, 317, 'type_single');
INSERT INTO `productimage` VALUES (3136, 317, 'type_single');
INSERT INTO `productimage` VALUES (3137, 317, 'type_single');
INSERT INTO `productimage` VALUES (3138, 317, 'type_single');
INSERT INTO `productimage` VALUES (3139, 317, 'type_detail');
INSERT INTO `productimage` VALUES (3140, 317, 'type_detail');
INSERT INTO `productimage` VALUES (3141, 317, 'type_detail');
INSERT INTO `productimage` VALUES (3142, 317, 'type_detail');
INSERT INTO `productimage` VALUES (3143, 317, 'type_detail');
INSERT INTO `productimage` VALUES (3144, 317, 'type_detail');
INSERT INTO `productimage` VALUES (3145, 318, 'type_single');
INSERT INTO `productimage` VALUES (3146, 318, 'type_single');
INSERT INTO `productimage` VALUES (3147, 318, 'type_single');
INSERT INTO `productimage` VALUES (3148, 318, 'type_single');
INSERT INTO `productimage` VALUES (3149, 318, 'type_single');
INSERT INTO `productimage` VALUES (3150, 318, 'type_detail');
INSERT INTO `productimage` VALUES (3151, 318, 'type_detail');
INSERT INTO `productimage` VALUES (3152, 318, 'type_detail');
INSERT INTO `productimage` VALUES (3153, 318, 'type_detail');
INSERT INTO `productimage` VALUES (3154, 318, 'type_detail');
INSERT INTO `productimage` VALUES (3155, 318, 'type_detail');
INSERT INTO `productimage` VALUES (3156, 319, 'type_single');
INSERT INTO `productimage` VALUES (3157, 319, 'type_single');
INSERT INTO `productimage` VALUES (3158, 319, 'type_single');
INSERT INTO `productimage` VALUES (3159, 319, 'type_single');
INSERT INTO `productimage` VALUES (3160, 319, 'type_single');
INSERT INTO `productimage` VALUES (3161, 319, 'type_detail');
INSERT INTO `productimage` VALUES (3162, 319, 'type_detail');
INSERT INTO `productimage` VALUES (3163, 319, 'type_detail');
INSERT INTO `productimage` VALUES (3164, 319, 'type_detail');
INSERT INTO `productimage` VALUES (3165, 319, 'type_detail');
INSERT INTO `productimage` VALUES (3166, 319, 'type_detail');
INSERT INTO `productimage` VALUES (3167, 320, 'type_single');
INSERT INTO `productimage` VALUES (3168, 320, 'type_single');
INSERT INTO `productimage` VALUES (3169, 320, 'type_single');
INSERT INTO `productimage` VALUES (3170, 320, 'type_single');
INSERT INTO `productimage` VALUES (3171, 320, 'type_single');
INSERT INTO `productimage` VALUES (3172, 320, 'type_detail');
INSERT INTO `productimage` VALUES (3173, 320, 'type_detail');
INSERT INTO `productimage` VALUES (3174, 320, 'type_detail');
INSERT INTO `productimage` VALUES (3175, 320, 'type_detail');
INSERT INTO `productimage` VALUES (3176, 320, 'type_detail');
INSERT INTO `productimage` VALUES (3177, 320, 'type_detail');
INSERT INTO `productimage` VALUES (3178, 321, 'type_single');
INSERT INTO `productimage` VALUES (3179, 321, 'type_single');
INSERT INTO `productimage` VALUES (3180, 321, 'type_single');
INSERT INTO `productimage` VALUES (3181, 321, 'type_single');
INSERT INTO `productimage` VALUES (3182, 321, 'type_single');
INSERT INTO `productimage` VALUES (3183, 321, 'type_detail');
INSERT INTO `productimage` VALUES (3184, 321, 'type_detail');
INSERT INTO `productimage` VALUES (3185, 321, 'type_detail');
INSERT INTO `productimage` VALUES (3186, 321, 'type_detail');
INSERT INTO `productimage` VALUES (3187, 321, 'type_detail');
INSERT INTO `productimage` VALUES (3188, 321, 'type_detail');
INSERT INTO `productimage` VALUES (3748, 373, 'type_single');
INSERT INTO `productimage` VALUES (3749, 373, 'type_single');
INSERT INTO `productimage` VALUES (3750, 373, 'type_single');
INSERT INTO `productimage` VALUES (3751, 373, 'type_single');
INSERT INTO `productimage` VALUES (3752, 373, 'type_single');
INSERT INTO `productimage` VALUES (3753, 373, 'type_detail');
INSERT INTO `productimage` VALUES (3754, 373, 'type_detail');
INSERT INTO `productimage` VALUES (3755, 373, 'type_detail');
INSERT INTO `productimage` VALUES (3756, 373, 'type_detail');
INSERT INTO `productimage` VALUES (3757, 373, 'type_detail');
INSERT INTO `productimage` VALUES (3758, 373, 'type_detail');
INSERT INTO `productimage` VALUES (3759, 374, 'type_single');
INSERT INTO `productimage` VALUES (3760, 374, 'type_single');
INSERT INTO `productimage` VALUES (3761, 374, 'type_single');
INSERT INTO `productimage` VALUES (3762, 374, 'type_single');
INSERT INTO `productimage` VALUES (3763, 374, 'type_single');
INSERT INTO `productimage` VALUES (3764, 374, 'type_detail');
INSERT INTO `productimage` VALUES (3765, 374, 'type_detail');
INSERT INTO `productimage` VALUES (3766, 374, 'type_detail');
INSERT INTO `productimage` VALUES (3767, 374, 'type_detail');
INSERT INTO `productimage` VALUES (3768, 374, 'type_detail');
INSERT INTO `productimage` VALUES (3769, 374, 'type_detail');
INSERT INTO `productimage` VALUES (3770, 375, 'type_single');
INSERT INTO `productimage` VALUES (3771, 375, 'type_single');
INSERT INTO `productimage` VALUES (3772, 375, 'type_single');
INSERT INTO `productimage` VALUES (3773, 375, 'type_single');
INSERT INTO `productimage` VALUES (3774, 375, 'type_single');
INSERT INTO `productimage` VALUES (3775, 375, 'type_detail');
INSERT INTO `productimage` VALUES (3776, 375, 'type_detail');
INSERT INTO `productimage` VALUES (3777, 375, 'type_detail');
INSERT INTO `productimage` VALUES (3778, 375, 'type_detail');
INSERT INTO `productimage` VALUES (3779, 375, 'type_detail');
INSERT INTO `productimage` VALUES (3780, 375, 'type_detail');
INSERT INTO `productimage` VALUES (3781, 376, 'type_single');
INSERT INTO `productimage` VALUES (3782, 376, 'type_single');
INSERT INTO `productimage` VALUES (3783, 376, 'type_single');
INSERT INTO `productimage` VALUES (3784, 376, 'type_single');
INSERT INTO `productimage` VALUES (3785, 376, 'type_single');
INSERT INTO `productimage` VALUES (3786, 376, 'type_detail');
INSERT INTO `productimage` VALUES (3787, 376, 'type_detail');
INSERT INTO `productimage` VALUES (3788, 376, 'type_detail');
INSERT INTO `productimage` VALUES (3789, 376, 'type_detail');
INSERT INTO `productimage` VALUES (3790, 376, 'type_detail');
INSERT INTO `productimage` VALUES (3791, 376, 'type_detail');
INSERT INTO `productimage` VALUES (3792, 377, 'type_single');
INSERT INTO `productimage` VALUES (3793, 377, 'type_single');
INSERT INTO `productimage` VALUES (3794, 377, 'type_single');
INSERT INTO `productimage` VALUES (3795, 377, 'type_single');
INSERT INTO `productimage` VALUES (3796, 377, 'type_single');
INSERT INTO `productimage` VALUES (3797, 377, 'type_detail');
INSERT INTO `productimage` VALUES (3798, 377, 'type_detail');
INSERT INTO `productimage` VALUES (3799, 377, 'type_detail');
INSERT INTO `productimage` VALUES (3800, 377, 'type_detail');
INSERT INTO `productimage` VALUES (3801, 377, 'type_detail');
INSERT INTO `productimage` VALUES (3802, 377, 'type_detail');
INSERT INTO `productimage` VALUES (4354, 429, 'type_single');
INSERT INTO `productimage` VALUES (4355, 429, 'type_single');
INSERT INTO `productimage` VALUES (4356, 429, 'type_single');
INSERT INTO `productimage` VALUES (4357, 429, 'type_single');
INSERT INTO `productimage` VALUES (4358, 429, 'type_single');
INSERT INTO `productimage` VALUES (4359, 429, 'type_detail');
INSERT INTO `productimage` VALUES (4360, 429, 'type_detail');
INSERT INTO `productimage` VALUES (4361, 429, 'type_detail');
INSERT INTO `productimage` VALUES (4362, 429, 'type_detail');
INSERT INTO `productimage` VALUES (4363, 429, 'type_detail');
INSERT INTO `productimage` VALUES (4364, 429, 'type_detail');
INSERT INTO `productimage` VALUES (4365, 430, 'type_single');
INSERT INTO `productimage` VALUES (4366, 430, 'type_single');
INSERT INTO `productimage` VALUES (4367, 430, 'type_single');
INSERT INTO `productimage` VALUES (4368, 430, 'type_single');
INSERT INTO `productimage` VALUES (4369, 430, 'type_single');
INSERT INTO `productimage` VALUES (4370, 430, 'type_detail');
INSERT INTO `productimage` VALUES (4371, 430, 'type_detail');
INSERT INTO `productimage` VALUES (4372, 430, 'type_detail');
INSERT INTO `productimage` VALUES (4373, 430, 'type_detail');
INSERT INTO `productimage` VALUES (4374, 430, 'type_detail');
INSERT INTO `productimage` VALUES (4375, 430, 'type_detail');
INSERT INTO `productimage` VALUES (4376, 431, 'type_single');
INSERT INTO `productimage` VALUES (4377, 431, 'type_single');
INSERT INTO `productimage` VALUES (4378, 431, 'type_single');
INSERT INTO `productimage` VALUES (4379, 431, 'type_single');
INSERT INTO `productimage` VALUES (4380, 431, 'type_single');
INSERT INTO `productimage` VALUES (4381, 431, 'type_detail');
INSERT INTO `productimage` VALUES (4382, 431, 'type_detail');
INSERT INTO `productimage` VALUES (4383, 431, 'type_detail');
INSERT INTO `productimage` VALUES (4384, 431, 'type_detail');
INSERT INTO `productimage` VALUES (4385, 431, 'type_detail');
INSERT INTO `productimage` VALUES (4386, 431, 'type_detail');
INSERT INTO `productimage` VALUES (4387, 432, 'type_single');
INSERT INTO `productimage` VALUES (4388, 432, 'type_single');
INSERT INTO `productimage` VALUES (4389, 432, 'type_single');
INSERT INTO `productimage` VALUES (4390, 432, 'type_single');
INSERT INTO `productimage` VALUES (4391, 432, 'type_detail');
INSERT INTO `productimage` VALUES (4392, 432, 'type_detail');
INSERT INTO `productimage` VALUES (4393, 432, 'type_detail');
INSERT INTO `productimage` VALUES (4394, 432, 'type_detail');
INSERT INTO `productimage` VALUES (4395, 432, 'type_detail');
INSERT INTO `productimage` VALUES (4396, 432, 'type_detail');
INSERT INTO `productimage` VALUES (4397, 433, 'type_single');
INSERT INTO `productimage` VALUES (4398, 433, 'type_single');
INSERT INTO `productimage` VALUES (4399, 433, 'type_single');
INSERT INTO `productimage` VALUES (4400, 433, 'type_single');
INSERT INTO `productimage` VALUES (4401, 433, 'type_single');
INSERT INTO `productimage` VALUES (4402, 433, 'type_detail');
INSERT INTO `productimage` VALUES (4403, 433, 'type_detail');
INSERT INTO `productimage` VALUES (4404, 433, 'type_detail');
INSERT INTO `productimage` VALUES (4405, 433, 'type_detail');
INSERT INTO `productimage` VALUES (4406, 433, 'type_detail');
INSERT INTO `productimage` VALUES (4407, 433, 'type_detail');
INSERT INTO `productimage` VALUES (4573, 449, 'type_single');
INSERT INTO `productimage` VALUES (4574, 449, 'type_single');
INSERT INTO `productimage` VALUES (4575, 449, 'type_single');
INSERT INTO `productimage` VALUES (4576, 449, 'type_single');
INSERT INTO `productimage` VALUES (4577, 449, 'type_detail');
INSERT INTO `productimage` VALUES (4578, 449, 'type_detail');
INSERT INTO `productimage` VALUES (4579, 449, 'type_detail');
INSERT INTO `productimage` VALUES (4580, 449, 'type_detail');
INSERT INTO `productimage` VALUES (4581, 449, 'type_detail');
INSERT INTO `productimage` VALUES (4582, 449, 'type_detail');
INSERT INTO `productimage` VALUES (4583, 450, 'type_single');
INSERT INTO `productimage` VALUES (4584, 450, 'type_single');
INSERT INTO `productimage` VALUES (4585, 450, 'type_single');
INSERT INTO `productimage` VALUES (4586, 450, 'type_single');
INSERT INTO `productimage` VALUES (4587, 450, 'type_single');
INSERT INTO `productimage` VALUES (4588, 450, 'type_detail');
INSERT INTO `productimage` VALUES (4589, 450, 'type_detail');
INSERT INTO `productimage` VALUES (4590, 450, 'type_detail');
INSERT INTO `productimage` VALUES (4591, 450, 'type_detail');
INSERT INTO `productimage` VALUES (4592, 450, 'type_detail');
INSERT INTO `productimage` VALUES (4593, 450, 'type_detail');
INSERT INTO `productimage` VALUES (4594, 451, 'type_single');
INSERT INTO `productimage` VALUES (4595, 451, 'type_single');
INSERT INTO `productimage` VALUES (4596, 451, 'type_single');
INSERT INTO `productimage` VALUES (4597, 451, 'type_single');
INSERT INTO `productimage` VALUES (4598, 451, 'type_single');
INSERT INTO `productimage` VALUES (4599, 451, 'type_detail');
INSERT INTO `productimage` VALUES (4600, 451, 'type_detail');
INSERT INTO `productimage` VALUES (4601, 451, 'type_detail');
INSERT INTO `productimage` VALUES (4602, 451, 'type_detail');
INSERT INTO `productimage` VALUES (4603, 451, 'type_detail');
INSERT INTO `productimage` VALUES (4604, 451, 'type_detail');
INSERT INTO `productimage` VALUES (4605, 452, 'type_single');
INSERT INTO `productimage` VALUES (4606, 452, 'type_single');
INSERT INTO `productimage` VALUES (4607, 452, 'type_single');
INSERT INTO `productimage` VALUES (4608, 452, 'type_single');
INSERT INTO `productimage` VALUES (4609, 452, 'type_detail');
INSERT INTO `productimage` VALUES (4610, 452, 'type_detail');
INSERT INTO `productimage` VALUES (4611, 452, 'type_detail');
INSERT INTO `productimage` VALUES (4612, 452, 'type_detail');
INSERT INTO `productimage` VALUES (4613, 452, 'type_detail');
INSERT INTO `productimage` VALUES (4614, 452, 'type_detail');
INSERT INTO `productimage` VALUES (4615, 453, 'type_single');
INSERT INTO `productimage` VALUES (4616, 453, 'type_single');
INSERT INTO `productimage` VALUES (4617, 453, 'type_single');
INSERT INTO `productimage` VALUES (4618, 453, 'type_single');
INSERT INTO `productimage` VALUES (4619, 453, 'type_single');
INSERT INTO `productimage` VALUES (4620, 453, 'type_detail');
INSERT INTO `productimage` VALUES (4621, 453, 'type_detail');
INSERT INTO `productimage` VALUES (4622, 453, 'type_detail');
INSERT INTO `productimage` VALUES (4623, 453, 'type_detail');
INSERT INTO `productimage` VALUES (4624, 453, 'type_detail');
INSERT INTO `productimage` VALUES (4625, 453, 'type_detail');
INSERT INTO `productimage` VALUES (5208, 509, 'type_single');
INSERT INTO `productimage` VALUES (5209, 509, 'type_single');
INSERT INTO `productimage` VALUES (5210, 509, 'type_single');
INSERT INTO `productimage` VALUES (5211, 509, 'type_single');
INSERT INTO `productimage` VALUES (5212, 509, 'type_detail');
INSERT INTO `productimage` VALUES (5213, 509, 'type_detail');
INSERT INTO `productimage` VALUES (5214, 509, 'type_detail');
INSERT INTO `productimage` VALUES (5215, 509, 'type_detail');
INSERT INTO `productimage` VALUES (5216, 509, 'type_detail');
INSERT INTO `productimage` VALUES (5217, 509, 'type_detail');
INSERT INTO `productimage` VALUES (5218, 510, 'type_single');
INSERT INTO `productimage` VALUES (5219, 510, 'type_single');
INSERT INTO `productimage` VALUES (5220, 510, 'type_single');
INSERT INTO `productimage` VALUES (5221, 510, 'type_single');
INSERT INTO `productimage` VALUES (5222, 510, 'type_single');
INSERT INTO `productimage` VALUES (5223, 510, 'type_detail');
INSERT INTO `productimage` VALUES (5224, 510, 'type_detail');
INSERT INTO `productimage` VALUES (5225, 510, 'type_detail');
INSERT INTO `productimage` VALUES (5226, 510, 'type_detail');
INSERT INTO `productimage` VALUES (5227, 510, 'type_detail');
INSERT INTO `productimage` VALUES (5228, 510, 'type_detail');
INSERT INTO `productimage` VALUES (5229, 511, 'type_single');
INSERT INTO `productimage` VALUES (5230, 511, 'type_single');
INSERT INTO `productimage` VALUES (5231, 511, 'type_single');
INSERT INTO `productimage` VALUES (5232, 511, 'type_single');
INSERT INTO `productimage` VALUES (5233, 511, 'type_single');
INSERT INTO `productimage` VALUES (5234, 511, 'type_detail');
INSERT INTO `productimage` VALUES (5235, 511, 'type_detail');
INSERT INTO `productimage` VALUES (5236, 511, 'type_detail');
INSERT INTO `productimage` VALUES (5237, 511, 'type_detail');
INSERT INTO `productimage` VALUES (5238, 511, 'type_detail');
INSERT INTO `productimage` VALUES (5239, 511, 'type_detail');
INSERT INTO `productimage` VALUES (5240, 512, 'type_single');
INSERT INTO `productimage` VALUES (5241, 512, 'type_single');
INSERT INTO `productimage` VALUES (5242, 512, 'type_single');
INSERT INTO `productimage` VALUES (5243, 512, 'type_single');
INSERT INTO `productimage` VALUES (5244, 512, 'type_single');
INSERT INTO `productimage` VALUES (5245, 512, 'type_detail');
INSERT INTO `productimage` VALUES (5246, 512, 'type_detail');
INSERT INTO `productimage` VALUES (5247, 512, 'type_detail');
INSERT INTO `productimage` VALUES (5248, 512, 'type_detail');
INSERT INTO `productimage` VALUES (5249, 512, 'type_detail');
INSERT INTO `productimage` VALUES (5250, 512, 'type_detail');
INSERT INTO `productimage` VALUES (5251, 513, 'type_single');
INSERT INTO `productimage` VALUES (5252, 513, 'type_single');
INSERT INTO `productimage` VALUES (5253, 513, 'type_single');
INSERT INTO `productimage` VALUES (5254, 513, 'type_single');
INSERT INTO `productimage` VALUES (5255, 513, 'type_single');
INSERT INTO `productimage` VALUES (5256, 513, 'type_detail');
INSERT INTO `productimage` VALUES (5257, 513, 'type_detail');
INSERT INTO `productimage` VALUES (5258, 513, 'type_detail');
INSERT INTO `productimage` VALUES (5259, 513, 'type_detail');
INSERT INTO `productimage` VALUES (5260, 513, 'type_detail');
INSERT INTO `productimage` VALUES (5261, 513, 'type_detail');
INSERT INTO `productimage` VALUES (5823, 565, 'type_single');
INSERT INTO `productimage` VALUES (5824, 565, 'type_single');
INSERT INTO `productimage` VALUES (5825, 565, 'type_single');
INSERT INTO `productimage` VALUES (5826, 565, 'type_single');
INSERT INTO `productimage` VALUES (5827, 565, 'type_single');
INSERT INTO `productimage` VALUES (5828, 565, 'type_detail');
INSERT INTO `productimage` VALUES (5829, 565, 'type_detail');
INSERT INTO `productimage` VALUES (5830, 565, 'type_detail');
INSERT INTO `productimage` VALUES (5831, 565, 'type_detail');
INSERT INTO `productimage` VALUES (5832, 565, 'type_detail');
INSERT INTO `productimage` VALUES (5833, 565, 'type_detail');
INSERT INTO `productimage` VALUES (5834, 566, 'type_single');
INSERT INTO `productimage` VALUES (5835, 566, 'type_single');
INSERT INTO `productimage` VALUES (5836, 566, 'type_single');
INSERT INTO `productimage` VALUES (5837, 566, 'type_single');
INSERT INTO `productimage` VALUES (5838, 566, 'type_single');
INSERT INTO `productimage` VALUES (5839, 566, 'type_detail');
INSERT INTO `productimage` VALUES (5840, 566, 'type_detail');
INSERT INTO `productimage` VALUES (5841, 566, 'type_detail');
INSERT INTO `productimage` VALUES (5842, 566, 'type_detail');
INSERT INTO `productimage` VALUES (5843, 566, 'type_detail');
INSERT INTO `productimage` VALUES (5844, 566, 'type_detail');
INSERT INTO `productimage` VALUES (5845, 567, 'type_single');
INSERT INTO `productimage` VALUES (5846, 567, 'type_single');
INSERT INTO `productimage` VALUES (5847, 567, 'type_single');
INSERT INTO `productimage` VALUES (5848, 567, 'type_single');
INSERT INTO `productimage` VALUES (5849, 567, 'type_detail');
INSERT INTO `productimage` VALUES (5850, 567, 'type_detail');
INSERT INTO `productimage` VALUES (5851, 567, 'type_detail');
INSERT INTO `productimage` VALUES (5852, 567, 'type_detail');
INSERT INTO `productimage` VALUES (5853, 567, 'type_detail');
INSERT INTO `productimage` VALUES (5854, 567, 'type_detail');
INSERT INTO `productimage` VALUES (5855, 568, 'type_single');
INSERT INTO `productimage` VALUES (5856, 568, 'type_single');
INSERT INTO `productimage` VALUES (5857, 568, 'type_single');
INSERT INTO `productimage` VALUES (5858, 568, 'type_single');
INSERT INTO `productimage` VALUES (5859, 568, 'type_single');
INSERT INTO `productimage` VALUES (5860, 568, 'type_detail');
INSERT INTO `productimage` VALUES (5861, 568, 'type_detail');
INSERT INTO `productimage` VALUES (5862, 568, 'type_detail');
INSERT INTO `productimage` VALUES (5863, 568, 'type_detail');
INSERT INTO `productimage` VALUES (5864, 568, 'type_detail');
INSERT INTO `productimage` VALUES (5865, 568, 'type_detail');
INSERT INTO `productimage` VALUES (5866, 569, 'type_single');
INSERT INTO `productimage` VALUES (5867, 569, 'type_single');
INSERT INTO `productimage` VALUES (5868, 569, 'type_single');
INSERT INTO `productimage` VALUES (5869, 569, 'type_single');
INSERT INTO `productimage` VALUES (5870, 569, 'type_single');
INSERT INTO `productimage` VALUES (5871, 569, 'type_detail');
INSERT INTO `productimage` VALUES (5872, 569, 'type_detail');
INSERT INTO `productimage` VALUES (5873, 569, 'type_detail');
INSERT INTO `productimage` VALUES (5874, 569, 'type_detail');
INSERT INTO `productimage` VALUES (5875, 569, 'type_detail');
INSERT INTO `productimage` VALUES (5876, 569, 'type_detail');
INSERT INTO `productimage` VALUES (6427, 620, 'type_single');
INSERT INTO `productimage` VALUES (6428, 620, 'type_single');
INSERT INTO `productimage` VALUES (6429, 620, 'type_single');
INSERT INTO `productimage` VALUES (6430, 620, 'type_single');
INSERT INTO `productimage` VALUES (6431, 620, 'type_single');
INSERT INTO `productimage` VALUES (6432, 620, 'type_detail');
INSERT INTO `productimage` VALUES (6433, 620, 'type_detail');
INSERT INTO `productimage` VALUES (6434, 620, 'type_detail');
INSERT INTO `productimage` VALUES (6435, 620, 'type_detail');
INSERT INTO `productimage` VALUES (6436, 620, 'type_detail');
INSERT INTO `productimage` VALUES (6437, 620, 'type_detail');
INSERT INTO `productimage` VALUES (6438, 621, 'type_single');
INSERT INTO `productimage` VALUES (6439, 621, 'type_single');
INSERT INTO `productimage` VALUES (6440, 621, 'type_single');
INSERT INTO `productimage` VALUES (6441, 621, 'type_single');
INSERT INTO `productimage` VALUES (6442, 621, 'type_single');
INSERT INTO `productimage` VALUES (6443, 621, 'type_detail');
INSERT INTO `productimage` VALUES (6444, 621, 'type_detail');
INSERT INTO `productimage` VALUES (6445, 621, 'type_detail');
INSERT INTO `productimage` VALUES (6446, 621, 'type_detail');
INSERT INTO `productimage` VALUES (6447, 621, 'type_detail');
INSERT INTO `productimage` VALUES (6448, 621, 'type_detail');
INSERT INTO `productimage` VALUES (6449, 622, 'type_single');
INSERT INTO `productimage` VALUES (6450, 622, 'type_single');
INSERT INTO `productimage` VALUES (6451, 622, 'type_single');
INSERT INTO `productimage` VALUES (6452, 622, 'type_single');
INSERT INTO `productimage` VALUES (6453, 622, 'type_single');
INSERT INTO `productimage` VALUES (6454, 622, 'type_detail');
INSERT INTO `productimage` VALUES (6455, 622, 'type_detail');
INSERT INTO `productimage` VALUES (6456, 622, 'type_detail');
INSERT INTO `productimage` VALUES (6457, 622, 'type_detail');
INSERT INTO `productimage` VALUES (6458, 622, 'type_detail');
INSERT INTO `productimage` VALUES (6459, 622, 'type_detail');
INSERT INTO `productimage` VALUES (6460, 623, 'type_single');
INSERT INTO `productimage` VALUES (6461, 623, 'type_single');
INSERT INTO `productimage` VALUES (6462, 623, 'type_single');
INSERT INTO `productimage` VALUES (6463, 623, 'type_single');
INSERT INTO `productimage` VALUES (6464, 623, 'type_single');
INSERT INTO `productimage` VALUES (6465, 623, 'type_detail');
INSERT INTO `productimage` VALUES (6466, 623, 'type_detail');
INSERT INTO `productimage` VALUES (6467, 623, 'type_detail');
INSERT INTO `productimage` VALUES (6468, 623, 'type_detail');
INSERT INTO `productimage` VALUES (6469, 623, 'type_detail');
INSERT INTO `productimage` VALUES (6470, 623, 'type_detail');
INSERT INTO `productimage` VALUES (6471, 624, 'type_single');
INSERT INTO `productimage` VALUES (6472, 624, 'type_single');
INSERT INTO `productimage` VALUES (6473, 624, 'type_single');
INSERT INTO `productimage` VALUES (6474, 624, 'type_single');
INSERT INTO `productimage` VALUES (6475, 624, 'type_single');
INSERT INTO `productimage` VALUES (6476, 624, 'type_detail');
INSERT INTO `productimage` VALUES (6477, 624, 'type_detail');
INSERT INTO `productimage` VALUES (6478, 624, 'type_detail');
INSERT INTO `productimage` VALUES (6479, 624, 'type_detail');
INSERT INTO `productimage` VALUES (6480, 624, 'type_detail');
INSERT INTO `productimage` VALUES (6481, 624, 'type_detail');
INSERT INTO `productimage` VALUES (7010, 673, 'type_single');
INSERT INTO `productimage` VALUES (7011, 673, 'type_single');
INSERT INTO `productimage` VALUES (7012, 673, 'type_single');
INSERT INTO `productimage` VALUES (7013, 673, 'type_single');
INSERT INTO `productimage` VALUES (7014, 673, 'type_single');
INSERT INTO `productimage` VALUES (7015, 673, 'type_detail');
INSERT INTO `productimage` VALUES (7016, 673, 'type_detail');
INSERT INTO `productimage` VALUES (7017, 673, 'type_detail');
INSERT INTO `productimage` VALUES (7018, 673, 'type_detail');
INSERT INTO `productimage` VALUES (7019, 673, 'type_detail');
INSERT INTO `productimage` VALUES (7020, 673, 'type_detail');
INSERT INTO `productimage` VALUES (7021, 674, 'type_single');
INSERT INTO `productimage` VALUES (7022, 674, 'type_single');
INSERT INTO `productimage` VALUES (7023, 674, 'type_single');
INSERT INTO `productimage` VALUES (7024, 674, 'type_single');
INSERT INTO `productimage` VALUES (7025, 674, 'type_single');
INSERT INTO `productimage` VALUES (7026, 674, 'type_detail');
INSERT INTO `productimage` VALUES (7027, 674, 'type_detail');
INSERT INTO `productimage` VALUES (7028, 674, 'type_detail');
INSERT INTO `productimage` VALUES (7029, 674, 'type_detail');
INSERT INTO `productimage` VALUES (7030, 674, 'type_detail');
INSERT INTO `productimage` VALUES (7031, 674, 'type_detail');
INSERT INTO `productimage` VALUES (7032, 675, 'type_single');
INSERT INTO `productimage` VALUES (7033, 675, 'type_single');
INSERT INTO `productimage` VALUES (7034, 675, 'type_single');
INSERT INTO `productimage` VALUES (7035, 675, 'type_single');
INSERT INTO `productimage` VALUES (7036, 675, 'type_single');
INSERT INTO `productimage` VALUES (7037, 675, 'type_detail');
INSERT INTO `productimage` VALUES (7038, 675, 'type_detail');
INSERT INTO `productimage` VALUES (7039, 675, 'type_detail');
INSERT INTO `productimage` VALUES (7040, 675, 'type_detail');
INSERT INTO `productimage` VALUES (7041, 675, 'type_detail');
INSERT INTO `productimage` VALUES (7042, 675, 'type_detail');
INSERT INTO `productimage` VALUES (7043, 676, 'type_single');
INSERT INTO `productimage` VALUES (7044, 676, 'type_single');
INSERT INTO `productimage` VALUES (7045, 676, 'type_single');
INSERT INTO `productimage` VALUES (7046, 676, 'type_single');
INSERT INTO `productimage` VALUES (7047, 676, 'type_single');
INSERT INTO `productimage` VALUES (7048, 676, 'type_detail');
INSERT INTO `productimage` VALUES (7049, 676, 'type_detail');
INSERT INTO `productimage` VALUES (7050, 676, 'type_detail');
INSERT INTO `productimage` VALUES (7051, 676, 'type_detail');
INSERT INTO `productimage` VALUES (7052, 676, 'type_detail');
INSERT INTO `productimage` VALUES (7053, 676, 'type_detail');
INSERT INTO `productimage` VALUES (7054, 677, 'type_single');
INSERT INTO `productimage` VALUES (7055, 677, 'type_single');
INSERT INTO `productimage` VALUES (7056, 677, 'type_single');
INSERT INTO `productimage` VALUES (7057, 677, 'type_single');
INSERT INTO `productimage` VALUES (7058, 677, 'type_single');
INSERT INTO `productimage` VALUES (7059, 677, 'type_detail');
INSERT INTO `productimage` VALUES (7060, 677, 'type_detail');
INSERT INTO `productimage` VALUES (7061, 677, 'type_detail');
INSERT INTO `productimage` VALUES (7062, 677, 'type_detail');
INSERT INTO `productimage` VALUES (7063, 677, 'type_detail');
INSERT INTO `productimage` VALUES (7064, 677, 'type_detail');
INSERT INTO `productimage` VALUES (7626, 729, 'type_single');
INSERT INTO `productimage` VALUES (7627, 729, 'type_single');
INSERT INTO `productimage` VALUES (7628, 729, 'type_single');
INSERT INTO `productimage` VALUES (7629, 729, 'type_single');
INSERT INTO `productimage` VALUES (7630, 729, 'type_single');
INSERT INTO `productimage` VALUES (7631, 729, 'type_detail');
INSERT INTO `productimage` VALUES (7632, 729, 'type_detail');
INSERT INTO `productimage` VALUES (7633, 729, 'type_detail');
INSERT INTO `productimage` VALUES (7634, 729, 'type_detail');
INSERT INTO `productimage` VALUES (7635, 729, 'type_detail');
INSERT INTO `productimage` VALUES (7636, 729, 'type_detail');
INSERT INTO `productimage` VALUES (7637, 730, 'type_single');
INSERT INTO `productimage` VALUES (7638, 730, 'type_single');
INSERT INTO `productimage` VALUES (7639, 730, 'type_single');
INSERT INTO `productimage` VALUES (7640, 730, 'type_single');
INSERT INTO `productimage` VALUES (7641, 730, 'type_single');
INSERT INTO `productimage` VALUES (7642, 730, 'type_detail');
INSERT INTO `productimage` VALUES (7643, 730, 'type_detail');
INSERT INTO `productimage` VALUES (7644, 730, 'type_detail');
INSERT INTO `productimage` VALUES (7645, 730, 'type_detail');
INSERT INTO `productimage` VALUES (7646, 730, 'type_detail');
INSERT INTO `productimage` VALUES (7647, 730, 'type_detail');
INSERT INTO `productimage` VALUES (7648, 731, 'type_single');
INSERT INTO `productimage` VALUES (7649, 731, 'type_single');
INSERT INTO `productimage` VALUES (7650, 731, 'type_single');
INSERT INTO `productimage` VALUES (7651, 731, 'type_single');
INSERT INTO `productimage` VALUES (7652, 731, 'type_single');
INSERT INTO `productimage` VALUES (7653, 731, 'type_detail');
INSERT INTO `productimage` VALUES (7654, 731, 'type_detail');
INSERT INTO `productimage` VALUES (7655, 731, 'type_detail');
INSERT INTO `productimage` VALUES (7656, 731, 'type_detail');
INSERT INTO `productimage` VALUES (7657, 731, 'type_detail');
INSERT INTO `productimage` VALUES (7658, 731, 'type_detail');
INSERT INTO `productimage` VALUES (7659, 732, 'type_single');
INSERT INTO `productimage` VALUES (7660, 732, 'type_single');
INSERT INTO `productimage` VALUES (7661, 732, 'type_single');
INSERT INTO `productimage` VALUES (7662, 732, 'type_single');
INSERT INTO `productimage` VALUES (7663, 732, 'type_single');
INSERT INTO `productimage` VALUES (7664, 732, 'type_detail');
INSERT INTO `productimage` VALUES (7665, 732, 'type_detail');
INSERT INTO `productimage` VALUES (7666, 732, 'type_detail');
INSERT INTO `productimage` VALUES (7667, 732, 'type_detail');
INSERT INTO `productimage` VALUES (7668, 732, 'type_detail');
INSERT INTO `productimage` VALUES (7669, 732, 'type_detail');
INSERT INTO `productimage` VALUES (7670, 733, 'type_single');
INSERT INTO `productimage` VALUES (7671, 733, 'type_single');
INSERT INTO `productimage` VALUES (7672, 733, 'type_single');
INSERT INTO `productimage` VALUES (7673, 733, 'type_single');
INSERT INTO `productimage` VALUES (7674, 733, 'type_single');
INSERT INTO `productimage` VALUES (7675, 733, 'type_detail');
INSERT INTO `productimage` VALUES (7676, 733, 'type_detail');
INSERT INTO `productimage` VALUES (7677, 733, 'type_detail');
INSERT INTO `productimage` VALUES (7678, 733, 'type_detail');
INSERT INTO `productimage` VALUES (7679, 733, 'type_detail');
INSERT INTO `productimage` VALUES (7680, 733, 'type_detail');
INSERT INTO `productimage` VALUES (8231, 784, 'type_single');
INSERT INTO `productimage` VALUES (8232, 784, 'type_single');
INSERT INTO `productimage` VALUES (8233, 784, 'type_single');
INSERT INTO `productimage` VALUES (8234, 784, 'type_single');
INSERT INTO `productimage` VALUES (8235, 784, 'type_single');
INSERT INTO `productimage` VALUES (8236, 784, 'type_detail');
INSERT INTO `productimage` VALUES (8237, 784, 'type_detail');
INSERT INTO `productimage` VALUES (8238, 784, 'type_detail');
INSERT INTO `productimage` VALUES (8239, 784, 'type_detail');
INSERT INTO `productimage` VALUES (8240, 784, 'type_detail');
INSERT INTO `productimage` VALUES (8241, 784, 'type_detail');
INSERT INTO `productimage` VALUES (8242, 785, 'type_single');
INSERT INTO `productimage` VALUES (8243, 785, 'type_single');
INSERT INTO `productimage` VALUES (8244, 785, 'type_single');
INSERT INTO `productimage` VALUES (8245, 785, 'type_single');
INSERT INTO `productimage` VALUES (8246, 785, 'type_single');
INSERT INTO `productimage` VALUES (8247, 785, 'type_detail');
INSERT INTO `productimage` VALUES (8248, 785, 'type_detail');
INSERT INTO `productimage` VALUES (8249, 785, 'type_detail');
INSERT INTO `productimage` VALUES (8250, 785, 'type_detail');
INSERT INTO `productimage` VALUES (8251, 785, 'type_detail');
INSERT INTO `productimage` VALUES (8252, 785, 'type_detail');
INSERT INTO `productimage` VALUES (8253, 786, 'type_single');
INSERT INTO `productimage` VALUES (8254, 786, 'type_single');
INSERT INTO `productimage` VALUES (8255, 786, 'type_single');
INSERT INTO `productimage` VALUES (8256, 786, 'type_single');
INSERT INTO `productimage` VALUES (8257, 786, 'type_single');
INSERT INTO `productimage` VALUES (8258, 786, 'type_detail');
INSERT INTO `productimage` VALUES (8259, 786, 'type_detail');
INSERT INTO `productimage` VALUES (8260, 786, 'type_detail');
INSERT INTO `productimage` VALUES (8261, 786, 'type_detail');
INSERT INTO `productimage` VALUES (8262, 786, 'type_detail');
INSERT INTO `productimage` VALUES (8263, 786, 'type_detail');
INSERT INTO `productimage` VALUES (8264, 787, 'type_single');
INSERT INTO `productimage` VALUES (8265, 787, 'type_single');
INSERT INTO `productimage` VALUES (8266, 787, 'type_single');
INSERT INTO `productimage` VALUES (8267, 787, 'type_single');
INSERT INTO `productimage` VALUES (8268, 787, 'type_single');
INSERT INTO `productimage` VALUES (8269, 787, 'type_detail');
INSERT INTO `productimage` VALUES (8270, 787, 'type_detail');
INSERT INTO `productimage` VALUES (8271, 787, 'type_detail');
INSERT INTO `productimage` VALUES (8272, 787, 'type_detail');
INSERT INTO `productimage` VALUES (8273, 787, 'type_detail');
INSERT INTO `productimage` VALUES (8274, 787, 'type_detail');
INSERT INTO `productimage` VALUES (8275, 788, 'type_single');
INSERT INTO `productimage` VALUES (8276, 788, 'type_single');
INSERT INTO `productimage` VALUES (8277, 788, 'type_single');
INSERT INTO `productimage` VALUES (8278, 788, 'type_single');
INSERT INTO `productimage` VALUES (8279, 788, 'type_single');
INSERT INTO `productimage` VALUES (8280, 788, 'type_detail');
INSERT INTO `productimage` VALUES (8281, 788, 'type_detail');
INSERT INTO `productimage` VALUES (8282, 788, 'type_detail');
INSERT INTO `productimage` VALUES (8283, 788, 'type_detail');
INSERT INTO `productimage` VALUES (8284, 788, 'type_detail');
INSERT INTO `productimage` VALUES (8285, 788, 'type_detail');
INSERT INTO `productimage` VALUES (8891, 844, 'type_single');
INSERT INTO `productimage` VALUES (8892, 844, 'type_single');
INSERT INTO `productimage` VALUES (8893, 844, 'type_single');
INSERT INTO `productimage` VALUES (8894, 844, 'type_single');
INSERT INTO `productimage` VALUES (8895, 844, 'type_single');
INSERT INTO `productimage` VALUES (8896, 844, 'type_detail');
INSERT INTO `productimage` VALUES (8897, 844, 'type_detail');
INSERT INTO `productimage` VALUES (8898, 844, 'type_detail');
INSERT INTO `productimage` VALUES (8899, 844, 'type_detail');
INSERT INTO `productimage` VALUES (8900, 844, 'type_detail');
INSERT INTO `productimage` VALUES (8901, 844, 'type_detail');
INSERT INTO `productimage` VALUES (8902, 845, 'type_single');
INSERT INTO `productimage` VALUES (8903, 845, 'type_single');
INSERT INTO `productimage` VALUES (8904, 845, 'type_single');
INSERT INTO `productimage` VALUES (8905, 845, 'type_single');
INSERT INTO `productimage` VALUES (8906, 845, 'type_single');
INSERT INTO `productimage` VALUES (8907, 845, 'type_detail');
INSERT INTO `productimage` VALUES (8908, 845, 'type_detail');
INSERT INTO `productimage` VALUES (8909, 845, 'type_detail');
INSERT INTO `productimage` VALUES (8910, 845, 'type_detail');
INSERT INTO `productimage` VALUES (8911, 845, 'type_detail');
INSERT INTO `productimage` VALUES (8912, 845, 'type_detail');
INSERT INTO `productimage` VALUES (8913, 846, 'type_single');
INSERT INTO `productimage` VALUES (8914, 846, 'type_single');
INSERT INTO `productimage` VALUES (8915, 846, 'type_single');
INSERT INTO `productimage` VALUES (8916, 846, 'type_single');
INSERT INTO `productimage` VALUES (8917, 846, 'type_single');
INSERT INTO `productimage` VALUES (8918, 846, 'type_detail');
INSERT INTO `productimage` VALUES (8919, 846, 'type_detail');
INSERT INTO `productimage` VALUES (8920, 846, 'type_detail');
INSERT INTO `productimage` VALUES (8921, 846, 'type_detail');
INSERT INTO `productimage` VALUES (8922, 846, 'type_detail');
INSERT INTO `productimage` VALUES (8923, 846, 'type_detail');
INSERT INTO `productimage` VALUES (8924, 847, 'type_single');
INSERT INTO `productimage` VALUES (8925, 847, 'type_single');
INSERT INTO `productimage` VALUES (8926, 847, 'type_single');
INSERT INTO `productimage` VALUES (8927, 847, 'type_single');
INSERT INTO `productimage` VALUES (8928, 847, 'type_single');
INSERT INTO `productimage` VALUES (8929, 847, 'type_detail');
INSERT INTO `productimage` VALUES (8930, 847, 'type_detail');
INSERT INTO `productimage` VALUES (8931, 847, 'type_detail');
INSERT INTO `productimage` VALUES (8932, 847, 'type_detail');
INSERT INTO `productimage` VALUES (8933, 847, 'type_detail');
INSERT INTO `productimage` VALUES (8934, 847, 'type_detail');
INSERT INTO `productimage` VALUES (8935, 848, 'type_single');
INSERT INTO `productimage` VALUES (8936, 848, 'type_single');
INSERT INTO `productimage` VALUES (8937, 848, 'type_single');
INSERT INTO `productimage` VALUES (8938, 848, 'type_single');
INSERT INTO `productimage` VALUES (8939, 848, 'type_single');
INSERT INTO `productimage` VALUES (8940, 848, 'type_detail');
INSERT INTO `productimage` VALUES (8941, 848, 'type_detail');
INSERT INTO `productimage` VALUES (8942, 848, 'type_detail');
INSERT INTO `productimage` VALUES (8943, 848, 'type_detail');
INSERT INTO `productimage` VALUES (8944, 848, 'type_detail');
INSERT INTO `productimage` VALUES (8945, 848, 'type_detail');
INSERT INTO `productimage` VALUES (9495, 899, 'type_single');
INSERT INTO `productimage` VALUES (9496, 899, 'type_single');
INSERT INTO `productimage` VALUES (9497, 899, 'type_single');
INSERT INTO `productimage` VALUES (9498, 899, 'type_single');
INSERT INTO `productimage` VALUES (9499, 899, 'type_single');
INSERT INTO `productimage` VALUES (9500, 899, 'type_detail');
INSERT INTO `productimage` VALUES (9501, 899, 'type_detail');
INSERT INTO `productimage` VALUES (9502, 899, 'type_detail');
INSERT INTO `productimage` VALUES (9503, 899, 'type_detail');
INSERT INTO `productimage` VALUES (9504, 899, 'type_detail');
INSERT INTO `productimage` VALUES (9505, 899, 'type_detail');
INSERT INTO `productimage` VALUES (9506, 900, 'type_single');
INSERT INTO `productimage` VALUES (9507, 900, 'type_single');
INSERT INTO `productimage` VALUES (9508, 900, 'type_single');
INSERT INTO `productimage` VALUES (9509, 900, 'type_single');
INSERT INTO `productimage` VALUES (9510, 900, 'type_single');
INSERT INTO `productimage` VALUES (9511, 900, 'type_detail');
INSERT INTO `productimage` VALUES (9512, 900, 'type_detail');
INSERT INTO `productimage` VALUES (9513, 900, 'type_detail');
INSERT INTO `productimage` VALUES (9514, 900, 'type_detail');
INSERT INTO `productimage` VALUES (9515, 900, 'type_detail');
INSERT INTO `productimage` VALUES (9516, 900, 'type_detail');
INSERT INTO `productimage` VALUES (9517, 901, 'type_single');
INSERT INTO `productimage` VALUES (9518, 901, 'type_single');
INSERT INTO `productimage` VALUES (9519, 901, 'type_single');
INSERT INTO `productimage` VALUES (9520, 901, 'type_single');
INSERT INTO `productimage` VALUES (9521, 901, 'type_single');
INSERT INTO `productimage` VALUES (9522, 901, 'type_detail');
INSERT INTO `productimage` VALUES (9523, 901, 'type_detail');
INSERT INTO `productimage` VALUES (9524, 901, 'type_detail');
INSERT INTO `productimage` VALUES (9525, 901, 'type_detail');
INSERT INTO `productimage` VALUES (9526, 901, 'type_detail');
INSERT INTO `productimage` VALUES (9527, 901, 'type_detail');
INSERT INTO `productimage` VALUES (9528, 902, 'type_single');
INSERT INTO `productimage` VALUES (9529, 902, 'type_single');
INSERT INTO `productimage` VALUES (9530, 902, 'type_single');
INSERT INTO `productimage` VALUES (9531, 902, 'type_single');
INSERT INTO `productimage` VALUES (9532, 902, 'type_single');
INSERT INTO `productimage` VALUES (9533, 902, 'type_detail');
INSERT INTO `productimage` VALUES (9534, 902, 'type_detail');
INSERT INTO `productimage` VALUES (9535, 902, 'type_detail');
INSERT INTO `productimage` VALUES (9536, 902, 'type_detail');
INSERT INTO `productimage` VALUES (9537, 902, 'type_detail');
INSERT INTO `productimage` VALUES (9538, 902, 'type_detail');
INSERT INTO `productimage` VALUES (9539, 903, 'type_single');
INSERT INTO `productimage` VALUES (9540, 903, 'type_single');
INSERT INTO `productimage` VALUES (9541, 903, 'type_single');
INSERT INTO `productimage` VALUES (9542, 903, 'type_single');
INSERT INTO `productimage` VALUES (9543, 903, 'type_single');
INSERT INTO `productimage` VALUES (9544, 903, 'type_detail');
INSERT INTO `productimage` VALUES (9545, 903, 'type_detail');
INSERT INTO `productimage` VALUES (9546, 903, 'type_detail');
INSERT INTO `productimage` VALUES (9547, 903, 'type_detail');
INSERT INTO `productimage` VALUES (9548, 903, 'type_detail');
INSERT INTO `productimage` VALUES (9549, 903, 'type_detail');
INSERT INTO `productimage` VALUES (10144, 958, 'type_single');
INSERT INTO `productimage` VALUES (10145, 958, 'type_single');
INSERT INTO `productimage` VALUES (10146, 958, 'type_single');
INSERT INTO `productimage` VALUES (10147, 958, 'type_single');
INSERT INTO `productimage` VALUES (10148, 958, 'type_single');
INSERT INTO `productimage` VALUES (10149, 958, 'type_detail');
INSERT INTO `productimage` VALUES (10150, 958, 'type_detail');
INSERT INTO `productimage` VALUES (10151, 958, 'type_detail');
INSERT INTO `productimage` VALUES (10152, 958, 'type_detail');
INSERT INTO `productimage` VALUES (10153, 958, 'type_detail');
INSERT INTO `productimage` VALUES (10154, 958, 'type_detail');
INSERT INTO `productimage` VALUES (10155, 959, 'type_single');
INSERT INTO `productimage` VALUES (10156, 959, 'type_single');
INSERT INTO `productimage` VALUES (10157, 959, 'type_single');
INSERT INTO `productimage` VALUES (10158, 959, 'type_single');
INSERT INTO `productimage` VALUES (10159, 959, 'type_single');
INSERT INTO `productimage` VALUES (10160, 959, 'type_detail');
INSERT INTO `productimage` VALUES (10161, 959, 'type_detail');
INSERT INTO `productimage` VALUES (10162, 959, 'type_detail');
INSERT INTO `productimage` VALUES (10163, 959, 'type_detail');
INSERT INTO `productimage` VALUES (10164, 959, 'type_detail');
INSERT INTO `productimage` VALUES (10165, 959, 'type_detail');
INSERT INTO `productimage` VALUES (10166, 960, 'type_single');
INSERT INTO `productimage` VALUES (10167, 960, 'type_single');
INSERT INTO `productimage` VALUES (10168, 960, 'type_single');
INSERT INTO `productimage` VALUES (10169, 960, 'type_single');
INSERT INTO `productimage` VALUES (10170, 960, 'type_single');
INSERT INTO `productimage` VALUES (10171, 960, 'type_detail');
INSERT INTO `productimage` VALUES (10172, 960, 'type_detail');
INSERT INTO `productimage` VALUES (10173, 960, 'type_detail');
INSERT INTO `productimage` VALUES (10174, 960, 'type_detail');
INSERT INTO `productimage` VALUES (10175, 960, 'type_detail');
INSERT INTO `productimage` VALUES (10176, 960, 'type_detail');
INSERT INTO `productimage` VALUES (10177, 961, 'type_single');
INSERT INTO `productimage` VALUES (10178, 961, 'type_single');
INSERT INTO `productimage` VALUES (10179, 961, 'type_single');
INSERT INTO `productimage` VALUES (10180, 961, 'type_single');
INSERT INTO `productimage` VALUES (10181, 961, 'type_single');
INSERT INTO `productimage` VALUES (10182, 961, 'type_detail');
INSERT INTO `productimage` VALUES (10183, 961, 'type_detail');
INSERT INTO `productimage` VALUES (10184, 961, 'type_detail');
INSERT INTO `productimage` VALUES (10185, 961, 'type_detail');
INSERT INTO `productimage` VALUES (10186, 961, 'type_detail');
INSERT INTO `productimage` VALUES (10187, 961, 'type_detail');
INSERT INTO `productimage` VALUES (10188, 962, 'type_single');
INSERT INTO `productimage` VALUES (10189, 962, 'type_single');
INSERT INTO `productimage` VALUES (10190, 962, 'type_single');
INSERT INTO `productimage` VALUES (10191, 962, 'type_single');
INSERT INTO `productimage` VALUES (10192, 962, 'type_single');
INSERT INTO `productimage` VALUES (10193, 962, 'type_detail');
INSERT INTO `productimage` VALUES (10194, 962, 'type_detail');
INSERT INTO `productimage` VALUES (10195, 962, 'type_detail');
INSERT INTO `productimage` VALUES (10196, 962, 'type_detail');
INSERT INTO `productimage` VALUES (10197, 962, 'type_detail');
INSERT INTO `productimage` VALUES (10198, 962, 'type_detail');

-- ----------------------------
-- Table structure for property
-- ----------------------------
DROP TABLE IF EXISTS `property`;
CREATE TABLE `property`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '属性id',
  `cid` int(0) NULL DEFAULT NULL COMMENT '对应产品id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属性名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_property_category`(`cid`) USING BTREE,
  CONSTRAINT `fk_property_category` FOREIGN KEY (`cid`) REFERENCES `category` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 258 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of property
-- ----------------------------
INSERT INTO `property` VALUES (1, 83, '品牌');
INSERT INTO `property` VALUES (2, 83, '证书状态');
INSERT INTO `property` VALUES (3, 83, '3C产品型号');
INSERT INTO `property` VALUES (4, 83, '申请人名称');
INSERT INTO `property` VALUES (5, 83, '证书编号');
INSERT INTO `property` VALUES (6, 83, '分辨率');
INSERT INTO `property` VALUES (7, 83, '型号');
INSERT INTO `property` VALUES (8, 83, '制造商名称');
INSERT INTO `property` VALUES (9, 83, '网络连接方式');
INSERT INTO `property` VALUES (10, 83, '产品名称');
INSERT INTO `property` VALUES (11, 83, '能效等级');
INSERT INTO `property` VALUES (12, 83, '3D类型');
INSERT INTO `property` VALUES (13, 83, '操作系统');
INSERT INTO `property` VALUES (14, 82, '品牌');
INSERT INTO `property` VALUES (15, 82, '冲水按键类型');
INSERT INTO `property` VALUES (16, 82, '坐便器类型');
INSERT INTO `property` VALUES (17, 82, '盖板是否缓冲');
INSERT INTO `property` VALUES (18, 82, '型号');
INSERT INTO `property` VALUES (19, 82, '坐便器冲水方式');
INSERT INTO `property` VALUES (20, 82, '排水方式');
INSERT INTO `property` VALUES (21, 82, '材质');
INSERT INTO `property` VALUES (22, 82, '最小坑距');
INSERT INTO `property` VALUES (23, 82, '承重');
INSERT INTO `property` VALUES (24, 82, '颜色分类');
INSERT INTO `property` VALUES (25, 82, '坐便冲水量');
INSERT INTO `property` VALUES (26, 82, '同城服务');
INSERT INTO `property` VALUES (27, 81, '风格');
INSERT INTO `property` VALUES (28, 81, '城市');
INSERT INTO `property` VALUES (29, 81, '面料饰面工艺');
INSERT INTO `property` VALUES (30, 81, '是否带储物空间');
INSERT INTO `property` VALUES (31, 81, '包装体积');
INSERT INTO `property` VALUES (32, 81, '颜色分类');
INSERT INTO `property` VALUES (33, 81, '附加功能');
INSERT INTO `property` VALUES (34, 81, '是否可拆洗');
INSERT INTO `property` VALUES (35, 81, '结构工艺');
INSERT INTO `property` VALUES (36, 81, '设计元素');
INSERT INTO `property` VALUES (37, 81, '几人坐');
INSERT INTO `property` VALUES (38, 81, '图案');
INSERT INTO `property` VALUES (39, 81, '是否组装');
INSERT INTO `property` VALUES (40, 81, '面料');
INSERT INTO `property` VALUES (41, 81, '可送货/安装');
INSERT INTO `property` VALUES (42, 81, '木质结构工艺');
INSERT INTO `property` VALUES (43, 81, '沙发组合形式');
INSERT INTO `property` VALUES (44, 81, '产地');
INSERT INTO `property` VALUES (45, 81, '是否可定制');
INSERT INTO `property` VALUES (46, 81, '品牌');
INSERT INTO `property` VALUES (47, 81, '适用对象');
INSERT INTO `property` VALUES (48, 81, '材质');
INSERT INTO `property` VALUES (49, 81, '款式定位');
INSERT INTO `property` VALUES (50, 81, '填充物');
INSERT INTO `property` VALUES (51, 81, '填充物硬度');
INSERT INTO `property` VALUES (52, 81, '出租车是否可运输');
INSERT INTO `property` VALUES (53, 81, '型号');
INSERT INTO `property` VALUES (54, 81, '木质材质');
INSERT INTO `property` VALUES (55, 81, '是否可预售');
INSERT INTO `property` VALUES (56, 81, '安装说明详情');
INSERT INTO `property` VALUES (57, 80, '品牌');
INSERT INTO `property` VALUES (58, 80, '证书状态');
INSERT INTO `property` VALUES (59, 80, '3C产品型号');
INSERT INTO `property` VALUES (60, 80, '申请人名称');
INSERT INTO `property` VALUES (61, 80, '证书编号');
INSERT INTO `property` VALUES (62, 80, '型号');
INSERT INTO `property` VALUES (63, 80, '控制方式');
INSERT INTO `property` VALUES (64, 80, '制造商名称');
INSERT INTO `property` VALUES (65, 80, '款式');
INSERT INTO `property` VALUES (66, 80, '产品名称');
INSERT INTO `property` VALUES (67, 80, '能效等级');
INSERT INTO `property` VALUES (68, 79, '上市时间');
INSERT INTO `property` VALUES (69, 79, '款式');
INSERT INTO `property` VALUES (70, 79, '是否商场同款');
INSERT INTO `property` VALUES (71, 79, '货号');
INSERT INTO `property` VALUES (72, 79, '品牌');
INSERT INTO `property` VALUES (73, 78, '液晶显示');
INSERT INTO `property` VALUES (74, 78, '尘盒容量');
INSERT INTO `property` VALUES (75, 78, '外观造型');
INSERT INTO `property` VALUES (76, 78, '功能');
INSERT INTO `property` VALUES (77, 78, '最高高度');
INSERT INTO `property` VALUES (78, 78, '碰撞保护');
INSERT INTO `property` VALUES (79, 78, '是否自动充电');
INSERT INTO `property` VALUES (80, 78, '电池容量');
INSERT INTO `property` VALUES (81, 78, '有无虚拟墙');
INSERT INTO `property` VALUES (82, 78, '是否有定时预约功能');
INSERT INTO `property` VALUES (83, 78, '货号');
INSERT INTO `property` VALUES (84, 78, '颜色分类');
INSERT INTO `property` VALUES (85, 78, '清扫路线');
INSERT INTO `property` VALUES (86, 78, '是否带遥控器');
INSERT INTO `property` VALUES (87, 77, '品牌');
INSERT INTO `property` VALUES (88, 77, '转速');
INSERT INTO `property` VALUES (89, 77, '证书状态');
INSERT INTO `property` VALUES (90, 77, '3C产品型号');
INSERT INTO `property` VALUES (91, 77, '申请人名称');
INSERT INTO `property` VALUES (92, 77, '额定功率');
INSERT INTO `property` VALUES (93, 77, '证书编号');
INSERT INTO `property` VALUES (94, 77, '型号');
INSERT INTO `property` VALUES (95, 77, '制造商名称');
INSERT INTO `property` VALUES (96, 77, '附加功能');
INSERT INTO `property` VALUES (97, 77, '采购地');
INSERT INTO `property` VALUES (98, 77, '机身材质');
INSERT INTO `property` VALUES (99, 77, '颜色分类');
INSERT INTO `property` VALUES (100, 77, '产品名称');
INSERT INTO `property` VALUES (101, 77, '操作方式');
INSERT INTO `property` VALUES (102, 76, '冰箱冷柜机型');
INSERT INTO `property` VALUES (103, 76, '证书状态');
INSERT INTO `property` VALUES (104, 76, '箱门结构');
INSERT INTO `property` VALUES (105, 76, '美菱冰箱型号');
INSERT INTO `property` VALUES (106, 76, '3C产品型号');
INSERT INTO `property` VALUES (107, 76, '申请人名称');
INSERT INTO `property` VALUES (108, 76, '证书编号');
INSERT INTO `property` VALUES (109, 76, '制造商名称');
INSERT INTO `property` VALUES (110, 76, '制冷方式');
INSERT INTO `property` VALUES (111, 76, '产品名称');
INSERT INTO `property` VALUES (112, 76, '能效等级');
INSERT INTO `property` VALUES (113, 75, '空调类型');
INSERT INTO `property` VALUES (114, 75, '证书状态');
INSERT INTO `property` VALUES (115, 75, '证书编号');
INSERT INTO `property` VALUES (116, 75, '海信空调型号');
INSERT INTO `property` VALUES (117, 75, '工作方式');
INSERT INTO `property` VALUES (118, 75, '冷暖类型');
INSERT INTO `property` VALUES (119, 75, '产品名称');
INSERT INTO `property` VALUES (120, 75, '能效等级');
INSERT INTO `property` VALUES (121, 75, '空调功率');
INSERT INTO `property` VALUES (122, 75, '适用面积');
INSERT INTO `property` VALUES (123, 74, '风格');
INSERT INTO `property` VALUES (124, 74, '颜色分类');
INSERT INTO `property` VALUES (125, 74, '显示方式');
INSERT INTO `property` VALUES (126, 74, '表壳材质');
INSERT INTO `property` VALUES (127, 74, '机芯类型');
INSERT INTO `property` VALUES (128, 74, '手表镜面材质');
INSERT INTO `property` VALUES (129, 74, '机芯产地');
INSERT INTO `property` VALUES (130, 74, '表盘厚度');
INSERT INTO `property` VALUES (131, 74, '品牌产地');
INSERT INTO `property` VALUES (132, 74, '成色');
INSERT INTO `property` VALUES (133, 74, '表盘直径');
INSERT INTO `property` VALUES (134, 74, '上市时间');
INSERT INTO `property` VALUES (135, 74, '表带材质');
INSERT INTO `property` VALUES (136, 74, '保修');
INSERT INTO `property` VALUES (137, 74, '品牌');
INSERT INTO `property` VALUES (138, 74, '形状');
INSERT INTO `property` VALUES (139, 74, '防水深度');
INSERT INTO `property` VALUES (140, 74, '流行元素');
INSERT INTO `property` VALUES (141, 74, '手表种类');
INSERT INTO `property` VALUES (142, 74, '型号');
INSERT INTO `property` VALUES (143, 73, '风格');
INSERT INTO `property` VALUES (144, 73, '颜色分类');
INSERT INTO `property` VALUES (145, 73, '显示方式');
INSERT INTO `property` VALUES (146, 73, '表壳材质');
INSERT INTO `property` VALUES (147, 73, '机芯类型');
INSERT INTO `property` VALUES (148, 73, '手表镜面材质');
INSERT INTO `property` VALUES (149, 73, '表扣款式');
INSERT INTO `property` VALUES (150, 73, '表盘厚度');
INSERT INTO `property` VALUES (151, 73, '品牌产地');
INSERT INTO `property` VALUES (152, 73, '表盘直径');
INSERT INTO `property` VALUES (153, 73, '成色');
INSERT INTO `property` VALUES (154, 73, '上市时间');
INSERT INTO `property` VALUES (155, 73, '表带材质');
INSERT INTO `property` VALUES (156, 73, '保修');
INSERT INTO `property` VALUES (157, 73, '品牌');
INSERT INTO `property` VALUES (158, 73, '形状');
INSERT INTO `property` VALUES (159, 73, '防水深度');
INSERT INTO `property` VALUES (160, 73, '表底类型');
INSERT INTO `property` VALUES (161, 73, '表冠类型');
INSERT INTO `property` VALUES (162, 73, '流行元素');
INSERT INTO `property` VALUES (163, 73, '手表种类');
INSERT INTO `property` VALUES (164, 73, '型号');
INSERT INTO `property` VALUES (165, 72, '风格');
INSERT INTO `property` VALUES (166, 72, '大小');
INSERT INTO `property` VALUES (167, 72, '内部结构');
INSERT INTO `property` VALUES (168, 72, '颜色分类');
INSERT INTO `property` VALUES (169, 72, '箱包硬度');
INSERT INTO `property` VALUES (170, 72, '款式');
INSERT INTO `property` VALUES (171, 72, '图案');
INSERT INTO `property` VALUES (172, 72, '成色');
INSERT INTO `property` VALUES (173, 72, '里料材质');
INSERT INTO `property` VALUES (174, 72, '上市时间');
INSERT INTO `property` VALUES (175, 72, '品牌');
INSERT INTO `property` VALUES (176, 72, '形状');
INSERT INTO `property` VALUES (177, 72, '箱包外袋种类');
INSERT INTO `property` VALUES (178, 72, '适用对象');
INSERT INTO `property` VALUES (179, 72, '质地');
INSERT INTO `property` VALUES (180, 72, '拿包方式');
INSERT INTO `property` VALUES (181, 72, '适用场景');
INSERT INTO `property` VALUES (182, 72, '提拎部件类型');
INSERT INTO `property` VALUES (183, 72, '闭合方式');
INSERT INTO `property` VALUES (184, 72, '是否可折叠');
INSERT INTO `property` VALUES (185, 72, '有无夹层');
INSERT INTO `property` VALUES (186, 72, '货号');
INSERT INTO `property` VALUES (187, 72, '皮革材质');
INSERT INTO `property` VALUES (188, 71, '销售渠道类型');
INSERT INTO `property` VALUES (189, 71, '面料分类');
INSERT INTO `property` VALUES (190, 71, '上市年份季节');
INSERT INTO `property` VALUES (191, 71, '品牌');
INSERT INTO `property` VALUES (192, 71, '货号');
INSERT INTO `property` VALUES (193, 71, '基础风格');
INSERT INTO `property` VALUES (194, 71, '材质成分');
INSERT INTO `property` VALUES (195, 71, '厚薄');
INSERT INTO `property` VALUES (196, 69, '风格');
INSERT INTO `property` VALUES (197, 69, '鞋面材质');
INSERT INTO `property` VALUES (198, 69, '低帮鞋品名');
INSERT INTO `property` VALUES (199, 69, '鞋底材质');
INSERT INTO `property` VALUES (200, 69, '颜色分类');
INSERT INTO `property` VALUES (201, 69, '上市年份季节');
INSERT INTO `property` VALUES (202, 69, '款式');
INSERT INTO `property` VALUES (203, 69, '图案');
INSERT INTO `property` VALUES (204, 69, '鞋面内里材质');
INSERT INTO `property` VALUES (205, 69, '季节');
INSERT INTO `property` VALUES (206, 69, '细分风格');
INSERT INTO `property` VALUES (207, 69, '鞋跟高');
INSERT INTO `property` VALUES (208, 69, '品牌');
INSERT INTO `property` VALUES (209, 69, '适用对象');
INSERT INTO `property` VALUES (210, 69, '销售渠道类型');
INSERT INTO `property` VALUES (211, 69, '功能');
INSERT INTO `property` VALUES (212, 69, '鞋制作工艺');
INSERT INTO `property` VALUES (213, 69, '尺码');
INSERT INTO `property` VALUES (214, 69, '闭合方式');
INSERT INTO `property` VALUES (215, 69, '流行元素');
INSERT INTO `property` VALUES (216, 69, '跟底款式');
INSERT INTO `property` VALUES (217, 69, '货号');
INSERT INTO `property` VALUES (218, 69, '鞋头款式');
INSERT INTO `property` VALUES (219, 69, '鞋垫材质');
INSERT INTO `property` VALUES (220, 69, '场合');
INSERT INTO `property` VALUES (221, 68, '适用年龄');
INSERT INTO `property` VALUES (222, 68, '颜色分类');
INSERT INTO `property` VALUES (223, 68, '上市年份季节');
INSERT INTO `property` VALUES (224, 68, '尺码');
INSERT INTO `property` VALUES (225, 68, '货号');
INSERT INTO `property` VALUES (226, 68, '品牌');
INSERT INTO `property` VALUES (227, 68, '材质成分');
INSERT INTO `property` VALUES (228, 64, '品牌');
INSERT INTO `property` VALUES (229, 64, '产地');
INSERT INTO `property` VALUES (230, 64, '上市时间');
INSERT INTO `property` VALUES (231, 64, '型号');
INSERT INTO `property` VALUES (232, 64, '功能');
INSERT INTO `property` VALUES (233, 64, '适用性别');
INSERT INTO `property` VALUES (234, 64, '风格');
INSERT INTO `property` VALUES (235, 64, '价格区间');
INSERT INTO `property` VALUES (236, 64, '眼镜配件类型');
INSERT INTO `property` VALUES (237, 64, '是否商场同款');
INSERT INTO `property` VALUES (238, 64, '镜片材质');
INSERT INTO `property` VALUES (239, 64, '货号');
INSERT INTO `property` VALUES (240, 64, '颜色分类');
INSERT INTO `property` VALUES (241, 64, '是否可调');
INSERT INTO `property` VALUES (242, 64, '适合脸型');
INSERT INTO `property` VALUES (243, 60, '产地');
INSERT INTO `property` VALUES (244, 60, '证书状态');
INSERT INTO `property` VALUES (245, 60, '3C产品型号');
INSERT INTO `property` VALUES (246, 60, '申请人名称');
INSERT INTO `property` VALUES (247, 60, '安装接口');
INSERT INTO `property` VALUES (248, 60, '适合体重');
INSERT INTO `property` VALUES (249, 60, '证书编号');
INSERT INTO `property` VALUES (250, 60, '型号');
INSERT INTO `property` VALUES (251, 60, '制造商名称');
INSERT INTO `property` VALUES (252, 60, '颜色分类');
INSERT INTO `property` VALUES (253, 60, '款式');
INSERT INTO `property` VALUES (254, 60, '产品名称');
INSERT INTO `property` VALUES (255, 60, '人体固定方式');
INSERT INTO `property` VALUES (256, 60, '安全座椅品牌');
INSERT INTO `property` VALUES (257, 60, '适用年龄');

-- ----------------------------
-- Table structure for propertyvalue
-- ----------------------------
DROP TABLE IF EXISTS `propertyvalue`;
CREATE TABLE `propertyvalue`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '属性值id',
  `pid` int(0) NULL DEFAULT NULL COMMENT '产品id',
  `ptid` int(0) NULL DEFAULT NULL COMMENT '属性id',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '属性内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_propertyvalue_property`(`ptid`) USING BTREE,
  INDEX `fk_propertyvalue_product`(`pid`) USING BTREE,
  CONSTRAINT `fk_propertyvalue_product` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_propertyvalue_property` FOREIGN KEY (`ptid`) REFERENCES `property` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of propertyvalue
-- ----------------------------

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `content` varchar(4000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `uid` int(0) NULL DEFAULT NULL COMMENT '用户id',
  `pid` int(0) NULL DEFAULT NULL COMMENT '产品id',
  `createDate` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_review_product`(`pid`) USING BTREE,
  INDEX `fk_review_user`(`uid`) USING BTREE,
  CONSTRAINT `fk_review_product` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_review_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `salt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户散列值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (11, 'asd', 'qweq', 'qweq');
INSERT INTO `user` VALUES (12, '18370080689', 'zyc2000921@', NULL);
INSERT INTO `user` VALUES (13, 'asda', '123', NULL);

SET FOREIGN_KEY_CHECKS = 1;
