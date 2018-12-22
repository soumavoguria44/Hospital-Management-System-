-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: soumavo
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `billing` (
  `BillNum` int(11) NOT NULL AUTO_INCREMENT,
  `PId` int(11) NOT NULL,
  `Patient_Type` varchar(20) DEFAULT NULL,
  `Doctor_Charge` double NOT NULL,
  `Medicine_Charge` double DEFAULT NULL,
  `Room_Charge` double DEFAULT NULL,
  `Operation_Charge` double DEFAULT NULL,
  `Number_Of_Days` int(11) DEFAULT NULL,
  `Nursing_Charge` double DEFAULT NULL,
  `Lab_Charge` double DEFAULT NULL,
  `Total` double GENERATED ALWAYS AS ((((((`Doctor_Charge` + `Medicine_Charge`) + (`Room_Charge` * `Number_Of_Days`)) + `Operation_Charge`) + `Nursing_Charge`) + `Lab_Charge`)) VIRTUAL NOT NULL,
  PRIMARY KEY (`BillNum`),
  KEY `PId` (`PId`),
  KEY `Bill_Index` (`BillNum`),
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`PId`) REFERENCES `person` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing`
--

LOCK TABLES `billing` WRITE;
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
INSERT INTO `billing` (`BillNum`, `PId`, `Patient_Type`, `Doctor_Charge`, `Medicine_Charge`, `Room_Charge`, `Operation_Charge`, `Number_Of_Days`, `Nursing_Charge`, `Lab_Charge`) VALUES (1,1,'Inpatient',2000,200,40,620,4,120,124),(2,2,'Inpatient',2000,200,40,620,4,120,124),(3,2,'Inpatient',400,1400,400,1800,8,300,200),(4,1,'Inpatient',200,1325,100,1700,12,150,100),(5,3,'Oupatient',200,100,0,0,0,0,100),(6,4,'Oupatient',300,250,0,0,0,0,150),(7,2,'Oupatient',300,250,0,0,0,0,150);
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insert_in__Billing` AFTER INSERT ON `billing` FOR EACH ROW BEGIN
   Set @prevTotal = (Select NewSum from hospital_fund order by NewSum desc limit 1);
   If(@prevTotal is Not Null) Then
     Insert into Hospital_Fund(Oldsum,Newsum,DateUpdated,UserLogged) values(@prevTotal,@prevTotal+NEW.Total,now(),user());
     Else
     Insert into Hospital_Fund(Oldsum,Newsum,DateUpdated,UserLogged) values(0,NEW.Total,now(),user());
   END IF;
   END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `doctor` (
  `Id_Doc` int(11) NOT NULL AUTO_INCREMENT,
  `Fname` varchar(50) NOT NULL,
  `Lname` varchar(50) NOT NULL,
  `Gender` char(1) NOT NULL,
  `Department` varchar(50) NOT NULL,
  `Mobile_Num` varchar(50) NOT NULL,
  PRIMARY KEY (`Id_Doc`),
  KEY `Gender` (`Gender`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`Gender`) REFERENCES `gender_ref` (`gender`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (1,'Hary','Kane','M','Orthopadics','9038856379'),(2,'Akashmika','Dhar','F','Cardiologist','9433218912'),(3,'Sourav','Patel','M','Urologist','879621256'),(4,'Virat','Kohli','M','Dentist','879645879'),(5,'Praveen','Bhardwaj','M','Dermatologist','987456126'),(6,'Adam','Jackson','M','Physician','987456123'),(7,'Eden','Hazard','M','Physician','4138559865');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gender_ref`
--

DROP TABLE IF EXISTS `gender_ref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `gender_ref` (
  `Gender` char(1) NOT NULL,
  PRIMARY KEY (`Gender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gender_ref`
--

LOCK TABLES `gender_ref` WRITE;
/*!40000 ALTER TABLE `gender_ref` DISABLE KEYS */;
INSERT INTO `gender_ref` VALUES ('F'),('M');
/*!40000 ALTER TABLE `gender_ref` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hos_department`
--

DROP TABLE IF EXISTS `hos_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `hos_department` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `DepartmentName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hos_department`
--

LOCK TABLES `hos_department` WRITE;
/*!40000 ALTER TABLE `hos_department` DISABLE KEYS */;
INSERT INTO `hos_department` VALUES (1,'Reception'),(2,'Cook'),(3,'Supervisor'),(4,'Lab Administrator'),(5,'Nurse'),(6,'Cleaning');
/*!40000 ALTER TABLE `hos_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital_fund`
--

DROP TABLE IF EXISTS `hospital_fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `hospital_fund` (
  `OldSum` double DEFAULT NULL,
  `NewSum` double DEFAULT NULL,
  `DateUpdated` timestamp NULL DEFAULT NULL,
  `UserLogged` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital_fund`
--

LOCK TABLES `hospital_fund` WRITE;
/*!40000 ALTER TABLE `hospital_fund` DISABLE KEYS */;
INSERT INTO `hospital_fund` VALUES (0,7300,'2018-12-12 08:32:41','root@localhost'),(7300,11975,'2018-12-12 08:33:19','root@localhost'),(11975,12375,'2018-12-12 08:34:20','root@localhost'),(12375,13075,'2018-12-12 08:34:42','root@localhost'),(13075,13775,'2018-12-14 20:00:23','root@localhost');
/*!40000 ALTER TABLE `hospital_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inpatient`
--

DROP TABLE IF EXISTS `inpatient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `inpatient` (
  `PId` int(11) NOT NULL,
  `Doctor_Id` int(11) NOT NULL,
  `Room_Id` int(11) NOT NULL,
  `DateofAdmission` timestamp NULL DEFAULT NULL,
  `DateofDischarge` timestamp NULL DEFAULT NULL,
  `Remarks` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`PId`),
  KEY `Doctor_Id` (`Doctor_Id`),
  KEY `Room_Id` (`Room_Id`),
  CONSTRAINT `inpatient_ibfk_1` FOREIGN KEY (`PId`) REFERENCES `person` (`pid`),
  CONSTRAINT `inpatient_ibfk_2` FOREIGN KEY (`Doctor_Id`) REFERENCES `doctor` (`id_doc`),
  CONSTRAINT `inpatient_ibfk_3` FOREIGN KEY (`Room_Id`) REFERENCES `room` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inpatient`
--

LOCK TABLES `inpatient` WRITE;
/*!40000 ALTER TABLE `inpatient` DISABLE KEYS */;
INSERT INTO `inpatient` VALUES (1,1,1,'2017-12-04 07:45:41','2017-12-02 06:54:41','Needs to be Operated due to gland enlargement'),(2,6,2,'2018-01-04 07:45:41','2018-01-28 08:54:41','Needs surgery due to tissue tear');
/*!40000 ALTER TABLE `inpatient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_administrator`
--

DROP TABLE IF EXISTS `lab_administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `lab_administrator` (
  `LabAdmin_Id` int(11) NOT NULL,
  `Lab_Department` varchar(50) NOT NULL,
  PRIMARY KEY (`LabAdmin_Id`),
  CONSTRAINT `lab_administrator_ibfk_1` FOREIGN KEY (`LabAdmin_Id`) REFERENCES `staff` (`id_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_administrator`
--

LOCK TABLES `lab_administrator` WRITE;
/*!40000 ALTER TABLE `lab_administrator` DISABLE KEYS */;
INSERT INTO `lab_administrator` VALUES (7,'Blood Test'),(8,'Haematology');
/*!40000 ALTER TABLE `lab_administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_report`
--

DROP TABLE IF EXISTS `lab_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `lab_report` (
  `LabReport_Num` int(11) NOT NULL AUTO_INCREMENT,
  `PId` int(11) NOT NULL,
  `Weight` double NOT NULL,
  `Doctor_Id` int(11) NOT NULL,
  `Date_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Lab_Admin` int(11) NOT NULL,
  `Amount` double NOT NULL,
  `Patient_Status` varchar(20) NOT NULL,
  PRIMARY KEY (`LabReport_Num`),
  KEY `Doctor_Id` (`Doctor_Id`),
  KEY `PId` (`PId`),
  KEY `Lab_Admin` (`Lab_Admin`),
  CONSTRAINT `lab_report_ibfk_1` FOREIGN KEY (`Doctor_Id`) REFERENCES `doctor` (`id_doc`),
  CONSTRAINT `lab_report_ibfk_2` FOREIGN KEY (`PId`) REFERENCES `person` (`pid`),
  CONSTRAINT `lab_report_ibfk_3` FOREIGN KEY (`Lab_Admin`) REFERENCES `lab_administrator` (`labadmin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_report`
--

LOCK TABLES `lab_report` WRITE;
/*!40000 ALTER TABLE `lab_report` DISABLE KEYS */;
INSERT INTO `lab_report` VALUES (1001,1,45,1,'2018-12-12 06:54:41',7,400,'Inpatient'),(1002,2,65,6,'2018-12-12 06:55:43',8,200,'Inpatient'),(1003,3,48,5,'2018-12-12 06:56:38',8,100,'Outpatient'),(1004,4,52,2,'2018-12-12 06:58:36',8,150,'Outpatient');
/*!40000 ALTER TABLE `lab_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outpatient`
--

DROP TABLE IF EXISTS `outpatient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `outpatient` (
  `PId` int(11) NOT NULL,
  `Doctor_Id` int(11) NOT NULL,
  `Date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Remarks` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`PId`),
  KEY `Doctor_Id` (`Doctor_Id`),
  CONSTRAINT `outpatient_ibfk_1` FOREIGN KEY (`PId`) REFERENCES `person` (`pid`),
  CONSTRAINT `outpatient_ibfk_2` FOREIGN KEY (`Doctor_Id`) REFERENCES `doctor` (`id_doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outpatient`
--

LOCK TABLES `outpatient` WRITE;
/*!40000 ALTER TABLE `outpatient` DISABLE KEYS */;
INSERT INTO `outpatient` VALUES (3,5,'2018-12-12 07:20:42','Needs paracetamol and adequate water'),(4,2,'2018-12-12 07:20:42','Take Allegra for 7 days');
/*!40000 ALTER TABLE `outpatient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `person` (
  `PId` int(11) NOT NULL AUTO_INCREMENT,
  `Fname` varchar(50) NOT NULL,
  `Lname` varchar(50) NOT NULL DEFAULT 'LNU',
  `Gender` char(1) NOT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Mob_Number` varchar(50) DEFAULT NULL,
  `Doc_Assigned` int(11) DEFAULT NULL,
  PRIMARY KEY (`PId`),
  KEY `Gender` (`Gender`),
  KEY `Doc_Assigned` (`Doc_Assigned`),
  KEY `Person_Index` (`PId`),
  CONSTRAINT `person_ibfk_1` FOREIGN KEY (`Gender`) REFERENCES `gender_ref` (`gender`) ON UPDATE CASCADE,
  CONSTRAINT `person_ibfk_2` FOREIGN KEY (`Doc_Assigned`) REFERENCES `doctor` (`id_doc`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Soumavo','Guria','M','214 A RRJ Road','4138009260',1),(2,'Ryad','Maharez','M','Manchester Road','4138965545',4),(3,'Nishi','Desai','F','18 Kolkata','41875462345',6),(4,'Sramana','Ghose','F','18 Ballygunge','4184587789',6);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `room` (
  `Room_Id` int(11) NOT NULL AUTO_INCREMENT,
  `Room_Name` varchar(50) NOT NULL,
  `Room_Rate_Per_Day` double DEFAULT NULL,
  PRIMARY KEY (`Room_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,'AC Deluxe',400),(2,'Standard',300),(3,'Economy',150);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `staff` (
  `Id_Num` int(11) NOT NULL AUTO_INCREMENT,
  `Fname` varchar(50) NOT NULL,
  `LName` varchar(50) NOT NULL,
  `Department_Num` int(11) DEFAULT NULL,
  `Doj` datetime NOT NULL,
  `Gender` char(1) NOT NULL,
  `Address` varchar(150) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Phone` varchar(90) NOT NULL,
  `Hourly_Rate` double NOT NULL,
  `Hours_Worked` double NOT NULL,
  `Total` double GENERATED ALWAYS AS ((`Hourly_Rate` * `Hours_Worked`)) VIRTUAL NOT NULL,
  PRIMARY KEY (`Id_Num`),
  KEY `Gender` (`Gender`),
  KEY `Department_Num` (`Department_Num`),
  KEY `Staff_Index` (`Phone`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`Gender`) REFERENCES `gender_ref` (`gender`) ON UPDATE CASCADE,
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`Department_Num`) REFERENCES `hos_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` (`Id_Num`, `Fname`, `LName`, `Department_Num`, `Doj`, `Gender`, `Address`, `Email`, `Phone`, `Hourly_Rate`, `Hours_Worked`) VALUES (1,'Akhil','Sachdeva',1,'2016-12-11 10:59:51','M','17 Tremont Street','akhil@gmail.com','4138009260',11,20),(2,'Anurag','Dhar',1,'2015-10-11 08:55:51','M','16 Burney Street','dhar@gmail.com','4138006212',18,25),(3,'Prathamesh','Landekar',2,'2014-10-11 08:55:51','M','14 Huntington Street','landekar@gmail.com','4138001111',12,30),(4,'Prashant','Sawale',2,'2014-08-19 09:55:51','M','14 Roxbury','prashant@gmail.com','4138000825',12,36),(5,'Anay','Arun',3,'2013-08-16 14:55:50','M','14 Columbia','anay@rediff.com','6498000825',30,36),(6,'Rohan','Magare',3,'2011-08-16 14:55:50','M','14 Columbia','rohan@rediff.com','6998000825',30,40),(7,'Ashish','Jaiswal',4,'2015-08-16 18:55:50','M','14 Fenway','ash@yahoo.com','7418000825',25,35),(8,'Ranit','Mridha',4,'2016-08-16 20:55:50','M','14 Boylston','forloveranit@yahoo.com','8148000825',25,40),(9,'Sujata','Deb',5,'2014-10-26 18:55:50','F','14 Allstate','sujata@yahoo.com','6137008025',18,35),(10,'Surbhi','Bhatnagar',5,'2013-09-22 14:55:50','F','19 Roxbury','bhatnagar@yahoo.com','6987008025',18,25),(11,'Arijit','Pal',6,'2012-09-22 14:55:50','M','18 Silpara','apal@yahoo.com','6987008025',10,25),(12,'Subham','Sarkar',6,'2016-08-14 12:55:50','M','17 Jadavpur','ssarkar@yahoo.com','6987008017',10,15);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supervisor`
--

DROP TABLE IF EXISTS `supervisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `supervisor` (
  `SupId` int(11) NOT NULL,
  `PId` int(11) NOT NULL,
  `Nurse_Allocated` int(11) NOT NULL,
  `Cook_Allocated` int(11) NOT NULL,
  `CleaningStaff_Allocated` int(11) NOT NULL,
  PRIMARY KEY (`SupId`,`PId`),
  KEY `PId` (`PId`),
  KEY `Nurse_Allocated` (`Nurse_Allocated`),
  KEY `Cook_Allocated` (`Cook_Allocated`),
  KEY `CleaningStaff_Allocated` (`CleaningStaff_Allocated`),
  CONSTRAINT `supervisor_ibfk_1` FOREIGN KEY (`SupId`) REFERENCES `staff` (`id_num`),
  CONSTRAINT `supervisor_ibfk_2` FOREIGN KEY (`PId`) REFERENCES `inpatient` (`pid`),
  CONSTRAINT `supervisor_ibfk_3` FOREIGN KEY (`Nurse_Allocated`) REFERENCES `staff` (`id_num`),
  CONSTRAINT `supervisor_ibfk_4` FOREIGN KEY (`Cook_Allocated`) REFERENCES `staff` (`id_num`),
  CONSTRAINT `supervisor_ibfk_5` FOREIGN KEY (`CleaningStaff_Allocated`) REFERENCES `staff` (`id_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supervisor`
--

LOCK TABLES `supervisor` WRITE;
/*!40000 ALTER TABLE `supervisor` DISABLE KEYS */;
INSERT INTO `supervisor` VALUES (5,1,9,4,11),(6,2,10,3,12);
/*!40000 ALTER TABLE `supervisor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `weekly_total_hours_cost_check`
--

DROP TABLE IF EXISTS `weekly_total_hours_cost_check`;
/*!50001 DROP VIEW IF EXISTS `weekly_total_hours_cost_check`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `weekly_total_hours_cost_check` AS SELECT 
 1 AS `departmentname`,
 1 AS `hourly_rate`,
 1 AS `Total_Hours`,
 1 AS `Total_Cost`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'soumavo'
--

--
-- Dumping routines for database 'soumavo'
--
/*!50003 DROP FUNCTION IF EXISTS `GETFULLNAME` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `GETFULLNAME`(fname CHAR(250),lname CHAR(250)) RETURNS char(250) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
        DECLARE fullname CHAR(250);
        SET fullname=CONCAT(fname,' ',lname);
        RETURN fullname;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Details_Through_Number` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Details_Through_Number`(In MobileNum varchar(30))
Begin
Select concat_ws(' ',p.fname,p.lname) as Full_Name,p.gender,p.address,concat_ws(' ',d.fname,d.lname) as Doctor_Name,
d.department,l.patient_status,concat_ws(' ',s.fname,s.lname) as Lab_Admin
from person p inner join doctor d
on p.Doc_Assigned=d.Id_doc
inner join lab_report l
on p.Doc_Assigned= l.Doctor_Id
inner join Lab_administrator ladmin
on l.lab_admin=ladmin.labadmin_id
inner join staff s on s.id_num=ladmin.labadmin_id 
where s.Department_Num = '4'
and p.mob_number=MobileNum;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `weekly_total_hours_cost_check`
--

/*!50001 DROP VIEW IF EXISTS `weekly_total_hours_cost_check`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `weekly_total_hours_cost_check` AS select `hos_department`.`DepartmentName` AS `departmentname`,`staff`.`Hourly_Rate` AS `hourly_rate`,sum(`staff`.`Hours_Worked`) AS `Total_Hours`,sum(`staff`.`Total`) AS `Total_Cost` from (`staff` join `hos_department` on((`staff`.`Department_Num` = `hos_department`.`Id`))) group by `hos_department`.`DepartmentName` with rollup having (sum(`staff`.`Hours_Worked`) > 20) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-22 18:21:31
