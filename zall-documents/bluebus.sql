-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 19, 2024 at 09:54 AM
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
-- Database: `bluebus`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add search bus', 1, 'add_searchbus'),
(2, 'Can change search bus', 1, 'change_searchbus'),
(3, 'Can delete search bus', 1, 'delete_searchbus'),
(4, 'Can view search bus', 1, 'view_searchbus'),
(5, 'Can add log entry', 2, 'add_logentry'),
(6, 'Can change log entry', 2, 'change_logentry'),
(7, 'Can delete log entry', 2, 'delete_logentry'),
(8, 'Can view log entry', 2, 'view_logentry'),
(9, 'Can add permission', 3, 'add_permission'),
(10, 'Can change permission', 3, 'change_permission'),
(11, 'Can delete permission', 3, 'delete_permission'),
(12, 'Can view permission', 3, 'view_permission'),
(13, 'Can add group', 4, 'add_group'),
(14, 'Can change group', 4, 'change_group'),
(15, 'Can delete group', 4, 'delete_group'),
(16, 'Can view group', 4, 'view_group'),
(17, 'Can add user', 5, 'add_user'),
(18, 'Can change user', 5, 'change_user'),
(19, 'Can delete user', 5, 'delete_user'),
(20, 'Can view user', 5, 'view_user'),
(21, 'Can add content type', 6, 'add_contenttype'),
(22, 'Can change content type', 6, 'change_contenttype'),
(23, 'Can delete content type', 6, 'delete_contenttype'),
(24, 'Can view content type', 6, 'view_contenttype'),
(25, 'Can add session', 7, 'add_session'),
(26, 'Can change session', 7, 'change_session'),
(27, 'Can delete session', 7, 'delete_session'),
(28, 'Can view session', 7, 'view_session');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$FPx7PlhwmvZvS9LYySyEFg$B/gX/9Rd62jDe5wLOI4g8r+oGxQi5B8PkIr6RzSlpC4=', '2024-11-18 09:12:05.167732', 1, 'admin', '', '', 'admin@gmail.com', 1, 1, '2024-11-18 09:11:57.979532'),
(2, 'pbkdf2_sha256$600000$RzRvzOV4wBnGCpHORPBEPe$nhxs/cKoRox44DOupDo3EGKDmJErlxqIyb7mFYIE5p4=', '2024-11-18 17:28:07.871498', 0, 'abu', '', '', '', 0, 1, '2024-11-18 09:13:55.137260'),
(3, 'pbkdf2_sha256$600000$zp2t9Wd0zNJyDyKOZNXpRv$HLfK1rr/FXXuk9rTyh0h34Ug7T61E0VbYJKQvLbZzd8=', '2024-11-18 17:26:05.409190', 0, 'anu', '', '', '', 0, 1, '2024-11-18 09:22:21.685498');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bluebus_searchbus`
--

CREATE TABLE `bluebus_searchbus` (
  `id` bigint(20) NOT NULL,
  `bus_name` varchar(50) NOT NULL,
  `from_source` varchar(50) NOT NULL,
  `to_desti` varchar(50) NOT NULL,
  `via_city` varchar(50) DEFAULT NULL,
  `from_time` time(6) NOT NULL,
  `to_time` time(6) NOT NULL,
  `departure_date` date NOT NULL,
  `arrival_date` date NOT NULL,
  `bus_ac` tinyint(1) NOT NULL,
  `bus_nonac` tinyint(1) NOT NULL,
  `bus_ac_check_text` varchar(10) DEFAULT NULL,
  `bus_sleeper_seater_text` varchar(10) DEFAULT NULL,
  `bus_price` int(11) NOT NULL,
  `bus_seat` int(11) NOT NULL,
  `bus_occupy_seat` int(11) NOT NULL,
  `seater` tinyint(1) NOT NULL,
  `sleeper` tinyint(1) NOT NULL,
  `booked_seat_numbers` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bluebus_searchbus`
--

