-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 10, 2024 at 11:33 AM
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
  `Staff` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `Password`, `Username`, `Age`, `Gender`, `eMail`, `Score`, `Skin`, `Staff`) VALUES
(1, '11223344', 'Nodislav_Aleksienko', 17, 1, 'dino@mailer.com', 1, 303, 4),
(2, '11223344', 'Zeks_Antifriz', 65, 2, 'zika@iberzokna.zimesugumske', 1, 91, 0),
(3, '12345678', 'Rus.kgb', 60, 1, 'fuck@off.com', 1, 303, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
