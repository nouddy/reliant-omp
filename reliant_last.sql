-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 15, 2024 at 10:32 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `reliant`
--

-- --------------------------------------------------------

--
-- Table structure for table `business`
--

CREATE TABLE `business` (
  `BusinessID` int(11) NOT NULL,
  `BusinessOwner` int(11) NOT NULL,
  `BusinessName` varchar(64) NOT NULL,
  `BusinessLocked` int(11) NOT NULL,
  `BusinessMoney` int(11) NOT NULL,
  `BusinessVW` int(11) NOT NULL,
  `BusinessType` float NOT NULL,
  `BusinessPrice` float NOT NULL,
  `BusinessEntrance_X` float NOT NULL,
  `BusinessEntrance_Y` float NOT NULL,
  `BusinessEntrance_Z` float NOT NULL,
  `BusinessExit_X` float NOT NULL,
  `BusinessExit_Y` float NOT NULL,
  `BusinessExit_Z` float NOT NULL,
  `BusinessInteract_X` float NOT NULL,
  `BusinessInteract_Y` float NOT NULL,
  `BusinessInteract_Z` float NOT NULL,
  `BusinessProducts` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `business`
--

INSERT INTO `business` (`BusinessID`, `BusinessOwner`, `BusinessName`, `BusinessLocked`, `BusinessMoney`, `BusinessVW`, `BusinessType`, `BusinessPrice`, `BusinessEntrance_X`, `BusinessEntrance_Y`, `BusinessEntrance_Z`, `BusinessExit_X`, `BusinessExit_Y`, `BusinessExit_Z`, `BusinessInteract_X`, `BusinessInteract_Y`, `BusinessInteract_Z`, `BusinessProducts`) VALUES
(1, -1, '0', 1, 0, 1, 1, 0, 162.178, -169.923, 1.58472, 6.08, -28.89, 1003.54, 162.178, -169.923, 1.58472, 0);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `PlayerID` int(11) NOT NULL,
  `ItemID` int(11) NOT NULL,
  `ItemQuantity` int(11) NOT NULL,
  `ItemType` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`PlayerID`, `ItemID`, `ItemQuantity`, `ItemType`) VALUES
(4, 24, 90, 2);

-- --------------------------------------------------------

--
-- Table structure for table `player_property`
--

CREATE TABLE `player_property` (
  `PlayerID` int(11) NOT NULL,
  `BusinessID` int(11) NOT NULL,
  `HouseID` int(11) NOT NULL,
  `ApartmentID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player_property`
--

INSERT INTO `player_property` (`PlayerID`, `BusinessID`, `HouseID`, `ApartmentID`) VALUES
(1, -1, -1, -1),
(4, -1, -1, -1),
(9, -1, -1, -1);

-- --------------------------------------------------------

--
-- Table structure for table `staff_questions`
--

CREATE TABLE `staff_questions` (
  `ID` int(11) NOT NULL,
  `PlayerID` int(11) NOT NULL,
  `Question` varchar(246) NOT NULL,
  `Date` varchar(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `Password` varchar(64) NOT NULL DEFAULT 'password1234',
  `Username` varchar(24) NOT NULL DEFAULT 'John_Doe',
  `Age` int(11) NOT NULL DEFAULT 18,
  `Gender` int(11) NOT NULL DEFAULT 1,
  `eMail` varchar(128) NOT NULL DEFAULT 'user.user@gmail.com',
  `Score` int(11) NOT NULL DEFAULT 1,
  `Skin` int(11) NOT NULL DEFAULT 24,
  `Staff` int(11) NOT NULL DEFAULT 0,
  `Money` int(11) NOT NULL,
  `Introduction` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `Password`, `Username`, `Age`, `Gender`, `eMail`, `Score`, `Skin`, `Staff`, `Money`, `Introduction`) VALUES
(1, 'djkramak', 'Eros_Bosandzeros', 18, 1, 'zdravkocolic@skibidi.rizzler', 1, 303, 0, 3500, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`BusinessID`);

--
-- Indexes for table `player_property`
--
ALTER TABLE `player_property`
  ADD UNIQUE KEY `uSQLID` (`PlayerID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `BusinessID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
