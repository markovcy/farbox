CREATE DATABASE  IF NOT EXISTS `shop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shop`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `description` text,
  `image` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Ноуты','Описание ноутов','1.jpg'),(2,'Телефон','Описание телефонов','2.jpg');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `cost` double DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `category` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,'Asus VivoBook D540NA-GQ211T','Екран 15.6\" (1366x768) WXGA HD, матовий / Intel Pentium N4200 (1.1 - 2.5 ГГц) / RAM 4 ГБ / HDD 500 ГБ / Intel HD Graphics 505 / без ОД / Wi-Fi / Bluetooth / веб-камера / Windows 10 Home 64bit',7999,'asus_d540na_gq211t_images_10642535768.jpg',1),(2,'Ноутбук Lenovo IdeaPad 330-15AST','Екран 15.6\" TN+film (1366x768) HD, матовий / AMD E2-9000 (1.8 - 2.2 ГГц) / RAM 4 ГБ / HDD 500 ГБ / AMD Radeon R2 Graphics / без ОД / LAN / Wi-Fi / Bluetooth / веб-камера / DOS / 2.2 кг / чорний',6499,'lenovo_81d600jyra_images_10442255288.jpg',1),(3,'Ноутбук Dell Inspiron 3573','Екран 15.6\" (1366x768) WXGA HD, глянсовий з антивідблисковим покриттям / Intel Celeron N4000 (1.1 - 2.6 ГГц) / RAM 4 ГБ / HDD 500 ГБ / Intel UHD Graphics 600 / DVD±RW / Wi-Fi / Bluetooth / веб-камера / Linux / 2.15 кг / чорний',6299,'copy_dell_inspiron_3573_alex299901_5bac934976a22_images_7670670744.jpg',1),(4,'Apple MacBook Pro 15\" Retina Z0V00006S Space Grey (i9 2.9GHz/2TB)','Экран 15,4\" IPS (2560x1600) Retina, глянцевый /Intel Core i9(2,9-4,8 ГГц) / RAM 32 ГБ / SSD 2 ТБ /AMD Radeon Pro 560X, 4 ГБ GDDR5/ без ОД / Wi-Fi / Bluetooth / веб-камера / macOS High Sierra / 1.83 кг / серый',177156,'64306312_images_9249871008.jpg',1),(5,'Apple MacBook Pro 15\" Space Gray (MR9426) 2018','Экран 15,4\" IPS (2560x1600) Retina, глянцевый /Intel Core i9(2,9-4,8 ГГц) / RAM 32 ГБ / SSD 2 ТБ /AMD Radeon Pro 560X, 4 ГБ GDDR5/ без ОД / Wi-Fi / Bluetooth / веб-камера / macOS High Sierra / 1.83 кг / серый',150999,'54573204_images_11323625388.jpg',1),(6,'Ноутбук Dell Latitude 7414 Rugged Extreme (74i58S2IHD-WBK)','Екран 14\" TN (1366x768) WXGA HD, глянсовий, Multi-Touch / Intel Core i5-6300U (2.4 - 3.0 ГГц) / RAM 8 ГБ / SSD 256 ГБ / Intel HD Graphics 520 / без ОД / LAN / Wi-Fi / Bluetooth / 3G / 4G / веб-камера / Windows 10 Pro 64bit / 3.69 кг / чорний',139994,'copy_dell_74i716s3r73_wbk_5c7d0f4b9ffad_images_11230556673.jpg',1),(7,'Apple MacBook Pro 15\" Space Gray (Z0UC0000D/MPTW2) 2017','Экран 15\" (2880x1800), IPS / глянцевый / Intel Core i7 (3.1 - 4.1 ГГц) / RAM 16 ГБ / SSD 1 ТБ / AMD Radeon Pro 560,4 ГБ / Wi-Fi 802.11 a/b/g/n/ac / Bluetooth 4.2 / Веб-камера HD-камера FaceTime 720p 1.3 Мп / MacOS Sierra / 349.3х240.7х15.5 мм, 1.83 кг / серый',87999,'42607960_images_4743479056.jpg',1),(8,'Apple MacBook A1534 Rose Gold (MNYM2UA/A)','',55523,'75069108_images_11285451942.jpg',1),(9,'Ноутбук Lenovo ThinkPad X380 Yoga (20LH001HRT) Black','Екран 13.3\" IPS (1920x1080) Full HD, Multi-touch, глянсовий / Intel Core i5-8250U (1.6 - 3.4 ГГц) / RAM 8 ГБ / SSD 512 ГБ / Intel UHD Graphics 620 / без ОД / Mini LAN (RJ-45) / Wi-Fi / Bluetooth / веб-камера / Windows 10 Pro 64bit / 1.43 кг / чорний / стилус\nДокладніше: https://rozetka.com.ua/ua/lenovo_20lh001hrt/p47259120/',53611,'lenovo_20lh001hrt_images_10809693627.jpg',1),(10,'Samsung Galaxy M20 4/64GB Ocean Blue (SM-M205FZBWSEK)','Экран (6.3\", PLS, 2340х1080)/ Samsung Exynos 7904 (2 x 1.8 ГГц + 6 x 1.6 ГГц)/ двойная основная камера: 13 Мп + 5 Мп, фронтальная 8 Мп/ RAM 4 ГБ/ 64 ГБ встроенной памяти + microSD (до 512 ГБ)/ 3G/ LTE/ GPS/ ГЛОНАСС/ BDS/ поддержка 2х SIM-карт (Nano-SIM)/ Android 8.1 (SE 9.5) / 5000 мА*ч',6199.54,'samsung_galaxy_m20_4_64gb_ocean_blue_images_10883949159.jpg',2),(11,'Samsung Galaxy S10 8/128 GB Black (SM-G973FZKDSEK)','Экран (6.1\", Dynamic AMOLED, 3040x1440)/ Samsung Exynos 9820 (2 x 2.7 ГГц + 2 x 2.3 ГГц + 4 x 1.9 ГГц)/ тройная основная камера: 12 Мп + 12 Мп + 16 Мп / фронтальная 10 Мп/ RAM 8 ГБ/ 128 ГБ встроенной памяти + microSD (до 512 ГБ)/ 3G/ LTE/ GPS/ A-GPS / ГЛОНАСС/ BDS/ поддержка 2х SIM-карт (Nano-SIM)/ Android 9.0 (Pie) / 3400 мА*ч/',29999,'samsung_galaxy_s10_6_128_gb_black_sm_g973fzkdsek_images_11052552609.jpg',2),(12,'Huawei P smart+ Black','Экран (6.3\", IPS, 2340x1080)/ HiSilicon Kirin 710 (2.2 ГГц + 1.7 ГГц)/ двойная основная камера: 16 Мп + 2 Мп, двойная фронтальная камера: 24 Мп + 2 Мп/ RAM 4 ГБ/ 64 ГБ встроенной памяти + microSD (до 256 ГБ)/ 3G/ LTE/ A-GPS/ ГЛОНАСС/ BDS/ поддержка 2х SIM-карт (Nano-SIM)/ Android 8.1 (Oreo)/ 3340 мА*ч',6999,'huawei_p_smart_plus_black_images_7926542781.jpg',2),(13,'Xiaomi Redmi Note 5 3/32GB Rose Gold (Global Rom + OTA)','Экран (5.99\", IPS, 2160x1080)/ Qualcomm Snapdragon 636 (1.8 ГГц)/ основная камера: 12 Мп + 5 Мп, фронтальная камера: 13 Мп/ RAM 3 ГБ/ 32 ГБ встроенной памяти + microSD (до 128 ГБ)/ 3G/ LTE/ GPS/ GLONASS/ поддержка 2х SIM-карт (Nano-SIM)/ Android 8.1 (Oreo)/ 4000 мА*ч',4399,'xiaomi_redmi_note5_332gb_rose_gold_images_5031920016.jpg',2),(14,'Sony Xperia XA2 Black','Экран (5.2\", IPS, 1920x1080)/ Qualcomm Snapdragon 630/ основная камера: 23 Мп, фронтальная камера: 8 Мп/ RAM 3 ГБ/ 32 ГБ встроенной памяти + microSD/SDHC (до 256 ГБ)/ 3G/ LTE/ GPS/ A-GPS/ГЛОНАСС/ поддержка 2х SIM-карт (Nano-SIM)/ Android 8.0 (Oreo)/ 3300 мА*ч',4777,'sony_xa2_black_images_3386205631.jpg',2),(15,'Samsung Galaxy M20 4/64GB Dark Grey (SM-M205FDAWSEK)','Экран (6.3\", PLS, 2340х1080)/ Samsung Exynos 7904 (2 x 1.8 ГГц + 6 x 1.6 ГГц)/ двойная основная камера: 13 Мп + 5 Мп, фронтальная 8 Мп/ RAM 4 ГБ/ 64 ГБ встроенной памяти + microSD (до 512 ГБ)/ 3G/ LTE/ GPS/ ГЛОНАСС/ BDS/ поддержка 2х SIM-карт (Nano-SIM)/ Android 8.1 (SE 9.5) / 5000 мА*ч\nПодробнее: https://rozetka.com.ua/mobile-phones/c80003/',6199,'samsung_galaxy_m20_4_64gb_darck_grey_images_10883883675.jpg',2);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_order`
