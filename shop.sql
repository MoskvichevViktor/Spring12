

DROP TABLE IF EXISTS `carts`;

CREATE TABLE `carts` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `carts_items`;

CREATE TABLE `carts_items` (
                               `id` bigint NOT NULL AUTO_INCREMENT,
                               `carts_id` bigint NOT NULL,
                               `product_id` bigint NOT NULL,
                               `quantity` int NOT NULL,
                               PRIMARY KEY (`id`),
                               KEY `carts_items_carts_id_fk` (`carts_id`),
                               KEY `carts_items_products_id_fk` (`product_id`),
                               CONSTRAINT `carts_items_carts_id_fk` FOREIGN KEY (`carts_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
                               CONSTRAINT `carts_items_products_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
                              `id` bigint NOT NULL,
                              `name` varchar(100) NOT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




DROP TABLE IF EXISTS `photos`;

CREATE TABLE `photos` (
                          `id` bigint NOT NULL,
                          `path` text NOT NULL,
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `product_categories`;

CREATE TABLE `product_categories` (
                                      `id` bigint NOT NULL AUTO_INCREMENT,
                                      `product_id` bigint NOT NULL,
                                      `category_id` bigint NOT NULL,
                                      PRIMARY KEY (`id`,`product_id`),
                                      KEY `fk_product_id_idx` (`product_id`),
                                      KEY `fk_category_id_idx` (`category_id`),
                                      CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
                                      CONSTRAINT `fk_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `product_photos`;

CREATE TABLE `product_photos` (
                                  `id` bigint NOT NULL,
                                  `product_id` bigint NOT NULL,
                                  `photo_id` bigint NOT NULL,
                                  `default` tinyint NOT NULL DEFAULT '0',
                                  PRIMARY KEY (`id`),
                                  KEY `fk_product_id_photo_idx` (`product_id`),
                                  KEY `fk_photo_id_photo_idx` (`photo_id`),
                                  CONSTRAINT `fk_photo_id_photo` FOREIGN KEY (`photo_id`) REFERENCES `photos` (`id`),
                                  CONSTRAINT `fk_product_id_photo` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `title` text NOT NULL,
                            `short_description` varchar(100) DEFAULT NULL,
                            `full_description` text,
                            `price` decimal(10,2) NOT NULL,
                            `quantity` int NOT NULL DEFAULT '0',
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `name` varchar(45) NOT NULL,
                         PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `user_roles`;

CREATE TABLE `user_roles` (
                              `id` bigint NOT NULL AUTO_INCREMENT,
                              `user_id` bigint NOT NULL,
                              `role_id` bigint NOT NULL,
                              PRIMARY KEY (`id`),
                              KEY `fk_user_id_idx` (`user_id`),
                              KEY `fk_role_id_idx` (`role_id`),
                              CONSTRAINT `fk_role_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
                              CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `login` varchar(45) NOT NULL,
                         `password` text NOT NULL,
                         `first_name` varchar(45) NOT NULL,
                         `last_name` varchar(45) NOT NULL,
                         `email` varchar(45) NOT NULL,
                         `phone` varchar(45) NOT NULL,
                         `address` text NOT NULL,
                         `enabled` tinyint NOT NULL DEFAULT '1',
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
