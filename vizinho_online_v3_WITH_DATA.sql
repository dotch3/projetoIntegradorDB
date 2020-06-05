-- phpMyAdmin SQL Dump
-- version 4.9.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jun 05, 2020 at 02:36 AM
-- Server version: 5.7.26
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `vizinho_online`
--

-- --------------------------------------------------------

--
-- Table structure for table `CATEGORIES`
--

CREATE TABLE `CATEGORIES` (
  `id_category` int(5) UNSIGNED ZEROFILL NOT NULL,
  `category_code` varchar(200) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `CATEGORIES`
--

INSERT INTO `CATEGORIES` (`id_category`, `category_code`, `name`, `description`, `create_date`, `modify_date`, `delete_date`) VALUES
(00001, 'FERR', 'Ferramentas', 'Categoria para os itens ferramentas', '2020-06-01 21:45:42', NULL, NULL),
(00002, 'ESCR', 'Material de escritorio', 'Itens de material de escritorio', '2020-05-25 21:45:42', NULL, NULL),
(00003, 'ELEC', 'Electronicos', 'Categoria para itens electronicos e electricos', '2020-06-01 20:47:43', NULL, NULL),
(00004, 'DIGI', 'Digital', 'categoria para itens digitais', '2020-06-01 20:47:43', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `FAVORITES`
--

CREATE TABLE `FAVORITES` (
  `id_favorite` int(5) UNSIGNED NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `favorite_code` varchar(45) DEFAULT NULL,
  `favorite_status` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `FEEDBACKS`
--

CREATE TABLE `FEEDBACKS` (
  `id_feedback` int(4) UNSIGNED ZEROFILL NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `FEEDBACKS`
--

INSERT INTO `FEEDBACKS` (`id_feedback`, `title`, `comment`, `score`, `create_date`, `modify_date`, `delete_date`) VALUES
(0001, 'Bom', 'o item me ajudo bastante', 10, '2020-06-02 21:33:39', NULL, NULL),
(0002, 'Ruim', 'nao gostei da ferramenta', 1, '2020-06-02 21:34:29', NULL, NULL);

--
-- Triggers `FEEDBACKS`
--
DELIMITER $$
CREATE TRIGGER `score` BEFORE INSERT ON `FEEDBACKS` FOR EACH ROW BEGIN
  IF NEW.score<0 OR NEW.score>50 THEN
    CALL `Error: Wrong values for score, valid 0-5`; -- this trick will throw an error
  END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `score_update` BEFORE UPDATE ON `FEEDBACKS` FOR EACH ROW BEGIN
  IF NEW.score<0 OR NEW.score>50 THEN
    CALL `Error: Wrong values for score, valid 0-5`; -- needs a valid score
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `IMAGES`
--

CREATE TABLE `IMAGES` (
  `id_image` int(5) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `path_location` varchar(100) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL,
  `format_image` varchar(45) DEFAULT NULL,
  `size_image` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ITEMS`
--

CREATE TABLE `ITEMS` (
  `id_item` int(5) UNSIGNED ZEROFILL NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL,
  `description` text COMMENT 'full description of the item',
  `tax_fee` varchar(45) DEFAULT NULL COMMENT 'Price that will be charged by the item',
  `internal_notes` varchar(200) DEFAULT NULL COMMENT 'This field will be used by the system and administrators.',
  `feedback_score` int(11) DEFAULT NULL,
  `units` varchar(45) DEFAULT NULL,
  `loan_start_date` datetime DEFAULT NULL,
  `loan_end_date` datetime DEFAULT NULL,
  `replacement_cost` float DEFAULT NULL,
  `id_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ITEMS`
--

INSERT INTO `ITEMS` (`id_item`, `name`, `code`, `create_date`, `modify_date`, `delete_date`, `description`, `tax_fee`, `internal_notes`, `feedback_score`, `units`, `loan_start_date`, `loan_end_date`, `replacement_cost`, `id_status`) VALUES
(00001, 'Furadeira', 'FERR01', '2020-06-01 21:57:56', NULL, NULL, 'Furadeira 110/220 de impacto', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(00002, 'Martelo', 'FERR02', NULL, NULL, NULL, 'Martelo de bolacha', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(00003, 'Mouse', 'TEC01', '2020-05-04 20:29:58', NULL, NULL, 'Mouse inhalambrico de 5 botoes para games', NULL, NULL, NULL, '2', NULL, NULL, NULL, 1),
(00004, 'Teclado inhalambrico', 'TEC02', NULL, NULL, NULL, 'Teclado para computador MAC e compativel com Windows', NULL, NULL, NULL, '1', NULL, NULL, NULL, 2),
(00005, 'Soldador electrico', 'ELEC01', '2020-06-08 20:58:57', NULL, NULL, 'Soldador para circuitos electricos', NULL, NULL, NULL, '1', NULL, NULL, NULL, 1),
(00006, 'Impressora HP', 'ESCR', '2020-05-27 20:58:57', NULL, NULL, 'Impressora a cor, wireless.\r\n220/110V', NULL, NULL, NULL, '1', NULL, NULL, NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `ITEMS_FEEDBACK`
--

CREATE TABLE `ITEMS_FEEDBACK` (
  `id_item_feedback` int(5) UNSIGNED ZEROFILL NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL,
  `id_item` int(5) UNSIGNED ZEROFILL NOT NULL,
  `id_feedback` int(4) UNSIGNED ZEROFILL NOT NULL,
  `id_user` int(5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ITEMS_FEEDBACK`
--

INSERT INTO `ITEMS_FEEDBACK` (`id_item_feedback`, `create_date`, `modify_date`, `delete_date`, `id_item`, `id_feedback`, `id_user`) VALUES
(00001, '2020-06-01 21:40:04', NULL, NULL, 00001, 0001, 00006),
(00002, '2020-05-25 21:45:42', NULL, NULL, 00005, 0002, 00004);

-- --------------------------------------------------------

--
-- Table structure for table `ITEMS_IMAGES`
--

CREATE TABLE `ITEMS_IMAGES` (
  `id_item_image` int(11) NOT NULL,
  `IMAGES_id_image` int(5) NOT NULL,
  `id_item` int(5) UNSIGNED ZEROFILL NOT NULL,
  `id_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `ITEM_CATEGORY`
--

CREATE TABLE `ITEM_CATEGORY` (
  `id_item_category` int(5) UNSIGNED NOT NULL COMMENT 'foreign key category',
  `create_date` datetime NOT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL,
  `id_category` int(4) UNSIGNED ZEROFILL NOT NULL,
  `id_item` int(5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ITEM_CATEGORY`
--

INSERT INTO `ITEM_CATEGORY` (`id_item_category`, `create_date`, `modify_date`, `delete_date`, `id_category`, `id_item`) VALUES
(1, '2020-06-01 20:43:12', NULL, NULL, 0001, 00001),
(2, '2020-05-27 20:43:12', NULL, NULL, 0001, 00002),
(3, '2020-06-01 20:47:00', NULL, NULL, 0002, 00003),
(4, '2020-06-01 20:47:00', NULL, NULL, 0002, 00004);

-- --------------------------------------------------------

--
-- Table structure for table `LEND_ITEMS`
--

CREATE TABLE `LEND_ITEMS` (
  `id_lend_item` int(5) NOT NULL,
  `status_lend_item` varchar(45) DEFAULT NULL COMMENT ' Livre, Emprestado, En Negociacao',
  `lend_create_date` varchar(45) DEFAULT NULL,
  `lend_modify_date` varchar(45) DEFAULT NULL,
  `lend_finish_date` varchar(45) DEFAULT NULL,
  `id_user_neighbor` int(5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `LOCATIONS`
--

CREATE TABLE `LOCATIONS` (
  `id_location` int(10) UNSIGNED NOT NULL,
  `apartment_number` int(11) NOT NULL,
  `build` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `intercom_branch` int(11) DEFAULT NULL,
  `id_user` int(5) UNSIGNED ZEROFILL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `LOCATIONS`
--

INSERT INTO `LOCATIONS` (`id_location`, `apartment_number`, `build`, `address`, `intercom_branch`, `id_user`) VALUES
(1, 2500, 'Bloco B', 'av.Ipiranga', 2500, 00001),
(2, 120, 'Bloco A', 'av. Central', 120, 00002),
(3, 110, 'Bloco A', 'av. Central', 110, 00003),
(4, 140, 'Bloco A', 'av. Central', 120, 00004),
(5, 2501, 'Bloco B', 'av.Ipiranga', 2501, 00005);

-- --------------------------------------------------------

--
-- Table structure for table `POSTS`
--

CREATE TABLE `POSTS` (
  `id_post` int(5) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL,
  `comment` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `id_image` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `POSTS`
--

INSERT INTO `POSTS` (`id_post`, `create_date`, `modify_date`, `delete_date`, `comment`, `title`, `id_image`) VALUES
(1, '2020-06-01 21:44:56', NULL, NULL, 'Primer comentario de post', 'Teste primer post', NULL),
(2, '2020-05-25 21:45:42', '2020-06-02 21:44:56', NULL, 'teste de comentario', 'meu teste de comentario', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `STATUS_ITEMS`
--

CREATE TABLE `STATUS_ITEMS` (
  `id_status_item` int(5) NOT NULL,
  `name_status` varchar(45) DEFAULT NULL,
  `code_status` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `STATUS_ITEMS`
--

INSERT INTO `STATUS_ITEMS` (`id_status_item`, `name_status`, `code_status`) VALUES
(1, 'livre', 'LIV'),
(2, 'emprestado', 'EMP'),
(3, 'negociacao', 'NEG');

-- --------------------------------------------------------

--
-- Table structure for table `USERS`
--

CREATE TABLE `USERS` (
  `id_user` int(5) UNSIGNED ZEROFILL NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `cpf` varchar(45) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `ranking` varchar(45) DEFAULT NULL,
  `cellphone` int(15) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `USERS`
--

INSERT INTO `USERS` (`id_user`, `name`, `last_name`, `username`, `password`, `email`, `cpf`, `age`, `ranking`, `cellphone`, `create_date`, `modify_date`, `delete_date`, `image_id`) VALUES
(00001, 'joao', 'Rocha', 'jrocha', 'jrocha123', 'jrocha@test.test', '2383882888', 33, NULL, NULL, '2020-05-13 20:29:58', NULL, NULL, NULL),
(00002, 'maria', 'Rocha', 'mrocha', 'mrocha123', 'mrocha@test.test', '2383442888', 30, NULL, NULL, '2020-05-12 20:29:58', '2020-06-02 20:34:12', NULL, NULL),
(00003, 'Karina', 'Silva', 'Karina.silva', 'Karina.silva123', 'Karina.silva@test.test', '3883442888', 36, NULL, NULL, '2020-05-04 20:29:58', '2020-06-09 20:43:50', NULL, NULL),
(00004, 'Marcos', 'Silva', 'marcos.silva', 'marcos.silva123', 'marcos.silva@test.test', '3383442888', 23, NULL, NULL, '2020-05-04 20:29:58', '2020-06-09 20:40:30', NULL, NULL),
(00005, 'Paulo', 'Soarez', 'paulo.soarez', 'paulo.soarez123', 'paulo.soarez@test.test', '3102242888', 32, NULL, NULL, '2020-05-24 20:29:58', '2020-06-03 20:40:30', NULL, NULL),
(00006, 'Cristian', 'Garcia', 'cgarcia', 'cgarcia123', 'cgrcia@test.org', '3803442888', 45, NULL, NULL, '2020-06-01 21:18:27', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `USERS_FAVORITES`
--

CREATE TABLE `USERS_FAVORITES` (
  `id_user_favorite` int(5) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `id_user` int(5) UNSIGNED ZEROFILL NOT NULL,
  `id_favorite` int(10) UNSIGNED NOT NULL,
  `id_post` int(5) UNSIGNED DEFAULT NULL,
  `id_item` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `USERS_FEEDBACK`
--

CREATE TABLE `USERS_FEEDBACK` (
  `id_user_feedback` int(5) UNSIGNED NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `comment` varchar(45) DEFAULT NULL,
  `score` varchar(45) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `id_user` int(5) UNSIGNED ZEROFILL NOT NULL,
  `id_feedback` int(4) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `USERS_ITEM`
--

CREATE TABLE `USERS_ITEM` (
  `id_user_item` int(5) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  `id_item` int(5) UNSIGNED ZEROFILL NOT NULL,
  `id_user_owner` int(5) UNSIGNED ZEROFILL NOT NULL,
  `id_lend_item` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `USERS_ITEM`
--

INSERT INTO `USERS_ITEM` (`id_user_item`, `create_date`, `modify_date`, `delete_time`, `id_item`, `id_user_owner`, `id_lend_item`) VALUES
(1, '2020-06-01 19:34:55', NULL, NULL, 00001, 00001, NULL),
(2, '2020-06-01 19:34:55', NULL, NULL, 00002, 00003, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `USERS_POSTS`
--

CREATE TABLE `USERS_POSTS` (
  `id_user_post` int(5) UNSIGNED NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime DEFAULT NULL,
  `delete_date` datetime DEFAULT NULL,
  `id_user` int(5) UNSIGNED ZEROFILL NOT NULL,
  `id_post` int(10) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `USERS_POSTS`
--

INSERT INTO `USERS_POSTS` (`id_user_post`, `create_date`, `modify_date`, `delete_date`, `id_user`, `id_post`) VALUES
(1, '2020-06-01 21:53:05', NULL, NULL, 00001, 0000000001),
(2, '2020-05-25 21:45:42', NULL, NULL, 00006, 0000000002);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CATEGORIES`
--
ALTER TABLE `CATEGORIES`
  ADD PRIMARY KEY (`id_category`),
  ADD UNIQUE KEY `id_category_UNIQUE` (`id_category`);

--
-- Indexes for table `FAVORITES`
--
ALTER TABLE `FAVORITES`
  ADD PRIMARY KEY (`id_favorite`);

--
-- Indexes for table `FEEDBACKS`
--
ALTER TABLE `FEEDBACKS`
  ADD PRIMARY KEY (`id_feedback`),
  ADD UNIQUE KEY `id_feedback_UNIQUE` (`id_feedback`);

--
-- Indexes for table `IMAGES`
--
ALTER TABLE `IMAGES`
  ADD PRIMARY KEY (`id_image`);

--
-- Indexes for table `ITEMS`
--
ALTER TABLE `ITEMS`
  ADD PRIMARY KEY (`id_item`,`id_status`),
  ADD UNIQUE KEY `id_Item_UNIQUE` (`id_item`),
  ADD UNIQUE KEY `code_UNIQUE` (`code`);

--
-- Indexes for table `ITEMS_FEEDBACK`
--
ALTER TABLE `ITEMS_FEEDBACK`
  ADD PRIMARY KEY (`id_item_feedback`,`id_item`,`id_feedback`,`id_user`),
  ADD UNIQUE KEY `id_Item_feedback_UNIQUE` (`id_item_feedback`);

--
-- Indexes for table `ITEMS_IMAGES`
--
ALTER TABLE `ITEMS_IMAGES`
  ADD PRIMARY KEY (`id_item_image`,`IMAGES_id_image`,`id_item`,`id_status`);

--
-- Indexes for table `ITEM_CATEGORY`
--
ALTER TABLE `ITEM_CATEGORY`
  ADD PRIMARY KEY (`id_category`,`id_item`),
  ADD UNIQUE KEY `id_item_category_UNIQUE` (`id_item_category`),
  ADD KEY `fk_ITEM_CATEGORY_CATEGORIES1_idx` (`id_category`);

--
-- Indexes for table `LEND_ITEMS`
--
ALTER TABLE `LEND_ITEMS`
  ADD PRIMARY KEY (`id_lend_item`,`id_user_neighbor`);

--
-- Indexes for table `LOCATIONS`
--
ALTER TABLE `LOCATIONS`
  ADD PRIMARY KEY (`id_location`);

--
-- Indexes for table `POSTS`
--
ALTER TABLE `POSTS`
  ADD PRIMARY KEY (`id_post`);

--
-- Indexes for table `STATUS_ITEMS`
--
ALTER TABLE `STATUS_ITEMS`
  ADD PRIMARY KEY (`id_status_item`);

--
-- Indexes for table `USERS`
--
ALTER TABLE `USERS`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `id_user_UNIQUE` (`id_user`),
  ADD UNIQUE KEY `cpf_UNIQUE` (`cpf`);

--
-- Indexes for table `USERS_FAVORITES`
--
ALTER TABLE `USERS_FAVORITES`
  ADD PRIMARY KEY (`id_user_favorite`,`id_user`,`id_favorite`);

--
-- Indexes for table `USERS_FEEDBACK`
--
ALTER TABLE `USERS_FEEDBACK`
  ADD PRIMARY KEY (`id_user_feedback`,`id_user`,`id_feedback`),
  ADD UNIQUE KEY `id_users_feedback_UNIQUE` (`id_user_feedback`);

--
-- Indexes for table `USERS_ITEM`
--
ALTER TABLE `USERS_ITEM`
  ADD PRIMARY KEY (`id_user_item`,`id_item`,`id_user_owner`),
  ADD UNIQUE KEY `id_user_item_UNIQUE` (`id_user_item`);

--
-- Indexes for table `USERS_POSTS`
--
ALTER TABLE `USERS_POSTS`
  ADD PRIMARY KEY (`id_user_post`,`id_user`,`id_post`),
  ADD UNIQUE KEY `id_user_post_UNIQUE` (`id_user_post`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `CATEGORIES`
--
ALTER TABLE `CATEGORIES`
  MODIFY `id_category` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `FAVORITES`
--
ALTER TABLE `FAVORITES`
  MODIFY `id_favorite` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `FEEDBACKS`
--
ALTER TABLE `FEEDBACKS`
  MODIFY `id_feedback` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `IMAGES`
--
ALTER TABLE `IMAGES`
  MODIFY `id_image` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ITEMS`
--
ALTER TABLE `ITEMS`
  MODIFY `id_item` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ITEMS_FEEDBACK`
--
ALTER TABLE `ITEMS_FEEDBACK`
  MODIFY `id_item_feedback` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ITEMS_IMAGES`
--
ALTER TABLE `ITEMS_IMAGES`
  MODIFY `id_item_image` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ITEM_CATEGORY`
--
ALTER TABLE `ITEM_CATEGORY`
  MODIFY `id_item_category` int(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'foreign key category', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `LEND_ITEMS`
--
ALTER TABLE `LEND_ITEMS`
  MODIFY `id_lend_item` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `LOCATIONS`
--
ALTER TABLE `LOCATIONS`
  MODIFY `id_location` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `POSTS`
--
ALTER TABLE `POSTS`
  MODIFY `id_post` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `STATUS_ITEMS`
--
ALTER TABLE `STATUS_ITEMS`
  MODIFY `id_status_item` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `USERS`
--
ALTER TABLE `USERS`
  MODIFY `id_user` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `USERS_FAVORITES`
--
ALTER TABLE `USERS_FAVORITES`
  MODIFY `id_user_favorite` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `USERS_FEEDBACK`
--
ALTER TABLE `USERS_FEEDBACK`
  MODIFY `id_user_feedback` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `USERS_ITEM`
--
ALTER TABLE `USERS_ITEM`
  MODIFY `id_user_item` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `USERS_POSTS`
--
ALTER TABLE `USERS_POSTS`
  MODIFY `id_user_post` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
