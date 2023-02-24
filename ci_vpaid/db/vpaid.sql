-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 29, 2017 at 12:50 PM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vpaid`
--

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `city_id` int(11) NOT NULL,
  `city_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`city_id`, `city_name`) VALUES
(1, 'Karachi'),
(2, 'Lahore');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country_name`) VALUES
(1, 'Pakistan');

-- --------------------------------------------------------

--
-- Table structure for table `device`
--

CREATE TABLE `device` (
  `device_id` int(11) NOT NULL,
  `device_token` text NOT NULL,
  `device_udid` text NOT NULL,
  `os_id` int(11) NOT NULL COMMENT '0 for ios, 1 for android',
  `date` datetime NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `device`
--

INSERT INTO `device` (`device_id`, `device_token`, `device_udid`, `os_id`, `date`, `user_id`) VALUES
(3, '123', '456', 0, '2017-04-29 16:16:58', 3),
(4, '123', '456', 0, '2017-04-29 16:20:00', 4);

-- --------------------------------------------------------

--
-- Table structure for table `merchant`
--

CREATE TABLE `merchant` (
  `merchant_id` int(11) NOT NULL,
  `merchant_name` varchar(40) NOT NULL,
  `merchant_category` int(11) NOT NULL,
  `merchant_description` text NOT NULL,
  `merchant_contact` varchar(40) NOT NULL,
  `merchant_address` text NOT NULL,
  `merchant_national_identity` text NOT NULL,
  `merchant_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `merchant`
--

INSERT INTO `merchant` (`merchant_id`, `merchant_name`, `merchant_category`, `merchant_description`, `merchant_contact`, `merchant_address`, `merchant_national_identity`, `merchant_type`) VALUES
(1, 'KFC', 1, 'Best Fast Food', '(021) 111 532 532', 'abc, Karachi, Pakistan.', '42000-1111111-1', 1),
(2, 'McDonald\'s', 1, 'Best Burgers', '0306 4214545', 'N Circular Avenue, Off:, Korangi Rd, Karachi', '42101-9999999-9', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `order_customer_id` int(11) NOT NULL,
  `order_place_id` int(11) NOT NULL,
  `order_total_price` int(11) NOT NULL,
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
  `place_id` int(11) NOT NULL,
  `place_name` varchar(40) NOT NULL,
  `place_address` text NOT NULL,
  `place_image` text NOT NULL,
  `place_city` int(11) NOT NULL,
  `place_state` int(11) NOT NULL,
  `place_country` int(11) NOT NULL,
  `place_merchant_type` int(11) DEFAULT NULL,
  `place_cover` text,
  `place_video` text,
  `place_merchant_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `place_cover_video_type` int(11) NOT NULL DEFAULT '0' COMMENT '0 for no video, 1 for youtube, 2 for vimeo, 3 for our server'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `places`
--

INSERT INTO `places` (`place_id`, `place_name`, `place_address`, `place_image`, `place_city`, `place_state`, `place_country`, `place_merchant_type`, `place_cover`, `place_video`, `place_merchant_id`, `is_active`, `is_delete`, `place_cover_video_type`) VALUES
(3, 'KFC', 'Nursery Flyover, Karachi', 'images/kfc.png', 1, 1, 1, 1, NULL, 'VxkSU-N-igE', 1, 1, 0, 1),
(4, 'McDonald\'s', 'Tariq Road', 'images/download.png', 1, 1, 1, 1, NULL, '99830142', 2, 1, 0, 2),
(5, 'KFC', 'Bahadur Shah Zafar Road, Karachi', 'images/kfc.png', 1, 1, 1, 1, 'images/kfc_cover.jpg', NULL, 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(40) NOT NULL,
  `product_merchant_id` int(11) NOT NULL,
  `product_category` int(11) NOT NULL,
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
(2, 'Mighty Zinger', 1, 1, 450, 'images/products/mighty_zinger.jpeg', 'Delicious pieces of juicy chicken thigh with KFC’s Spicy Zinger Recipe, cheese, fresh lettuce in a fresh round bun.', 1, 0),
(3, 'Cheeseburger', 2, 1, 300, 'images/products/cheese_burger.jpg', 'Say cheese! A legendary combo of 100% pure beef with onions, pickles, ketchup, mustard and cheese, all in a soft burger bun.', 1, 0),
(4, 'Milkshakes', 2, 1, 150, 'images/products/shakes.jpg', 'An irresistible blend! Acreamy, fresh milk and strawberry syrup shake so thick it hardly makes it up the straw.Also available in chocolate and vanilla.', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `product_category_id` int(11) NOT NULL,
  `product_category_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`product_category_id`, `product_category_name`) VALUES
(1, 'Fast Food'),
(2, 'Grocery');

-- --------------------------------------------------------

--
-- Table structure for table `product_place`
--

CREATE TABLE `product_place` (
  `product_place_id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_place`
--

INSERT INTO `product_place` (`product_place_id`, `place_id`, `product_id`) VALUES
(1, 3, 1),
(2, 3, 2),
(3, 4, 3),
(4, 4, 4),
(5, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `state`
--

CREATE TABLE `state` (
  `state_id` int(11) NOT NULL,
  `state_name` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `state`
--

INSERT INTO `state` (`state_id`, `state_name`) VALUES
(1, 'Sindh'),
(2, 'Punjab');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_firstName` varchar(40) NOT NULL,
  `user_lastName` varchar(40) DEFAULT NULL,
  `user_phone` varchar(30) NOT NULL,
  `user_image` text,
  `user_type` int(11) NOT NULL,
  `user_email` varchar(80) DEFAULT NULL,
  `user_password` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_firstName`, `user_lastName`, `user_phone`, `user_image`, `user_type`, `user_email`, `user_password`) VALUES
(3, 'Ammar', '', '03441234567', NULL, 2, NULL, NULL),
(4, 'Ahmed', '', '03451234567', NULL, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_detail`
--

CREATE TABLE `user_detail` (
  `user_detail_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_address` text,
  `user_city` int(11) DEFAULT NULL,
  `user_state` int(11) DEFAULT NULL,
  `user_country` int(11) DEFAULT NULL,
  `user_lat` double DEFAULT NULL,
  `user_lng` double DEFAULT NULL,
  `user_image` text,
  `user_type` int(11) NOT NULL,
  `user_email` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_detail`
--

INSERT INTO `user_detail` (`user_detail_id`, `user_id`, `user_address`, `user_city`, `user_state`, `user_country`, `user_lat`, `user_lng`, `user_image`, `user_type`, `user_email`) VALUES
(2, 3, NULL, 1, 1, 1, 24.867179, 67.080692, NULL, 2, NULL),
(3, 4, NULL, 1, 1, 1, 24.867179, 67.080692, NULL, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_type`
--

CREATE TABLE `user_type` (
  `user_type_id` int(11) NOT NULL,
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
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `device`
--
ALTER TABLE `device`
  MODIFY `device_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `merchant`
--
ALTER TABLE `merchant`
  MODIFY `merchant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `places`
--
ALTER TABLE `places`
  MODIFY `place_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `product_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `product_place`
--
ALTER TABLE `product_place`
  MODIFY `product_place_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `state`
--
ALTER TABLE `state`
  MODIFY `state_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `user_detail`
--
ALTER TABLE `user_detail`
  MODIFY `user_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `user_type`
--
ALTER TABLE `user_type`
  MODIFY `user_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
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

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
