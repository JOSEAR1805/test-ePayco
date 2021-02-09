-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 09-02-2021 a las 09:30:25
-- Versión del servidor: 8.0.23-0ubuntu0.20.04.1
-- Versión de PHP: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_test_epayco`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payments`
--

CREATE TABLE `payments` (
  `id` int NOT NULL,
  `userId` int NOT NULL,
  `code` varchar(6) DEFAULT NULL,
  `status` int DEFAULT NULL COMMENT '0: pendiente\n1: aceptado\n2: negado\n3: congelado',
  `quantity` double DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `payConfirmed` timestamp NULL DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `payments`
--

INSERT INTO `payments` (`id`, `userId`, `code`, `status`, `quantity`, `note`, `payConfirmed`, `createdAt`, `updatedAt`) VALUES
(1, 7, NULL, 0, 239.79, NULL, NULL, '2021-02-09 06:19:49', '2021-02-09 06:19:49'),
(2, 7, NULL, 0, 90.48, NULL, NULL, '2021-02-09 06:32:18', '2021-02-09 06:32:18'),
(3, 7, NULL, 0, 68.21, NULL, NULL, '2021-02-09 06:32:40', '2021-02-09 06:32:40'),
(4, 7, NULL, 0, 913.72, NULL, NULL, '2021-02-09 06:37:21', '2021-02-09 06:37:21'),
(5, 7, NULL, 0, 279.59, NULL, NULL, '2021-02-09 06:37:52', '2021-02-09 06:37:52'),
(6, 7, NULL, 0, 236.15, NULL, NULL, '2021-02-09 06:39:34', '2021-02-09 06:39:34'),
(7, 7, 'bpl6GB', 0, 753.38, NULL, NULL, '2021-02-09 07:28:34', '2021-02-09 07:28:34'),
(8, 7, 'oCdut5', 0, 898.5, NULL, NULL, '2021-02-09 07:29:11', '2021-02-09 07:29:11'),
(9, 7, 'CAv7lV', 0, 60.82, NULL, NULL, '2021-02-09 07:30:50', '2021-02-09 07:30:50'),
(10, 7, 'dN4p08', 0, 691.82, NULL, NULL, '2021-02-09 07:32:24', '2021-02-09 07:32:24'),
(11, 7, 'i4S32r', 0, 112.16, NULL, NULL, '2021-02-09 07:33:32', '2021-02-09 07:33:32'),
(12, 7, 'CxMdvD', 0, 990.69, NULL, NULL, '2021-02-09 07:34:39', '2021-02-09 07:34:39'),
(13, 7, '1Tv3kn', 0, 152.2, NULL, NULL, '2021-02-09 07:34:56', '2021-02-09 07:34:56'),
(14, 7, 'd054aY', 0, 975.81, NULL, NULL, '2021-02-09 07:35:44', '2021-02-09 07:35:44'),
(15, 7, 'Dah67C', 0, 81.31, NULL, NULL, '2021-02-09 07:36:44', '2021-02-09 07:36:44'),
(16, 7, 'esoON5', 1, 657.43, NULL, NULL, '2021-02-09 07:47:56', '2021-02-09 07:55:03'),
(17, 7, '2eY5PZ', 1, 321312, NULL, NULL, '2021-02-09 10:31:30', '2021-02-09 10:32:11'),
(18, 7, 'KPIc2i', 1, 100000, NULL, NULL, '2021-02-09 10:34:03', '2021-02-09 10:34:34'),
(19, 7, 'lgTGjm', 1, 1000, NULL, NULL, '2021-02-09 10:40:34', '2021-02-09 10:41:23'),
(20, 7, 'PLuo0m', 1, 5000, NULL, NULL, '2021-02-09 11:10:41', '2021-02-09 11:11:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transactions`
--

CREATE TABLE `transactions` (
  `id` int NOT NULL,
  `userId` int NOT NULL,
  `type` int DEFAULT NULL COMMENT '1: abono\n2: retiro',
  `status` int DEFAULT NULL COMMENT '1: approved\n2: denied',
  `quantity` double DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `transactions`
--

INSERT INTO `transactions` (`id`, `userId`, `type`, `status`, `quantity`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 1, 7915, NULL, NULL),
(2, 1, 1, 1, 7218, NULL, NULL),
(3, 1, 1, 1, 7549, NULL, NULL),
(4, 1, 1, 1, 1244, NULL, NULL),
(5, 1, 1, 1, 644.96, NULL, NULL),
(6, 1, 1, 1, 489.14, NULL, NULL),
(7, 1, 1, 1, 265.55, NULL, NULL),
(8, 1, 1, 1, 281.62, NULL, NULL),
(9, 7, 1, 1, 661.46, '2021-02-09 04:32:18', '2021-02-09 04:32:18'),
(10, 7, 2, 1, 320.13, '2021-02-09 04:34:48', '2021-02-09 04:42:54'),
(11, 7, 2, 1, 450.19, '2021-02-09 04:43:16', '2021-02-09 04:43:16'),
(12, 7, 2, 1, 657.43, '2021-02-09 07:48:13', '2021-02-09 07:48:13'),
(13, 7, 2, 1, 657.43, '2021-02-09 07:50:23', '2021-02-09 07:50:23'),
(14, 7, 2, 1, 657.43, '2021-02-09 07:55:03', '2021-02-09 07:55:03'),
(15, 7, 1, 1, 655.89, '2021-02-09 08:08:54', '2021-02-09 08:08:54'),
(16, 7, 1, 1, 1000, '2021-02-09 08:29:42', '2021-02-09 08:29:42'),
(17, 7, 1, 1, 30000, '2021-02-09 08:31:05', '2021-02-09 08:31:05'),
(18, 7, 1, 1, 100000, '2021-02-09 08:35:04', '2021-02-09 08:35:04'),
(19, 7, 1, 1, 100000, '2021-02-09 08:36:05', '2021-02-09 08:36:05'),
(20, 7, 1, 1, 100000, '2021-02-09 08:36:20', '2021-02-09 08:36:20'),
(21, 7, 1, 1, 100000, '2021-02-09 08:37:02', '2021-02-09 08:37:02'),
(22, 7, 1, 1, 100000, '2021-02-09 08:38:26', '2021-02-09 08:38:26'),
(23, 7, 1, 1, 100000, '2021-02-09 08:38:31', '2021-02-09 08:38:31'),
(24, 7, 1, 1, 100000, '2021-02-09 08:38:44', '2021-02-09 08:38:44'),
(25, 7, 1, 1, 100000, '2021-02-09 08:39:01', '2021-02-09 08:39:01'),
(26, 7, 1, 1, 100000, '2021-02-09 08:40:24', '2021-02-09 08:40:24'),
(27, 7, 1, 1, 1000, '2021-02-09 08:40:33', '2021-02-09 08:40:33'),
(28, 7, 1, 1, 321312, '2021-02-09 08:41:26', '2021-02-09 08:41:26'),
(29, 7, 1, 1, 100000, '2021-02-09 08:41:46', '2021-02-09 08:41:46'),
(30, 7, 1, 1, 321312, '2021-02-09 08:44:38', '2021-02-09 08:44:38'),
(31, 7, 1, 1, 435345, '2021-02-09 08:46:06', '2021-02-09 08:46:06'),
(32, 7, 1, 1, 323232, '2021-02-09 08:47:15', '2021-02-09 08:47:15'),
(33, 7, 1, 1, 700000, '2021-02-09 08:51:50', '2021-02-09 08:51:50'),
(34, 7, 1, 1, 100000, '2021-02-09 08:53:59', '2021-02-09 08:53:59'),
(35, 7, 2, 1, 321312, '2021-02-09 10:32:11', '2021-02-09 10:32:11'),
(36, 7, 2, 1, 100000, '2021-02-09 10:34:34', '2021-02-09 10:34:34'),
(37, 7, 2, 1, 1000, '2021-02-09 10:41:23', '2021-02-09 10:41:23'),
(38, 7, 2, 1, 5000, '2021-02-09 11:11:01', '2021-02-09 11:11:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `document` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `document`, `email`, `phone`, `createdAt`, `updatedAt`, `deletedAt`) VALUES
(1, 'Lewis Thiel DVM', '37844266', 'Hertha80@gmail.com', '671-980-7043', NULL, '2021-02-09 08:24:29', NULL),
(2, 'Angel O\'Reilly', '94644478', 'Jarret_Gislason51@gmail.com', '913-930-0136', NULL, '2021-02-09 08:25:25', '2021-02-09 08:25:25'),
(5, 'Randolph Kirlin MD', '54260798', 'Dan_Gibson@yahoo.com', '869-268-9405', NULL, NULL, NULL),
(6, 'Earl Swaniawski', '58011191', 'Palma.Thiel64@yahoo.com', '820-898-5132', NULL, NULL, NULL),
(7, 'José Artigas', '123456789', 'jgam310@gmail.com', '+584141234567', '2021-02-08 07:52:56', '2021-02-08 07:52:56', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_UNIQUE` (`code`),
  ADD KEY `fk_payments_users2_idx` (`userId`);

--
-- Indices de la tabla `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_walletTransactions_users1_idx` (`userId`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `document_UNIQUE` (`document`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `phone_UNIQUE` (`phone`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_users2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_walletTransactions_users1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
