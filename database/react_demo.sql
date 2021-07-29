-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 29, 2021 at 12:56 PM
-- Server version: 5.7.15-log
-- PHP Version: 5.6.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `react_demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `user_code` varchar(50) NOT NULL,
  `user_prename` varchar(10) NOT NULL COMMENT 'คำนำหน้าชื่อ',
  `user_name` varchar(50) NOT NULL COMMENT 'ชื่อ',
  `user_lastname` varchar(50) NOT NULL COMMENT 'สกุล',
  `user_username` varchar(50) NOT NULL COMMENT 'ชื่อ ID ที่เข้า login',
  `user_password` varchar(15) NOT NULL COMMENT 'รหัสผ่านเข้าระบบ',
  `user_type_code` int(11) NOT NULL COMMENT 'สิทธิการเข้าใช้งานระบบ',
  `user_active` varchar(5) NOT NULL COMMENT 'สถานะของผู้ใช้',
  `user_image` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`user_code`, `user_prename`, `user_name`, `user_lastname`, `user_username`, `user_password`, `user_type_code`, `user_active`, `user_image`) VALUES
('US20210001', 'นาย', 'อาทิตย์', 'ไกรนอก', 'admin', '123456', 0, '1', '');

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_type`
--

CREATE TABLE `tb_user_type` (
  `user_type_code` varchar(50) NOT NULL COMMENT 'รหัสประเภทสิทธิการเข้าใช้งานระบบ',
  `user_type_name` varchar(45) DEFAULT NULL COMMENT 'ชื่อสิทธิการเข้าใช้งานระบบ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_user_type`
--

INSERT INTO `tb_user_type` (`user_type_code`, `user_type_name`) VALUES
('UT001', 'Admin'),
('UT002', 'พนักงาน');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`user_code`);

--
-- Indexes for table `tb_user_type`
--
ALTER TABLE `tb_user_type`
  ADD PRIMARY KEY (`user_type_code`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
