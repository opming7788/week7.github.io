-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: website
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Unique ID',
  `yourname` varchar(255) NOT NULL COMMENT 'yourname',
  `username` varchar(255) NOT NULL COMMENT 'Username',
  `password` varchar(255) NOT NULL COMMENT 'Password',
  `follower_count` int unsigned NOT NULL DEFAULT '0' COMMENT 'Follower Count',
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Signup Time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'jimmy','opming','12345',32,'2024-05-07 09:53:31'),(2,'丁滿','dman','zzz',0,'2024-05-07 09:53:44'),(3,'澎澎','ply','aaa',100,'2024-05-07 09:54:04'),(4,'張三','jane_smith','ss',200,'2024-05-07 09:54:04'),(5,'Emily Brown','emily_b','44',300,'2024-05-07 09:54:04'),(6,'小精靈','spirit','123',0,'2024-05-07 09:55:11'),(7,'蔡','guessEnglish','888',0,'2024-05-07 10:03:33'),(8,'陳明','aaa','aaa',0,'2024-05-07 17:30:02'),(9,'GG','2330','2330',0,'2024-05-07 18:24:08'),(10,'林老師','gg','aa',0,'2024-05-08 01:16:07'),(11,'fuckman','fuckman','123',0,'2024-05-12 18:22:27'),(12,'我是誰','2454','111',0,'2024-05-12 18:35:12');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Unique ID',
  `member_id` bigint NOT NULL COMMENT 'Member ID for Message Sender',
  `content` varchar(255) NOT NULL COMMENT 'Content',
  `like_count` int unsigned NOT NULL DEFAULT '0' COMMENT 'Like Count',
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Publish Time',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,6,'吃早餐沒?',0,'2024-05-07 09:55:23'),(4,3,'十萬青年十萬肝',0,'2024-05-07 09:56:42'),(5,2,'GG輪班救台灣',0,'2024-05-07 09:58:22'),(6,6,'吃午餐囉',0,'2024-05-07 09:59:05'),(8,6,'123到台灣，台灣有個阿里山',0,'2024-05-07 09:59:36'),(9,5,'好熱鬧阿',0,'2024-05-07 10:01:08'),(10,1,'天下武功，唯快不破',0,'2024-05-07 10:01:47'),(14,4,'吃晚餐嗎?',0,'2024-05-07 10:03:07'),(15,7,'台灣獨立',0,'2024-05-07 10:03:45'),(16,7,'我也來試看看',0,'2024-05-07 10:05:07'),(17,3,'沒事多喝水',0,'2024-05-07 10:05:49'),(18,6,'多喝水沒事',0,'2024-05-07 10:06:33'),(19,3,'晚安，睡覺囉',0,'2024-05-07 16:33:40'),(22,6,'今天天氣真好',0,'2024-05-07 17:28:57'),(24,8,'輪班星人報到',0,'2024-05-07 17:30:44'),(25,8,'123456789',0,'2024-05-07 17:31:12'),(27,1,'刪留言',0,'2024-05-07 18:14:28'),(28,1,'加上留言',0,'2024-05-07 18:14:35'),(29,9,'台積電上看1200',0,'2024-05-07 18:24:25'),(30,9,'FFFFFFFFFFFFFFFFFFFFFFFFF',0,'2024-05-07 18:24:46'),(32,3,'草0老師',0,'2024-05-08 01:13:01'),(33,1,'十里山路不換肩',0,'2024-05-08 01:14:38'),(34,6,'台灣獨立',0,'2024-05-08 01:15:09'),(35,1,' ',0,'2024-05-08 01:15:23'),(36,10,'今天天氣真好',0,'2024-05-08 01:16:24'),(37,1,'喔喔喔喔喔喔喔喔喔',0,'2024-05-10 20:43:10'),(39,9,'台積電看2000',0,'2024-05-12 18:37:23'),(40,1,'123到阿里山',0,'2024-05-12 22:57:40'),(41,1,'台灣獨立',0,'2024-05-12 23:03:17'),(42,1,'黑嘿嘿嘿',0,'2024-05-12 23:52:38'),(45,1,'哈哈555哈哈',0,'2024-05-13 00:50:10'),(46,1,'今天天氣真好',0,'2024-05-13 00:52:24'),(47,9,'2330萬歲',0,'2024-05-13 00:54:16'),(48,1,'哈哈55哈哈',0,'2024-05-13 00:54:34'),(50,3,'台灣獨立',0,'2024-05-13 00:55:38'),(51,3,'台灣獨立',0,'2024-05-13 00:56:13'),(52,3,'我說在座的各位都是垃圾',0,'2024-05-13 00:58:14'),(53,3,'吃早餐沒?',0,'2024-05-13 00:59:03'),(55,3,'hello',0,'2024-05-13 01:13:04'),(56,9,'12345',0,'2024-05-13 01:13:48'),(57,3,'0933787545',0,'2024-05-13 01:17:25'),(58,3,'哈哈哈哈',0,'2024-05-13 01:37:30'),(59,1,'大家好',0,'2024-05-13 01:46:05'),(60,1,'吃早餐沒?',0,'2024-05-13 01:57:39'),(61,1,'台灣獨立',0,'2024-05-13 19:21:54'),(62,6,'我說在座的各位都是垃圾',0,'2024-05-13 23:18:13');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-13 23:26:57
