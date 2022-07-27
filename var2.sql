-- MySQL dump 10.13  Distrib 5.7.38, for Linux (x86_64)
--
-- Host: localhost    Database: variant2
-- ------------------------------------------------------
-- Server version	5.7.38

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `avto`
--

DROP TABLE IF EXISTS `avto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avto` (
  `id` int(11) NOT NULL,
  `km` int(10) NOT NULL,
  `number` varchar(255) NOT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `model_id` int(11) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `manufacture_year` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `model_id_fk` (`model_id`),
  KEY `client_id_fk` (`client_id`),
  KEY `number_index` (`number`) USING BTREE,
  KEY `vendor_id_afk` (`vendor_id`),
  KEY `country_id_afk` (`country_id`),
  CONSTRAINT `client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `country_id_afk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `model_id_fk` FOREIGN KEY (`model_id`) REFERENCES `model` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `vendor_id_afk` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avto`
--

LOCK TABLES `avto` WRITE;
/*!40000 ALTER TABLE `avto` DISABLE KEYS */;
INSERT INTO `avto` VALUES (1,17500,'A111AA61',4,6,7,2017,1),(2,15000,'A222AA161',7,1,5,2018,2),(3,55000,'B222BB126',9,5,5,2019,3),(4,155000,'C333CC161',2,3,3,2014,4),(5,25800,'E444E161',1,4,7,2016,5),(6,95500,'T555TT61',9,9,5,1996,6),(7,225500,'T777TT161',8,8,3,2009,7),(8,325500,'C888CK126',6,10,6,2015,8),(9,15555,'CN999CK',3,2,4,2005,9),(10,777555,'26CK999',5,7,6,2014,10),(11,9900,'C126CK126',9,5,5,2021,11);
/*!40000 ALTER TABLE `avto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL,
  `city` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id_fk` (`country_id`),
  CONSTRAINT `country_id_fk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Erevan',1),(2,'Minsk',2),(3,'Modena',4),(4,'Mogilev',2),(5,'Pyatigorsk',6),(6,'Rostov',6),(7,'Taganrog',6);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `avto_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_index` (`surname`) USING BTREE,
  KEY `avto_id_cfk` (`avto_id`),
  CONSTRAINT `avto_id_cfk` FOREIGN KEY (`avto_id`) REFERENCES `avto` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Ivan','Petrov','79001234567',1),(2,'Petr','Ivanov','79011234567',2),(3,'Maksim','Ivanov','79021234567',3),(4,'Mihail','Petrov','79031234567',4),(5,'Fedor','Maksimov','79041234567',5),(6,'Igor','Fedorov','79051234567',6),(7,'Igor','Sidorov','79061234567',7),(8,'Egor','Trofimov','79071234567',8),(9,'Nicola','Tesla','79081234567',9),(10,'David','Hachatryan','79091234567',10),(11,'Vladimir','Makarov','79191234567',11);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `country` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Armenia'),(2,'Belarus'),(3,'France'),(4,'Italy'),(5,'Japan'),(6,'Rissia'),(7,'usa');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master`
--

DROP TABLE IF EXISTS `master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `master` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) NOT NULL,
  `service_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `service_id_fk` (`service_id`),
  KEY `master_surname_index` (`surname`) USING BTREE,
  CONSTRAINT `service_id_fk` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master`
--

