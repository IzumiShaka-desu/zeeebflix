-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 13, 2020 at 02:48 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `zeeebflix`
--

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `email` varchar(30) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favorite`
--

INSERT INTO `favorite` (`email`, `id`) VALUES
('se@mail.com', 1),
('sh@mail.com', 5),
('se@mail.com', 3),
('se@mail.com', 6);

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `country` varchar(12) NOT NULL,
  `length` varchar(12) NOT NULL,
  `rating` double NOT NULL,
  `year` int(7) NOT NULL,
  `genres` varchar(30) NOT NULL,
  `details` varchar(50) NOT NULL,
  `ytUrl` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`id`, `title`, `country`, `length`, `rating`, `year`, `genres`, `details`, `ytUrl`) VALUES
(1, 'Mulan', 'USA', '113min', 3, 2020, 'Action,Adventure,Martial Arts', 'A young Chinese maiden disguises herself as a male', 'https://www.youtube.com/watch?v=KK8FHdFluOQ'),
(2, 'Kamen Rider × Super Sentai × Uchuu Keiji', 'JP', '118min', 4, 2013, 'Action,Superhero,Drama,Comedy', 'A new evil organization known as Space Shocker, wh', 'https://www.youtube.com/watch?v=49ttxlWY6VA'),
(3, 'Love and Murder of S', 'JP', '118min', 5, 2019, 'Drama,Horror,Mystery', 'Etsuro is a loner who does not leave his place. He', 'https://www.youtube.com/watch?v=i4HWnogEqto'),
(4, 'Isshukan Friends', 'JP', '113min', 4, 2017, 'Comedy,Drama,Romance ', 'Yuki Hase befriended a lonely girl classmate when ', 'https://www.youtube.com/watch?v=s47d7J3hVwA'),
(5, 'Cold Eyes', 'KR', '117min', 3.8, 2013, ' Action,Crime,Thriller', 'A high-tech police surveillance team attempts to t', 'https://www.youtube.com/watch?v=ltrpZfmdbmw'),
(6, 'Avengers: END GAME', 'USA', '118min', 4.8, 2019, 'Action,Adventure,Drama', 'After the devastating events of Avengers: Infinity', 'https://www.youtube.com/watch?v=X9Q5A9j4N3A'),
(7, 'X-Men: Dark Phoenix', 'USA', '117min', 4, 2019, 'Action,Adventure,Sci-Fi', 'Jean Grey begins to develop incredible powers that', 'https://www.youtube.com/watch?v=C3Y6t2culaA'),
(8, 'ParaNorman', 'USA', '112min', 3, 2012, ' Animation,Adventure,Comedy', 'A misunderstood boy takes on ghosts, zombies and g', 'https://www.youtube.com/watch?v=fvk5wgVHSss'),
(9, 'The Thinning', 'USA', '110min', 3, 2016, 'Action,Drama,Horror ', 'In a future, overcrowded, dystopian society, stude', 'https://www.youtube.com/watch?v=XD3M5JN1uhg'),
(10, 'Tensou Sentai Goseiger Vs Shinkenger ', 'JP', '112min', 4, 2011, 'Action', 'While running some errands for his fellow Goseiger', 'https://www.youtube.com/watch?v=ELqMh6P4hvE'),
(11, 'Rasuk 2', 'ID', '113min', 4, 2020, 'Horor', 'Isabella experienced something in the autopsy room', 'https://www.youtube.com/watch?v=meM9vCpeyA4'),
(12, 'The Road', 'USA', '113min', 4, 2009, 'Drama', 'In a dangerous post-apocalyptic world, an ailing f', 'https://www.youtube.com/watch?v=El6fxciKhn8'),
(13, 'Spirited Away', 'JP', '110min', 4, 2001, 'Animation, Adventure, Family ', 'During her family\'s move to the suburbs, a sullen ', 'https://www.youtube.com/watch?v=guGKen41YR4'),
(14, 'The Great Wall', 'USA', '115min', 4.6, 2016, ' Action,Adventure,Fantasy', 'In ancient China, a group of European mercenaries ', 'https://www.youtube.com/watch?v=sN5tZniP1p0'),
(15, 'Here Comes Hell ', 'USA', '114min', 3.8, 2019, 'Comedy,Horror ', 'A 1930\'s dinner party descends into carnage, gore ', 'https://www.youtube.com/watch?v=ZBP7OwcECvI');

-- --------------------------------------------------------

--
-- Table structure for table `recommned`
--

CREATE TABLE `recommned` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `recommned`
--

INSERT INTO `recommned` (`id`) VALUES
(1),
(3),
(6),
(7),
(13);

-- --------------------------------------------------------

--
-- Table structure for table `userlogin`
--

CREATE TABLE `userlogin` (
  `id` int(11) NOT NULL,
  `email` varchar(30) NOT NULL,
  `fullname` varchar(30) NOT NULL,
  `password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `userlogin`
--

INSERT INTO `userlogin` (`id`, `email`, `fullname`, `password`) VALUES
(1, 'sh@mail.com', 'shamal', 'e2b98325e39318c3819acc27fc81cccd784b7e9a'),
(2, 'shk@mail.ckm', 'shk', '40bd001563085fc35165329ea1ff5c5ecbdbbeef'),
(3, 'se@mail.com', 'se', '00762ccfa703393e0daff813a6ecc19f7cd02421');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD KEY `id` (`id`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recommned`
--
ALTER TABLE `recommned`
  ADD KEY `id` (`id`);

--
-- Indexes for table `userlogin`
--
ALTER TABLE `userlogin`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `movie`
--
ALTER TABLE `movie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `userlogin`
--
ALTER TABLE `userlogin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `favorite`
--
ALTER TABLE `favorite`
  ADD CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`id`) REFERENCES `movie` (`id`);

--
-- Constraints for table `recommned`
--
ALTER TABLE `recommned`
  ADD CONSTRAINT `recommned_ibfk_1` FOREIGN KEY (`id`) REFERENCES `movie` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