--

DROP TABLE IF EXISTS `shop_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `goods_id` int NOT NULL,
  `goods_cost` double NOT NULL,
  `goods_amount` int NOT NULL,
  `total` double NOT NULL,
  `date` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_order`
--

LOCK TABLES `shop_order` WRITE;
/*!40000 ALTER TABLE `shop_order` DISABLE KEYS */;
INSERT INTO `shop_order` VALUES (1,12,2,6499,2,12998,1705165679),(2,14,2,6499,2,12998,1705227622),(3,17,2,6499,2,12998,1707093915),(4,18,2,6499,2,12998,1707094666),(5,19,2,6499,2,12998,1707094995),(6,20,2,6499,2,12998,1707095000),(7,21,2,6499,2,12998,1707095275);
/*!40000 ALTER TABLE `shop_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int DEFAULT NULL,
  `login` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `hash` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','123','AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) NOT NULL,
  `user_phone` varchar(100) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `address` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (1,'jnio','ujbn','onh','hb'),(2,'jnio','ujbn','onh','hb'),(3,'jnio','ujbn','onh888','hb'),(4,'jnio','ujbn','onh888','hb'),(5,'123','123','13','123'),(6,'Oleg','557788','55@ua',';,'),(7,'Oleg','557788','55@ua',';,'),(8,'Oleg','557788','55@ua',';,'),(9,'Oleg','557788','55@ua',';,'),(10,'Oleg','557788','55@ua','knlknm'),(11,'Oleg','557788','55@ua','knlknm'),(12,'Oleg','557788','55@ua','knlknm'),(13,'Oleg','557788','55@ua','knlknm'),(14,'Oleg','557788','55@ua','knlknm'),(15,'Oleg','557788','55@ua','ijijioj'),(16,'Oleg','557788','55@ua',''),(17,'Oleg','557788','55@ua','impiom'),(18,'Oleg','557788','55@ua','ijp0jiop'),(19,'Oleg','557788','55@ua',''),(20,'Oleg','557788','55@ua','444444'),(21,'Oleg','557788','55@ua','444444');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-19  1:57:59
