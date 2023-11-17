/*
 Navicat Premium Data Transfer

 Source Server         : mysql_3306
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : localhost:3306
 Source Schema         : bookstore

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 31/12/2021 22:36:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for books
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '东野圭吾',
  `price` float(100, 0) NOT NULL,
  `sales` int(100) NOT NULL,
  `stock` int(100) NOT NULL,
  `img_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'static/img/.jpg',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of books
-- ----------------------------
INSERT INTO `books` VALUES (1, '解忧杂货店', '东野圭吾', 40, 291, 26, 'static/img/解忧杂货店.jpg');
INSERT INTO `books` VALUES (2, '新参者', '东野圭吾', 40, 264, 16, 'static/img/新参者.jpg');
INSERT INTO `books` VALUES (3, '白夜行', '东野圭吾', 40, 538, 18, 'static/img/白夜行.jpg');
INSERT INTO `books` VALUES (4, '嫌疑人X的献身', '东野圭吾', 35, 256, 25, 'static/img/嫌疑人X的献身.jpg');
INSERT INTO `books` VALUES (5, '恶意', '东野圭吾', 40, 268, 16, 'static/img/恶意.jpg');
INSERT INTO `books` VALUES (6, '放学后', '东野圭吾', 45, 248, 29, 'static/img/放学后.jpg');
INSERT INTO `books` VALUES (7, '圣女的救济', '东野圭吾', 45, 312, 43, 'static/img/圣女的救济.jpg');
INSERT INTO `books` VALUES (8, '红手指', '东野圭吾', 40, 225, 34, 'static/img/红手指.jpg');
INSERT INTO `books` VALUES (9, '黎明之街', '东野圭吾', 50, 216, 36, 'static/img/黎明之街.jpg');
INSERT INTO `books` VALUES (10, 'test1', '东野圭吾', 999, 0, 1, 'static/img/.jpg');
INSERT INTO `books` VALUES (11, 'test2', '东野圭吾', 999, 0, 1, 'static/img/.jpg');
INSERT INTO `books` VALUES (12, '秘密', '东野圭吾', 45, 336, 28, 'static/img/秘密.jpg');

-- ----------------------------
-- Table structure for cart_itmes
-- ----------------------------
DROP TABLE IF EXISTS `cart_itmes`;
CREATE TABLE `cart_itmes`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `COUNT` int(11) NOT NULL,
  `amount` double(11, 2) NOT NULL,
  `book_id` int(11) NOT NULL,
  `cart_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `book_id`(`book_id`) USING BTREE,
  INDEX `cart_id`(`cart_id`) USING BTREE,
  CONSTRAINT `cart_itmes_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cart_itmes_ibfk_2` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart_itmes
-- ----------------------------
INSERT INTO `cart_itmes` VALUES (51, 10, 440.00, 3, 'bd97dc0c-2265-4fb6-4951-f3978122a9a0');
INSERT INTO `cart_itmes` VALUES (76, 1, 44.00, 3, '0090e801-f85d-4b5a-516b-02ebe9c9cfdb');
INSERT INTO `cart_itmes` VALUES (77, 1, 31.00, 12, '0090e801-f85d-4b5a-516b-02ebe9c9cfdb');

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_amount` double(11, 2) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carts
-- ----------------------------
INSERT INTO `carts` VALUES ('0090e801-f85d-4b5a-516b-02ebe9c9cfdb', 2, 75.00, 1);
INSERT INTO `carts` VALUES ('4c66d5ae-ddb1-495c-41b4-2cb09cf10237', 1, 45.00, 18);
INSERT INTO `carts` VALUES ('bd97dc0c-2265-4fb6-4951-f3978122a9a0', 10, 440.00, 14);

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `COUNT` int(11) NOT NULL,
  `amount` double(11, 2) NOT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` double(11, 2) NOT NULL,
  `img_path` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `order_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime(0) NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_amount` double(11, 2) NOT NULL,
  `state` int(11) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('070c8ba1-3e22-4cd4-427d-ea237e300dd7', '2021-12-31 20:45:43', 1, 40.00, 0, 18);
INSERT INTO `orders` VALUES ('5430ac57-82c0-4335-6d26-fe07ce858d29', '2021-12-31 20:46:38', 1, 40.00, 0, 18);
INSERT INTO `orders` VALUES ('a54df1e4-0608-4781-5758-bc7ba451a6e0', '2021-12-31 20:28:13', 1, 40.00, 2, 18);
INSERT INTO `orders` VALUES ('a925bcfc-c5dd-4327-685a-fda30254d70e', '2021-12-31 20:46:35', 1, 40.00, 1, 18);

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `session_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`session_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('ae76b697-7136-4b91-633d-6cfc77e4f670', '1', 18);
INSERT INTO `sessions` VALUES ('e8c7029d-d182-4ef1-5ebe-0d2f1ec3a9af', '1', 18);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `PASSWORD` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `username`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'test1', ' ', '10010');
INSERT INTO `users` VALUES (14, 'test2', ' ', '11111111');
INSERT INTO `users` VALUES (16, '3', '3', '3');
INSERT INTO `users` VALUES (18, '1', '1', '1');
INSERT INTO `users` VALUES (22, '23', '23', '23');
INSERT INTO `users` VALUES (25, '12', '12', '12');

SET FOREIGN_KEY_CHECKS = 1;
