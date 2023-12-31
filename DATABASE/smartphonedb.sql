-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 26, 2023 at 07:57 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smartphonedb`
--

-- --------------------------------------------------------

--
-- Table structure for table `cartdetail`
--

CREATE TABLE `cartdetail` (
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unitPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cartdetail`
--

INSERT INTO `cartdetail` (`userId`, `productId`, `quantity`, `unitPrice`) VALUES
(7, 142, 1, 25590000),
(35, 142, 1, 1100000),
(35, 150, 2, 8690000);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `supplierId` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `supplierId`, `status`) VALUES
(30, 'IPHONE', 1, 1),
(31, 'SAMSUNG', 2, 1),
(32, 'VIVO', 5, 1),
(39, 'IPHONE1', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `coupon`
--

CREATE TABLE `coupon` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `count` int(11) NOT NULL,
  `promotion` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `coupon`
--

INSERT INTO `coupon` (`id`, `code`, `count`, `promotion`, `description`, `status`) VALUES
(1, 'CM3', 40, '3', 'Khuyến mãi 3%', 1),
(2, 'CM4', 30, '10', 'Khuyến mãi 10%', 1),
(3, 'CM5', 1, '5', 'Khuyến mãi 5%', 1),
(14, 'CM6', 0, '1', 'Không khuyến mãi ', 1);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `address` varchar(200) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `userId` int(11) NOT NULL,
  `statusCustomer` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `fullname`, `address`, `phone`, `email`, `userId`, `statusCustomer`) VALUES
