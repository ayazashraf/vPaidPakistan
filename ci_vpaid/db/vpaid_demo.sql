-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: debeaumont.pdx1-mysql-a7-2a.dreamhost.com
-- Generation Time: Mar 08, 2023 at 02:18 AM
-- Server version: 8.0.28-0ubuntu0.20.04.3
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vpaid_demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `city_id` int NOT NULL,
  `city_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`city_id`, `city_name`) VALUES
(1, 'Karachi'),
(2, 'Lahore'),
(3, 'League City');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int NOT NULL,
  `country_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country_name`) VALUES
(1, 'Pakistan'),
(2, 'United States');

-- --------------------------------------------------------

--
-- Table structure for table `device`
--

CREATE TABLE `device` (
  `device_id` int NOT NULL,
  `device_token` text NOT NULL,
  `device_udid` text NOT NULL,
  `os_id` int NOT NULL COMMENT '0 for ios, 1 for android',
  `date` datetime NOT NULL,
  `user_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `device`
--

INSERT INTO `device` (`device_id`, `device_token`, `device_udid`, `os_id`, `date`, `user_id`) VALUES
(3, '123', '456', 0, '2017-04-29 16:16:58', 3),
(4, '123', '456', 0, '2017-04-29 16:20:00', 4),
(5, '196ab8e54452e37389fe337a6113aa3e3ac07a813c0a87698b33c609cbdbb28e', '5632D0D3-8CE3-4563-9696-DA96AAA27DF9', 0, '2017-05-02 12:06:28', 5),
(6, 'b1d817ba6e3f5ab872e36a7912fa19d83ce7fb73c9455b466765553a46520deb', '83CB016E-30F7-43E1-8779-C3B252E6AFFB', 0, '2017-05-02 05:16:33', 6),
(7, 'aac439bd7df8b0bf8c2027437f0e68b2ec9b6f429fabf894436a479f6bf3c5c5', '3E284307-0167-4006-B9DC-8A5FF7EF815D', 0, '2017-05-04 00:42:01', 7),
(8, '123', '9CDD5365-B4CC-4955-9017-6E2BC2997C9C', 0, '2017-05-04 07:04:11', 8);

-- --------------------------------------------------------

--
-- Table structure for table `merchant`
--