INSERT INTO `bluebus_searchbus` (`id`, `bus_name`, `from_source`, `to_desti`, `via_city`, `from_time`, `to_time`, `departure_date`, `arrival_date`, `bus_ac`, `bus_nonac`, `bus_ac_check_text`, `bus_sleeper_seater_text`, `bus_price`, `bus_seat`, `bus_occupy_seat`, `seater`, `sleeper`, `booked_seat_numbers`) VALUES
(1, 'shreeji', 'rajkot', 'pune', 'surat', '21:00:00.000000', '13:00:00.000000', '2024-11-18', '2024-11-19', 1, 0, 'A/C', 'SLEEPER', 2000, 36, 0, 0, 1, ''),
(2, 'egle', 'rajkot', 'pune', 'surat', '18:00:00.802000', '10:00:00.000000', '2024-11-18', '2024-11-19', 1, 0, 'A/C', 'SLEEPER', 2200, 36, 0, 0, 1, ''),
(3, 'king travels', 'surat', 'pune', '', '22:00:00.802000', '06:00:00.000000', '2024-11-18', '2024-11-19', 0, 1, 'NON A/C', 'SLEEPER', 800, 36, 0, 0, 1, ''),
(4, 'pavan travels', 'surat', 'pune', '', '22:00:00.802000', '06:00:00.000000', '2024-11-18', '2024-11-19', 0, 1, 'NON A/C', 'SEATER', 500, 36, 0, 1, 0, ''),
(5, 'gopal travels', 'rajkot', 'pune', 'surat', '23:00:00.802000', '15:00:00.000000', '2024-11-18', '2024-11-19', 0, 1, 'NON A/C', 'SEATER', 1200, 36, 0, 1, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(2, 'admin', 'logentry'),
(4, 'auth', 'group'),
(3, 'auth', 'permission'),
(5, 'auth', 'user'),
(1, 'blueBus', 'searchbus'),
(6, 'contenttypes', 'contenttype'),
(7, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-11-18 08:57:59.227422'),
(2, 'auth', '0001_initial', '2024-11-18 08:58:05.445041'),
(3, 'admin', '0001_initial', '2024-11-18 08:58:07.424888'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-11-18 08:58:07.440564'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-11-18 08:58:07.502029'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-11-18 08:58:08.005642'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-11-18 08:58:09.289796'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-11-18 08:58:09.385331'),
(9, 'auth', '0004_alter_user_username_opts', '2024-11-18 08:58:09.415418'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-11-18 08:58:09.716746'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-11-18 08:58:09.725634'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-11-18 08:58:09.758073'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-11-18 08:58:09.845817'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-11-18 08:58:09.955488'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-11-18 08:58:10.105710'),
(16, 'auth', '0011_update_proxy_permissions', '2024-11-18 08:58:10.182024'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-11-18 08:58:10.287541'),
(18, 'sessions', '0001_initial', '2024-11-18 08:58:10.532775'),
(19, 'blueBus', '0001_initial', '2024-11-18 09:07:15.411966'),
(20, 'blueBus', '0002_alter_searchbus_bus_price', '2024-11-18 09:56:44.145219'),
(21, 'blueBus', '0003_alter_searchbus_bus_price', '2024-11-18 09:57:53.690758');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('c1vkoy1ad45remmsna78ntwbu78qra1g', '.eJxVjEuOwjAQRO_iNUTtj0LCcvZIiAtYtrs9CQQb-bNC3B1HIBDLevWq7syneNU51uSI7dnJnC-xsA0rUSPlMjd2rIEaQboVjaasGh-2nG8FCNUKW7M2ju1DXZZXCjF8QV6IbpQ-kdrFJ2lTy6RrpqRnbMeC_TBr3IXCWuDZhP_YuRhKmm23Kt27zd0hIi1_b_fnYDJ5amsA58BLgQIUOCs4ScPBD7teWiUVV34AkuNAiLDjksD3MArLper70UnPHk_XgWCB:1tD5z3:ZSfUrT-J7pB52r5NM8PNdl9_Mir5L5un8oT-2Euof9o', '2024-12-02 17:56:21.141159');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `bluebus_searchbus`
--
ALTER TABLE `bluebus_searchbus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bluebus_searchbus`
--
ALTER TABLE `bluebus_searchbus`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