(1, 'Nguyen Chi Cong', 'Cà Mau', '0948399484', 'congkhpro291002@gmail.com', 7, 1),
(2, 'Nguyen Van Tien Dụng', 'Binh Chanh', '0948399484', 'tiendung2209@gmail.com', 8, 1),
(3, 'Nguyen Thanh Trung', 'Ha Noi', '0912314500', 'thanhtrung2203@gmail.com', 33, 1),
(4, 'Nguyen Trung Thanh', 'Dak Lak', '0862222110', 'thanhtrung22022004@gmail.com', 35, 1);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `address` varchar(200) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `salary` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `userId`, `fullname`, `address`, `phone`, `email`, `salary`, `status`) VALUES
(2, 11, 'Nguyen Van Tien Dung', 'Ha Noi', '0867453290', 'chicong123@gmail.com', 2500000, 1),
(3, 26, 'Lai Quang Vinh', 'Long An', '0346457860', 'tuongtanduy2004@gmail.com', 3000000, 1),
(4, 34, 'Nguyen Dinh Thinh', 'Dong Nai', '0948399484', 'dinhthinh12345@gmail.com', 100000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `forgot_password_token`
--

CREATE TABLE `forgot_password_token` (
  `id` int(11) NOT NULL,
  `token` varchar(100) NOT NULL,
  `isuUsed` tinyint(1) NOT NULL,
  `expireTime` datetime NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `forgot_password_token`
--

INSERT INTO `forgot_password_token` (`id`, `token`, `isuUsed`, `expireTime`, `user_id`) VALUES
(4, 'dad34529-e3c4-48ca-b51a-23a3df6430b5', 0, '2023-12-08 21:10:55', 7);

-- --------------------------------------------------------

--
-- Table structure for table `importbill`
--

CREATE TABLE `importbill` (
  `id` int(11) NOT NULL,
  `supplierId` int(11) NOT NULL,
  `importDate` date NOT NULL,
  `Status` int(11) NOT NULL,
  `total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `importbill`
--

INSERT INTO `importbill` (`id`, `supplierId`, `importDate`, `Status`, `total`) VALUES
(1, 1, '2022-10-22', 1, 1500000),
(2, 2, '2023-11-24', 2, 1500000),
(27, 1, '2023-12-06', 1, 15000000),
(28, 1, '2023-12-07', 1, 300000000),
(29, 1, '2023-12-07', 1, 135000000),
(30, 1, '2023-12-07', 1, 100000000),
(31, 2, '2023-12-07', 1, 11000000),
(32, 1, '2023-12-07', 1, 11000000),
(33, 1, '2023-12-07', 1, 0),
(34, 1, '2023-12-07', 1, 11000000),
(35, 1, '2023-12-07', 1, 110000000),
(36, 1, '2023-12-09', 1, 3000000);

-- --------------------------------------------------------

--
-- Table structure for table `importbilldetail`
--

CREATE TABLE `importbilldetail` (
  `id` int(11) NOT NULL,
  `importId` int(11) DEFAULT NULL,
  `productId` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unitPrice` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `importbilldetail`
--

INSERT INTO `importbilldetail` (`id`, `importId`, `productId`, `quantity`, `unitPrice`) VALUES
(1, 1, 131, 2, 20000),
(2, 1, 132, 3, 13000000),
(3, 2, 132, 1, 230000),
(24, 27, 142, 1, 15000000),
(25, 28, 142, 10, 30000000),
(26, 29, 142, 4, 33750000),
(27, 30, 149, 5, 20000000),
(28, 35, 142, 3, 36666666.666666664),
(29, 36, 142, 3, 1000000);

-- --------------------------------------------------------

--
-- Table structure for table `orderdetail`
--

CREATE TABLE `orderdetail` (
  `orderId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unitPrice` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderdetail`
--

INSERT INTO `orderdetail` (`orderId`, `productId`, `quantity`, `unitPrice`) VALUES
(19, 144, 1, 25590000),
(19, 146, 1, 25590000),
(20, 150, 2, 8690000),
(22, 146, 1, 25590000),
(35, 142, 1, 25590000);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `employeeId` int(11) DEFAULT NULL,
  `adminName` varchar(50) NOT NULL,
  `orderDate` date NOT NULL,
  `Status` int(11) NOT NULL,
  `couponId` int(11) DEFAULT NULL,
  `paymentMethod` varchar(50) NOT NULL,
  `total` double NOT NULL,
  `ShipName` varchar(50) NOT NULL,
  `ShipAddress` varchar(200) NOT NULL,
  `ShipPhoneNumber` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customerId`, `employeeId`, `adminName`, `orderDate`, `Status`, `couponId`, `paymentMethod`, `total`, `ShipName`, `ShipAddress`, `ShipPhoneNumber`) VALUES
(19, 1, NULL, 'Mai Ngoc Canh', '2023-12-22', 4, 1, 'COD', 49644600, 'Nguyen Chi Cong', 'Cà Mau', '0948399484'),
(20, 4, 3, '', '2023-12-23', 4, 1, 'COD', 16858600, 'Nguyen Trung Thanh', 'Dak Lak', '0862222110'),
(22, 1, NULL, 'Mai Ngoc Canh', '2023-12-24', 4, 1, 'COD', 24822300, 'Nguyen Chi Cong', 'Cà Mau', '0948399484'),
(35, 1, NULL, 'Mai Ngoc Canh', '2023-12-26', 4, 1, 'COD', 24822300, 'Nguyen Chi Cong', 'Cà Mau', '0948399484');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` double(50,0) NOT NULL,
  `Image` varchar(100) NOT NULL,
  `description` varchar(10000) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `color` varchar(50) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `ScreenSize` varchar(50) DEFAULT NULL,
  `FrontCamera` varchar(50) DEFAULT NULL,
  `Chipset` varchar(50) DEFAULT NULL,
  `RAM` varchar(50) DEFAULT NULL,
  `InternalStorage` varchar(50) DEFAULT NULL,
  `Battery` varchar(50) DEFAULT NULL,
  `importPrice` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `price`, `Image`, `description`, `categoryId`, `quantity`, `color`, `status`, `ScreenSize`, `FrontCamera`, `Chipset`, `RAM`, `InternalStorage`, `Battery`, `importPrice`) VALUES
(131, 'iPhone 15 Pro Max 256GB', 34920000, 'IPhone_1.jpeg', 'iPhone 15 Pro Max đem lại một diện mạo hoàn toàn mới và sở hữu nhiều tính năng ưu việt cùng công nghệ tiên tiến. Hãy khám phá các đánh giá chi tiết về sản phẩm về khía cạnh thiết kế, màn hình, hiệu năng, thời lượng pin và bộ camera độc đáo qua các thông tin dưới đây!', 30, 100, 'đen', 1, NULL, NULL, NULL, '8 GB\n', NULL, NULL, NULL),
(132, 'iPhone 15 Pro Max 256GB', 34290000, 'IPhone_2.png', 'Đẹp Xứng Đáng với chất lượng', 30, 100, 'xanh', 1, NULL, NULL, NULL, '8 GB', NULL, NULL, NULL),
(142, 'iPhone 15 Plus VN/a', 25590000, 'iphone-15-plus-black-thumbtz-650x650.png.png', 'iPhone 15 Plus VN/a', 30, 28, 'đen', 1, NULL, NULL, NULL, '6 GB', NULL, NULL, 1000000),
(143, 'iPhone 15 Plus VN/a', 25590000, 'iphone-15-plus yellow.png', 'iPhone 15 Plus VN/a', 30, 99, 'Vàng', 1, '6.7 inches', '12MP, ƒ/1.9', 'Apple A16 Bionic', '6 GB', '512 GB', '4383 mAh', NULL),
(144, 'iPhone 15 Plus VN/a', 25590000, 'iphone15pink.jpg', 'iPhone 15 Plus VN/a', 30, 95, 'hồng', 1, '6.7 inches', '12MP, ƒ/1.9', 'Apple A16 Bionic', '6 GB', '512 GB', '4383 mAh', NULL),
(145, 'Samsung Galaxy S23 Ultra 8/256GB', 25900000, 'SamsungGalaxyS23_BLACK.png', 'Samsung Galaxy S23 Ultra 8/256GB', 31, 100, 'Đen', 1, '6.8 inches', '12MP F2.2 (Dual Pixel AF)', 'Snapdragon 8 Gen 2 (4 nm)', '8 GB', '256 GB', '5,000mAh', NULL),
(146, 'Samsung Galaxy S23 Ultra 8/256GB', 25590000, 'SamsungGalaxyS23_WHITE.png', 'Samsung Galaxy S23 Ultra 8/256GB', 31, 91, 'Trắng', 1, '6.8 inches', '12MP F2.2 (Dual Pixel AF)', 'Snapdragon 8 Gen 2 (4 nm)', '8 GB', '256 GB', '5,000mAh', NULL),
(147, 'Samsung Galaxy S23 Ultra 8/256GB', 25590000, 'SamsungGalaxyS23_GREEN.png', 'Samsung Galaxy S23 Ultra 8/256GB', 31, 100, 'xanh lá', 1, '6.8 inches', '12MP F2.2 (Dual Pixel AF)', 'Snapdragon 8 Gen 2 (4 nm)', '8 GB', '256 GB', '5,000mAh', NULL),
(149, 'Samsung Galaxy A54 5G 8/128GB', 22000000, 'SamsungGalaxyA5_BLACK.png', 'Samsung Galaxy A54 5G 8/128GB', 31, 105, 'đen', 1, '6.4 inches', 'Camera góc rộng: 32 MP, f/2.2, 26mm, 1/2.8\", 0.8µm', 'Exynos 1380 (5 nm)', '8 GB', '128 GB', '5000 mAh', 20000000),
(150, 'Samsung Galaxy A54 5G 8/128GB', 8690000, 'SamsungGalaxyA5_TIM.png', 'Samsung Galaxy A54 5G 8/128GB', 31, 96, 'Tím', 1, '6.4 inches', 'Camera góc rộng: 32 MP, f/2.2, 26mm, 1/2.8\", 0.8µm', 'Exynos 1380 (5 nm)', '8 GB', '128 GB', '5000 mAh', NULL),
(151, 'Vivo V29e 8GB-256GB', 8690000, 'Vivo_V29e.png', 'Vivo V29e 8GB-256GB', 32, 100, 'xanh', 1, '6.67 inches', '50 MP, f/2.0, AF', 'Qualcomm Snapdragon 695', '8 GB', '256 GB', '4800 mAh', NULL),
(152, 'Vivo Y17s 4/128GB', 3890000, 'Vivo_Y17s.png', 'Vivo Y17s 4/128GB', 32, 100, 'Tím', 1, '6.56 inches', '8 MP, f/2.0', 'MediaTek Helio G85', '4 GB', '128 GB', '5000 mAh', NULL),
(153, 'Vivo Y36 8-128GB', 5490000, 'Vivo_Y36.png', 'Vivo Y36 8-128GB', 32, 100, 'xanh', 1, '6.64 inches', '16 MP, f/2.45', 'Snapdragon 680 8 nhân', '8 GB', '128 GB', '5,000 mAh', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `review`
--

CREATE TABLE `review` (
  `id` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `rating` int(50) NOT NULL,
  `DateReview` datetime NOT NULL,
  `comments` varchar(2000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `review`
--

INSERT INTO `review` (`id`, `customerId`, `productId`, `rating`, `DateReview`, `comments`) VALUES
(38, 1, 142, 5, '2023-12-08 23:52:23', 'Sản phẩm tốt'),
(39, 3, 142, 5, '2023-12-08 23:52:23', 'Sản phẩm tốt'),
(40, 1, 142, 5, '2023-12-08 22:59:58', 'sản phẩm tốt'),
(41, 1, 143, 5, '2023-12-25 18:36:17', 'sản phẩm tốt chất lượng nên mua'),
(42, 1, 143, 4, '2023-12-25 18:36:56', 'đánh giá sản phẩm lần 2'),
(43, 1, 146, 5, '2023-12-26 04:58:54', 'Sản phẩm tốt chất lượng cao '),
(44, 1, 144, 4, '2023-12-26 04:59:31', 'Sản phẩm tốt chất lượng tạm được '),
(45, 1, 142, 4, '2023-12-26 06:50:54', 'Sản phẩm chất lượng tốt đáng tin cậy');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `Id` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `PhoneNumber` varchar(10) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`Id`, `Name`, `PhoneNumber`, `Address`, `status`) VALUES
(1, 'Apple', '0816089161', 'Ca Mau', 1),
(2, 'Samsung', '0785431800', 'Ha Noi', 1),
(5, 'Vivo APEX', '0785346410', 'Ha Noi', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(100) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `role` enum('ADMIN','USER','EMPLOYEE') NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `fullname`, `address`, `phone`, `role`, `status`) VALUES
(7, 'congkhpro291002@gmail.com', '$2a$10$4zzxBP0Ot2GonLPW4mNnz.BkeS9tX0ZWM5FL4rPHc607QNVyzUGgm', 'Nguyen Chi Cong', 'Ca Mau', '0129293493', 'USER', 1),
(8, 'congnguyen@gmail.com', '$2a$10$/RK4hgagmY7w/8CyYhQ.E.qcgFiI1ANppwn3Pq6l0oOFRjwvUOxSm', 'Bui Duy Hung', 'Dak Lak', '0823147350', 'USER', 1),
(9, 'admin@gmail.com', '$2a$10$cFfZBkooDqE7HzlM0b9dm.CGFs7XE3bpUVPB.iSIJyB/OnQKIPAHm', 'Mai Ngoc Canh', 'Ben Tre', '0347349402', 'ADMIN', 1),
(11, 'chicong123@gmail.com', '$2a$10$fvULYA6JnR2wssmuqEE.rOdXJ0/yK1poTTI2NqfB.qmizyWiWxPNS', 'Nguyen Van Tien Dung', 'Ha Noi', '0867453290', 'EMPLOYEE', 1),
(26, 'tuongtanduy2004@gmail.com', '$2a$10$JCkdXm7DaACyfkRxuAnQHOL46eQ31qrBLgGX2KoUxfBHweZK82Hv6', 'Lai Quang Vinh', 'Long An', '0346457860', 'EMPLOYEE', 1),
(27, 'congkhpro231@gmail.com', '$2a$10$LS26b9.S3kp9j/lDu9K88OPe0wr9/9aQmRfbjfRDfONVYI4daHGw2', 'Pham Dang Khoa', 'Dak Lak', '0756590412', 'EMPLOYEE', 1),
(28, 'kitout306@gmail.com', '$2a$10$Gdtw4H4ekZDeZVqBaqtxouULsWWx/TxOQBQ8jCfD72suwAn8l5m4G', 'Nguyen Dinh Thinh', 'Dong Nai', '0128754100', 'ADMIN', 1),
(32, 'thanhtrung2202@gmail.com', '$2a$10$yqaEDfPfi/stQYKbOf/xf.mte9VB0uiIvlDmdPIKfZNl5vXf3Ugk.', 'Nguyen Thanh Trung', 'Ha Noi', '0915113300', 'USER', 1),
(33, 'thanhtrung2203@gmail.com', '$2a$10$9WWJsJ6ShJLpQR971s6zjepW7Y.kP2ntKzB62ew3./RNcnXOJAbmC', 'Nguyen Thanh Trung', 'Ha Noi', '0912314500', 'USER', 1),
(34, 'dinhthinh12345@gmail.com', '$2a$10$YWHJTIjD5KD0T0.YPKSRbe70goQHX2d2HFk53Hvmt3IPp5NFZKhYG', 'Nguyen Dinh Thinh', 'Dong Nai', '0948399484', 'EMPLOYEE', 1),
(35, 'thanhtrung22022004@gmail.com', '$2a$10$jdvMIgm4ZgIdwJTSwJ3JDeG/nMdvHPDwa3uF2YvJfDY98h5yujV9W', 'Nguyen Trung Thanh', 'Dak Lak', '0862222110', 'USER', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cartdetail`
--
ALTER TABLE `cartdetail`
  ADD PRIMARY KEY (`userId`,`productId`),
  ADD KEY `fk_cart_product` (`productId`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `s` (`supplierId`);

--
-- Indexes for table `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_fk_3` (`userId`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_fk_2` (`userId`);

--
-- Indexes for table `forgot_password_token`
--
ALTER TABLE `forgot_password_token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_id2` (`user_id`);

--
-- Indexes for table `importbill`
--
ALTER TABLE `importbill`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_supplier_id` (`supplierId`);

--
-- Indexes for table `importbilldetail`
--
ALTER TABLE `importbilldetail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_import` (`importId`),
  ADD KEY `fk_product` (`productId`);

--
-- Indexes for table `orderdetail`
--
ALTER TABLE `orderdetail`
  ADD PRIMARY KEY (`orderId`,`productId`),
  ADD KEY `product_fk` (`productId`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coupon_fk` (`couponId`),
  ADD KEY `FK_customer_1` (`customerId`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_fk` (`categoryId`);

--
-- Indexes for table `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_fk_2` (`productId`),
  ADD KEY `fk_customer` (`customerId`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `coupon`
--
ALTER TABLE `coupon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `forgot_password_token`
--
ALTER TABLE `forgot_password_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `importbill`
--
ALTER TABLE `importbill`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `importbilldetail`
--
ALTER TABLE `importbilldetail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `review`
--
ALTER TABLE `review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cartdetail`
--
ALTER TABLE `cartdetail`
  ADD CONSTRAINT `fk_cart_product` FOREIGN KEY (`productId`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `fk_cart_user` FOREIGN KEY (`userId`) REFERENCES `user` (`id`);

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `s` FOREIGN KEY (`supplierId`) REFERENCES `supplier` (`Id`);

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `user_fk_3` FOREIGN KEY (`userId`) REFERENCES `user` (`id`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `user_fk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`);

--
-- Constraints for table `forgot_password_token`
--
ALTER TABLE `forgot_password_token`
  ADD CONSTRAINT `fk_user_id2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `importbill`
--
ALTER TABLE `importbill`
  ADD CONSTRAINT `fk_supplier_id` FOREIGN KEY (`supplierId`) REFERENCES `supplier` (`Id`);

--
-- Constraints for table `importbilldetail`
--
ALTER TABLE `importbilldetail`
  ADD CONSTRAINT `fk_import` FOREIGN KEY (`importId`) REFERENCES `importbill` (`id`),
  ADD CONSTRAINT `fk_product` FOREIGN KEY (`productId`) REFERENCES `product` (`id`);

--
-- Constraints for table `orderdetail`
--
ALTER TABLE `orderdetail`
  ADD CONSTRAINT `order_fk` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `product_fk` FOREIGN KEY (`productId`) REFERENCES `product` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_customer_1` FOREIGN KEY (`customerId`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `coupon_fk` FOREIGN KEY (`couponId`) REFERENCES `coupon` (`id`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `category_fk` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`);

--
-- Constraints for table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `fk_customer` FOREIGN KEY (`customerId`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `product_fk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
