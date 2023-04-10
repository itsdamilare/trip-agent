-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 08, 2023 at 10:44 AM
-- Server version: 10.4.16-MariaDB
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trip_agent`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL COMMENT 'Users table reference id',
  `package_id` int(11) NOT NULL COMMENT 'Package table reference id',
  `booked_seats` int(11) NOT NULL DEFAULT 1,
  `price` int(11) NOT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2014_10_12_100000_create_password_resets_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2023_03_24_144128_create_packages_table', 1),
(7, '2023_03_24_152332_create_bookings_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE `packages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `date` date NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_available` int(11) NOT NULL,
  `has_insurance` int(11) NOT NULL,
  `total_seats` int(11) NOT NULL,
  `booked_seats` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `title`, `description`, `price`, `date`, `image_url`, `is_available`, `has_insurance`, `total_seats`, `booked_seats`, `created_at`, `updated_at`) VALUES
(1, 'Bali Retreat', 'Escape to a tropical paradise in Bali', 1500, '2023-04-24', 'https://images.pexels.com/photos/169647/pexels-photo-169647.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 20, 0, NULL, NULL),
(2, 'Northern Lights Adventure', 'Witness the beauty of the Northern Lights in Norway', 2500, '2023-05-24', 'https://images.pexels.com/photos/313782/pexels-photo-313782.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 15, 0, NULL, NULL),
(3, 'Safari Adventure', 'Explore the wildlife of Africa on a safari tour', 3000, '2023-06-24', 'https://images.pexels.com/photos/460672/pexels-photo-460672.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 10, 0, NULL, NULL),
(4, 'Mediterranean Cruise', 'Discover the beauty of the Mediterranean on a luxury cruise', 4000, '2023-07-24', 'https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 30, 0, NULL, NULL),
(5, 'Grand Canyon Expedition', 'Experience the awe-inspiring beauty of the Grand Canyon', 1200, '2023-08-24', 'https://images.pexels.com/photos/417344/pexels-photo-417344.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 25, 0, NULL, NULL),
(6, 'Tropical Island Getaway', 'Relax on a secluded island paradise in the Caribbean', 2000, '2023-09-24', 'https://images.pexels.com/photos/699466/pexels-photo-699466.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 12, 0, NULL, NULL),
(7, 'Historical European Tour', 'Explore the rich history of Europe on a guided tour', 3500, '2023-04-24', 'https://images.pexels.com/photos/802024/pexels-photo-802024.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 18, 0, NULL, NULL),
(8, 'Skiing Adventure', 'Hit the slopes on a skiing adventure in the Swiss Alps', 2800, '2023-05-24', 'https://images.pexels.com/photos/256150/pexels-photo-256150.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 20, 0, NULL, NULL),
(9, 'Trekking Expedition', 'Embark on a challenging trekking adventure in the Himalayas', 4500, '2023-06-24', 'https://images.pexels.com/photos/681335/pexels-photo-681335.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 8, 0, NULL, NULL),
(10, 'Beach Vacation', 'Relax on the sandy beaches of Hawaii', 1800, '2023-07-24', 'https://images.pexels.com/photos/220769/pexels-photo-220769.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 16, 0, NULL, NULL),
(11, 'Amazon Rainforest Expedition', 'Explore the wonders of the Amazon rainforest on a guided tour', 3500, '2023-04-24', 'https://images.pexels.com/photos/773471/pexels-photo-773471.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 10, 0, NULL, NULL),
(12, 'Road Trip Across America', 'Embark on an epic road trip across the United States', 5000, '2023-05-24', 'https://images.pexels.com/photos/386009/pexels-photo-386009.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 8, 0, NULL, NULL),
(13, 'Sailing Adventure', 'Sail the seas on a luxury yacht and explore hidden coves', 4000, '2023-06-24', 'https://images.pexels.com/photos/280221/pexels-photo-280221.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 12, 0, NULL, NULL),
(14, 'Cultural Immersion Tour', 'Immerse yourself in the local culture on a guided tour of Thailand', 2500, '2023-07-24', 'https://images.pexels.com/photos/672532/pexels-photo-672532.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 20, 0, NULL, NULL),
(15, 'Snowy Mountain Retreat', 'Escape to a cozy cabin in the mountains for a winter getaway', 1500, '2023-08-24', 'https://images.pexels.com/photos/753339/pexels-photo-753339.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 16, 0, NULL, NULL),
(16, 'Volcano Expedition', 'Hike to the summit of an active volcano in Indonesia', 3000, '2023-09-24', 'https://images.pexels.com/photos/16036300/pexels-photo-16036300.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 6, 0, NULL, NULL),
(17, 'Wine Tasting Tour', 'Sip on world-class wines on a guided tour of Napa Valley', 2000, '2023-04-24', 'https://images.pexels.com/photos/16022149/pexels-photo-16022149.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 14, 0, NULL, NULL),
(18, 'Bungee Jumping Adventure', 'Experience the thrill of bungee jumping in New Zealand', 1800, '2023-05-24', 'https://images.pexels.com/photos/1271619/pexels-photo-1271619.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 8, 0, NULL, NULL),
(19, 'Tropical Rainforest Trek', 'Hike through the lush tropical rainforests of Costa Rica', 2800, '2023-06-24', 'https://images.pexels.com/photos/287240/pexels-photo-287240.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 10, 0, NULL, NULL),
(20, 'City Sightseeing Tour', 'Discover the sights and sounds of New York City on a guided tour', 1500, '2023-07-24', 'https://images.pexels.com/photos/2174656/pexels-photo-2174656.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 20, 0, NULL, NULL),
(21, 'Jungle Safari in Tanzania', 'Experience the thrill of an African safari in the wilds of Tanzania', 4500, '2023-08-24', 'https://images.pexels.com/photos/2166559/pexels-photo-2166559.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 8, 0, NULL, NULL),
(22, 'Climb Mount Kilimanjaro', 'Embark on a challenging trek to the summit of Mount Kilimanjaro', 6000, '2023-09-24', 'https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 6, 0, NULL, NULL),
(23, 'Skiing Adventure in Japan', 'Hit the slopes and enjoy world-class skiing in Japan', 4000, '2023-09-24', 'https://images.pexels.com/photos/38238/maldives-ile-beach-sun-38238.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 12, 0, NULL, NULL),
(24, 'Northern Lights Tour in Norway', 'Witness the mesmerizing beauty of the Northern Lights in Norway', 5500, '2023-05-24', 'https://images.pexels.com/photos/16036927/pexels-photo-16036927.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 10, 0, NULL, NULL),
(25, 'Cycling Tour of France', 'Cycle through the picturesque countryside of France on a guided tour', 3500, '2023-04-24', 'https://images.pexels.com/photos/16021280/pexels-photo-16021280.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 16, 0, NULL, NULL),
(26, 'Diving Expedition in Belize', 'Explore the vibrant coral reefs of Belize on a diving expedition', 5000, '2023-06-24', 'https://images.pexels.com/photos/14388028/pexels-photo-14388028.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 6, 0, NULL, NULL),
(27, 'Rafting Adventure in Costa Rica', 'Get your adrenaline pumping on a white-water rafting adventure in Costa Rica', 3000, '2023-06-24', 'https://images.pexels.com/photos/16000582/pexels-photo-16000582.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 8, 0, NULL, NULL),
(28, 'Hiking Tour of Patagonia', 'Hike through the stunning landscapes of Patagonia on a guided tour', 4500, '2023-07-24', 'https://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 10, 0, NULL, NULL),
(29, 'Cultural Heritage Tour of India', 'Explore the rich cultural heritage of India on a guided tour', 2500, '2023-04-24', 'https://images.pexels.com/photos/15973830/pexels-photo-15973830.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 1, 20, 0, NULL, NULL),
(30, 'Island Hopping in the Philippines', 'Discover the beauty of the Philippines by hopping from one tropical island to another', 4000, '2023-05-24', 'https://images.pexels.com/photos/16013792/pexels-photo-16013792.jpeg?auto=compress&cs=tinysrgb&w=800', 1, 0, 12, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(8, 'Emmanuel Momoh', 'emmamomohs@gmail.com', NULL, '$2y$10$Ka95qEoeUQkm4HkPwMGP1uXKRDA3h7Ob03YAtRSM1FUq7TcMGh9mW', NULL, '2023-04-04 13:32:05', '2023-04-04 13:32:05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packages`
--
ALTER TABLE `packages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `packages`
--
ALTER TABLE `packages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