LOCK TABLES `master` WRITE;
/*!40000 ALTER TABLE `master` DISABLE KEYS */;
INSERT INTO `master` VALUES (1,'Ivan','Petrov',1),(2,'Petr','Petrov',2),(3,'Ivan','Ivanov',3),(4,'Sergei','Sergeev',4),(5,'Maksim','Zaharov',5),(6,'Ilya','Fedotov',6),(7,'Arsen','Akopyan',7),(8,'Silvio','Berluskoni',8),(9,'Maksim','Maksimov',9),(10,'Aleksei','Alekseev',10);
/*!40000 ALTER TABLE `master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model`
--

DROP TABLE IF EXISTS `model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model` (
  `id` int(11) NOT NULL,
  `model` varchar(50) NOT NULL,
  `country_id` int(11) NOT NULL,
  `vendor_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vendor_id_fk` (`vendor_id`),
  KEY `country_id_mfk` (`country_id`),
  CONSTRAINT `country_id_mfk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `vendor_id_fk` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model`
--

LOCK TABLES `model` WRITE;
/*!40000 ALTER TABLE `model` DISABLE KEYS */;
INSERT INTO `model` VALUES (1,'3',5,7),(2,'458',4,3),(3,'C4',3,2),(4,'Camaro',7,1),(5,'Camry',5,9),(6,'Focus3',7,4),(7,'Gazelle',6,5),(8,'Logan',3,8),(9,'Supra',5,9),(10,'Vesta',6,6);
/*!40000 ALTER TABLE `model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `records`
--

DROP TABLE IF EXISTS `records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `records` (
  `id` int(11) NOT NULL,
  `master_id` int(11) NOT NULL,
  `avto_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `master_id_fk` (`master_id`),
  KEY `avto_id_fk` (`avto_id`),
  KEY `client_id_rfk` (`client_id`),
  CONSTRAINT `avto_id_fk` FOREIGN KEY (`avto_id`) REFERENCES `avto` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `client_id_rfk` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `master_id_fk` FOREIGN KEY (`master_id`) REFERENCES `master` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `records`
--

LOCK TABLES `records` WRITE;
/*!40000 ALTER TABLE `records` DISABLE KEYS */;
INSERT INTO `records` VALUES (1,1,1,1,'2022-08-03 10:20:00'),(2,2,2,2,'2022-08-05 10:55:00'),(3,3,3,3,'2022-08-05 10:00:00'),(4,2,3,3,'2022-08-08 11:00:00'),(5,4,4,4,'2022-08-03 12:00:00'),(6,8,9,9,'2022-08-04 14:00:00'),(7,7,10,10,'2022-08-01 17:00:00');
/*!40000 ALTER TABLE `records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `id` int(11) NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `country_id` int(11) DEFAULT NULL,
  `city_id` int(10) NOT NULL,
  `street` varchar(255) NOT NULL,
  `house_num` int(11) NOT NULL,
  `places` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id_fk` (`city_id`),
  KEY `contry_id_sfk` (`country_id`),
  KEY `service_name_index` (`service_name`) USING BTREE,
  KEY `street_index` (`street`) USING BTREE,
  CONSTRAINT `city_id_fk` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `contry_id_sfk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Avto',2,2,'Pushkina',16,7),(2,'Formula',6,7,'Chehova',21,8),(3,'F1',6,7,'Lenina',16,5),(4,'Fortuna',6,6,'Malinovskogo',35,12),(5,'F1',2,4,'Lenina',40,11),(6,'9station',6,5,'Kalinina',301,10),(7,'Ararat',1,1,'Bagramyna',39,9),(8,'Ferrari',4,3,'Paganine',51,6),(9,'F1',6,6,'Taganrogskaya',120,8),(10,'F1',6,7,'Lenina',159,5);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vendor` (
  `id` int(11) NOT NULL,
  `vendor` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id_vfk` (`country_id`),
  CONSTRAINT `country_id_vfk` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor`
--

LOCK TABLES `vendor` WRITE;
/*!40000 ALTER TABLE `vendor` DISABLE KEYS */;
INSERT INTO `vendor` VALUES (1,'Chevrolet',7),(2,'Citroen',3),(3,'Ferrari',4),(4,'Ford',7),(5,'GAZ',6),(6,'Lada',6),(7,'Mazda',5),(8,'Renault',3),(9,'Toyota',5);
/*!40000 ALTER TABLE `vendor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-27 19:01:35
