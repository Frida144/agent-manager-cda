CREATE DATABASE  IF NOT EXISTS `agent_manager` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `agent_manager`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: agent_manager
-- ------------------------------------------------------
-- Server version	8.4.7

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
-- Table structure for table `abilities`
--

DROP TABLE IF EXISTS `abilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abilities` (
  `Id_Ability` int NOT NULL AUTO_INCREMENT,
  `ability` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`Id_Ability`),
  UNIQUE KEY `ability` (`ability`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abilities`
--

LOCK TABLES `abilities` WRITE;
/*!40000 ALTER TABLE `abilities` DISABLE KEYS */;
INSERT INTO `abilities` VALUES (4,'Grappin'),(6,'Jeter un sort'),(5,'Lancer d\'objet'),(7,'SortilÃ¨ge'),(3,'Super force'),(2,'Super vitesse'),(1,'Vol');
/*!40000 ALTER TABLE `abilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agents`
--

DROP TABLE IF EXISTS `agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agents` (
  `Id_Agent` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dob` date DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Id_Archetype` int NOT NULL,
  `Id_Tier` int NOT NULL,
  `Id_Team` int DEFAULT NULL,
  PRIMARY KEY (`Id_Agent`),
  KEY `fk_agents_archetypes` (`Id_Archetype`),
  KEY `fk_agents_tiers` (`Id_Tier`),
  KEY `fk_agents_teams` (`Id_Team`),
  CONSTRAINT `fk_agents_archetypes` FOREIGN KEY (`Id_Archetype`) REFERENCES `archetypes` (`Id_Archetype`) ON DELETE RESTRICT,
  CONSTRAINT `fk_agents_teams` FOREIGN KEY (`Id_Team`) REFERENCES `teams` (`Id_Team`) ON DELETE SET NULL,
  CONSTRAINT `fk_agents_tiers` FOREIGN KEY (`Id_Tier`) REFERENCES `tiers` (`Id_Tier`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agents`
--

LOCK TABLES `agents` WRITE;
/*!40000 ALTER TABLE `agents` DISABLE KEYS */;
/*!40000 ALTER TABLE `agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archetypes`
--

DROP TABLE IF EXISTS `archetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `archetypes` (
  `Id_Archetype` int NOT NULL AUTO_INCREMENT,
  `archetype` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`Id_Archetype`),
  UNIQUE KEY `archetype` (`archetype`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archetypes`
--

LOCK TABLES `archetypes` WRITE;
/*!40000 ALTER TABLE `archetypes` DISABLE KEYS */;
INSERT INTO `archetypes` VALUES (5,'Batman'),(7,'Constantine'),(3,'Flash'),(6,'Hulk'),(4,'Spider-Man'),(1,'Superman'),(2,'Thor');
/*!40000 ALTER TABLE `archetypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `archetypes_abilities`
--

DROP TABLE IF EXISTS `archetypes_abilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `archetypes_abilities` (
  `Id_Archetype` int NOT NULL,
  `Id_Ability` int NOT NULL,
  PRIMARY KEY (`Id_Archetype`,`Id_Ability`),
  KEY `fk_aa_abilities` (`Id_Ability`),
  CONSTRAINT `fk_aa_abilities` FOREIGN KEY (`Id_Ability`) REFERENCES `abilities` (`Id_Ability`) ON DELETE CASCADE,
  CONSTRAINT `fk_aa_archetypes` FOREIGN KEY (`Id_Archetype`) REFERENCES `archetypes` (`Id_Archetype`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archetypes_abilities`
--

LOCK TABLES `archetypes_abilities` WRITE;
/*!40000 ALTER TABLE `archetypes_abilities` DISABLE KEYS */;
INSERT INTO `archetypes_abilities` VALUES (1,1),(1,2),(3,2),(1,3),(2,3),(4,3),(6,3),(4,4),(5,4),(4,5),(5,5),(7,6),(7,7);
/*!40000 ALTER TABLE `archetypes_abilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `Id_Role` int NOT NULL AUTO_INCREMENT,
  `role` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`Id_Role`),
  UNIQUE KEY `role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrateur'),(2,'Manager');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `Id_Team` int NOT NULL AUTO_INCREMENT,
  `team_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Id_User` int NOT NULL,
  PRIMARY KEY (`Id_Team`),
  UNIQUE KEY `team_name` (`team_name`),
  KEY `fk_teams_users` (`Id_User`),
  CONSTRAINT `fk_teams_users` FOREIGN KEY (`Id_User`) REFERENCES `users` (`Id_User`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tiers`
--

DROP TABLE IF EXISTS `tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tiers` (
  `Id_Tier` int NOT NULL AUTO_INCREMENT,
  `tier` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` int NOT NULL,
  PRIMARY KEY (`Id_Tier`),
  UNIQUE KEY `tier` (`tier`),
  UNIQUE KEY `level` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tiers`
--

LOCK TABLES `tiers` WRITE;
/*!40000 ALTER TABLE `tiers` DISABLE KEYS */;
INSERT INTO `tiers` VALUES (1,'God',7),(2,'A',6),(3,'B',5),(4,'C',4),(5,'D',3),(6,'E',2),(7,'F',1);
/*!40000 ALTER TABLE `tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Id_User` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Id_Role` int NOT NULL,
  PRIMARY KEY (`Id_User`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_users_roles` (`Id_Role`),
  CONSTRAINT `fk_users_roles` FOREIGN KEY (`Id_Role`) REFERENCES `roles` (`Id_Role`) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-10  9:08:00