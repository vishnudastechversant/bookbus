-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 15, 2022 at 08:12 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bus_reservation`
--

-- --------------------------------------------------------

--
-- Table structure for table `br_bookings`
--

CREATE TABLE `br_bookings` (
  `id` int(11) NOT NULL,
  `customer` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `seat_no` int(11) NOT NULL,
  `paid` int(11) NOT NULL COMMENT '1 > YES\r\n0 > NO\r\n',
  `status` int(11) NOT NULL COMMENT '0 > PENDING\r\n1 > SUCCESS\r\n2 > BOOKING CANCELLED',
  `booked_on` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `br_buses`
--

CREATE TABLE `br_buses` (
  `id` int(11) NOT NULL,
  `bus_name` varchar(25) NOT NULL,
  `bus_type` varchar(10) NOT NULL,
  `layout_type` int(11) DEFAULT NULL,
  `available_today` int(11) DEFAULT 1 COMMENT '0 > NO\r\n1 > YES \r\n',
  `no_of_seats` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `br_bus_routes`
--

CREATE TABLE `br_bus_routes` (
  `id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `route_from` varchar(50) NOT NULL,
  `route_to` varchar(50) NOT NULL,
  `departure_time` datetime NOT NULL,
  `arrival_time` datetime NOT NULL,
  `available_today` int(11) DEFAULT 1 COMMENT '0 NO\r\n1 YES\r\n',
  `daily_bus` int(11) DEFAULT 0 COMMENT '0 > NO, 1 > YES',
  `created_on` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `br_city`
--

