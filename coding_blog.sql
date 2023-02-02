-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 02, 2023 at 04:55 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `coding blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `Serialno` int(50) NOT NULL,
  `Name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `PhoneNumber` varchar(50) NOT NULL,
  `Message` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`Serialno`, `Name`, `email`, `PhoneNumber`, `Message`, `date`) VALUES
(1, 'first post', 'firstpost@gmail.com', '1234567098', '', '2022-12-08 13:06:45'),
(2, 'ABC', 'abc@gmail.com', '9947281289', 'Hi,This is blog related to Coding.', '2022-12-08 13:51:13'),
(3, 'new name', 'new@gmail.com', '6727912649', 'posting now.', '2022-12-09 20:51:38'),
(4, 'name', 'add@gmail.com', '3828191949', 'this is blog.', '2022-12-17 11:08:56');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `Serialno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(12) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`Serialno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'Let\'s learn about Coding.', 'this is first post', 'first-post', 'This is my post Related to Better Programming is a programming-oriented blog on Medium. They publish multiple articles every day from several authors, all curated and edited to ensure excellent content.\n\nThey cover a range of subjects and languages for programming, with content for both beginners and very advanced readers. If you want to develop programming skills, it’s a must-have on your daily reading list. So, before you plan to start your own programming blog, it is best to be a regular reader of Better Programming blogs!', 'post-bg.jpg', '2022-12-17 16:12:23'),
(2, 'Becoming Coder', 'this is second post how to become coder', 'second-post', 'Before you switch careers, first things first: you should know the basic definition of computer code. Professional coders (also known as Software Engineers or Web Developers) write in a variety of programming languages to create software, apps, and websites. All the apps on your phone, the browser you’re working on, your social media feed—it’s all been brought to life with the help of code.\r\n\r\nSimilar to the way a cook follows a set of step-by-step instructions to create a signature dish, computer code is a set of instructions that guide software to perform a desired function. That should give you a good picture of what a coder does.\r\n\r\nCode can be as simple as a one-line instruction. For example, below is a one-line code in Python that prints the text ‘Hello World’:', 'home-bg.jpg', '2022-12-18 19:12:00'),
(3, 'Tips for Programming Beginners', 'Tips ', 'coding-tips', 'Coding and programming demand is skyrocketing every single day. Programming and software creation is now a billion-dollar business. Apart from the list of the best programming blogs and websites, you saw above, here are a few top tips that will help you in mastering your coding skills!\r\n\r\nStart with the Basics: It’s crucial for you to learn the basics first in any programming language. It will get much simpler to learn the programming language once you understand the fundamentals correctly.\r\nFind a Programming Buddy: Having a companion who has common coding ambitions is one of the best ways to practice programming and coding. You can either reach out to your neighborhood, office mates, or college friends, or you can use online groups to find buddies.\r\nCode by Hand: If you ever want to study programming languages to a fundamental degree, the only successful way to go is to write codes by hand.\r\nLearn by Practicing: You’ll find a lot of free online programs, videos, guides, etc. to learn how to code, but you’ll only be able to code once you really start doing it. You can use free programming sites to educate yourself and even use their educational software to start coding.\r\nLook for as Many Courses as You Can: One platform will teach you something, and other platforms will teach you a few other coding talents, so when you start out, make sure you spend your time searching for as many courses as you can.', 'a.jpg', '2022-12-18 19:19:27'),
(6, 'ababa', 'tt', 'ff=77', 'hgh', 'a.png', '2022-12-19 11:52:29');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`Serialno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`Serialno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `Serialno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `Serialno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
