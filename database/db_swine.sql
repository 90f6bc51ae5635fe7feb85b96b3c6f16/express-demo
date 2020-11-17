-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 17, 2020 at 09:56 AM
-- Server version: 5.7.17-log
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_swine`
--

-- --------------------------------------------------------

--
-- Table structure for table `notify_device`
--

CREATE TABLE `notify_device` (
  `farm_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `house_device_data_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'เก็บค่า วัน/เวลา เมื่อฝั่ง hardware ส่งค่าเข้ามา',
  `house_device_data_values` varchar(45) DEFAULT NULL COMMENT 'เก็บค่าที่ sensor วัดได้',
  `house_device_data_num` int(11) DEFAULT NULL COMMENT 'ลำดับจำนวน sensor ที่อยู่ในจุดติดตั่งนั้นๆ (station)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_device`
--

CREATE TABLE `tb_device` (
  `device_id` int(15) NOT NULL COMMENT 'รหัส sensor (ที่จะอยู่ภายในจุดติดตั้ง[Station] )',
  `device_name_en` varchar(50) DEFAULT NULL COMMENT 'ชื่อ sensor ภาษา eng',
  `device_name_th` varchar(50) DEFAULT NULL COMMENT 'ชื่อ sensor ภาษา ไทย',
  `device_unit` varchar(10) DEFAULT NULL COMMENT 'หน่วยของค่าที่วัดได้จาก sensor',
  `device_value_min` varchar(45) DEFAULT NULL COMMENT 'ค่าต่ำสุดของ sensor ที่วัดได้ (เพื่อตรวจจับความผิดปกติของ sensor)',
  `device_value_max` varchar(45) DEFAULT NULL COMMENT 'ค่าสูงสุดของ sensor ที่วัดได้ (เพื่อตรวจจับความผิดปกติของ sensor)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='sensor list';

-- --------------------------------------------------------

--
-- Table structure for table `tb_farm`
--

CREATE TABLE `tb_farm` (
  `farm_id` int(15) NOT NULL COMMENT 'รหัสฟาร์ม\n',
  `farm_name_en` varchar(50) DEFAULT NULL COMMENT 'ชื่อฟาร์ม ไทย',
  `farm_name_th` varchar(50) DEFAULT NULL COMMENT 'ชื่อฟาร์ม eng',
  `farm_address` varchar(200) DEFAULT NULL COMMENT 'ที่อยู่ฟาม',
  `farm_owner` varchar(50) DEFAULT NULL COMMENT 'ชื่อเจ้าของฟาม',
  `farm_phone` varchar(10) DEFAULT NULL COMMENT 'เบอร์ติดต่อฟาม',
  `farm_lat` varchar(45) DEFAULT NULL COMMENT '\nLatitude',
  `farm_lon` varchar(45) DEFAULT NULL COMMENT 'Longitude',
  `farm_registration` timestamp NULL DEFAULT NULL COMMENT 'วัน/เวลา ที่สมัครเข้าเป็นสมาชิกของ website'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_farm`
--

INSERT INTO `tb_farm` (`farm_id`, `farm_name_en`, `farm_name_th`, `farm_address`, `farm_owner`, `farm_phone`, `farm_lat`, `farm_lon`, `farm_registration`) VALUES
(1, 's', 's', 's', 's', 's', 's', 's', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_feed_cost`
--

CREATE TABLE `tb_feed_cost` (
  `feed_cost_id` int(11) NOT NULL COMMENT 'รหัสการรับอาหาร',
  `generation_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `farm_id` int(11) NOT NULL,
  `feed_cost_name` varchar(45) DEFAULT NULL COMMENT 'ชื่ออาหารที่รับเข้า',
  `feed_cost_values` float DEFAULT NULL COMMENT 'จำนวนเงิน / กก',
  `feed_cost_num` float DEFAULT NULL COMMENT 'จำนวนอาหารที่รับเข้า',
  `feed_cost_bill` varchar(45) DEFAULT NULL COMMENT 'เลขที่บิลที่รับเข้า',
  `feed_cost_date` date DEFAULT NULL COMMENT 'วันที่รับเข้า',
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_finance_debit_list`
--

CREATE TABLE `tb_finance_debit_list` (
  `finance_debit_list_code` varchar(100) NOT NULL COMMENT 'รหัสอ้างอิงรายการใบรับชำระหนี้',
  `finance_debit_code` varchar(50) NOT NULL COMMENT 'รหัสรายการใบรับชำระหนี้',
  `invoice_customer_code` varchar(50) NOT NULL COMMENT 'รหัสอ้างอิงใบกำกับภาษี',
  `credit_note_code` varchar(50) NOT NULL COMMENT 'รหัสอ้างอิงใบลดหนี้',
  `debit_note_code` varchar(50) NOT NULL COMMENT 'หมายเลขใบเพิ่มหนี้',
  `finance_debit_list_billing` varchar(100) NOT NULL COMMENT 'หมายเลขใบวางบิล',
  `finance_debit_list_receipt` varchar(100) NOT NULL COMMENT 'หมายเลขใบเสร็จ',
  `finance_debit_list_amount` double NOT NULL COMMENT 'จำนวนเงินรวม',
  `finance_debit_list_paid` double NOT NULL COMMENT 'จำนวนเงินที่จ่าย',
  `finance_debit_list_balance` double NOT NULL COMMENT 'ยอดคงเหลือ',
  `finance_debit_list_remark` varchar(200) NOT NULL COMMENT 'หมายเหตุ',
  `billing_note_list_code` varchar(100) NOT NULL COMMENT 'รหัสใบวางบิล',
  `addby` varchar(50) NOT NULL COMMENT 'ผู้เพิ่มข้อมูล',
  `adddate` datetime DEFAULT NULL COMMENT 'วันที่เพิ่มข้อมูล',
  `updateby` varchar(50) NOT NULL COMMENT 'ผู้แก้ไขข้อมูล',
  `lastupdate` datetime DEFAULT NULL COMMENT 'วันที่แก้ไขข้อมูล'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_finance_debit_list`
--

INSERT INTO `tb_finance_debit_list` (`finance_debit_list_code`, `finance_debit_code`, `invoice_customer_code`, `credit_note_code`, `debit_note_code`, `finance_debit_list_billing`, `finance_debit_list_receipt`, `finance_debit_list_amount`, `finance_debit_list_paid`, `finance_debit_list_balance`, `finance_debit_list_remark`, `billing_note_list_code`, `addby`, `adddate`, `updateby`, `lastupdate`) VALUES
('CN051120000109330', 'CN0511200001', 'INV201102001', '', '', '-', '', 25680, 0, 12000, '', '', '', '2020-11-05 09:33:49', '', NULL),
('CN0511200003', 'CN0511200003', 'INV201102001', '', '', '-', '', 25680, 12000, 3680, '', '', '', '2020-11-05 09:34:36', '', NULL),
('CN051120000309350', 'CN0511200003', 'INV201102001', '', '', '-', '', 25680, 15680, 10000, '', '', '', '2020-11-05 09:35:07', '', NULL),
('CN151020000115530', 'CN1510200001', 'CN0511200003', '', '', '-', '', 16050, 0, 16050, '', '', '', '2020-10-15 15:53:54', '', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_generation`
--

CREATE TABLE `tb_generation` (
  `generation_id` int(11) NOT NULL COMMENT ' รหัสข้อมูลรุ่นหมู',
  `farm_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `generation_name` varchar(45) DEFAULT NULL COMMENT 'ชื้อรุ่นหมู',
  `swine_type_id` int(11) DEFAULT NULL COMMENT 'รหัสประเภทหมู',
  `swine_species_id` int(11) DEFAULT NULL,
  `generation_datein` timestamp NULL DEFAULT NULL COMMENT 'วัน/เวลา ที่หมูเข้าโรงเรื่อน',
  `generation_dateout` timestamp NULL DEFAULT NULL COMMENT 'วัน/เวลา ที่หมูออกโรงเรื่อน',
  `generation_num_in` int(11) DEFAULT NULL COMMENT 'จำนวนที่หมูเข้าโรงเรื่อน',
  `generation_swine_claim` int(11) DEFAULT NULL COMMENT 'จำนวนที่เคลมหมูที่ผิดปกติ',
  `generation_age_in` int(11) DEFAULT NULL COMMENT 'อายุก่อนที่หมูเข้าโรงเรื่อน (นับเป็นวัน)',
  `generation_weight_in` int(11) DEFAULT NULL COMMENT 'น้ำหนักชังตอนเข้าโรงเรื่อน',
  `user_id` int(11) DEFAULT NULL COMMENT 'รหัสผู้ดูแลหมูรุ่นนั่นๆ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_house`
--

CREATE TABLE `tb_house` (
  `house_id` int(15) NOT NULL,
  `farm_id` int(11) NOT NULL COMMENT 'รหัสโรงเรื่อนภายในฟาม',
  `house_name` int(15) DEFAULT NULL COMMENT 'ชื่อโรงเรื่อนภายในฟาม',
  `swine_type_id` int(15) DEFAULT NULL COMMENT 'รหัสประเภท(พันธ์)หมูที่เลี้ยงภายในโรงเรื่อนนั้นๆ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_house_device`
--

CREATE TABLE `tb_house_device` (
  `house_device_id` int(11) NOT NULL COMMENT 'ลำดับของ sensor ภายในจุดติดตั้งนั้น ๆ (station)',
  `farm_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_notify_device`
--

CREATE TABLE `tb_notify_device` (
  `notify_device_id` int(11) NOT NULL,
  `farm_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `device_id` int(11) NOT NULL,
  `notify_device_max` float DEFAULT NULL COMMENT 'ขอบเขตค่าสูงสุด',
  `notify_device_min` float DEFAULT NULL COMMENT 'ขอบเขตค่าต่ำสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_page`
--

CREATE TABLE `tb_page` (
  `page_id` int(11) NOT NULL,
  `page_name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_page_user_type`
--

CREATE TABLE `tb_page_user_type` (
  `page_user_type_id` int(11) NOT NULL COMMENT 'รหัสประเภทสิทธ์การเข้าถึง\n',
  `tb_page_id` int(11) NOT NULL COMMENT 'รหัสหน้าการเข้าถึง\n',
  `tb_page_user_type_view` varchar(45) DEFAULT NULL COMMENT 'สิทธ์การดู',
  `tb_page_user_type_add` varchar(45) DEFAULT NULL COMMENT 'สิทธ์การเพิ่ม',
  `tb_page_user_type_edit` varchar(45) DEFAULT NULL COMMENT 'สิทธ์การแก้ไข',
  `tb_page_user_type_delete` varchar(45) DEFAULT NULL COMMENT 'สิทธ์การลบ',
  `tb_page_user_type_approve` varchar(45) DEFAULT NULL COMMENT 'สิทธ์การอนุมัติ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_performance_feed`
--

CREATE TABLE `tb_performance_feed` (
  `feed_id` int(11) NOT NULL COMMENT 'รหัสข้อมูลประสิทธิภาพการกินอาหาร',
  `generation_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `farm_id` int(11) NOT NULL,
  `performance_feed_date` date DEFAULT NULL COMMENT 'วันที่ของค่าประสิทธิภาพนั้นๆ',
  `performance_feed_week` int(11) DEFAULT NULL COMMENT 'สัปดาห์การเลี้ยงของหมู',
  `performance_feed_before` float DEFAULT NULL COMMENT 'ค่าของวันก่อนหน้าที่ยกยอดมา',
  `performance_feed_in` float DEFAULT NULL COMMENT 'ค่าอาหารเข้าเล้า',
  `performance_feed_use` float DEFAULT NULL COMMENT 'ค่าอาหารที่ใช้ไป',
  `performance_feed_move_out` float DEFAULT NULL COMMENT 'ค่าอาหารที่ย้ายออกไป',
  `performance_feed_move_in` float DEFAULT NULL COMMENT 'ค่าอาหารที่ย้ายเข้ามา',
  `performance_feed_avg_per_swine` float DEFAULT NULL COMMENT 'ค่าเฉลี่ยการกิน/ตัว',
  `performance_feed_timestamp` timestamp NULL DEFAULT NULL COMMENT 'วัน/เวลา ในการบันทึกข้อมูล',
  `performance_feed_remark` varchar(100) DEFAULT NULL COMMENT 'หมายเหตุ',
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_performance_swine`
--

CREATE TABLE `tb_performance_swine` (
  `performance_swine` int(11) NOT NULL COMMENT 'รหัสข้อมูลจำนวนหมูคงเหลือ',
  `generation_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `farm_id` int(11) NOT NULL,
  `performance_swine_date` date DEFAULT NULL COMMENT 'วันที่ของค่าประสิทธิภาพนั้นๆ',
  `performance_swine_before` int(11) DEFAULT NULL COMMENT 'จำนวนหมูวันก่อนหน้า',
  `performance_swine_die` int(11) DEFAULT NULL COMMENT 'จำนวนหมูตาย',
  `performance_swine_issue` int(11) DEFAULT NULL COMMENT 'จำนวนหมูที่มีปัญหา',
  `performance_swine_sale` int(11) DEFAULT NULL COMMENT 'จำนวนหมูที่ขาย',
  `performance_swine_balance` int(11) DEFAULT NULL COMMENT 'จำนวนหมูคงเหลือ',
  `performance_swine_timestamp` timestamp NULL DEFAULT NULL COMMENT 'วัน/เวลา ในการบันทึกข้อมูล',
  `performance_swine_remark` varchar(100) DEFAULT NULL COMMENT 'หมายเหตุ',
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_standard_feed`
--

CREATE TABLE `tb_standard_feed` (
  `standard_feed_id` int(11) NOT NULL,
  `farm_id` int(11) DEFAULT NULL,
  `swine_type_id` int(11) DEFAULT NULL,
  `swine_species_id` int(11) DEFAULT NULL,
  `standard_feed_name` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_standart_feed_data`
--

CREATE TABLE `tb_standart_feed_data` (
  `standart_feed_id` int(11) NOT NULL COMMENT 'รหัสชุดค่ามาตรฐาน\n',
  `standart_feed_data_week` int(11) NOT NULL COMMENT 'สัปดาห์ของค่ามาตรฐาน',
  `standart_feed_data_feedname` varchar(45) DEFAULT NULL COMMENT 'ชื่ออาหารที่ใช้ในสัปดาห์นั้นๆ',
  `standart_feed_eat_daily` float DEFAULT NULL COMMENT 'ค่าเฉลี่ยอัตราการกินอาหารต่อวัน ในสัปดาห์นั้นๆ',
  `standart_feed_eat_sum` float DEFAULT NULL COMMENT 'อัตราค่าการกินอาหารสะสม ในสัปดาห์นั้นๆ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_station`
--

CREATE TABLE `tb_station` (
  `station_id` int(11) NOT NULL COMMENT 'รหัสจำนวนจุดติดตั้ง(node)',
  `station_name` varchar(45) DEFAULT NULL COMMENT 'ชื่อจำนวนจุดติดตั้ง(node)',
  `station_remark` varchar(45) DEFAULT NULL COMMENT 'หมายเหตุ // comments'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_swine_species`
--

CREATE TABLE `tb_swine_species` (
  `swine_species_id` int(11) NOT NULL COMMENT 'รหัสสายพันธุ์หมู\n',
  `swine_species_name` varchar(45) DEFAULT NULL COMMENT 'ชื่อสายพันธุ์หมู\n'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_swine_type`
--

CREATE TABLE `tb_swine_type` (
  `swine_type_id` int(11) NOT NULL COMMENT 'รหัสประเภท(พันธ์)หมูที่เลี้ยงภายในโรงเรื่อนนั้นๆ',
  `swine_type_name` varchar(45) DEFAULT NULL COMMENT 'ชื่อประเภท(พันธ์)หมูที่เลี้ยงภายในโรงเรื่อนนั้นๆ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `user_id` int(15) NOT NULL COMMENT 'ลำดับ account',
  `user_prename` varchar(10) NOT NULL COMMENT 'คำนำหน้าชื่อ',
  `user_name` varchar(50) NOT NULL COMMENT 'ชื่อ',
  `user_lastname` varchar(50) NOT NULL COMMENT 'สกุล',
  `user_username` varchar(50) NOT NULL COMMENT 'ชื่อ ID ที่เข้า login',
  `user_password` varchar(15) NOT NULL COMMENT 'รหัสผ่านเข้าระบบ',
  `user_type_id` int(11) NOT NULL COMMENT 'สิทธิการเข้าใช้งานระบบ',
  `user_active` varchar(5) NOT NULL COMMENT 'สถานะของผู้ใช้',
  `farm_id` int(15) NOT NULL COMMENT 'รหัสของฟาม'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`user_id`, `user_prename`, `user_name`, `user_lastname`, `user_username`, `user_password`, `user_type_id`, `user_active`, `farm_id`) VALUES
(1, 'นาย', 'อาทิตย์', 'ไกรนอก', 'admin', '123456', 1, '1', 1),
(2, 'นาย', 'อาทิตย์', 'ไกรนอก', 'admin2', '123456', 1, '1', 1),
(3, 'นาย', 'อาทิตย์', 'ไกรนอก', 'admin3', '123456', 1, '1', 1),
(8, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(9, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(10, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(11, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(12, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(13, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(14, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(15, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(16, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(17, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(18, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(19, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(20, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(21, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(22, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(23, 'Mr.', 'Artit', 'Krainok', 'Username', 'Password', 1, '0', 1),
(29, 'MM.', 'MMM', 'LLL', 'admin5', '1234566', 1, '0', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_user_type`
--

CREATE TABLE `tb_user_type` (
  `user_type_id` int(11) NOT NULL COMMENT 'รหัสประเภทสิทธิการเข้าใช้งานระบบ',
  `user_type_name` varchar(45) DEFAULT NULL COMMENT 'ชื่อสิทธิการเข้าใช้งานระบบ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_user_type`
--

INSERT INTO `tb_user_type` (`user_type_id`, `user_type_name`) VALUES
(1, 'admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `notify_device`
--
ALTER TABLE `notify_device`
  ADD PRIMARY KEY (`farm_id`,`house_id`,`station_id`,`device_id`,`house_device_data_timestamp`);

--
-- Indexes for table `tb_device`
--
ALTER TABLE `tb_device`
  ADD PRIMARY KEY (`device_id`);

--
-- Indexes for table `tb_farm`
--
ALTER TABLE `tb_farm`
  ADD PRIMARY KEY (`farm_id`);

--
-- Indexes for table `tb_feed_cost`
--
ALTER TABLE `tb_feed_cost`
  ADD PRIMARY KEY (`feed_cost_id`,`generation_id`,`house_id`,`farm_id`);

--
-- Indexes for table `tb_finance_debit_list`
--
ALTER TABLE `tb_finance_debit_list`
  ADD PRIMARY KEY (`finance_debit_list_code`);

--
-- Indexes for table `tb_generation`
--
ALTER TABLE `tb_generation`
  ADD PRIMARY KEY (`generation_id`,`farm_id`,`house_id`);

--
-- Indexes for table `tb_house`
--
ALTER TABLE `tb_house`
  ADD PRIMARY KEY (`house_id`,`farm_id`);

--
-- Indexes for table `tb_house_device`
--
ALTER TABLE `tb_house_device`
  ADD PRIMARY KEY (`house_device_id`,`farm_id`,`house_id`,`station_id`,`device_id`);

--
-- Indexes for table `tb_notify_device`
--
ALTER TABLE `tb_notify_device`
  ADD PRIMARY KEY (`notify_device_id`,`farm_id`,`house_id`,`device_id`);

--
-- Indexes for table `tb_page`
--
ALTER TABLE `tb_page`
  ADD PRIMARY KEY (`page_id`);

--
-- Indexes for table `tb_page_user_type`
--
ALTER TABLE `tb_page_user_type`
  ADD PRIMARY KEY (`page_user_type_id`,`tb_page_id`);

--
-- Indexes for table `tb_performance_feed`
--
ALTER TABLE `tb_performance_feed`
  ADD PRIMARY KEY (`feed_id`,`generation_id`,`house_id`,`farm_id`);

--
-- Indexes for table `tb_performance_swine`
--
ALTER TABLE `tb_performance_swine`
  ADD PRIMARY KEY (`performance_swine`,`generation_id`,`house_id`,`farm_id`);

--
-- Indexes for table `tb_standard_feed`
--
ALTER TABLE `tb_standard_feed`
  ADD PRIMARY KEY (`standard_feed_id`);

--
-- Indexes for table `tb_standart_feed_data`
--
ALTER TABLE `tb_standart_feed_data`
  ADD PRIMARY KEY (`standart_feed_data_week`,`standart_feed_id`);

--
-- Indexes for table `tb_station`
--
ALTER TABLE `tb_station`
  ADD PRIMARY KEY (`station_id`);

--
-- Indexes for table `tb_swine_species`
--
ALTER TABLE `tb_swine_species`
  ADD PRIMARY KEY (`swine_species_id`);

--
-- Indexes for table `tb_swine_type`
--
ALTER TABLE `tb_swine_type`
  ADD PRIMARY KEY (`swine_type_id`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `tb_user_type`
--
ALTER TABLE `tb_user_type`
  ADD PRIMARY KEY (`user_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_feed_cost`
--
ALTER TABLE `tb_feed_cost`
  MODIFY `feed_cost_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสการรับอาหาร';
--
-- AUTO_INCREMENT for table `tb_performance_feed`
--
ALTER TABLE `tb_performance_feed`
  MODIFY `feed_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสข้อมูลประสิทธิภาพการกินอาหาร';
--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `user_id` int(15) NOT NULL AUTO_INCREMENT COMMENT 'ลำดับ account', AUTO_INCREMENT=30;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
