CREATE TABLE `actor` (
  `actor_id` smallint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `last_update` timestamp NOT NULL
);

CREATE TABLE `address` (
  `address_id` smallint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `district` varchar(20) NOT NULL,
  `city_id` smallint NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `location` geometry NOT NULL,
  `last_update` timestamp NOT NULL
);

CREATE TABLE `category` (
  `category_id` tinyint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL,
  `last_update` timestamp NOT NULL
);

CREATE TABLE `city` (
  `city_id` smallint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `city` varchar(50) NOT NULL,
  `country_id` smallint NOT NULL,
  `last_update` timestamp NOT NULL
);

CREATE TABLE `country` (
  `country_id` smallint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `country` varchar(50) NOT NULL,
  `last_update` timestamp NOT NULL
);

CREATE TABLE `customer` (
  `customer_id` smallint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `store_id` tinyint NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address_id` smallint NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT "1",
  `create_date` datetime NOT NULL,
  `last_update` timestamp
);

CREATE TABLE `film` (
  `film_id` smallint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `release_year` year DEFAULT NULL,
  `language_id` tinyint NOT NULL,
  `original_language_id` tinyint DEFAULT NULL,
  `rental_duration` tinyint NOT NULL DEFAULT "3",
  `rental_rate` decimal(4,2) NOT NULL DEFAULT "4.99",
  `length` smallint DEFAULT NULL,
  `replacement_cost` decimal(5,2) NOT NULL DEFAULT "19.99",
  `rating` ENUM ('G', 'PG', 'PG-13', 'R', 'NC-17') DEFAULT "G",
  `special_features` set('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  `last_update` timestamp NOT NULL,
  PRIMARY KEY (`film_id`, `title`)
);

CREATE TABLE `film_actor` (
  `actor_id` smallint NOT NULL,
  `film_id` smallint NOT NULL,
  `last_update` timestamp NOT NULL,
  PRIMARY KEY (`actor_id`, `film_id`)
);

CREATE TABLE `film_category` (
  `film_id` smallint NOT NULL,
  `category_id` tinyint NOT NULL,
  `last_update` timestamp NOT NULL,
  PRIMARY KEY (`film_id`, `category_id`)
);

CREATE TABLE `film_text` (
  `film_id` smallint PRIMARY KEY NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text
);

CREATE TABLE `inventory` (
  `inventory_id` mediumint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `film_id` smallint NOT NULL,
  `store_id` tinyint NOT NULL,
  `last_update` timestamp NOT NULL
);

CREATE TABLE `language` (
  `language_id` tinyint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` char(20) NOT NULL,
  `last_update` timestamp NOT NULL
);

CREATE TABLE `payment` (
  `payment_id` smallint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `customer_id` smallint NOT NULL,
  `staff_id` tinyint NOT NULL,
  `rental_id` int DEFAULT NULL,
  `amount` decimal(5,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `last_update` timestamp
);

CREATE TABLE `rental` (
  `rental_id` int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `rental_date` datetime NOT NULL,
  `inventory_id` mediumint NOT NULL,
  `customer_id` smallint NOT NULL,
  `return_date` datetime DEFAULT NULL,
  `staff_id` tinyint NOT NULL,
  `last_update` timestamp NOT NULL
);

CREATE TABLE `staff` (
  `staff_id` tinyint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `address_id` smallint NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `store_id` tinyint NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT "1",
  `username` varchar(16) NOT NULL,
  `password` varchar(40) DEFAULT NULL,
  `last_update` timestamp NOT NULL
);

CREATE TABLE `store` (
  `store_id` tinyint PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `manager_staff_id` tinyint NOT NULL,
  `address_id` smallint NOT NULL,
  `last_update` timestamp NOT NULL
);

ALTER TABLE `address` ADD FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `city` ADD FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `customer` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `customer` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `film` ADD FOREIGN KEY (`language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `film` ADD FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `film_actor` ADD FOREIGN KEY (`actor_id`) REFERENCES `actor` (`actor_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `film_actor` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `film_category` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `film_category` ADD FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `inventory` ADD FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `inventory` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `payment` ADD FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `payment` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `payment` ADD FOREIGN KEY (`rental_id`) REFERENCES `rental` (`rental_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `rental` ADD FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `rental` ADD FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `rental` ADD FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `staff` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `staff` ADD FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `store` ADD FOREIGN KEY (`manager_staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `store` ADD FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `film_text` ADD FOREIGN KEY (`film_id`) REFERENCES `film_actor` (`film_id`);

ALTER TABLE `customer` ADD FOREIGN KEY (`customer_id`) REFERENCES `customer` (`store_id`);

CREATE INDEX `idx_actor_last_name` ON `actor` (`last_name`);

CREATE INDEX `idx_fk_city_id` ON `address` (`city_id`);

CREATE INDEX `idx_fk_country_id` ON `city` (`country_id`);

CREATE INDEX `idx_fk_store_id` ON `customer` (`store_id`);

CREATE INDEX `idx_fk_address_id` ON `customer` (`address_id`);

CREATE INDEX `idx_last_name` ON `customer` (`last_name`);

CREATE INDEX `idx_title` ON `film` (`title`);

CREATE INDEX `idx_fk_language_id` ON `film` (`language_id`);

CREATE INDEX `idx_fk_original_language_id` ON `film` (`original_language_id`);

CREATE INDEX `idx_fk_film_id` ON `film_actor` (`film_id`);

CREATE INDEX `fk_film_category_category` ON `film_category` (`category_id`);

CREATE INDEX `idx_fk_film_id` ON `inventory` (`film_id`);

CREATE INDEX `idx_store_id_film_id` ON `inventory` (`store_id`, `film_id`);

CREATE INDEX `idx_fk_staff_id` ON `payment` (`staff_id`);

CREATE INDEX `idx_fk_customer_id` ON `payment` (`customer_id`);

CREATE INDEX `fk_payment_rental` ON `payment` (`rental_id`);

CREATE UNIQUE INDEX `rental_date` ON `rental` (`rental_date`, `inventory_id`, `customer_id`);

CREATE INDEX `idx_fk_inventory_id` ON `rental` (`inventory_id`);

CREATE INDEX `idx_fk_customer_id` ON `rental` (`customer_id`);

CREATE INDEX `idx_fk_staff_id` ON `rental` (`staff_id`);

CREATE INDEX `idx_fk_store_id` ON `staff` (`store_id`);

CREATE INDEX `idx_fk_address_id` ON `staff` (`address_id`);

CREATE UNIQUE INDEX `idx_unique_manager` ON `store` (`manager_staff_id`);

CREATE INDEX `idx_fk_address_id` ON `store` (`address_id`);
