CREATE DATABASE IF NOT EXISTS `ub_db` DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
use ub_db;

CREATE TABLE IF NOT EXISTS `accounts` (

	`id` INT AUTO_INCREMENT,
    `username` VARCHAR(24) NOT NULL,
    `password` VARCHAR(60) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `birth_date` VARCHAR(10),
    `gender` ENUM('F', 'M', 'NB'),
    `admin` TINYINT,
    `register_date` VARCHAR(10) NOT NULL,
    `last_login` VARCHAR(10),
    `last_ip` VARCHAR(16) NOT NULL,

    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AUTO_INCREMENT = 1 ;