CREATE TABLE `merchant` (
  `merchant_id` int NOT NULL,
  `merchant_name` varchar(40) NOT NULL,
  `merchant_category` int NOT NULL,
  `merchant_description` text NOT NULL,
  `merchant_contact` varchar(40) NOT NULL,
  `merchant_email` varchar(80) DEFAULT NULL,
  `merchant_address` text NOT NULL,
  `merchant_national_identity` text NOT NULL,
  `merchant_type` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `merchant`
--

INSERT INTO `merchant` (`merchant_id`, `merchant_name`, `merchant_category`, `merchant_description`, `merchant_contact`, `merchant_email`, `merchant_address`, `merchant_national_identity`, `merchant_type`) VALUES
(1, 'KFC', 1, 'Best Fast Food', '(021) 111 532 532', NULL, 'abc, Karachi, Pakistan.', '42000-1111111-1', 1),
(2, 'McDonald\'s', 1, 'Best Burgers', '0306 4214545', NULL, 'N Circular Avenue, Off:, Korangi Rd, Karachi', '42101-9999999-9', 1),
(3, 'PocketGlobe', 2, 'Pocketglobe - All your local needs in one app, wherever you are', '8324295796', 'vpaid.pk@gmail.com', '2606 via Montesano League City League, TX 77573, US', 'xxxxx-xxxxxxx-x', 2);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `order_customer_id` int NOT NULL,
  `order_place_id` int NOT NULL,
  `order_total_price` int NOT NULL,
  `order_placed_time` datetime NOT NULL,
  `order_completion_time` datetime NOT NULL,
  `order_review` text,
  `order_rating` double DEFAULT NULL,
  `order_confirmation_time` datetime DEFAULT NULL,
  `order_is_confirmed` tinyint(1) DEFAULT NULL,
  `order_is_prepared` tinyint(1) DEFAULT NULL,
  `order_prepared_time` datetime DEFAULT NULL,
  `order_is_served` tinyint(1) DEFAULT NULL,
  `order_served_time` datetime DEFAULT NULL,
  `order_is_checked_out` tinyint(1) DEFAULT NULL,
  `order_referential_code` text,
  `order_description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `places`
--

CREATE TABLE `places` (
  `place_id` int NOT NULL,
  `place_name` varchar(40) NOT NULL,
  `place_address` text NOT NULL,
  `place_image` text NOT NULL,
  `place_city` int NOT NULL,
  `place_state` int NOT NULL,
  `place_country` int NOT NULL,
  `place_merchant_type` int DEFAULT NULL,
  `place_cover` text,
  `place_video` text,
  `place_merchant_id` int NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `place_cover_video_type` int NOT NULL DEFAULT '0' COMMENT '0 for no video, 1 for youtube, 2 for vimeo, 3 for our server'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `places`
--

INSERT INTO `places` (`place_id`, `place_name`, `place_address`, `place_image`, `place_city`, `place_state`, `place_country`, `place_merchant_type`, `place_cover`, `place_video`, `place_merchant_id`, `is_active`, `is_delete`, `place_cover_video_type`) VALUES
(3, 'KFC', 'Nursery Flyover, Karachi', 'images/kfc.png', 1, 1, 1, 1, NULL, 'VxkSU-N-igE', 1, 0, 0, 1),
(4, 'McDonald\'s', 'Tariq Road', 'images/download.png', 1, 1, 1, 1, NULL, '99830142', 2, 0, 0, 2),
(5, 'KFC', 'Bahadur Shah Zafar Road, Karachi', 'images/kfc.png', 1, 1, 1, 1, 'images/kfc_cover.jpg', NULL, 1, 0, 0, 0),
(6, 'PocketGlobe Shop', '2606 via Montesano League City League, TX 77573, US', 'images/pocketglobe_logo.png', 3, 3, 2, 2, NULL, 'CnFejVQTwXQ', 3, 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int NOT NULL,
  `product_name` text NOT NULL,
  `product_merchant_id` int NOT NULL,
  `product_category` int NOT NULL,
  `product_price` double NOT NULL,
  `product_image` text NOT NULL,
  `product_short_description` text NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `product_merchant_id`, `product_category`, `product_price`, `product_image`, `product_short_description`, `is_active`, `is_delete`) VALUES
(1, 'Zinger Stacker', 1, 1, 370, 'images/products/zinger_stacker.jpeg', 'Zinger Stacker is a new product, it  features 2  Zinger marinated fillets with our signature spicy sauce, cheese, and loaded with Jalapenos, all of this wrapped in a new corn meal bun.', 1, 0),
(2, 'Mighty Zinger', 1, 1, 450, 'images/products/mighty_zinger.jpeg', 'Delicious pieces of juicy chicken thigh with KFCâ€™s Spicy Zinger Recipe, cheese, fresh lettuce in a fresh round bun.', 1, 0),
(3, 'Cheeseburger', 2, 1, 300, 'images/products/cheese_burger.jpg', 'Say cheese! A legendary combo of 100% pure beef with onions, pickles, ketchup, mustard and cheese, all in a soft burger bun.', 1, 0),
(4, 'Milkshakes', 2, 1, 150, 'images/products/shakes.jpg', 'An irresistible blend! Acreamy, fresh milk and strawberry syrup shake so thick it hardly makes it up the straw.Also available in chocolate and vanilla.', 1, 0),
(5, 'IT (per month) Antivirus-Managed', 3, 3, 3.99, 'images/products/itpermonth.jpeg', 'Link to download and purchase Cloudcare from AVG will be sent via email.', 1, 0),
(6, 'Text Marketing (prices per month)', 3, 3, 29.99, 'images/products/textmarketing.png', '', 1, 0),
(7, 'Mail-Out Advertising (11x6 Jumbo Cards - 1 Side Full Color)', 3, 3, 1999, 'images/products/mailoutadvertising.png', '', 1, 0),
(8, 'Website + Management (+ 50-100 per month)', 3, 3, 500, 'images/products/website_and_management.png', 'Website + Management (+50-100 per Month after)', 1, 0),
(9, 'Pocketglobe App (Year advance Bundle)', 3, 3, 900, 'images/products/pocketglobe_logo.png', 'Pocketglobe - All your local needs in one app, wherever you are', 1, 0),
(10, 'Pocketglobe Local/Global Advertising (PG Global Featured 12 months)', 3, 3, 549.99, 'images/products/pocketglobe_grey_logo.png', '', 1, 0),
(11, 'Microsoft Office 365 Managed + Migration + Installation-Managed Office(per seat)', 3, 3, 5, 'images/products/microsoftoffice360.png', 'Link to download and purchase Office 365 from Microsoft will be sent via email.', 1, 0),
(12, 'Social Media Advertising (Includes Management + Creation) per month (2 SM Account)', 3, 3, 29.99, 'images/products/socialmediaadvertising.png', '', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `product_category_id` int NOT NULL,
  `product_category_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`product_category_id`, `product_category_name`) VALUES