CREATE TABLE `br_city` (
  `id` int(11) NOT NULL,
  `city` varchar(35) NOT NULL,
  `state_id` int(11) NOT NULL,
  `created_on` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `br_city`
--

INSERT INTO `br_city` (`id`, `city`, `state_id`, `created_on`) VALUES
(1, 'North and Middle Andaman', 32, '2022-02-15 12:41:00'),
(2, 'South Andaman', 32, '2022-02-15 12:41:00'),
(3, 'Nicobar', 32, '2022-02-15 12:41:00'),
(4, 'Adilabad', 1, '2022-02-15 12:41:00'),
(5, 'Anantapur', 1, '2022-02-15 12:41:00'),
(6, 'Chittoor', 1, '2022-02-15 12:41:00'),
(7, 'East Godavari', 1, '2022-02-15 12:41:00'),
(8, 'Guntur', 1, '2022-02-15 12:41:00'),
(9, 'Hyderabad', 1, '2022-02-15 12:41:00'),
(10, 'Kadapa', 1, '2022-02-15 12:41:00'),
(11, 'Karimnagar', 1, '2022-02-15 12:41:00'),
(12, 'Khammam', 1, '2022-02-15 12:41:00'),
(13, 'Krishna', 1, '2022-02-15 12:41:00'),
(14, 'Kurnool', 1, '2022-02-15 12:41:00'),
(15, 'Mahbubnagar', 1, '2022-02-15 12:41:00'),
(16, 'Medak', 1, '2022-02-15 12:41:00'),
(17, 'Nalgonda', 1, '2022-02-15 12:41:00'),
(18, 'Nellore', 1, '2022-02-15 12:41:00'),
(19, 'Nizamabad', 1, '2022-02-15 12:41:00'),
(20, 'Prakasam', 1, '2022-02-15 12:41:00'),
(21, 'Rangareddi', 1, '2022-02-15 12:41:00'),
(22, 'Srikakulam', 1, '2022-02-15 12:41:00'),
(23, 'Vishakhapatnam', 1, '2022-02-15 12:41:00'),
(24, 'Vizianagaram', 1, '2022-02-15 12:41:00'),
(25, 'Warangal', 1, '2022-02-15 12:41:00'),
(26, 'West Godavari', 1, '2022-02-15 12:41:00'),
(27, 'Anjaw', 3, '2022-02-15 12:41:00'),
(28, 'Changlang', 3, '2022-02-15 12:41:00'),
(29, 'East Kameng', 3, '2022-02-15 12:41:00'),
(30, 'Lohit', 3, '2022-02-15 12:41:00'),
(31, 'Lower Subansiri', 3, '2022-02-15 12:41:00'),
(32, 'Papum Pare', 3, '2022-02-15 12:41:00'),
(33, 'Tirap', 3, '2022-02-15 12:41:00'),
(34, 'Dibang Valley', 3, '2022-02-15 12:41:00'),
(35, 'Upper Subansiri', 3, '2022-02-15 12:41:00'),
(36, 'West Kameng', 3, '2022-02-15 12:41:00'),
(37, 'Barpeta', 2, '2022-02-15 12:41:00'),
(38, 'Bongaigaon', 2, '2022-02-15 12:41:00'),
(39, 'Cachar', 2, '2022-02-15 12:41:00'),
(40, 'Darrang', 2, '2022-02-15 12:41:00'),
(41, 'Dhemaji', 2, '2022-02-15 12:41:00'),
(42, 'Dhubri', 2, '2022-02-15 12:41:00'),
(43, 'Dibrugarh', 2, '2022-02-15 12:41:00'),
(44, 'Goalpara', 2, '2022-02-15 12:41:00'),
(45, 'Golaghat', 2, '2022-02-15 12:41:00'),
(46, 'Hailakandi', 2, '2022-02-15 12:41:00'),
(47, 'Jorhat', 2, '2022-02-15 12:41:00'),
(48, 'Karbi Anglong', 2, '2022-02-15 12:41:00'),
(49, 'Karimganj', 2, '2022-02-15 12:41:00'),
(50, 'Kokrajhar', 2, '2022-02-15 12:41:00'),
(51, 'Lakhimpur', 2, '2022-02-15 12:41:00'),
(52, 'Marigaon', 2, '2022-02-15 12:41:00'),
(53, 'Nagaon', 2, '2022-02-15 12:41:00'),
(54, 'Nalbari', 2, '2022-02-15 12:41:00'),
(55, 'North Cachar Hills', 2, '2022-02-15 12:41:00'),
(56, 'Sibsagar', 2, '2022-02-15 12:41:00'),
(57, 'Sonitpur', 2, '2022-02-15 12:41:00'),
(58, 'Tinsukia', 2, '2022-02-15 12:41:00'),
(59, 'Araria', 4, '2022-02-15 12:41:00'),
(60, 'Aurangabad', 4, '2022-02-15 12:41:00'),
(61, 'Banka', 4, '2022-02-15 12:41:00'),
(62, 'Begusarai', 4, '2022-02-15 12:41:00'),
(63, 'Bhagalpur', 4, '2022-02-15 12:41:00'),
(64, 'Bhojpur', 4, '2022-02-15 12:41:00'),
(65, 'Buxar', 4, '2022-02-15 12:41:00'),
(66, 'Darbhanga', 4, '2022-02-15 12:41:00'),
(67, 'Purba Champaran', 4, '2022-02-15 12:41:00'),
(68, 'Gaya', 4, '2022-02-15 12:41:00'),
(69, 'Gopalganj', 4, '2022-02-15 12:41:00'),
(70, 'Jamui', 4, '2022-02-15 12:41:00'),
(71, 'Jehanabad', 4, '2022-02-15 12:41:00'),
(72, 'Khagaria', 4, '2022-02-15 12:41:00'),
(73, 'Kishanganj', 4, '2022-02-15 12:41:00'),
(74, 'Kaimur', 4, '2022-02-15 12:41:00'),
(75, 'Katihar', 4, '2022-02-15 12:41:00'),
(76, 'Lakhisarai', 4, '2022-02-15 12:41:00'),
(77, 'Madhubani', 4, '2022-02-15 12:41:00'),
(78, 'Munger', 4, '2022-02-15 12:41:00'),
(79, 'Madhepura', 4, '2022-02-15 12:41:00'),
(80, 'Muzaffarpur', 4, '2022-02-15 12:41:00'),
(81, 'Nalanda', 4, '2022-02-15 12:41:00'),
(82, 'Nawada', 4, '2022-02-15 12:41:00'),
(83, 'Patna', 4, '2022-02-15 12:41:00'),
(84, 'Purnia', 4, '2022-02-15 12:41:00'),
(85, 'Rohtas', 4, '2022-02-15 12:41:00'),
(86, 'Saharsa', 4, '2022-02-15 12:41:00'),
(87, 'Samastipur', 4, '2022-02-15 12:41:00'),
(88, 'Sheohar', 4, '2022-02-15 12:41:00'),
(89, 'Sheikhpura', 4, '2022-02-15 12:41:00'),
(90, 'Saran', 4, '2022-02-15 12:41:00'),
(91, 'Sitamarhi', 4, '2022-02-15 12:41:00'),
(92, 'Supaul', 4, '2022-02-15 12:41:00'),
(93, 'Siwan', 4, '2022-02-15 12:41:00'),
(94, 'Vaishali', 4, '2022-02-15 12:41:00'),
(95, 'Pashchim Champaran', 4, '2022-02-15 12:41:00'),
(96, 'Bastar', 36, '2022-02-15 12:41:00'),
(97, 'Bilaspur', 36, '2022-02-15 12:41:00'),
(98, 'Dantewada', 36, '2022-02-15 12:41:00'),
(99, 'Dhamtari', 36, '2022-02-15 12:41:00'),
(100, 'Durg', 36, '2022-02-15 12:41:00'),
(101, 'Jashpur', 36, '2022-02-15 12:41:00'),
(102, 'Janjgir-Champa', 36, '2022-02-15 12:41:00'),
(103, 'Korba', 36, '2022-02-15 12:41:00'),
(104, 'Koriya', 36, '2022-02-15 12:41:00'),
(105, 'Kanker', 36, '2022-02-15 12:41:00'),
(106, 'Kawardha', 36, '2022-02-15 12:41:00'),
(107, 'Mahasamund', 36, '2022-02-15 12:41:00'),
(108, 'Raigarh', 36, '2022-02-15 12:41:00'),
(109, 'Rajnandgaon', 36, '2022-02-15 12:41:00'),
(110, 'Raipur', 36, '2022-02-15 12:41:00'),
(111, 'Surguja', 36, '2022-02-15 12:41:00'),
(112, 'Diu', 29, '2022-02-15 12:41:00'),
(113, 'Daman', 29, '2022-02-15 12:41:00'),
(114, 'Central Delhi', 25, '2022-02-15 12:41:00'),
(115, 'East Delhi', 25, '2022-02-15 12:41:00'),
(116, 'New Delhi', 25, '2022-02-15 12:41:00'),
(117, 'North Delhi', 25, '2022-02-15 12:41:00'),
(118, 'North East Delhi', 25, '2022-02-15 12:41:00'),
(119, 'North West Delhi', 25, '2022-02-15 12:41:00'),
(120, 'South Delhi', 25, '2022-02-15 12:41:00'),
(121, 'South West Delhi', 25, '2022-02-15 12:41:00'),
(122, 'West Delhi', 25, '2022-02-15 12:41:00'),
(123, 'North Goa', 26, '2022-02-15 12:41:00'),
(124, 'South Goa', 26, '2022-02-15 12:41:00'),
(125, 'Ahmedabad', 5, '2022-02-15 12:41:00'),
(126, 'Amreli District', 5, '2022-02-15 12:41:00'),
(127, 'Anand', 5, '2022-02-15 12:41:00'),
(128, 'Banaskantha', 5, '2022-02-15 12:41:00'),
(129, 'Bharuch', 5, '2022-02-15 12:41:00'),
(130, 'Bhavnagar', 5, '2022-02-15 12:41:00'),
(131, 'Dahod', 5, '2022-02-15 12:41:00'),
(132, 'The Dangs', 5, '2022-02-15 12:41:00'),
(133, 'Gandhinagar', 5, '2022-02-15 12:41:00'),
(134, 'Jamnagar', 5, '2022-02-15 12:41:00'),
(135, 'Junagadh', 5, '2022-02-15 12:41:00'),
(136, 'Kutch', 5, '2022-02-15 12:41:00'),
(137, 'Kheda', 5, '2022-02-15 12:41:00'),
(138, 'Mehsana', 5, '2022-02-15 12:41:00'),
(139, 'Narmada', 5, '2022-02-15 12:41:00'),
(140, 'Navsari', 5, '2022-02-15 12:41:00'),
(141, 'Patan', 5, '2022-02-15 12:41:00'),
(142, 'Panchmahal', 5, '2022-02-15 12:41:00'),
(143, 'Porbandar', 5, '2022-02-15 12:41:00'),
(144, 'Rajkot', 5, '2022-02-15 12:41:00'),
(145, 'Sabarkantha', 5, '2022-02-15 12:41:00'),
(146, 'Surendranagar', 5, '2022-02-15 12:41:00'),
(147, 'Surat', 5, '2022-02-15 12:41:00'),
(148, 'Vadodara', 5, '2022-02-15 12:41:00'),
(149, 'Valsad', 5, '2022-02-15 12:41:00'),
(150, 'Ambala', 6, '2022-02-15 12:41:00'),
(151, 'Bhiwani', 6, '2022-02-15 12:41:00'),
(152, 'Faridabad', 6, '2022-02-15 12:41:00'),
(153, 'Fatehabad', 6, '2022-02-15 12:41:00'),
(154, 'Gurgaon', 6, '2022-02-15 12:41:00'),
(155, 'Hissar', 6, '2022-02-15 12:41:00'),
(156, 'Jhajjar', 6, '2022-02-15 12:41:00'),
(157, 'Jind', 6, '2022-02-15 12:41:00'),
(158, 'Karnal', 6, '2022-02-15 12:41:00'),
(159, 'Kaithal', 6, '2022-02-15 12:41:00'),
(160, 'Kurukshetra', 6, '2022-02-15 12:41:00'),
(161, 'Mahendragarh', 6, '2022-02-15 12:41:00'),
(162, 'Mewat', 6, '2022-02-15 12:41:00'),
(163, 'Panchkula', 6, '2022-02-15 12:41:00'),
(164, 'Panipat', 6, '2022-02-15 12:41:00'),
(165, 'Rewari', 6, '2022-02-15 12:41:00'),
(166, 'Rohtak', 6, '2022-02-15 12:41:00'),
(167, 'Sirsa', 6, '2022-02-15 12:41:00'),
(168, 'Sonepat', 6, '2022-02-15 12:41:00'),
(169, 'Yamuna Nagar', 6, '2022-02-15 12:41:00'),
(170, 'Palwal', 6, '2022-02-15 12:41:00'),
(171, 'Bilaspur', 7, '2022-02-15 12:41:00'),
(172, 'Chamba', 7, '2022-02-15 12:41:00'),
(173, 'Hamirpur', 7, '2022-02-15 12:41:00'),
(174, 'Kangra', 7, '2022-02-15 12:41:00'),
(175, 'Kinnaur', 7, '2022-02-15 12:41:00'),
(176, 'Kulu', 7, '2022-02-15 12:41:00'),
(177, 'Lahaul and Spiti', 7, '2022-02-15 12:41:00'),
(178, 'Mandi', 7, '2022-02-15 12:41:00'),
(179, 'Shimla', 7, '2022-02-15 12:41:00'),
(180, 'Sirmaur', 7, '2022-02-15 12:41:00'),
(181, 'Solan', 7, '2022-02-15 12:41:00'),
(182, 'Una', 7, '2022-02-15 12:41:00'),
(183, 'Anantnag', 8, '2022-02-15 12:41:00'),
(184, 'Badgam', 8, '2022-02-15 12:41:00'),
(185, 'Bandipore', 8, '2022-02-15 12:41:00'),
(186, 'Baramula', 8, '2022-02-15 12:41:00'),
(187, 'Doda', 8, '2022-02-15 12:41:00'),
(188, 'Jammu', 8, '2022-02-15 12:41:00'),
(189, 'Kargil', 8, '2022-02-15 12:41:00'),
(190, 'Kathua', 8, '2022-02-15 12:41:00'),
(191, 'Kupwara', 8, '2022-02-15 12:41:00'),
(192, 'Leh', 8, '2022-02-15 12:41:00'),
(193, 'Poonch', 8, '2022-02-15 12:41:00'),
(194, 'Pulwama', 8, '2022-02-15 12:41:00'),
(195, 'Rajauri', 8, '2022-02-15 12:41:00'),
(196, 'Srinagar', 8, '2022-02-15 12:41:00'),
(197, 'Samba', 8, '2022-02-15 12:41:00'),
(198, 'Udhampur', 8, '2022-02-15 12:41:00'),
(199, 'Bokaro', 34, '2022-02-15 12:41:00'),
(200, 'Chatra', 34, '2022-02-15 12:41:00'),
(201, 'Deoghar', 34, '2022-02-15 12:41:00'),
(202, 'Dhanbad', 34, '2022-02-15 12:41:00'),
(203, 'Dumka', 34, '2022-02-15 12:41:00'),
(204, 'Purba Singhbhum', 34, '2022-02-15 12:41:00'),
(205, 'Garhwa', 34, '2022-02-15 12:41:00'),
(206, 'Giridih', 34, '2022-02-15 12:41:00'),
(207, 'Godda', 34, '2022-02-15 12:41:00'),
(208, 'Gumla', 34, '2022-02-15 12:41:00'),
(209, 'Hazaribagh', 34, '2022-02-15 12:41:00'),
(210, 'Koderma', 34, '2022-02-15 12:41:00'),
(211, 'Lohardaga', 34, '2022-02-15 12:41:00'),
(212, 'Pakur', 34, '2022-02-15 12:41:00'),
(213, 'Palamu', 34, '2022-02-15 12:41:00'),
(214, 'Ranchi', 34, '2022-02-15 12:41:00'),
(215, 'Sahibganj', 34, '2022-02-15 12:41:00'),
(216, 'Seraikela and Kharsawan', 34, '2022-02-15 12:41:00'),
(217, 'Pashchim Singhbhum', 34, '2022-02-15 12:41:00'),
(218, 'Ramgarh', 34, '2022-02-15 12:41:00'),
(219, 'Bidar', 9, '2022-02-15 12:41:00'),
(220, 'Belgaum', 9, '2022-02-15 12:41:00'),
(221, 'Bijapur', 9, '2022-02-15 12:41:00'),
(222, 'Bagalkot', 9, '2022-02-15 12:41:00'),
(223, 'Bellary', 9, '2022-02-15 12:41:00'),
(224, 'Bangalore Rural District', 9, '2022-02-15 12:41:00'),
(225, 'Bangalore Urban District', 9, '2022-02-15 12:41:00'),
(226, 'Chamarajnagar', 9, '2022-02-15 12:41:00'),
(227, 'Chikmagalur', 9, '2022-02-15 12:41:00'),
(228, 'Chitradurga', 9, '2022-02-15 12:41:00'),
(229, 'Davanagere', 9, '2022-02-15 12:41:00'),
(230, 'Dharwad', 9, '2022-02-15 12:41:00'),
(231, 'Dakshina Kannada', 9, '2022-02-15 12:41:00'),
(232, 'Gadag', 9, '2022-02-15 12:41:00'),
(233, 'Gulbarga', 9, '2022-02-15 12:41:00'),
(234, 'Hassan', 9, '2022-02-15 12:41:00'),
(235, 'Haveri District', 9, '2022-02-15 12:41:00'),
(236, 'Kodagu', 9, '2022-02-15 12:41:00'),
(237, 'Kolar', 9, '2022-02-15 12:41:00'),
(238, 'Koppal', 9, '2022-02-15 12:41:00'),
(239, 'Mandya', 9, '2022-02-15 12:41:00'),
(240, 'Mysore', 9, '2022-02-15 12:41:00'),
(241, 'Raichur', 9, '2022-02-15 12:41:00'),
(242, 'Shimoga', 9, '2022-02-15 12:41:00'),
(243, 'Tumkur', 9, '2022-02-15 12:41:00'),
(244, 'Udupi', 9, '2022-02-15 12:41:00'),
(245, 'Uttara Kannada', 9, '2022-02-15 12:41:00'),
(246, 'Ramanagara', 9, '2022-02-15 12:41:00'),
(247, 'Chikballapur', 9, '2022-02-15 12:41:00'),
(248, 'Yadagiri', 9, '2022-02-15 12:41:00'),
(249, 'Alappuzha', 10, '2022-02-15 12:41:00'),
(250, 'Ernakulam', 10, '2022-02-15 12:41:00'),
(251, 'Idukki', 10, '2022-02-15 12:41:00'),
(252, 'Kollam', 10, '2022-02-15 12:41:00'),
(253, 'Kannur', 10, '2022-02-15 12:41:00'),
(254, 'Kasaragod', 10, '2022-02-15 12:41:00'),
(255, 'Kottayam', 10, '2022-02-15 12:41:00'),
(256, 'Kozhikode', 10, '2022-02-15 12:41:00'),
(257, 'Malappuram', 10, '2022-02-15 12:41:00'),
(258, 'Palakkad', 10, '2022-02-15 12:41:00'),
(259, 'Pathanamthitta', 10, '2022-02-15 12:41:00'),
(260, 'Thrissur', 10, '2022-02-15 12:41:00'),
(261, 'Thiruvananthapuram', 10, '2022-02-15 12:41:00'),
(262, 'Wayanad', 10, '2022-02-15 12:41:00'),
(263, 'Alirajpur', 11, '2022-02-15 12:41:00'),
(264, 'Anuppur', 11, '2022-02-15 12:41:00'),
(265, 'Ashok Nagar', 11, '2022-02-15 12:41:00'),
(266, 'Balaghat', 11, '2022-02-15 12:41:00'),
(267, 'Barwani', 11, '2022-02-15 12:41:00'),
(268, 'Betul', 11, '2022-02-15 12:41:00'),
(269, 'Bhind', 11, '2022-02-15 12:41:00'),
(270, 'Bhopal', 11, '2022-02-15 12:41:00'),
(271, 'Burhanpur', 11, '2022-02-15 12:41:00'),
(272, 'Chhatarpur', 11, '2022-02-15 12:41:00'),
(273, 'Chhindwara', 11, '2022-02-15 12:41:00'),
(274, 'Damoh', 11, '2022-02-15 12:41:00'),
(275, 'Datia', 11, '2022-02-15 12:41:00'),
(276, 'Dewas', 11, '2022-02-15 12:41:00'),
(277, 'Dhar', 11, '2022-02-15 12:41:00'),
(278, 'Dindori', 11, '2022-02-15 12:41:00'),
(279, 'Guna', 11, '2022-02-15 12:41:00'),
(280, 'Gwalior', 11, '2022-02-15 12:41:00'),
(281, 'Harda', 11, '2022-02-15 12:41:00'),
(282, 'Hoshangabad', 11, '2022-02-15 12:41:00'),
(283, 'Indore', 11, '2022-02-15 12:41:00'),
(284, 'Jabalpur', 11, '2022-02-15 12:41:00'),
(285, 'Jhabua', 11, '2022-02-15 12:41:00'),
(286, 'Katni', 11, '2022-02-15 12:41:00'),
(287, 'Khandwa', 11, '2022-02-15 12:41:00'),
(288, 'Khargone', 11, '2022-02-15 12:41:00'),
(289, 'Mandla', 11, '2022-02-15 12:41:00'),
(290, 'Mandsaur', 11, '2022-02-15 12:41:00'),
(291, 'Morena', 11, '2022-02-15 12:41:00'),
(292, 'Narsinghpur', 11, '2022-02-15 12:41:00'),
(293, 'Neemuch', 11, '2022-02-15 12:41:00'),
(294, 'Panna', 11, '2022-02-15 12:41:00'),
(295, 'Rewa', 11, '2022-02-15 12:41:00'),
(296, 'Rajgarh', 11, '2022-02-15 12:41:00'),
(297, 'Ratlam', 11, '2022-02-15 12:41:00'),
(298, 'Raisen', 11, '2022-02-15 12:41:00'),
(299, 'Sagar', 11, '2022-02-15 12:41:00'),
(300, 'Satna', 11, '2022-02-15 12:41:00'),
(301, 'Sehore', 11, '2022-02-15 12:41:00'),
(302, 'Seoni', 11, '2022-02-15 12:41:00'),
(303, 'Shahdol', 11, '2022-02-15 12:41:00'),
(304, 'Shajapur', 11, '2022-02-15 12:41:00'),
(305, 'Sheopur', 11, '2022-02-15 12:41:00'),
(306, 'Shivpuri', 11, '2022-02-15 12:41:00'),
(307, 'Sidhi', 11, '2022-02-15 12:41:00'),
(308, 'Singrauli', 11, '2022-02-15 12:41:00'),
(309, 'Tikamgarh', 11, '2022-02-15 12:41:00'),
(310, 'Ujjain', 11, '2022-02-15 12:41:00'),
(311, 'Umaria', 11, '2022-02-15 12:41:00'),
(312, 'Vidisha', 11, '2022-02-15 12:41:00'),
(313, 'Ahmednagar', 12, '2022-02-15 12:41:00'),
(314, 'Akola', 12, '2022-02-15 12:41:00'),
(315, 'Amrawati', 12, '2022-02-15 12:41:00'),
(316, 'Aurangabad', 12, '2022-02-15 12:41:00'),
(317, 'Bhandara', 12, '2022-02-15 12:41:00'),
(318, 'Beed', 12, '2022-02-15 12:41:00'),
(319, 'Buldhana', 12, '2022-02-15 12:41:00'),
(320, 'Chandrapur', 12, '2022-02-15 12:41:00'),
(321, 'Dhule', 12, '2022-02-15 12:41:00'),
(322, 'Gadchiroli', 12, '2022-02-15 12:41:00'),
(323, 'Gondiya', 12, '2022-02-15 12:41:00'),
(324, 'Hingoli', 12, '2022-02-15 12:41:00'),
(325, 'Jalgaon', 12, '2022-02-15 12:41:00'),
(326, 'Jalna', 12, '2022-02-15 12:41:00'),
(327, 'Kolhapur', 12, '2022-02-15 12:41:00'),
(328, 'Latur', 12, '2022-02-15 12:41:00'),
(329, 'Mumbai City', 12, '2022-02-15 12:41:00'),
(330, 'Mumbai suburban', 12, '2022-02-15 12:41:00'),
(331, 'Nandurbar', 12, '2022-02-15 12:41:00'),
(332, 'Nanded', 12, '2022-02-15 12:41:00'),
(333, 'Nagpur', 12, '2022-02-15 12:41:00'),
(334, 'Nashik', 12, '2022-02-15 12:41:00'),
(335, 'Osmanabad', 12, '2022-02-15 12:41:00'),
(336, 'Parbhani', 12, '2022-02-15 12:41:00'),
(337, 'Pune', 12, '2022-02-15 12:41:00'),
(338, 'Raigad', 12, '2022-02-15 12:41:00'),
(339, 'Ratnagiri', 12, '2022-02-15 12:41:00'),
(340, 'Sindhudurg', 12, '2022-02-15 12:41:00'),
(341, 'Sangli', 12, '2022-02-15 12:41:00'),
(342, 'Solapur', 12, '2022-02-15 12:41:00'),
(343, 'Satara', 12, '2022-02-15 12:41:00'),
(344, 'Thane', 12, '2022-02-15 12:41:00'),
(345, 'Wardha', 12, '2022-02-15 12:41:00'),
(346, 'Washim', 12, '2022-02-15 12:41:00'),
(347, 'Yavatmal', 12, '2022-02-15 12:41:00'),
(348, 'Bishnupur', 13, '2022-02-15 12:41:00'),
(349, 'Churachandpur', 13, '2022-02-15 12:41:00'),
(350, 'Chandel', 13, '2022-02-15 12:41:00'),
(351, 'Imphal East', 13, '2022-02-15 12:41:00'),
(352, 'Senapati', 13, '2022-02-15 12:41:00'),
(353, 'Tamenglong', 13, '2022-02-15 12:41:00'),
(354, 'Thoubal', 13, '2022-02-15 12:41:00'),
(355, 'Ukhrul', 13, '2022-02-15 12:41:00'),
(356, 'Imphal West', 13, '2022-02-15 12:41:00'),
(357, 'East Garo Hills', 14, '2022-02-15 12:41:00'),
(358, 'East Khasi Hills', 14, '2022-02-15 12:41:00'),
(359, 'Jaintia Hills', 14, '2022-02-15 12:41:00'),
(360, 'Ri-Bhoi', 14, '2022-02-15 12:41:00'),
(361, 'South Garo Hills', 14, '2022-02-15 12:41:00'),
(362, 'West Garo Hills', 14, '2022-02-15 12:41:00'),
(363, 'West Khasi Hills', 14, '2022-02-15 12:41:00'),
(364, 'Aizawl', 15, '2022-02-15 12:41:00'),
(365, 'Champhai', 15, '2022-02-15 12:41:00'),
(366, 'Kolasib', 15, '2022-02-15 12:41:00'),
(367, 'Lawngtlai', 15, '2022-02-15 12:41:00'),
(368, 'Lunglei', 15, '2022-02-15 12:41:00'),
(369, 'Mamit', 15, '2022-02-15 12:41:00'),
(370, 'Saiha', 15, '2022-02-15 12:41:00'),
(371, 'Serchhip', 15, '2022-02-15 12:41:00'),
(372, 'Dimapur', 16, '2022-02-15 12:41:00'),
(373, 'Kohima', 16, '2022-02-15 12:41:00'),
(374, 'Mokokchung', 16, '2022-02-15 12:41:00'),
(375, 'Mon', 16, '2022-02-15 12:41:00'),
(376, 'Phek', 16, '2022-02-15 12:41:00'),
(377, 'Tuensang', 16, '2022-02-15 12:41:00'),
(378, 'Wokha', 16, '2022-02-15 12:41:00'),
(379, 'Zunheboto', 16, '2022-02-15 12:41:00'),
(380, 'Angul', 17, '2022-02-15 12:41:00'),
(381, 'Boudh', 17, '2022-02-15 12:41:00'),
(382, 'Bhadrak', 17, '2022-02-15 12:41:00'),
(383, 'Bolangir', 17, '2022-02-15 12:41:00'),
(384, 'Bargarh', 17, '2022-02-15 12:41:00'),
(385, 'Baleswar', 17, '2022-02-15 12:41:00'),
(386, 'Cuttack', 17, '2022-02-15 12:41:00'),
(387, 'Debagarh', 17, '2022-02-15 12:41:00'),
(388, 'Dhenkanal', 17, '2022-02-15 12:41:00'),
(389, 'Ganjam', 17, '2022-02-15 12:41:00'),
(390, 'Gajapati', 17, '2022-02-15 12:41:00'),
(391, 'Jharsuguda', 17, '2022-02-15 12:41:00'),
(392, 'Jajapur', 17, '2022-02-15 12:41:00'),
(393, 'Jagatsinghpur', 17, '2022-02-15 12:41:00'),
(394, 'Khordha', 17, '2022-02-15 12:41:00'),
(395, 'Kendujhar', 17, '2022-02-15 12:41:00'),
(396, 'Kalahandi', 17, '2022-02-15 12:41:00'),
(397, 'Kandhamal', 17, '2022-02-15 12:41:00'),
(398, 'Koraput', 17, '2022-02-15 12:41:00'),
(399, 'Kendrapara', 17, '2022-02-15 12:41:00'),
(400, 'Malkangiri', 17, '2022-02-15 12:41:00'),
(401, 'Mayurbhanj', 17, '2022-02-15 12:41:00'),
(402, 'Nabarangpur', 17, '2022-02-15 12:41:00'),
(403, 'Nuapada', 17, '2022-02-15 12:41:00'),
(404, 'Nayagarh', 17, '2022-02-15 12:41:00'),
(405, 'Puri', 17, '2022-02-15 12:41:00'),
(406, 'Rayagada', 17, '2022-02-15 12:41:00'),
(407, 'Sambalpur', 17, '2022-02-15 12:41:00'),
(408, 'Subarnapur', 17, '2022-02-15 12:41:00'),
(409, 'Sundargarh', 17, '2022-02-15 12:41:00'),
(410, 'Karaikal', 27, '2022-02-15 12:41:00'),
(411, 'Mahe', 27, '2022-02-15 12:41:00'),
(412, 'Puducherry', 27, '2022-02-15 12:41:00'),
(413, 'Yanam', 27, '2022-02-15 12:41:00'),
(414, 'Amritsar', 18, '2022-02-15 12:41:00'),
(415, 'Bathinda', 18, '2022-02-15 12:41:00'),
(416, 'Firozpur', 18, '2022-02-15 12:41:00'),
(417, 'Faridkot', 18, '2022-02-15 12:41:00'),
(418, 'Fatehgarh Sahib', 18, '2022-02-15 12:41:00'),
(419, 'Gurdaspur', 18, '2022-02-15 12:41:00'),
(420, 'Hoshiarpur', 18, '2022-02-15 12:41:00'),
(421, 'Jalandhar', 18, '2022-02-15 12:41:00'),
(422, 'Kapurthala', 18, '2022-02-15 12:41:00'),
(423, 'Ludhiana', 18, '2022-02-15 12:41:00'),
(424, 'Mansa', 18, '2022-02-15 12:41:00'),
(425, 'Moga', 18, '2022-02-15 12:41:00'),
(426, 'Mukatsar', 18, '2022-02-15 12:41:00'),
(427, 'Nawan Shehar', 18, '2022-02-15 12:41:00'),
(428, 'Patiala', 18, '2022-02-15 12:41:00'),
(429, 'Rupnagar', 18, '2022-02-15 12:41:00'),
(430, 'Sangrur', 18, '2022-02-15 12:41:00'),
(431, 'Ajmer', 19, '2022-02-15 12:41:00'),
(432, 'Alwar', 19, '2022-02-15 12:41:00'),
(433, 'Bikaner', 19, '2022-02-15 12:41:00'),
(434, 'Barmer', 19, '2022-02-15 12:41:00'),
(435, 'Banswara', 19, '2022-02-15 12:41:00'),
(436, 'Bharatpur', 19, '2022-02-15 12:41:00'),
(437, 'Baran', 19, '2022-02-15 12:41:00'),
(438, 'Bundi', 19, '2022-02-15 12:41:00'),
(439, 'Bhilwara', 19, '2022-02-15 12:41:00'),
(440, 'Churu', 19, '2022-02-15 12:41:00'),
(441, 'Chittorgarh', 19, '2022-02-15 12:41:00'),
(442, 'Dausa', 19, '2022-02-15 12:41:00'),
(443, 'Dholpur', 19, '2022-02-15 12:41:00'),
(444, 'Dungapur', 19, '2022-02-15 12:41:00'),
(445, 'Ganganagar', 19, '2022-02-15 12:41:00'),
(446, 'Hanumangarh', 19, '2022-02-15 12:41:00'),
(447, 'Juhnjhunun', 19, '2022-02-15 12:41:00'),
(448, 'Jalore', 19, '2022-02-15 12:41:00'),
(449, 'Jodhpur', 19, '2022-02-15 12:41:00'),
(450, 'Jaipur', 19, '2022-02-15 12:41:00'),
(451, 'Jaisalmer', 19, '2022-02-15 12:41:00'),
(452, 'Jhalawar', 19, '2022-02-15 12:41:00'),
(453, 'Karauli', 19, '2022-02-15 12:41:00'),
(454, 'Kota', 19, '2022-02-15 12:41:00'),
(455, 'Nagaur', 19, '2022-02-15 12:41:00'),
(456, 'Pali', 19, '2022-02-15 12:41:00'),
(457, 'Pratapgarh', 19, '2022-02-15 12:41:00'),
(458, 'Rajsamand', 19, '2022-02-15 12:41:00'),
(459, 'Sikar', 19, '2022-02-15 12:41:00'),
(460, 'Sawai Madhopur', 19, '2022-02-15 12:41:00'),
(461, 'Sirohi', 19, '2022-02-15 12:41:00'),
(462, 'Tonk', 19, '2022-02-15 12:41:00'),
(463, 'Udaipur', 19, '2022-02-15 12:41:00'),
(464, 'East Sikkim', 20, '2022-02-15 12:41:00'),
(465, 'North Sikkim', 20, '2022-02-15 12:41:00'),
(466, 'South Sikkim', 20, '2022-02-15 12:41:00'),
(467, 'West Sikkim', 20, '2022-02-15 12:41:00'),
(468, 'Ariyalur', 21, '2022-02-15 12:41:00'),
(469, 'Chennai', 21, '2022-02-15 12:41:00'),
(470, 'Coimbatore', 21, '2022-02-15 12:41:00'),
(471, 'Cuddalore', 21, '2022-02-15 12:41:00'),
(472, 'Dharmapuri', 21, '2022-02-15 12:41:00'),
(473, 'Dindigul', 21, '2022-02-15 12:41:00'),
(474, 'Erode', 21, '2022-02-15 12:41:00'),
(475, 'Kanchipuram', 21, '2022-02-15 12:41:00'),
(476, 'Kanyakumari', 21, '2022-02-15 12:41:00'),
(477, 'Karur', 21, '2022-02-15 12:41:00'),
(478, 'Madurai', 21, '2022-02-15 12:41:00'),
(479, 'Nagapattinam', 21, '2022-02-15 12:41:00'),
(480, 'The Nilgiris', 21, '2022-02-15 12:41:00'),
(481, 'Namakkal', 21, '2022-02-15 12:41:00'),
(482, 'Perambalur', 21, '2022-02-15 12:41:00'),
(483, 'Pudukkottai', 21, '2022-02-15 12:41:00'),
(484, 'Ramanathapuram', 21, '2022-02-15 12:41:00'),
(485, 'Salem', 21, '2022-02-15 12:41:00'),
(486, 'Sivagangai', 21, '2022-02-15 12:41:00'),
(487, 'Tiruppur', 21, '2022-02-15 12:41:00'),
(488, 'Tiruchirappalli', 21, '2022-02-15 12:41:00'),
(489, 'Theni', 21, '2022-02-15 12:41:00'),
(490, 'Tirunelveli', 21, '2022-02-15 12:41:00'),
(491, 'Thanjavur', 21, '2022-02-15 12:41:00'),
(492, 'Thoothukudi', 21, '2022-02-15 12:41:00'),
(493, 'Thiruvallur', 21, '2022-02-15 12:41:00'),
(494, 'Thiruvarur', 21, '2022-02-15 12:41:00'),
(495, 'Tiruvannamalai', 21, '2022-02-15 12:41:00'),
(496, 'Vellore', 21, '2022-02-15 12:41:00'),
(497, 'Villupuram', 21, '2022-02-15 12:41:00'),
(498, 'Dhalai', 22, '2022-02-15 12:41:00'),
(499, 'North Tripura', 22, '2022-02-15 12:41:00'),
(500, 'South Tripura', 22, '2022-02-15 12:41:00'),
(501, 'West Tripura', 22, '2022-02-15 12:41:00'),
(502, 'Almora', 33, '2022-02-15 12:41:00'),
(503, 'Bageshwar', 33, '2022-02-15 12:41:00'),
(504, 'Chamoli', 33, '2022-02-15 12:41:00'),
(505, 'Champawat', 33, '2022-02-15 12:41:00'),
(506, 'Dehradun', 33, '2022-02-15 12:41:00'),
(507, 'Haridwar', 33, '2022-02-15 12:41:00'),
(508, 'Nainital', 33, '2022-02-15 12:41:00'),
(509, 'Pauri Garhwal', 33, '2022-02-15 12:41:00'),
(510, 'Pithoragharh', 33, '2022-02-15 12:41:00'),
(511, 'Rudraprayag', 33, '2022-02-15 12:41:00'),
(512, 'Tehri Garhwal', 33, '2022-02-15 12:41:00'),
(513, 'Udham Singh Nagar', 33, '2022-02-15 12:41:00'),
(514, 'Uttarkashi', 33, '2022-02-15 12:41:00'),
(515, 'Agra', 23, '2022-02-15 12:41:00'),
(516, 'Allahabad', 23, '2022-02-15 12:41:00'),
(517, 'Aligarh', 23, '2022-02-15 12:41:00'),
(518, 'Ambedkar Nagar', 23, '2022-02-15 12:41:00'),
(519, 'Auraiya', 23, '2022-02-15 12:41:00'),
(520, 'Azamgarh', 23, '2022-02-15 12:41:00'),
(521, 'Barabanki', 23, '2022-02-15 12:41:00'),
(522, 'Badaun', 23, '2022-02-15 12:41:00'),
(523, 'Bagpat', 23, '2022-02-15 12:41:00'),
(524, 'Bahraich', 23, '2022-02-15 12:41:00'),
(525, 'Bijnor', 23, '2022-02-15 12:41:00'),
(526, 'Ballia', 23, '2022-02-15 12:41:00'),
(527, 'Banda', 23, '2022-02-15 12:41:00'),
(528, 'Balrampur', 23, '2022-02-15 12:41:00'),
(529, 'Bareilly', 23, '2022-02-15 12:41:00'),
(530, 'Basti', 23, '2022-02-15 12:41:00'),
(531, 'Bulandshahr', 23, '2022-02-15 12:41:00'),
(532, 'Chandauli', 23, '2022-02-15 12:41:00'),
(533, 'Chitrakoot', 23, '2022-02-15 12:41:00'),
(534, 'Deoria', 23, '2022-02-15 12:41:00'),
(535, 'Etah', 23, '2022-02-15 12:41:00'),
(536, 'Kanshiram Nagar', 23, '2022-02-15 12:41:00'),
(537, 'Etawah', 23, '2022-02-15 12:41:00'),
(538, 'Firozabad', 23, '2022-02-15 12:41:00'),
(539, 'Farrukhabad', 23, '2022-02-15 12:41:00'),
(540, 'Fatehpur', 23, '2022-02-15 12:41:00'),
(541, 'Faizabad', 23, '2022-02-15 12:41:00'),
(542, 'Gautam Buddha Nagar', 23, '2022-02-15 12:41:00'),
(543, 'Gonda', 23, '2022-02-15 12:41:00'),
(544, 'Ghazipur', 23, '2022-02-15 12:41:00'),
(545, 'Gorkakhpur', 23, '2022-02-15 12:41:00'),
(546, 'Ghaziabad', 23, '2022-02-15 12:41:00'),
(547, 'Hamirpur', 23, '2022-02-15 12:41:00'),
(548, 'Hardoi', 23, '2022-02-15 12:41:00'),
(549, 'Mahamaya Nagar', 23, '2022-02-15 12:41:00'),
(550, 'Jhansi', 23, '2022-02-15 12:41:00'),
(551, 'Jalaun', 23, '2022-02-15 12:41:00'),
(552, 'Jyotiba Phule Nagar', 23, '2022-02-15 12:41:00'),
(553, 'Jaunpur District', 23, '2022-02-15 12:41:00'),
(554, 'Kanpur Dehat', 23, '2022-02-15 12:41:00'),
(555, 'Kannauj', 23, '2022-02-15 12:41:00'),
(556, 'Kanpur Nagar', 23, '2022-02-15 12:41:00'),
(557, 'Kaushambi', 23, '2022-02-15 12:41:00'),
(558, 'Kushinagar', 23, '2022-02-15 12:41:00'),
(559, 'Lalitpur', 23, '2022-02-15 12:41:00'),
(560, 'Lakhimpur Kheri', 23, '2022-02-15 12:41:00'),
(561, 'Lucknow', 23, '2022-02-15 12:41:00'),
(562, 'Mau', 23, '2022-02-15 12:41:00'),
(563, 'Meerut', 23, '2022-02-15 12:41:00'),
(564, 'Maharajganj', 23, '2022-02-15 12:41:00'),
(565, 'Mahoba', 23, '2022-02-15 12:41:00'),
(566, 'Mirzapur', 23, '2022-02-15 12:41:00'),
(567, 'Moradabad', 23, '2022-02-15 12:41:00'),
(568, 'Mainpuri', 23, '2022-02-15 12:41:00'),
(569, 'Mathura', 23, '2022-02-15 12:41:00'),
(570, 'Muzaffarnagar', 23, '2022-02-15 12:41:00'),
(571, 'Pilibhit', 23, '2022-02-15 12:41:00'),
(572, 'Pratapgarh', 23, '2022-02-15 12:41:00'),
(573, 'Rampur', 23, '2022-02-15 12:41:00'),
(574, 'Rae Bareli', 23, '2022-02-15 12:41:00'),
(575, 'Saharanpur', 23, '2022-02-15 12:41:00'),
(576, 'Sitapur', 23, '2022-02-15 12:41:00'),
(577, 'Shahjahanpur', 23, '2022-02-15 12:41:00'),
(578, 'Sant Kabir Nagar', 23, '2022-02-15 12:41:00'),
(579, 'Siddharthnagar', 23, '2022-02-15 12:41:00'),
(580, 'Sonbhadra', 23, '2022-02-15 12:41:00'),
(581, 'Sant Ravidas Nagar', 23, '2022-02-15 12:41:00'),
(582, 'Sultanpur', 23, '2022-02-15 12:41:00'),
(583, 'Shravasti', 23, '2022-02-15 12:41:00'),
(584, 'Unnao', 23, '2022-02-15 12:41:00'),
(585, 'Varanasi', 23, '2022-02-15 12:41:00'),
(586, 'Birbhum', 24, '2022-02-15 12:41:00'),
(587, 'Bankura', 24, '2022-02-15 12:41:00'),
(588, 'Bardhaman', 24, '2022-02-15 12:41:00'),
(589, 'Darjeeling', 24, '2022-02-15 12:41:00'),
(590, 'Dakshin Dinajpur', 24, '2022-02-15 12:41:00'),
(591, 'Hooghly', 24, '2022-02-15 12:41:00'),
(592, 'Howrah', 24, '2022-02-15 12:41:00'),
(593, 'Jalpaiguri', 24, '2022-02-15 12:41:00'),
(594, 'Cooch Behar', 24, '2022-02-15 12:41:00'),
(595, 'Kolkata', 24, '2022-02-15 12:41:00'),
(596, 'Malda', 24, '2022-02-15 12:41:00'),
(597, 'Midnapore', 24, '2022-02-15 12:41:00'),
(598, 'Murshidabad', 24, '2022-02-15 12:41:00'),
(599, 'Nadia', 24, '2022-02-15 12:41:00'),
(600, 'North 24 Parganas', 24, '2022-02-15 12:41:00'),
(601, 'South 24 Parganas', 24, '2022-02-15 12:41:00'),
(602, 'Purulia', 24, '2022-02-15 12:41:00'),
(603, 'Uttar Dinajpur', 24, '2022-02-15 12:41:00');

-- --------------------------------------------------------

--
-- Table structure for table `br_state`
--

CREATE TABLE `br_state` (
  `id` int(11) NOT NULL,
  `state` varchar(35) DEFAULT NULL,
  `created_on` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `br_state`
--

INSERT INTO `br_state` (`id`, `state`, `created_on`) VALUES
(1, 'ANDHRA PRADESH', '2022-02-15 12:39:51'),
(2, 'ASSAM', '2022-02-15 12:39:51'),
(3, 'ARUNACHAL PRADESH', '2022-02-15 12:39:51'),
(4, 'BIHAR', '2022-02-15 12:39:51'),
(5, 'GUJRAT', '2022-02-15 12:39:51'),
(6, 'HARYANA', '2022-02-15 12:39:51'),
(7, 'HIMACHAL PRADESH', '2022-02-15 12:39:51'),
(8, 'JAMMU & KASHMIR', '2022-02-15 12:39:51'),
(9, 'KARNATAKA', '2022-02-15 12:39:51'),
(10, 'KERALA', '2022-02-15 12:39:51'),
(11, 'MADHYA PRADESH', '2022-02-15 12:39:51'),
(12, 'MAHARASHTRA', '2022-02-15 12:39:51'),
(13, 'MANIPUR', '2022-02-15 12:39:51'),
(14, 'MEGHALAYA', '2022-02-15 12:39:51'),
(15, 'MIZORAM', '2022-02-15 12:39:51'),
(16, 'NAGALAND', '2022-02-15 12:39:51'),
(17, 'ORISSA', '2022-02-15 12:39:51'),
(18, 'PUNJAB', '2022-02-15 12:39:51'),
(19, 'RAJASTHAN', '2022-02-15 12:39:51'),
(20, 'SIKKIM', '2022-02-15 12:39:51'),
(21, 'TAMIL NADU', '2022-02-15 12:39:51'),
(22, 'TRIPURA', '2022-02-15 12:39:51'),
(23, 'UTTAR PRADESH', '2022-02-15 12:39:51'),
(24, 'WEST BENGAL', '2022-02-15 12:39:51'),
(25, 'DELHI', '2022-02-15 12:39:51'),
(26, 'GOA', '2022-02-15 12:39:51'),
(27, 'PONDICHERY', '2022-02-15 12:39:51'),
(28, 'LAKSHDWEEP', '2022-02-15 12:39:51'),
(29, 'DAMAN & DIU', '2022-02-15 12:39:51'),
(30, 'DADRA & NAGAR', '2022-02-15 12:39:51'),
(31, 'CHANDIGARH', '2022-02-15 12:39:51'),
(32, 'ANDAMAN & NICOBAR', '2022-02-15 12:39:51'),
(33, 'UTTARANCHAL', '2022-02-15 12:39:51'),
(34, 'JHARKHAND', '2022-02-15 12:39:51'),
(35, 'CHATTISGARH', '2022-02-15 12:39:51');

-- --------------------------------------------------------

--
-- Table structure for table `br_user`
--

CREATE TABLE `br_user` (
  `id` int(11) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(100) NOT NULL,
  `google_token` varchar(25) DEFAULT NULL,
  `facebook_token` varchar(25) DEFAULT NULL,
  `login_type` varchar(10) NOT NULL,
  `user_role` int(11) DEFAULT 2 COMMENT '1 > ADMIN, 2 > CUSTOMER',
  `created_on` datetime DEFAULT current_timestamp(),
  `updated_on` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `br_bookings`
--
ALTER TABLE `br_bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `br_buses`
--
ALTER TABLE `br_buses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `br_bus_routes`
--
ALTER TABLE `br_bus_routes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `br_city`
--
ALTER TABLE `br_city`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `br_state`
--
ALTER TABLE `br_state`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `br_user`
--
ALTER TABLE `br_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `br_bookings`
--
ALTER TABLE `br_bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `br_buses`
--
ALTER TABLE `br_buses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `br_bus_routes`
--
ALTER TABLE `br_bus_routes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `br_city`
--
ALTER TABLE `br_city`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=604;

--
-- AUTO_INCREMENT for table `br_state`
--
ALTER TABLE `br_state`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `br_user`
--
ALTER TABLE `br_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
