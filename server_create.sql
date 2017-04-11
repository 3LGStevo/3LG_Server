CREATE DATABASE  IF NOT EXISTS `arma3life` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `arma3life`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: arma3life
-- ------------------------------------------------------
-- Server version	5.7.16-log

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
-- Table structure for table `bans`
--

DROP TABLE IF EXISTS `bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player` varchar(32) NOT NULL,
  `guid` varchar(50) NOT NULL,
  `count` int(100) NOT NULL DEFAULT '0',
  `mode` int(100) NOT NULL DEFAULT '0',
  `perma` int(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guid` varchar(50) NOT NULL,
  `contactlist` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hit`
--

DROP TABLE IF EXISTS `hit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guid` varchar(50) NOT NULL,
  `clients` text,
  `bounty` int(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `houses`
--

DROP TABLE IF EXISTS `houses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` varchar(32) NOT NULL,
  `pos` varchar(64) DEFAULT NULL,
  `inventory` text,
  `containers` text,
  `owned` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`,`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `players` (
  `uid` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `playerid` varchar(50) NOT NULL,
  `cash` int(100) NOT NULL DEFAULT '0',
  `bankacc` int(100) NOT NULL DEFAULT '0',
  `coplevel` enum('0','1','2','3','4','5','6') NOT NULL DEFAULT '0',
  `cop_licenses` text,
  `civ_licenses` text,
  `med_licenses` text,
  `cop_gear` text NOT NULL,
  `med_gear` text NOT NULL,
  `mediclevel` enum('0','1') NOT NULL DEFAULT '0',
  `arrested` tinyint(1) NOT NULL DEFAULT '0',
  `aliases` text NOT NULL,
  `adminlevel` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `donatorlvl` enum('0','1','2') NOT NULL DEFAULT '0',
  `civ_gear` text NOT NULL,
  `blacklist` tinyint(1) NOT NULL DEFAULT '0',
  `quest` int(100) NOT NULL DEFAULT '0',
  `army_class` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `rebel_class` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `idle` int(10) NOT NULL DEFAULT '168',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `playerid` (`playerid`),
  KEY `name` (`name`),
  KEY `blacklist` (`blacklist`)
) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ranks`
--

DROP TABLE IF EXISTS `ranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ranks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player` varchar(32) NOT NULL,
  `guid` varchar(50) NOT NULL,
  `civ_lvl` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL DEFAULT '0',
  `civ_exp` int(100) NOT NULL DEFAULT '0',
  `rob_lvl` enum('0','1','2','3','4','5','6','7','8','9') NOT NULL DEFAULT '0',
  `rob_exp` int(100) NOT NULL DEFAULT '0',
  `hack_lvl` enum('0','1','2','3','4','5','6','7','8','9') NOT NULL DEFAULT '0',
  `hack_exp` int(100) NOT NULL DEFAULT '0',
  `info_lvl` enum('0','1','2','3','4','5','6','7','8','9') NOT NULL DEFAULT '0',
  `info_exp` int(100) NOT NULL DEFAULT '0',
  `hunter_lvl` enum('0','1','2','3','4','5','6','7','8','9') NOT NULL DEFAULT '0',
  `hunter_exp` int(100) NOT NULL DEFAULT '0',
  `lockpick_lvl` enum('0','1','2','3','4','5','6') NOT NULL DEFAULT '0',
  `lockpick_exp` int(100) NOT NULL DEFAULT '0',
  `process_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `process_exp` int(100) NOT NULL DEFAULT '0',
  `gather_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `gather_exp` int(100) NOT NULL DEFAULT '0',
  `repair_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `repair_exp` int(100) NOT NULL DEFAULT '0',
  `pers_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `pers_exp` int(100) NOT NULL DEFAULT '0',
  `control_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `control_exp` int(100) NOT NULL DEFAULT '0',
  `bomb_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `bomb_exp` int(100) NOT NULL DEFAULT '0',
  `cop_lvl` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `cop_exp` int(100) NOT NULL DEFAULT '0',
  `forensic_lvl` enum('0','1','2','3','4','5','6','7','8','9') NOT NULL DEFAULT '0',
  `forensic_exp` int(100) NOT NULL DEFAULT '0',
  `raid_lvl` enum('0','1','2','3','4','5','6') NOT NULL DEFAULT '0',
  `raid_exp` int(100) NOT NULL DEFAULT '0',
  `arrest_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `arrest_exp` int(100) NOT NULL DEFAULT '0',
  `impound_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `impound_exp` int(100) NOT NULL DEFAULT '0',
  `inspect_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `inspect_exp` int(100) NOT NULL DEFAULT '0',
  `med_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `med_exp` int(100) NOT NULL DEFAULT '0',
  `revive_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `revive_exp` int(100) NOT NULL DEFAULT '0',
  `heal_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `heal_exp` int(100) NOT NULL DEFAULT '0',
  `kill_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `kill_exp` int(100) NOT NULL DEFAULT '0',
  `hitman_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `hitman_exp` int(100) NOT NULL DEFAULT '0',
  `driving_lvl` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `driving_exp` int(100) NOT NULL DEFAULT '0',
  `pilot_lvl` enum('0','1','2','3','4','5') NOT NULL DEFAULT '0',
  `pilot_exp` int(100) NOT NULL DEFAULT '0',
  `good_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `good_exp` int(100) NOT NULL DEFAULT '0',
  `bad_lvl` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `bad_exp` int(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=291 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stats`
--

DROP TABLE IF EXISTS `stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player` varchar(32) NOT NULL,
  `guid` varchar(50) NOT NULL,
  `kills` int(100) NOT NULL DEFAULT '0',
  `armykilled` int(100) NOT NULL DEFAULT '0',
  `rebelkilled` int(100) NOT NULL DEFAULT '0',
  `copkilled` int(100) NOT NULL DEFAULT '0',
  `assassinations` int(100) NOT NULL DEFAULT '0',
  `deaths` int(100) NOT NULL DEFAULT '0',
  `longestshot` int(100) NOT NULL DEFAULT '0',
  `bankrobberytime` int(100) NOT NULL DEFAULT '0',
  `bankrobberymoney` int(100) NOT NULL DEFAULT '0',
  `kart_lap` decimal(8,3) NOT NULL DEFAULT '10000.000',
  `shopsrobbed` int(100) NOT NULL DEFAULT '0',
  `totalbounty` int(100) NOT NULL DEFAULT '0',
  `bountypaid` int(100) NOT NULL DEFAULT '0',
  `crimes` int(100) NOT NULL DEFAULT '0',
  `jailed` int(100) NOT NULL DEFAULT '0',
  `revives` int(100) NOT NULL DEFAULT '0',
  `heals` int(100) NOT NULL DEFAULT '0',
  `cop_arrests` int(100) NOT NULL DEFAULT '0',
  `bh_arrests` int(100) NOT NULL DEFAULT '0',
  `impounds` int(100) NOT NULL DEFAULT '0',
  `raids` int(100) NOT NULL DEFAULT '0',
  `army_vault` int(100) NOT NULL DEFAULT '0',
  `rebel_vault` int(100) NOT NULL DEFAULT '0',
  `hacks` int(100) NOT NULL DEFAULT '0',
  `army_factories` int(100) NOT NULL DEFAULT '0',
  `rebel_factories` int(100) NOT NULL DEFAULT '0',
  `army_disarms` int(100) NOT NULL DEFAULT '0',
  `rebel_disarms` int(100) NOT NULL DEFAULT '0',
  `army_caps` int(100) NOT NULL DEFAULT '0',
  `rebel_caps` int(100) NOT NULL DEFAULT '0',
  `airdrops` int(100) NOT NULL DEFAULT '0',
  `treasures` int(100) NOT NULL DEFAULT '0',
  `secrets` int(100) NOT NULL DEFAULT '0',
  `adminwarnings` int(100) NOT NULL DEFAULT '0',
  `kart_wins` int(100) NOT NULL DEFAULT '0',
  `army_points` int(100) NOT NULL DEFAULT '0',
  `cop_points` int(100) NOT NULL DEFAULT '0',
  `rebel_points` int(100) NOT NULL DEFAULT '0',
  `med_points` int(100) NOT NULL DEFAULT '0',
  `army` int(1) NOT NULL DEFAULT '0',
  `rebel` int(1) NOT NULL DEFAULT '0',
  `hitman` int(1) NOT NULL DEFAULT '0',
  `hunter` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=291 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `side` varchar(15) NOT NULL,
  `classname` varchar(32) NOT NULL,
  `type` varchar(12) NOT NULL,
  `pid` varchar(32) NOT NULL,
  `alive` tinyint(1) NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `plate` int(20) NOT NULL,
  `color` int(20) NOT NULL,
  `inventory` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `side` (`side`),
  KEY `pid` (`pid`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=495 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wanted`
--

DROP TABLE IF EXISTS `wanted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wanted` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player` varchar(32) NOT NULL,
  `guid` varchar(50) NOT NULL,
  `crimes` text,
  `bounty` int(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=522 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'arma3life'
--
/*!50003 DROP PROCEDURE IF EXISTS `armyPointsUpdater` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `armyPointsUpdater`()
BEGIN
	DECLARE N INT DEFAULT 0;
    DECLARE I INT DEFAULT 0;
    DECLARE KILLS INT DEFAULT 0;
    DECLARE CAPS INT DEFAULT 0;
    DECLARE FACS INT DEFAULT 0;
    DECLARE DIS INT DEFAULT 0;
    DECLARE AIRDROP INT DEFAULT 0;
    DECLARE VAULTS INT DEFAULT 0;
    DECLARE SCORE INT DEFAULT 0;
    DECLARE UID VARCHAR(50);
    SELECT COUNT(*) FROM `stats` INTO N;
    SET I = 0;
    WHILE I<=N DO
		SET I = I + 1;
		SELECT `rebelkilled` FROM `stats` WHERE ID = I INTO KILLS;
		SELECT `army_caps` FROM `stats` WHERE ID = I INTO CAPS;
        SELECT `army_factories` FROM `stats` WHERE ID = I INTO FACS;
        SELECT `army_disarms` FROM `stats` WHERE ID = I INTO DIS;
        SELECT `airdrops` FROM `stats` WHERE ID = I INTO AIRDROP;
        SELECT `army_vault` FROM `stats` WHERE ID = I INTO VAULTS;
        SELECT `guid` FROM `stats` WHERE ID = I INTO UID;
        SET SCORE = 0;
        SET FACS = FACS * 3;
        SET DIS = DIS * 3;
        SET AIRDROP = AIRDROP * 2;
        SET VAULTS = VAULTS * 5;
        SET SCORE = SCORE + KILLS;
        SET SCORE = SCORE + CAPS;
        SET SCORE = SCORE + FACS;
        SET SCORE = SCORE + DIS;
        SET SCORE = SCORE + AIRDROP;
        SET SCORE = SCORE + VAULTS;
        UPDATE `stats` SET `army_points`= SCORE WHERE `guid` = UID;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `banHandler` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `banHandler`()
BEGIN
  ##Variables
  DECLARE I INT DEFAULT 0;
  DECLARE USERGUID VARCHAR(50);
  DECLARE WARNING INT DEFAULT 0;
  DECLARE N INT DEFAULT 0;
  
  ##Update the Bans records
  UPDATE `bans` SET `mode` = `mode` - 1 WHERE `mode` != 0 && `count` = 0 && `perma` = 0;
  UPDATE `bans` SET `count`= `count` - 1 WHERE `perma` = 0 && `count` != 0;
  
  ##Re-index the Ban Table
  SET @newid=0;
  UPDATE `bans` SET id=(@newid:=@newid+1) ORDER BY id;
  
  ##Correct the Admin Warnings in the Stats table
  SELECT COUNT(*) FROM `bans` INTO N;
  WHILE I<N DO
	SET I = I + 1;
	SELECT `guid` FROM `bans` WHERE ID=N INTO USERGUID;
    SELECT `mode` FROM `bans` WHERE ID=N INTO WARNING;
	UPDATE `stats` SET `adminwarnings` = WARNING where `guid` = USERGUID;
	END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `banRemove` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `banRemove`()
BEGIN
  DELETE FROM `bans` WHERE `mode` = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `copPointsUpdater` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `copPointsUpdater`()
BEGIN
	DECLARE N INT DEFAULT 0;
    DECLARE I INT DEFAULT 0;
    DECLARE ARRS INT DEFAULT 0;
    DECLARE IMPS INT DEFAULT 0;
    DECLARE RAID INT DEFAULT 0;
    DECLARE SCORE INT DEFAULT 0;
    DECLARE UID VARCHAR(50);
    SELECT COUNT(*) FROM `stats` INTO N;
    SET I = 0;
    WHILE I<=N DO
		SET I = I + 1;
		SELECT `cop_arrests` FROM `stats` WHERE ID = I INTO ARRS;
        SELECT `impounds` FROM `stats` WHERE ID = I INTO IMPS;
        SELECT `raids` FROM `stats` WHERE ID = I INTO RAID;
        SELECT `guid` FROM `stats` WHERE ID = I INTO UID;
        SET SCORE = 0;
        SET ARRS = ARRS * 3;
        SET RAID = RAID * 2;
        SET SCORE = SCORE + ARRS;
        SET SCORE = SCORE + IMPS;
        SET SCORE = SCORE + RAID;
        UPDATE `stats` SET `cop_points`= SCORE WHERE `guid` = UID;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteDeadVehicles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDeadVehicles`()
BEGIN
	DELETE FROM `vehicles` WHERE `alive` = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteOldHouses` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteOldHouses`()
BEGIN
  DELETE FROM `houses` WHERE `owned` = 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `endSeason1` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `endSeason1`()
BEGIN
	Update `stats` SET `kills`=0, `armykilled`=0, `rebelkilled`=0, `copkilled`=0, `assassinations`=0, `deaths`=0, `longestshot`=0, `bankrobberytime`=999999, `bankrobberymoney`=0, `kart_lap`=10000.000, `shopsrobbed`=0, `totalbounty`=0, `bountypaid`=0, `crimes`=0, `jailed`=0, `revives`=0, `heals`=0, `cop_arrests`=0, `bh_arrests`=0, `impounds`=0, `raids`=0, `army_vault`=0, `rebel_vault`=0, `hacks`=0, `army_factories`=0, `rebel_factories`=0, `army_disarms`=0, `rebel_disarms`=0, `army_caps`=0, `rebel_caps`=0, `airdrops`=0, `treasures`=0,  `secrets`=0, `kart_wins`=0 WHERE `id` != 0;
    call armyPointsUpdater;
    call copPointsUpdater;
    call medPointsUpdater;
    call rebelPointsUpdater;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inactiveHandler` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `inactiveHandler`()
BEGIN
	UPDATE `players` SET `idle` = `idle` - 1 WHERE `idle` != 0 && `adminlevel` = '0';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inactiveRemove` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `inactiveRemove`()
BEGIN
	##Variables
	DECLARE USERGUID VARCHAR(50);
	DECLARE I INT DEFAULT 0;
    DECLARE N INT DEFAULT 0;
    DECLARE INACTIVE INT DEFAULT 168;
    
	##Re-index the Players Table
    SET @newid=0;
	UPDATE `players` SET uid=(@newid:=@newid+1) ORDER BY uid;
    
    SELECT count(*) FROM `players` INTO N;
    WHILE I<N DO
		SET I= I+1;
		SELECT `idle` from `players` WHERE `uid` = I INTO INACTIVE;
        SELECT `playerid` from `players` WHERE `uid` = I INTO USERGUID;
		if (INACTIVE=0) THEN
            DELETE FROM `ranks` WHERE `guid`=USERGUID;
            DELETE FROM `stats` WHERE `guid`=USERGUID;
            DELETE FROM `vehicles` WHERE `pid`=USERGUID;
            DELETE FROM `houses` WHERE `pid`=USERGUID;
            DELETE FROM `wanted` WHERE `guid`=USERGUID;
            DELETE FROM `hit` WHERE `guid`=USERGUID;
            DELETE FROM `contacts` WHERE `guid`=USERGUID;
		END IF;
	END WHILE;
    
    DELETE FROM `players` WHERE `idle` = 0;
    
    CALL tableReindex;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `licenseUpdater` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `licenseUpdater`()
BEGIN
	DECLARE PLAYERGUID VARCHAR(45);
    DECLARE TEMP TEXT;
    DECLARE VAL INT;
	DECLARE N INT DEFAULT 0;
    DECLARE I INT DEFAULT 0;
    SELECT COUNT(*) FROM `players` INTO N;
    SET I = 0;
    SET VAL = 0;
    WHILE I<=N DO
		SET I=I + 1;
		SELECT `playerid` FROM `players` WHERE `uid`=I INTO PLAYERGUID;
        SELECT `civ_licenses` FROM `players` WHERE `uid`=I INTO TEMP;
        IF TEMP LIKE '%`license_civ_corp`,1%' THEN SET VAL = 1; END IF;
        IF TEMP LIKE '%`license_civ_corp`,0%' THEN SET VAL = 0; END IF;
		UPDATE `stats` SET `army`=VAL WHERE `guid`=PLAYERGUID;
        IF TEMP LIKE '%`license_civ_rebel`,1%' THEN SET VAL = 1; END IF;
        IF TEMP LIKE '%`license_civ_rebel`,0%' THEN SET VAL = 0; END IF;
		UPDATE `stats` SET `rebel`=VAL WHERE `guid`=PLAYERGUID;
        IF TEMP LIKE '%`license_civ_hitman`,1%' THEN SET VAL = 1; END IF;
        IF TEMP LIKE '%`license_civ_hitman`,0%' THEN SET VAL = 0; END IF;
		UPDATE `stats` SET `hitman`=VAL WHERE `guid`=PLAYERGUID;
        IF TEMP LIKE '%`license_civ_bh`,1%' THEN SET VAL = 1; END IF;
        IF TEMP LIKE '%`license_civ_bh`,0%' THEN SET VAL = 0; END IF;
		UPDATE `stats` SET `hunter`=VAL WHERE `guid`=PLAYERGUID;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `medPointsUpdater` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `medPointsUpdater`()
BEGIN
	DECLARE N INT DEFAULT 0;
    DECLARE I INT DEFAULT 0;
    DECLARE HEAL INT DEFAULT 0;
    DECLARE REV INT DEFAULT 0;
    DECLARE SCORE INT DEFAULT 0;
    DECLARE UID VARCHAR(50);
    SELECT COUNT(*) FROM `stats` INTO N;
    SET I = 0;
    WHILE I<=N DO
		SET I = I + 1;
		SELECT `revives` FROM `stats` WHERE ID = I INTO REV;
        SELECT `heals` FROM `stats` WHERE ID = I INTO HEAL;
        SELECT `guid` FROM `stats` WHERE ID = I INTO UID;
        SET SCORE = 0;
        SET REV = REV * 3;
        SET SCORE = SCORE + REV;
        SET SCORE = SCORE + HEAL;
        UPDATE `stats` SET `med_points`= SCORE WHERE `guid` = UID;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `players_db_reset` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `players_db_reset`()
BEGIN
	DELETE FROM `players` WHERE `adminlevel` = '0';
    UPDATE `players` SET `cash`=0,`bankacc`=500,`cop_licenses`='"[]"',`civ_licenses`='"[]"',`med_licenses`='"[]"',`cop_gear`='"[]"',`med_gear`='"[]"',`arrested`=0,`civ_gear`='"[]"',`quest`=0,`idle`=168 WHERE `adminlevel` != '0';
    
    DELETE FROM arma3life.contacts;
    DELETE FROM arma3life.hit;
    DELETE FROM arma3life.houses;
    DELETE FROM arma3life.ranks;
    DELETE FROM arma3life.stats;
    DELETE FROM arma3life.vehicles;
    DELETE FROM arma3life.wanted;
    
    call tableReindex;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rebelPointsUpdater` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `rebelPointsUpdater`()
BEGIN
	DECLARE N INT DEFAULT 0;
    DECLARE I INT DEFAULT 0;
    DECLARE KILLS INT DEFAULT 0;
    DECLARE CAPS INT DEFAULT 0;
    DECLARE FACS INT DEFAULT 0;
    DECLARE DIS INT DEFAULT 0;
    DECLARE VAULTS INT DEFAULT 0;
    DECLARE SCORE INT DEFAULT 0;
    DECLARE UID VARCHAR(50);
    SELECT COUNT(*) FROM `stats` INTO N;
    SET I = 0;
    WHILE I<=N DO
		SET I = I + 1;
		SELECT `armykilled` FROM `stats` WHERE ID = I INTO KILLS;
		SELECT `rebel_caps` FROM `stats` WHERE ID = I INTO CAPS;
        SELECT `rebel_factories` FROM `stats` WHERE ID = I INTO FACS;
        SELECT `rebel_disarms` FROM `stats` WHERE ID = I INTO DIS;
        SELECT `rebel_vault` FROM `stats` WHERE ID = I INTO VAULTS;
        SELECT `guid` FROM `stats` WHERE ID = I INTO UID;
        SET SCORE = 0;
        SET FACS = FACS * 3;
        SET DIS = DIS * 3;
        SET VAULTS = VAULTS * 5;
        SET SCORE = SCORE + KILLS;
        SET SCORE = SCORE + CAPS;
        SET SCORE = SCORE + FACS;
        SET SCORE = SCORE + DIS;
        SET SCORE = SCORE + VAULTS;
        UPDATE `stats` SET `rebel_points`= SCORE WHERE `guid` = UID;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `resetLifeVehicles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `resetLifeVehicles`()
BEGIN
	UPDATE vehicles SET `active`= 0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `tableReindex` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `tableReindex`()
BEGIN
    SET @newid=0;
	UPDATE `players` SET uid=(@newid:=@newid+1) ORDER BY uid;
    
    SET @newid=0;
	UPDATE `ranks` SET id=(@newid:=@newid+1) ORDER BY id;
    
    SET @newid=0;
	UPDATE `vehicles` SET id=(@newid:=@newid+1) ORDER BY id;
    
    SET @newid=0;
	UPDATE `wanted` SET id=(@newid:=@newid+1) ORDER BY id;
    
    SET @newid=0;
	UPDATE `hit` SET id=(@newid:=@newid+1) ORDER BY id;
    
    SET @newid=0;
	UPDATE `contacts` SET id=(@newid:=@newid+1) ORDER BY id;
    
    SET @newid=0;
	UPDATE `stats` SET id=(@newid:=@newid+1) ORDER BY id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-05  7:23:11