(1, 'Fast Food'),
(2, 'Grocery'),
(3, 'IT Services');

-- --------------------------------------------------------

--
-- Table structure for table `product_place`
--

CREATE TABLE `product_place` (
  `product_place_id` int NOT NULL,
  `place_id` int NOT NULL,
  `product_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_place`
--

INSERT INTO `product_place` (`product_place_id`, `place_id`, `product_id`) VALUES
(1, 3, 1),
(2, 3, 2),
(3, 4, 3),
(4, 4, 4),
(5, 5, 1),
(6, 6, 5),
(7, 6, 6),
(8, 6, 7),
(9, 6, 8),
(10, 6, 9),
(11, 6, 10),
(12, 6, 11),
(13, 6, 12);

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE `state` (
  `state_id` int NOT NULL,
  `state_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`state_id`, `state_name`) VALUES
(1, 'Sindh'),
(2, 'Punjab'),
(3, 'Texas');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `user_firstName` varchar(40) NOT NULL,
  `user_lastName` varchar(40) DEFAULT NULL,
  `user_phone` varchar(30) NOT NULL,
  `user_image` text,
  `user_type` int NOT NULL,
  `user_email` varchar(80) DEFAULT NULL,
  `user_password` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_firstName`, `user_lastName`, `user_phone`, `user_image`, `user_type`, `user_email`, `user_password`) VALUES
(3, 'Ammar', '', '03441234567', NULL, 2, NULL, NULL),
(4, 'Ahmed', '', '03451234567', NULL, 2, NULL, NULL),
(5, 'Ahmed Shahid', '', '+923432024978', NULL, 2, NULL, NULL),
(6, 'pg', '', '+923432024978', NULL, 2, NULL, NULL),
(7, 'Ahmed Shahid', '', '+923432024978', NULL, 2, NULL, NULL),
(8, 'how', '', '+18327389578', NULL, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_detail`
--

CREATE TABLE `user_detail` (
  `user_detail_id` int NOT NULL,
  `user_id` int NOT NULL,
  `user_address` text,
  `user_city` int DEFAULT NULL,
  `user_state` int DEFAULT NULL,
  `user_country` int DEFAULT NULL,
  `user_lat` double DEFAULT NULL,
  `user_lng` double DEFAULT NULL,
  `user_image` text,
  `user_type` int NOT NULL,
  `user_email` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_detail`
--

INSERT INTO `user_detail` (`user_detail_id`, `user_id`, `user_address`, `user_city`, `user_state`, `user_country`, `user_lat`, `user_lng`, `user_image`, `user_type`, `user_email`) VALUES
(2, 3, NULL, 1, 1, 1, 24.867179, 67.080692, NULL, 2, NULL),
(3, 4, NULL, 1, 1, 1, 24.867179, 67.080692, NULL, 2, NULL),
(4, 5, NULL, 1, 1, 1, 24.867551635016, 67.080946700939, NULL, 2, NULL),
(5, 6, NULL, 1, 1, 1, 24.867545751372, 67.080856604241, NULL, 2, NULL),
(6, 7, NULL, 1, 1, 1, 24.86750101684, 67.080865878333, NULL, 2, NULL),
(7, 8, NULL, 3, 3, 2, 29.513764955925, -95.059451986175, NULL, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_type`
--

CREATE TABLE `user_type` (
  `user_type_id` int NOT NULL,
  `user_type_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_type`
--

INSERT INTO `user_type` (`user_type_id`, `user_type_name`) VALUES
(1, 'Merchant'),
(2, 'Customer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_id`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `device`
--
ALTER TABLE `device`
  ADD PRIMARY KEY (`device_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `merchant`
--
ALTER TABLE `merchant`
  ADD PRIMARY KEY (`merchant_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `order_customer_id` (`order_customer_id`),
  ADD KEY `order_place_id` (`order_place_id`);

--
-- Indexes for table `places`
--
ALTER TABLE `places`
  ADD PRIMARY KEY (`place_id`),
  ADD KEY `place_city` (`place_city`),
  ADD KEY `place_state` (`place_state`),
  ADD KEY `place_country` (`place_country`),
  ADD KEY `place_merchant_type` (`place_merchant_type`),
  ADD KEY `place_merchant_id` (`place_merchant_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `product_merchant_id` (`product_merchant_id`),
  ADD KEY `product_category` (`product_category`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`product_category_id`);

--
-- Indexes for table `product_place`
--
ALTER TABLE `product_place`
  ADD PRIMARY KEY (`product_place_id`),
  ADD KEY `place_id` (`place_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `state`
--
ALTER TABLE `state`
  ADD PRIMARY KEY (`state_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `user_type` (`user_type`);

--
-- Indexes for table `user_detail`
--
ALTER TABLE `user_detail`
  ADD PRIMARY KEY (`user_detail_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `user_city` (`user_city`),
  ADD KEY `user_state` (`user_state`),
  ADD KEY `user_country` (`user_country`),
  ADD KEY `user_type` (`user_type`);

--
-- Indexes for table `user_type`
--
ALTER TABLE `user_type`
  ADD PRIMARY KEY (`user_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `device`
--
ALTER TABLE `device`
  MODIFY `device_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `merchant`
--
ALTER TABLE `merchant`
  MODIFY `merchant_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `places`
--
ALTER TABLE `places`
  MODIFY `place_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `product_category_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_place`
--
ALTER TABLE `product_place`
  MODIFY `product_place_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `state`
--
ALTER TABLE `state`
  MODIFY `state_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_detail`
--
ALTER TABLE `user_detail`
  MODIFY `user_detail_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user_type`
--
ALTER TABLE `user_type`
  MODIFY `user_type_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `device`
--
ALTER TABLE `device`
  ADD CONSTRAINT `device_user_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `order_customer_FK` FOREIGN KEY (`order_customer_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `order_place_FK` FOREIGN KEY (`order_place_id`) REFERENCES `places` (`place_id`);

--
-- Constraints for table `places`
--
ALTER TABLE `places`
  ADD CONSTRAINT `place_city_FK` FOREIGN KEY (`place_city`) REFERENCES `city` (`city_id`),
  ADD CONSTRAINT `place_country_FK` FOREIGN KEY (`place_country`) REFERENCES `country` (`country_id`),
  ADD CONSTRAINT `place_merchant_FK` FOREIGN KEY (`place_merchant_id`) REFERENCES `merchant` (`merchant_id`),
  ADD CONSTRAINT `place_state_FK` FOREIGN KEY (`place_state`) REFERENCES `state` (`state_id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_category_FK` FOREIGN KEY (`product_category`) REFERENCES `product_category` (`product_category_id`),
  ADD CONSTRAINT `product_merchant_FK` FOREIGN KEY (`product_merchant_id`) REFERENCES `merchant` (`merchant_id`);

--
-- Constraints for table `product_place`
--
ALTER TABLE `product_place`
  ADD CONSTRAINT `product_place_FK` FOREIGN KEY (`place_id`) REFERENCES `places` (`place_id`),
  ADD CONSTRAINT `productplace_product_FK` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_usertype_FK` FOREIGN KEY (`user_type`) REFERENCES `user_type` (`user_type_id`);

--
-- Constraints for table `user_detail`
--
ALTER TABLE `user_detail`
  ADD CONSTRAINT `userdetail_usertype_FK` FOREIGN KEY (`user_type`) REFERENCES `user_type` (`user_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
