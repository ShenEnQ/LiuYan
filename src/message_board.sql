/*
Navicat MySQL Data Transfer

Source Server         : LocalMySQL
Source Server Version : 50703
Source Host           : localhost:3306
Source Database       : message_board

Target Server Type    : MYSQL
Target Server Version : 50703
File Encoding         : 65001

Date: 2017-02-26 15:35:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for message_info
-- ----------------------------
DROP TABLE IF EXISTS `message_info`;
CREATE TABLE `message_info` (
  `id` varchar(20) DEFAULT NULL,
  `username` varchar(30) DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `time` varchar(30) DEFAULT NULL,
  `msg` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message_info
-- ----------------------------
INSERT INTO `message_info` VALUES ('1', 'fadf', '87026@qq.com', '127.0.0.1', '2015-03-09 20:01:29', '1111');
INSERT INTO `message_info` VALUES ('2', 'fadf', '87026@qq.com', '127.0.0.1', '2015-03-09 20:01:36', 'ddd');
INSERT INTO `message_info` VALUES ('3', 'fadf', '87026@qq.com', '127.0.0.1', '2015-03-09 20:01:43', 'fdfdfd');
INSERT INTO `message_info` VALUES ('4', 'fdffdafsdf', '87026@qq.com', '127.0.0.2', '2015-03-09 20:02:03', 'fdaf');
INSERT INTO `message_info` VALUES ('5', 'fdffdafsdf', '87026@qq.com', '127.0.0.1', '2015-03-09 20:02:08', 'fdafdaf');
INSERT INTO `message_info` VALUES ('6', 'fdffdafsdf', '87026@qq.com', '127.0.0.1', '2015-03-09 20:02:15', 'dafeafefe');
INSERT INTO `message_info` VALUES ('7', '啊啊', '88992@ew.com', '127.0.0.1', '2015-03-11 15:56:23', '中文测试');
INSERT INTO `message_info` VALUES ('8', 'tom', 'erew@qq.com', '127.0.0.1', '2015-11-03 21:59:23', 'fdafdsfs');
INSERT INTO `message_info` VALUES ('9', 'tom', 'erew@qq.com', '127.0.0.1', '2015-11-03 22:00:13', 'fdafs');
INSERT INTO `message_info` VALUES ('10', 'tom', 'erew@qq.com', '127.0.0.1', '2015-11-03 22:00:23', 'dfadfae');
INSERT INTO `message_info` VALUES ('11', 'tom', 'erew@qq.com', '127.0.0.1', '2015-11-03 22:00:29', 'feawefaw');
INSERT INTO `message_info` VALUES ('12', 'tom', '123456@qq.com', '127.0.0.1', '2017-02-26 15:09:11', 'test');
