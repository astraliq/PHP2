-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 07 2019 г., 22:18
-- Версия сервера: 5.7.25
-- Версия PHP: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `allsmarts`
--

-- --------------------------------------------------------

--
-- Структура таблицы `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `idProduct` int(30) NOT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `quantity` int(30) NOT NULL DEFAULT '1',
  `dateAdd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateChange` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `carts`
--

INSERT INTO `carts` (`id`, `idProduct`, `price`, `quantity`, `dateAdd`, `dateChange`, `userID`) VALUES
(24, 3, '45000', 3, '2019-09-22 18:47:35', NULL, 3),
(28, 22, '33990', 2, '2019-09-26 18:41:57', NULL, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `idCategory` int(4) NOT NULL,
  `nameCategory` varchar(255) NOT NULL,
  `discount` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`idCategory`, `nameCategory`, `discount`) VALUES
(1, 'Смартфоны', NULL),
(2, 'Аксуссуары', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `orderproducts`
--

CREATE TABLE `orderproducts` (
  `id` int(11) NOT NULL,
  `orderID` int(11) NOT NULL,
  `idProduct` int(30) NOT NULL,
  `price` decimal(10,0) NOT NULL,
  `quantity` int(30) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `orderproducts`
--

INSERT INTO `orderproducts` (`id`, `orderID`, `idProduct`, `price`, `quantity`) VALUES
(13, 10, 3, '45000', 2),
(12, 10, 4, '35000', 1),
(14, 11, 8, '30000', 1),
(15, 12, 7, '15000', 1),
(16, 13, 5, '25000', 1),
(17, 14, 3, '45000', 10),
(18, 15, 4, '35000', 4),
(20, 15, 6, '50000', 1),
(19, 15, 8, '30000', 1),
(67, 72, 3, '45000', 1),
(68, 73, 1, '5000', 5),
(69, 73, 2, '31400', 2),
(70, 73, 3, '45000', 3),
(79, 75, 1, '3000', 1),
(78, 75, 2, '28400', 1),
(77, 75, 3, '48000', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `dateCreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateChange` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '1 - не обработан, 2 - отменен, 3 - оплачен, 4 - доставлен'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `userID`, `address`, `dateCreate`, `dateChange`, `status`) VALUES
(10, 2, 'ddd', '2019-07-31 19:10:56', '2019-08-03 11:01:34', 3),
(11, 2, 'ddd', '2019-07-31 19:11:36', '2019-08-03 10:04:28', 2),
(12, 2, 'сюда', '2019-07-31 19:12:25', '2019-08-03 10:04:25', 4),
(13, 2, 'ddd', '2019-07-31 19:13:00', '2019-08-03 10:04:22', 3),
(14, 2, 'туда', '2019-07-31 19:13:33', NULL, 1),
(15, 3, 'user1 адрес', '2019-08-03 09:51:59', '2019-08-04 15:56:21', 3),
(72, 2, '444444', '2019-10-02 18:21:26', '2019-10-02 18:38:29', 2),
(73, 2, 'адрес доставки1', '2019-10-07 08:42:46', NULL, 1),
(74, 2, 'ыыы', '2019-10-07 08:45:51', NULL, 1),
(75, 2, 'ыыыы', '2019-10-07 08:46:09', NULL, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `orderstatuses`
--

CREATE TABLE `orderstatuses` (
  `id` int(4) NOT NULL,
  `statusName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `orderstatuses`
--

INSERT INTO `orderstatuses` (`id`, `statusName`) VALUES
(1, 'не обработан'),
(2, 'отменен'),
(3, 'оплачен'),
(4, 'доставлен');

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category` int(5) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `img` varchar(255) NOT NULL DEFAULT 'default.png',
  `description` text,
  `price` decimal(10,0) NOT NULL,
  `views` int(128) DEFAULT '0',
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateChange` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `img2` varchar(255) DEFAULT NULL,
  `img3` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`id`, `category`, `title`, `img`, `description`, `price`, `views`, `isActive`, `dateCreate`, `dateChange`, `img2`, `img3`) VALUES
(1, 1, 'Lumia 650', '1.png', 'Откройте для себя преимущества бесперебойного взаимодействия с Windows 10 в точной упаковке. Lumia 650 с изысканной производительностью и превосходным дизайном — это разумный выбор для вашего бизнеса.\nНаслаждайтесь четким и ярким просмотром даже под прямыми солнечными лучами с супер острым 5-дюймовым HD OLED-дисплеем, который элегантно расположен в точно обработанной металлической рамке с алмазной огранкой. Благодаря легкому дизайну, тонкому 6,9-миллиметровому профилю и внутренней памяти объемом до 16 ГБ, Lumia 650 имеет идеальное сочетание превосходного внешнего вида и характеристик, ориентированных на производительность.\nПолучите персональный снимок вашего дня с информацией о пробках, прогнозом погоды и расписанием, предоставленным Кортаной. Делайте четкие и четкие снимки с помощью 8-мегапиксельной камеры, а приложение «Фотографии» автоматически создает резервные копии снимков и синхронизирует их на устройствах Windows 10.\nСупер телефон.', '3000', 0, 1, '2019-07-19 18:16:56', '2019-10-07 08:44:39', NULL, NULL),
(2, 1, 'Xiaomi Mi8 6/256GB', '2.png', 'Xiaomi Mi&nbsp;8&nbsp;&mdash; новый аппарат от&nbsp;изготовителя, который славится выпуском надежных и&nbsp;производительных смартфонов. 					Эта модель девайса характеризуется уникальным сочетанием технических параметров, стильного внешнего исполнения и&nbsp;доступного ценника. Приобрести подобное устройство сможет каждый желающий, причем без особых для себя трат и&nbsp;расходов.', '28400', 0, 1, '2019-07-19 18:16:56', '2019-10-07 18:37:35', '2-1.jpg', '2-2.jpg'),
(3, 1, 'iPhone X', '3.png', 'Дисплей выполнен с&nbsp;применением матрицы типа Amoled. Диагональ дисплея составляет 5,8&nbsp;дюйма, разрешение&nbsp;&mdash; 2436&times;1125&nbsp;пикселей, плотность изображения&nbsp;&mdash; 458 точек на&nbsp;дюйм. Используются технологии Dolby Vision, HDR 10&nbsp;и&nbsp;ранее опробованная на&nbsp;iPad Pro система оптимизации цвета True Tone. Дисплей произведен компанией Samsung, применяющей дисплеи типа AMOLED и&nbsp;в&nbsp;собственных смартфонах. Характерное расположение субпикселей основных цветов имеет название Diamond Pixel, эта схема сменила PenTile в&nbsp;2013 году для всех экранов AMOLED Samsung. Экран Super Retina с&nbsp;разрешением 2436&times;1125, при диагонали 5,8&nbsp;дюйма, 458ppi[5]; впервые среди продуктов Apple используется технология OLED. Поддерживается HDR, Dolby Vision и&nbsp;True Tone. Сенсорный модуль дисплея распознает жесты &laquo;3D&nbsp;Touch&raquo;. В&nbsp;верхней части дисплея имеется вырез для фронтальной камеры и&nbsp;прочих сенсоров, по&nbsp;краям от&nbsp;выреза расположена информация из&nbsp;верхней статусной полосы (сигнал сетей связи, уровень заряда).', '48000', 0, 1, '2019-07-19 18:16:56', '2019-10-07 08:44:48', '3-1.jpg', '3-2.jpg'),
(4, 1, 'Apple iPhone 7', '4.png', '', '35000', 1, 1, '2019-07-19 18:16:56', '2019-08-11 11:07:22', NULL, NULL),
(5, 1, 'Apple iPhone 6se', '5.png', '', '25000', 0, 1, '2019-07-19 18:33:41', '2019-08-11 11:07:24', NULL, NULL),
(6, 1, 'Samsung Galaxy s10', '6.png', '', '50000', 0, 1, '2019-07-19 18:33:45', '2019-08-11 11:07:25', NULL, NULL),
(7, 1, 'Nokia 5', '7.png', '', '15000', 0, 1, '2019-07-19 18:36:35', '2019-08-11 11:07:27', NULL, NULL),
(8, 1, 'Nokia 6', '8.png', '', '30000', 0, 1, '2019-07-19 18:36:35', '2019-08-11 11:07:29', NULL, NULL),
(22, 2, 'Apple Watch 3', 'apple-watch-series-3.png', 'Apple Watch Series 4 GPS. Часы с абсолютно новым дизайном и новыми технологиями. Они помогают вести ещё более активный образ жизни, лучше следить \nза здоровьем и всегда оставаться на связи. \n\nАбсолютно новый дизайн. Изменения, которые меняют всё.\nСамый большой дисплей в линейке Apple Watch. Новый электрический датчик сердечной активности. Усовершенствованное колёсико Digital Crown с тактильным откликом. Такие знакомые и вместе с тем принципиально новые Apple Watch Series 4 меняют все представления о возможностях часов.\n\nПродвинутый трекер активности. Мотивация. Мотивация. Мотивация.\nНовый вид соревнований: один на один. Возможность делиться показателями активности с друзьями. Персональные тренерские подсказки. Ежемесячные мотивирующие цели. Виртуальные награды за достижения. Всё, чтобы вдохновить вас закрывать кольца Активности каждый день.\n\nПроактивный монитор здоровья. Почувствует. Позаботится. Подскажет.\nУведомления о слишком низком и высоком пульсе. Функции обнаружения падения и вызова экстренных служб. Новые циферблаты «Дыхание». Эти часы созданы, чтобы защищать вас и помогать вам вести более здоровый образ жизни.\n', '33990', 0, 1, '2019-08-04 15:37:59', '2019-08-11 11:07:31', NULL, NULL),
(23, 2, 'Xiaomi Mi 9 64GB Piano Black', '30043457b.jpg', 'Еще более мощный процессор Snapdragon™ 855\nЕще более быстрая 20 Вт беспроводная зарядка\nСтаньте первым, кто испытает все новые возможности', '29990', 0, 1, '2019-09-01 16:20:19', '2019-09-01 16:24:53', NULL, NULL),
(60, 2, 'Xiaomi Redmi Note 7 64GB Black', 'b1eeb95s-1920.jpg', 'В 4 раза больше пикселей для дополнительной четкости\nЧем больше пикселей, тем четче изображение. Redmi Note 7 оснащен совершенно новой матрицей с разрешением 48 Мп. В четыре раза больше пикселей, \nчем у типичного телефона с камерой 12 Мп. В режиме 48 Мп один пиксель обладает размером всего 0,8 мкм, что позволяет добиться невероятного разрешения.', '15990', 0, 1, '2019-09-01 16:32:07', NULL, NULL, NULL),
(62, 2, 'Товар 2', 'default.png', 'Описание 2', '200', 0, 1, '2019-09-01 16:32:54', NULL, NULL, NULL),
(63, 2, 'Товар 3', 'default.png', 'Описание 3', '300', 0, 1, '2019-09-01 16:32:54', NULL, NULL, NULL),
(64, 2, 'Товар 4', 'default.png', 'Описание 4', '400', 0, 1, '2019-09-01 16:32:54', NULL, NULL, NULL),
(65, 2, 'Товар 5', 'default.png', 'Описание 5', '500', 0, 1, '2019-09-01 16:32:54', NULL, NULL, NULL),
(66, 2, 'Товар 6', 'default.png', 'Описание 6', '600', 0, 1, '2019-09-01 16:32:54', NULL, NULL, NULL),
(67, 2, 'Товар 7', 'default.png', 'Описание 7', '700', 0, 1, '2019-09-01 16:32:54', NULL, NULL, NULL),
(68, 2, 'Товар 8', 'default.png', 'Описание 8', '800', 0, 1, '2019-09-01 16:32:54', NULL, NULL, NULL),
(69, 2, 'Товар 9', 'default.png', 'Описание 9', '900', 0, 1, '2019-09-01 16:32:54', NULL, NULL, NULL),
(70, 2, 'Товар 10', 'default.png', 'Описание 10', '1000', 0, 1, '2019-09-01 16:32:54', NULL, NULL, NULL),
(551, 2, 'Товар 491', 'default.png', 'Описание 491', '49100', 0, 1, '2019-09-01 16:32:58', NULL, NULL, NULL),
(552, 2, 'Товар 492', 'default.png', 'Описание 492', '49200', 0, 1, '2019-09-01 16:32:58', NULL, NULL, NULL),
(554, 2, 'Товар 494', 'default.png', 'Описание 494', '49400', 0, 1, '2019-09-01 16:32:59', NULL, NULL, NULL),
(555, 2, 'Товар 495', 'default.png', 'Описание 495', '49500', 0, 1, '2019-09-01 16:32:59', NULL, NULL, NULL),
(556, 2, 'Товар 496', 'default.png', 'Описание 496', '49600', 0, 1, '2019-09-01 16:32:59', NULL, NULL, NULL),
(557, 2, 'Товар 497', 'default.png', 'Описание 497', '49700', 0, 1, '2019-09-01 16:32:59', NULL, NULL, NULL),
(558, 2, 'Товар 498', 'default.png', 'Описание 498', '49800', 0, 1, '2019-09-01 16:32:59', NULL, NULL, NULL),
(559, 2, 'Товар 499', 'default.png', 'Описание 499', '49900', 0, 1, '2019-09-01 16:32:59', NULL, NULL, NULL),
(560, 1, ' Товар 100500', 'default.png ', 'Товар 100500', '100500', 0, 1, '2019-09-15 18:55:11', NULL, NULL, NULL),
(561, 1, ' Товар 500100', 'default.png ', 'Товар 500100', '500100', 0, 1, '2019-09-15 18:56:37', NULL, NULL, NULL),
(564, 1, 'iPhone 11', 'iphone11.png', 'Новая система двух камер не оставит никого из ваших друзей за кадром. Самый быстрый процессор iPhone и мощный аккумулятор позволят больше делать и тратить меньше времени на подзарядку. А высочайшее качество видео на iPhone означает, что ваши истории станут ещё ярче и детальнее.', '59990', 0, 1, '2019-10-02 18:58:26', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rate` int(1) DEFAULT NULL,
  `comment` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_change` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `reviews`
--

INSERT INTO `reviews` (`id`, `name`, `rate`, `comment`, `date`, `date_change`) VALUES
(2, 'Лекса', 4, 'Все Хорошо', '2019-07-20 13:32:33', NULL),
(5, 'Петр', 3, 'все отлично', '2019-07-20 19:05:12', '2019-07-21 06:01:27'),
(14, 'Вениамин', 4, 'Ничо так', '2019-07-21 06:12:20', '2019-07-21 07:39:16'),
(22, 'Саша Белый', 2, 'Могло быть и лучше!!!', '2019-07-21 07:39:39', '2019-08-11 11:00:48'),
(23, 'Юзер', 4, 'Нормас, пацаны ваще ребята!', '2019-08-11 11:01:42', '2019-09-25 19:31:23'),
(25, 'Пользователь', 4, 'Товар пришел, все работает!!! ', '2019-09-26 19:13:09', '2019-09-28 14:25:31'),
(26, 'Лолка', 5, 'все понравилось!', '2019-09-28 14:26:35', '2019-09-30 19:38:37');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `dateReg` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `dateReg`) VALUES
(2, 'admin', '3cf108a4e0a498347a5a75a792f23212', NULL, NULL, '2019-07-28 10:51:56'),
(3, 'user1', '24c9e15e52afc47c225b757e7bee1f9d', NULL, NULL, '2019-07-28 11:45:06'),
(4, 'user2', '7e58d63b60197ceb55a1c487989a3720', NULL, NULL, '2019-07-28 11:46:21'),
(5, 'newuser', '0354d89c28ec399c00d3cb2d094cf093', 'NULL', 'NULL', '2019-09-28 14:46:58');

-- --------------------------------------------------------

--
-- Структура таблицы `users_history`
--

CREATE TABLE `users_history` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `page` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users_history`
--

INSERT INTO `users_history` (`id`, `userId`, `page`, `date`) VALUES
(1, 2, '/index.php?path=catalog', '2019-09-22 18:06:59'),
(2, 2, '/index.php?path=user/logout', '2019-09-22 18:36:48'),
(3, 3, '/index.php?path=user/login', '2019-09-22 18:38:05'),
(4, 3, '/index.php', '2019-09-22 18:38:05'),
(5, 3, '/index.php?path=delivery', '2019-09-22 18:38:15'),
(6, 3, '/', '2019-09-22 18:38:16'),
(7, 3, '/index.php?path=catalog', '2019-09-22 18:38:17'),
(8, 3, '/index.php?path=user/logout', '2019-09-22 18:42:16'),
(9, 2, '/index.php?path=user/login', '2019-09-22 18:42:48'),
(10, 2, '/index.php', '2019-09-22 18:42:49'),
(11, 2, '/index.php?path=user/logout', '2019-09-22 18:42:50'),
(12, 3, '/index.php?path=user/login', '2019-09-22 18:47:01'),
(13, 3, '/index.php', '2019-09-22 18:47:01'),
(14, 3, '/index.php?path=user/logout', '2019-09-22 18:47:02'),
(15, 3, '/index.php?path=user/login', '2019-09-22 18:47:17'),
(16, 3, '/index.php', '2019-09-22 18:47:17'),
(17, 3, '/index.php?path=user/logout', '2019-09-22 18:47:19'),
(18, 3, '/index.php?path=user/login', '2019-09-22 18:47:21'),
(19, 3, '/index.php', '2019-09-22 18:47:22'),
(20, 3, '/index.php?path=user/logout', '2019-09-22 18:47:26'),
(21, 3, '/index.php?path=user/createorder', '2019-09-22 18:47:35'),
(22, 3, '/index.php?path=catalog', '2019-09-22 18:47:43'),
(23, 3, '/index.php?path=user/userprofile', '2019-09-22 18:47:47'),
(24, 3, '/index.php?path=user/createorder', '2019-09-22 18:47:55'),
(25, 3, '/index.php?path=user/userprofile', '2019-09-22 18:48:43'),
(26, 3, '/index.php?path=user/userprofile', '2019-09-22 19:12:16'),
(27, 3, '/index.php?path=user/userprofile', '2019-09-22 19:15:13'),
(28, 3, '/index.php?path=user/userprofile', '2019-09-22 19:16:09'),
(29, 3, '/index.php?path=user/userprofile', '2019-09-22 19:16:25'),
(30, 3, '/', '2019-09-22 19:16:34'),
(31, 3, '/index.php?path=contacts', '2019-09-22 19:16:36'),
(32, 3, '/', '2019-09-22 19:16:37'),
(33, 3, '/index.php?path=delivery', '2019-09-22 19:16:38'),
(34, 3, '/index.php?path=user/userprofile', '2019-09-22 19:16:39'),
(35, 3, '/index.php?path=user/logout', '2019-09-22 19:17:03'),
(36, 2, '/index.php?path=user/login', '2019-09-22 19:17:06'),
(37, 2, '/index.php', '2019-09-22 19:17:06'),
(38, 2, '/index.php?path=user/userprofile', '2019-09-22 19:17:08'),
(39, 2, '/index.php?path=user/userprofile', '2019-09-22 19:17:36'),
(40, 2, '/index.php?path=user/logout', '2019-09-22 19:19:03'),
(41, 4, '/index.php?path=user/createorder', '2019-09-22 19:19:28'),
(42, 4, '/', '2019-09-22 19:19:55'),
(43, 4, '/index.php?path=user/logout', '2019-09-22 19:19:55'),
(44, 4, '/index.php?path=user/createorder', '2019-09-22 19:20:09'),
(45, 4, '/index.php?path=catalog', '2019-09-22 19:20:15'),
(46, 4, '/index.php?path=user/logout', '2019-09-22 19:20:15'),
(47, 4, '/index.php?path=user/createorder', '2019-09-22 19:20:20'),
(48, 4, '/index.php?path=catalog', '2019-09-22 19:20:47'),
(49, 4, '/index.php?path=user/logout', '2019-09-22 19:20:48'),
(50, 4, '/index.php?path=user/createorder', '2019-09-22 19:22:24'),
(51, 4, '/', '2019-09-22 19:22:45'),
(52, 4, '/index.php?path=user/userprofile', '2019-09-22 19:22:46'),
(53, 4, '/', '2019-09-22 19:25:18'),
(54, 4, '/index.php?path=catalog', '2019-09-22 19:25:20'),
(55, 4, '/index.php?path=user/createorder', '2019-09-22 19:25:36'),
(56, 4, '/index.php?path=user/userprofile', '2019-09-22 19:25:58'),
(57, 4, '/', '2019-09-23 16:51:09'),
(58, 4, '/index.php?path=user/userprofile', '2019-09-23 16:51:14'),
(59, 4, '/index.php?path=user/userprofile', '2019-09-23 16:51:26'),
(60, 4, '/index.php?path=catalog', '2019-09-23 16:51:39'),
(61, 4, '/index.php?path=user/userprofile', '2019-09-23 16:51:41'),
(62, 4, '/', '2019-09-23 16:51:50'),
(63, 4, '/index.php?path=user/logout', '2019-09-23 16:51:52'),
(64, 4, '/index.php?path=user/login', '2019-09-23 19:01:02'),
(65, 4, '/index.php', '2019-09-23 19:01:02'),
(66, 4, '/index.php?path=catalog', '2019-09-23 19:01:04'),
(67, 4, '/', '2019-09-23 19:01:07'),
(68, 4, '/index.php?path=user/logout', '2019-09-23 19:01:08'),
(69, 4, '/index.php?path=user/login', '2019-09-23 19:52:43'),
(70, 4, '/index.php', '2019-09-23 19:52:43'),
(71, 4, '/index.php?path=user/logout', '2019-09-23 19:52:44'),
(72, 2, '/index.php?path=user/login', '2019-09-23 19:52:47'),
(73, 2, '/index.php', '2019-09-23 19:52:48'),
(74, 2, '/index.php?path=contacts', '2019-09-23 19:52:49'),
(75, 2, '/index.php?path=user/logout', '2019-09-23 19:53:51'),
(76, 2, '/index.php?path=user/login', '2019-09-24 17:59:28'),
(77, 2, '/index.php', '2019-09-24 17:59:28'),
(78, 2, '/index.php?path=user/userprofile', '2019-09-24 17:59:29'),
(79, 2, '/index.php?path=delivery', '2019-09-24 17:59:41'),
(80, 2, '/index.php?path=contacts', '2019-09-24 17:59:41'),
(81, 2, '/index.php?path=catalog', '2019-09-24 17:59:42'),
(82, 2, '/index.php?path=user/createorder', '2019-09-24 17:59:56'),
(83, 2, '/index.php?path=contacts', '2019-09-24 18:00:05'),
(84, 2, '/index.php?path=contacts', '2019-09-24 18:15:13'),
(85, 2, '/index.php?path=contacts', '2019-09-24 18:29:02'),
(86, 2, '/index.php?path=contacts', '2019-09-24 18:29:42'),
(87, 2, '/index.php?path=contacts', '2019-09-24 18:29:47'),
(88, 2, '/index.php?path=contacts', '2019-09-24 18:31:48'),
(89, 2, '/index.php?path=contacts', '2019-09-24 18:31:58'),
(90, 2, '/index.php?path=contacts', '2019-09-24 18:32:17'),
(91, 2, '/index.php?path=contacts', '2019-09-24 18:33:41'),
(92, 2, '/index.php?path=contacts', '2019-09-24 18:36:58'),
(93, 2, '/index.php?path=contacts', '2019-09-24 18:38:49'),
(94, 2, '/index.php?path=contacts', '2019-09-24 18:39:44'),
(95, 2, '/index.php?path=contacts', '2019-09-24 18:43:37'),
(96, 2, '/index.php?path=contacts', '2019-09-24 18:45:14'),
(97, 2, '/index.php?path=contacts', '2019-09-24 18:45:28'),
(98, 2, '/index.php?path=contacts', '2019-09-24 18:47:12'),
(99, 2, '/index.php?path=contacts', '2019-09-24 18:48:05'),
(100, 2, '/index.php?path=contacts', '2019-09-24 18:49:46'),
(101, 2, '/index.php?path=contacts', '2019-09-24 18:49:47'),
(102, 2, '/index.php?path=contacts', '2019-09-24 18:49:50'),
(103, 2, '/index.php?path=contacts', '2019-09-24 18:50:09'),
(104, 2, '/index.php?path=contacts', '2019-09-24 18:50:11'),
(105, 2, '/index.php?path=contacts', '2019-09-24 18:50:57'),
(106, 2, '/index.php?path=contacts', '2019-09-24 18:51:18'),
(107, 2, '/index.php?path=contacts', '2019-09-24 18:51:21'),
(108, 2, '/index.php?path=contacts', '2019-09-24 18:54:15'),
(109, 2, '/index.php?path=contacts', '2019-09-24 18:55:10'),
(110, 2, '/index.php?path=contacts', '2019-09-24 18:57:18'),
(111, 2, '/index.php?path=contacts', '2019-09-24 18:57:22'),
(112, 2, '/index.php?path=contacts', '2019-09-24 19:04:52'),
(113, 2, '/index.php?path=contacts', '2019-09-24 19:05:54'),
(114, 2, '/index.php?path=contacts', '2019-09-24 19:11:03'),
(115, 2, '/index.php?path=contacts', '2019-09-24 19:11:15'),
(116, 2, '/index.php?path=contacts', '2019-09-24 19:12:48'),
(117, 2, '/index.php?path=contacts', '2019-09-24 19:13:37'),
(118, 2, '/index.php?path=contacts', '2019-09-24 19:26:15'),
(119, 2, '/index.php?path=contacts', '2019-09-24 19:55:15'),
(120, 2, '/index.php?path=contacts', '2019-09-24 19:58:23'),
(121, 2, '/index.php?path=contacts', '2019-09-24 19:58:32'),
(122, 2, '/index.php?path=contacts', '2019-09-24 19:59:28'),
(123, 2, '/index.php?path=user/userprofile', '2019-09-24 20:06:51'),
(124, 2, '/index.php?path=contacts', '2019-09-24 20:07:29'),
(125, 2, '/index.php?path=contacts', '2019-09-24 20:15:35'),
(126, 2, '/index.php?path=contacts', '2019-09-24 20:26:08'),
(127, 2, '/index.php?path=contacts', '2019-09-24 20:34:27'),
(128, 2, '/index.php?path=contacts', '2019-09-24 20:38:43'),
(129, 2, '/index.php?path=contacts', '2019-09-24 20:38:52'),
(130, 2, '/index.php?path=contacts', '2019-09-24 20:41:03'),
(131, 2, '/index.php?path=contacts', '2019-09-24 20:42:00'),
(132, 2, '/index.php?path=contacts', '2019-09-24 20:42:11'),
(133, 2, '/index.php?path=contacts', '2019-09-24 20:42:31'),
(134, 2, '/index.php?path=contacts', '2019-09-24 20:42:50'),
(135, 2, '/index.php?path=contacts', '2019-09-24 20:43:11'),
(136, 2, '/index.php?path=contacts', '2019-09-24 20:43:21'),
(137, 2, '/index.php?path=contacts', '2019-09-24 20:43:58'),
(138, 2, '/index.php?path=contacts', '2019-09-24 20:49:01'),
(139, 2, '/index.php?path=contacts', '2019-09-24 20:49:13'),
(140, 2, '/index.php?path=contacts', '2019-09-25 17:23:37'),
(141, 2, '/index.php?path=contacts', '2019-09-25 17:26:02'),
(142, 2, '/index.php?path=contacts', '2019-09-25 17:27:58'),
(143, 2, '/index.php?path=contacts', '2019-09-25 17:28:01'),
(144, 2, '/index.php?path=user/logout', '2019-09-25 17:28:02'),
(145, 2, '/index.php?path=user/login', '2019-09-25 17:29:07'),
(146, 2, '/index.php', '2019-09-25 17:29:07'),
(147, 2, '/index.php?path=contacts', '2019-09-25 17:29:09'),
(148, 2, '/index.php?path=contacts', '2019-09-25 17:39:10'),
(149, 2, '/index.php?path=contacts', '2019-09-25 17:39:51'),
(150, 2, '/index.php?path=contacts', '2019-09-25 17:39:55'),
(151, 2, '/index.php?path=contacts', '2019-09-25 17:41:20'),
(152, 2, '/index.php?path=contacts', '2019-09-25 17:41:28'),
(153, 2, '/index.php?path=contacts', '2019-09-25 17:43:10'),
(154, 2, '/index.php?path=contacts', '2019-09-25 17:43:34'),
(155, 2, '/index.php?path=contacts', '2019-09-25 17:46:26'),
(156, 2, '/index.php?path=contacts', '2019-09-25 17:47:06'),
(157, 2, '/index.php?path=contacts', '2019-09-25 17:47:38'),
(158, 2, '/index.php?path=contacts', '2019-09-25 17:47:42'),
(159, 2, '/index.php?path=contacts', '2019-09-25 17:48:30'),
(160, 2, '/index.php?path=contacts', '2019-09-25 17:50:17'),
(161, 2, '/index.php?path=contacts', '2019-09-25 17:52:17'),
(162, 2, '/index.php?path=contacts', '2019-09-25 17:54:14'),
(163, 2, '/index.php?path=user/logout', '2019-09-25 17:54:31'),
(164, 2, '/index.php?path=user/login', '2019-09-25 17:55:06'),
(165, 2, '/index.php', '2019-09-25 17:55:06'),
(166, 2, '/index.php?path=contacts', '2019-09-25 17:55:07'),
(167, 2, '/index.php?path=contacts', '2019-09-25 17:59:57'),
(168, 2, '/index.php?path=contacts', '2019-09-25 18:00:12'),
(169, 2, '/index.php?path=contacts', '2019-09-25 18:02:28'),
(170, 2, '/index.php?path=contacts', '2019-09-25 18:02:38'),
(171, 2, '/index.php?path=contacts', '2019-09-25 18:02:41'),
(172, 2, '/index.php?path=contacts', '2019-09-25 18:03:36'),
(173, 2, '/index.php?path=contacts', '2019-09-25 18:06:03'),
(174, 2, '/index.php?path=contacts', '2019-09-25 18:06:42'),
(175, 2, '/index.php?path=contacts', '2019-09-25 18:06:52'),
(176, 2, '/index.php?path=contacts', '2019-09-25 18:06:55'),
(177, 2, '/index.php?path=contacts', '2019-09-25 18:15:09'),
(178, 2, '/index.php?path=contacts', '2019-09-25 18:25:33'),
(179, 2, '/index.php?path=contacts', '2019-09-25 18:26:15'),
(180, 2, '/index.php?path=contacts', '2019-09-25 18:26:18'),
(181, 2, '/index.php?path=contacts', '2019-09-25 18:31:04'),
(182, 2, '/index.php?path=contacts', '2019-09-25 18:32:35'),
(183, 2, '/index.php?path=contacts', '2019-09-25 18:34:30'),
(184, 2, '/index.php?path=contacts', '2019-09-25 18:34:53'),
(185, 2, '/index.php?path=contacts', '2019-09-25 18:35:09'),
(186, 2, '/index.php?path=contacts', '2019-09-25 18:37:13'),
(187, 2, '/index.php?path=contacts', '2019-09-25 18:38:42'),
(188, 2, '/index.php?path=contacts', '2019-09-25 18:39:17'),
(189, 2, '/index.php?path=contacts', '2019-09-25 18:39:24'),
(190, 2, '/index.php?path=contacts', '2019-09-25 18:39:53'),
(191, 2, '/index.php?path=contacts', '2019-09-25 18:40:10'),
(192, 2, '/index.php?path=contacts', '2019-09-25 18:43:40'),
(193, 2, '/index.php?path=contacts', '2019-09-25 18:44:15'),
(194, 2, '/index.php?path=contacts', '2019-09-25 18:47:19'),
(195, 2, '/index.php?path=contacts', '2019-09-25 18:52:10'),
(196, 2, '/index.php?path=contacts', '2019-09-25 18:52:54'),
(197, 2, '/index.php?path=contacts', '2019-09-25 18:52:58'),
(198, 2, '/index.php?path=contacts', '2019-09-25 18:55:25'),
(199, 2, '/index.php?path=contacts', '2019-09-25 19:11:31'),
(200, 2, '/index.php?path=contacts', '2019-09-25 19:11:35'),
(201, 2, '/index.php?path=contacts', '2019-09-25 19:12:10'),
(202, 2, '/index.php?path=contacts', '2019-09-25 19:15:40'),
(203, 2, '/index.php?path=contacts', '2019-09-25 19:16:49'),
(204, 2, '/index.php?path=contacts', '2019-09-25 19:17:03'),
(205, 2, '/index.php?path=contacts', '2019-09-25 19:19:53'),
(206, 2, '/index.php?path=contacts', '2019-09-25 19:22:07'),
(207, 2, '/index.php?path=contacts', '2019-09-25 19:22:31'),
(208, 2, '/index.php?path=contacts', '2019-09-25 19:24:06'),
(209, 2, '/index.php?path=contacts', '2019-09-25 19:24:26'),
(210, 2, '/index.php?path=contacts', '2019-09-25 19:24:59'),
(211, 2, '/index.php?path=contacts', '2019-09-25 19:27:03'),
(212, 2, '/index.php?path=contacts', '2019-09-25 19:30:50'),
(213, 2, '/index.php?path=contacts', '2019-09-25 19:31:02'),
(214, 2, '/index.php?path=contacts', '2019-09-25 19:31:14'),
(215, 2, '/index.php?path=contacts', '2019-09-25 19:31:25'),
(216, 2, '/index.php?path=contacts', '2019-09-25 19:31:37'),
(217, 2, '/index.php?path=catalog', '2019-09-25 19:35:25'),
(218, 2, '/', '2019-09-26 18:11:29'),
(219, 2, '/index.php?path=user/userprofile', '2019-09-26 18:11:32'),
(220, 2, '/index.php?path=contacts', '2019-09-26 18:11:39'),
(221, 2, '/index.php?path=contacts', '2019-09-26 18:14:59'),
(222, 2, '/index.php?path=contacts', '2019-09-26 18:18:38'),
(223, 2, '/index.php?path=contacts', '2019-09-26 18:21:57'),
(224, 2, '/', '2019-09-26 18:33:23'),
(225, 2, '/index.php?path=contacts', '2019-09-26 18:33:25'),
(226, 2, '/', '2019-09-26 18:38:05'),
(227, 2, '/index.php?path=catalog', '2019-09-26 18:38:15'),
(228, 2, '/index.php?path=delivery', '2019-09-26 18:38:17'),
(229, 2, '/index.php?path=contacts', '2019-09-26 18:38:18'),
(230, 2, '/', '2019-09-26 18:38:20'),
(231, 2, '/index.php?path=catalog', '2019-09-26 18:38:21'),
(232, 2, '/index.php?path=user/userprofile', '2019-09-26 18:38:36'),
(233, 2, '/index.php?path=user/logout', '2019-09-26 18:40:41'),
(234, 4, '/index.php?path=user/createorder', '2019-09-26 18:40:52'),
(235, 4, '/index.php?path=catalog', '2019-09-26 18:41:06'),
(236, 4, '/index.php?path=contacts', '2019-09-26 18:41:07'),
(237, 4, '/index.php?path=catalog', '2019-09-26 18:41:09'),
(238, 4, '/index.php?path=user/logout', '2019-09-26 18:41:09'),
(239, 3, '/index.php?path=user/createorder', '2019-09-26 18:41:15'),
(240, 3, '/index.php?path=catalog', '2019-09-26 18:41:19'),
(241, 3, '/index.php?path=user/logout', '2019-09-26 18:41:21'),
(242, 4, '/index.php?path=user/login', '2019-09-26 18:41:42'),
(243, 4, '/index.php', '2019-09-26 18:41:42'),
(244, 4, '/index.php?path=user/logout', '2019-09-26 18:41:46'),
(245, 4, '/index.php?path=user/createorder', '2019-09-26 18:41:57'),
(246, 4, '/', '2019-09-26 18:43:57'),
(247, 4, '/index.php?path=catalog', '2019-09-26 18:43:59'),
(248, 4, '/index.php?path=delivery', '2019-09-26 18:44:00'),
(249, 4, '/index.php?path=contacts', '2019-09-26 18:44:02'),
(250, 4, '/index.php?path=contacts', '2019-09-26 18:50:05'),
(251, 4, '/', '2019-09-26 18:50:06'),
(252, 4, '/index.php?path=catalog', '2019-09-26 18:50:07'),
(253, 4, '/index.php?path=contacts', '2019-09-26 18:50:08'),
(254, 4, '/index.php?path=user/logout', '2019-09-26 18:50:11'),
(255, 2, '/index.php?path=user/login', '2019-09-26 18:50:16'),
(256, 2, '/index.php', '2019-09-26 18:50:16'),
(257, 2, '/index.php?path=contacts', '2019-09-26 18:50:18'),
(258, 2, '/index.php?path=contacts', '2019-09-26 19:03:24'),
(259, 2, '/index.php?path=catalog', '2019-09-26 19:03:26'),
(260, 2, '/', '2019-09-26 19:03:27'),
(261, 2, '/index.php?path=catalog', '2019-09-26 19:03:28'),
(262, 2, '/index.php?path=contacts', '2019-09-26 19:03:33'),
(263, 2, '/index.php?path=contacts', '2019-09-26 19:06:07'),
(264, 2, '/index.php?path=contacts', '2019-09-26 19:11:52'),
(265, 2, '/index.php?path=contacts', '2019-09-26 19:12:48'),
(266, 2, '/index.php?path=contacts', '2019-09-26 19:12:55'),
(267, 2, '/index.php?path=contacts', '2019-09-26 19:13:09'),
(268, 2, '/index.php?path=contacts', '2019-09-26 19:29:38'),
(269, 2, '/', '2019-09-26 19:29:39'),
(270, 2, '/index.php?path=catalog', '2019-09-26 19:29:40'),
(271, 2, '/index.php?path=user/logout', '2019-09-26 19:29:41'),
(272, 3, '/index.php?path=user/login', '2019-09-28 06:28:22'),
(273, 3, '/index.php', '2019-09-28 06:28:22'),
(274, 3, '/index.php?path=user/userprofile', '2019-09-28 06:28:23'),
(275, 3, '/index.php?path=contacts', '2019-09-28 06:28:29'),
(276, 3, '/', '2019-09-28 06:28:30'),
(277, 3, '/', '2019-09-28 06:30:19'),
(278, 3, '/', '2019-09-28 06:33:17'),
(279, 3, '/', '2019-09-28 06:41:44'),
(280, 3, '/', '2019-09-28 06:41:55'),
(281, 3, '/', '2019-09-28 06:44:33'),
(282, 3, '/', '2019-09-28 06:44:46'),
(283, 3, '/', '2019-09-28 13:19:55'),
(284, 3, '/', '2019-09-28 13:19:56'),
(285, 3, '/index.php?path=catalog', '2019-09-28 13:22:29'),
(286, 3, '/', '2019-09-28 13:22:33'),
(287, 3, '/index.php?path=user/logout', '2019-09-28 13:22:35'),
(288, 2, '/index.php?path=user/login', '2019-09-28 13:30:20'),
(289, 2, '/index.php', '2019-09-28 13:30:20'),
(290, 2, '/index.php', '2019-09-28 13:30:31'),
(291, 2, '/index.php', '2019-09-28 13:30:41'),
(292, 2, '/index.php', '2019-09-28 13:30:50'),
(293, 2, '/index.php?path=delivery', '2019-09-28 13:30:56'),
(294, 2, '/index.php?path=contacts', '2019-09-28 13:31:00'),
(295, 2, '/index.php?path=delivery', '2019-09-28 13:31:04'),
(296, 2, '/index.php?path=catalog', '2019-09-28 13:31:06'),
(297, 2, '/index.php?path=catalog', '2019-09-28 13:38:58'),
(298, 2, '/', '2019-09-28 13:39:10'),
(299, 2, '/index.php?path=user/userprofile', '2019-09-28 13:39:12'),
(300, 2, '/', '2019-09-28 13:39:18'),
(301, 2, '/index.php?path=contacts', '2019-09-28 13:39:19'),
(302, 2, '/index.php?path=contacts', '2019-09-28 13:42:50'),
(303, 2, '/index.php?path=contacts', '2019-09-28 13:42:51'),
(304, 2, '/', '2019-09-28 13:43:33'),
(305, 2, '/', '2019-09-28 13:43:33'),
(306, 2, '/index.php?path=catalog', '2019-09-28 13:43:34'),
(307, 2, '/index.php?path=catalog/show/1', '2019-09-28 13:43:36'),
(308, 2, '/index.php?path=catalog/show/1', '2019-09-28 13:46:04'),
(309, 2, '/index.php?path=catalog/show/1', '2019-09-28 13:46:05'),
(310, 2, '/', '2019-09-28 13:46:12'),
(311, 2, '/index.php?path=contacts', '2019-09-28 13:46:13'),
(312, 2, '/index.php?path=contacts', '2019-09-28 13:52:25'),
(313, 2, '/index.php?path=contacts', '2019-09-28 13:53:55'),
(314, 2, '/index.php?path=contacts', '2019-09-28 13:58:17'),
(315, 2, '/index.php?path=contacts', '2019-09-28 14:01:05'),
(316, 2, '/index.php?path=contacts', '2019-09-28 14:01:06'),
(317, 2, '/index.php?path=contacts', '2019-09-28 14:03:31'),
(318, 2, '/index.php?path=contacts', '2019-09-28 14:03:58'),
(319, 2, '/index.php?path=contacts', '2019-09-28 14:03:59'),
(320, 2, '/index.php?path=contacts', '2019-09-28 14:03:59'),
(321, 2, '/index.php?path=contacts', '2019-09-28 14:04:03'),
(322, 2, '/index.php?path=contacts', '2019-09-28 14:04:06'),
(323, 2, '/index.php?path=contacts', '2019-09-28 14:04:46'),
(324, 2, '/index.php?path=contacts', '2019-09-28 14:06:54'),
(325, 2, '/index.php?path=contacts', '2019-09-28 14:07:13'),
(326, 2, '/index.php?path=contacts', '2019-09-28 14:07:48'),
(327, 2, '/index.php?path=contacts', '2019-09-28 14:09:50'),
(328, 2, '/index.php?path=contacts', '2019-09-28 14:10:21'),
(329, 2, '/index.php?path=contacts', '2019-09-28 14:10:25'),
(330, 2, '/index.php?path=contacts', '2019-09-28 14:12:39'),
(331, 2, '/index.php?path=contacts', '2019-09-28 14:13:06'),
(332, 2, '/', '2019-09-28 14:13:50'),
(333, 2, '/index.php?path=catalog', '2019-09-28 14:13:51'),
(334, 2, '/index.php?path=catalog', '2019-09-28 14:14:02'),
(335, 2, '/index.php?path=catalog', '2019-09-28 14:14:47'),
(336, 2, '/index.php?path=catalog', '2019-09-28 14:15:50'),
(337, 2, '/index.php?path=contacts', '2019-09-28 14:16:22'),
(338, 2, '/index.php?path=contacts', '2019-09-28 14:16:25'),
(339, 2, '/index.php?path=contacts', '2019-09-28 14:17:11'),
(340, 2, '/index.php?path=contacts', '2019-09-28 14:17:23'),
(341, 2, '/index.php?path=catalog', '2019-09-28 14:17:40'),
(342, 2, '/index.php?path=catalog', '2019-09-28 14:18:41'),
(343, 2, '/index.php?path=catalog', '2019-09-28 14:18:45'),
(344, 2, '/index.php?path=delivery', '2019-09-28 14:18:48'),
(345, 2, '/index.php?path=contacts', '2019-09-28 14:18:49'),
(346, 2, '/index.php?path=catalog', '2019-09-28 14:18:52'),
(347, 2, '/', '2019-09-28 14:19:00'),
(348, 2, '/index.php?path=user/userprofile', '2019-09-28 14:19:01'),
(349, 2, '/index.php?path=user/userprofile', '2019-09-28 14:22:42'),
(350, 2, '/index.php?path=user/userprofile', '2019-09-28 14:24:01'),
(351, 2, '/index.php?path=user/userprofile', '2019-09-28 14:24:38'),
(352, 2, '/index.php?path=catalog', '2019-09-28 14:24:45'),
(353, 2, '/', '2019-09-28 14:24:46'),
(354, 2, '/index.php?path=catalog', '2019-09-28 14:24:47'),
(355, 2, '/index.php?path=catalog/show/2', '2019-09-28 14:24:48'),
(356, 2, '/index.php?path=catalog/change/2', '2019-09-28 14:24:55'),
(357, 2, '/', '2019-09-28 14:24:59'),
(358, 2, '/index.php?path=catalog', '2019-09-28 14:25:00'),
(359, 2, '/index.php?path=catalog/add', '2019-09-28 14:25:01'),
(360, 2, '/', '2019-09-28 14:25:04'),
(361, 2, '/index.php?path=user/userprofile', '2019-09-28 14:25:05'),
(362, 2, '/index.php?path=user/userprofile', '2019-09-28 14:25:13'),
(363, 2, '/index.php?path=contacts', '2019-09-28 14:25:16'),
(364, 2, '/index.php?path=contacts', '2019-09-28 14:25:32'),
(365, 2, '/index.php?path=contacts', '2019-09-28 14:26:35'),
(366, 2, '/index.php?path=contacts', '2019-09-28 14:26:44'),
(367, 2, '/index.php?path=contacts', '2019-09-28 14:28:11'),
(368, 2, '/', '2019-09-28 14:28:16'),
(369, 2, '/index.php?path=catalog', '2019-09-28 14:28:19'),
(370, 2, '/index.php?path=catalog/show/2', '2019-09-28 14:28:21'),
(371, 2, '/', '2019-09-28 14:28:23'),
(372, 2, '/index.php?path=catalog', '2019-09-28 14:28:24'),
(373, 2, '/index.php?path=catalog/show/4', '2019-09-28 14:28:25'),
(374, 2, '/', '2019-09-28 14:28:29'),
(375, 2, '/', '2019-09-28 14:46:41'),
(376, 2, '/index.php?path=user/logout', '2019-09-28 14:46:44'),
(377, 5, '/index.php?path=user/login', '2019-09-28 14:48:03'),
(378, 5, '/index.php', '2019-09-28 14:48:03'),
(379, 5, '/index.php?path=user/userprofile', '2019-09-28 14:48:10'),
(380, 5, '/index.php?path=user/userprofile', '2019-09-28 14:49:12'),
(381, 5, '/index.php?path=user/userprofile', '2019-09-28 14:54:30'),
(382, 5, '/index.php?path=user/userprofile', '2019-09-28 14:58:41'),
(383, 5, '/index.php?path=catalog', '2019-09-28 14:58:49'),
(384, 5, '/index.php?path=user/userprofile', '2019-09-28 14:59:33'),
(385, 5, '/index.php?path=catalog', '2019-09-28 14:59:50'),
(386, 5, '/index.php?path=user/createorder', '2019-09-28 15:00:10'),
(387, 5, '/index.php?path=user/userprofile', '2019-09-28 15:00:34'),
(388, 5, '/index.php?path=user/createorder', '2019-09-28 15:00:48'),
(389, 5, '/index.php?path=user/createorder', '2019-09-28 15:01:47'),
(390, 5, '/index.php?path=user/userprofile', '2019-09-28 15:01:51'),
(391, 5, '/index.php?path=user/userprofile', '2019-09-28 15:02:15'),
(392, 5, '/index.php?path=user/userprofile', '2019-09-28 15:02:19'),
(393, 5, '/index.php?path=user/logout', '2019-09-28 15:02:22'),
(394, 2, '/index.php?path=user/login', '2019-09-28 15:02:25'),
(395, 2, '/index.php', '2019-09-28 15:02:25'),
(396, 2, '/index.php?path=user/userprofile', '2019-09-28 15:02:27'),
(397, 2, '/index.php?path=user/userprofile', '2019-09-28 15:02:34'),
(398, 2, '/index.php?path=user/userprofile', '2019-09-28 15:02:37'),
(399, 2, '/index.php?path=user/userprofile', '2019-09-28 15:02:43'),
(400, 2, '/index.php?path=user/userprofile', '2019-09-28 15:02:45'),
(401, 2, '/index.php?path=catalog', '2019-09-28 15:02:56'),
(402, 2, '/index.php?path=user/logout', '2019-09-28 15:03:37'),
(403, 0, '/index.php?path=user/reg', '2019-09-28 15:09:55'),
(404, 0, '/index.php', '2019-09-28 15:09:55'),
(405, 0, '/index.php?path=catalog', '2019-09-28 15:10:16'),
(406, 0, '/index.php?path=user/userprofile', '2019-09-28 15:10:18'),
(407, 0, '/index.php?path=user/logout', '2019-09-28 15:10:23'),
(408, 2, '/index.php?path=user/login', '2019-09-28 15:18:12'),
(409, 2, '/index.php', '2019-09-28 15:18:12'),
(410, 2, '/index.php?path=contacts', '2019-09-28 15:18:13'),
(411, 2, '/index.php?path=contacts', '2019-09-28 15:18:17'),
(412, 2, '/', '2019-09-28 15:20:48'),
(413, 2, '/', '2019-09-28 15:22:40'),
(414, 2, '/index.php?path=user/userprofile', '2019-09-28 15:22:41'),
(415, 2, '/index.php?path=user/userprofile', '2019-09-28 15:23:03'),
(416, 2, '/index.php?path=user/userprofile', '2019-09-28 15:24:24'),
(417, 2, '/index.php?path=user/userprofile', '2019-09-28 15:26:39'),
(418, 2, '/index.php?path=user/userprofile', '2019-09-28 15:26:57'),
(419, 2, '/index.php?path=user/userprofile', '2019-09-28 15:27:17'),
(420, 2, '/index.php?path=user/userprofile', '2019-09-28 15:28:09'),
(421, 2, '/index.php?path=user/userprofile', '2019-09-28 15:30:20'),
(422, 2, '/index.php?path=user/userprofile', '2019-09-28 15:30:37'),
(423, 2, '/index.php?path=user/userprofile', '2019-09-28 15:31:27'),
(424, 2, '/index.php?path=user/userprofile', '2019-09-28 15:32:18'),
(425, 2, '/index.php?path=user/userprofile', '2019-09-28 15:32:26'),
(426, 2, '/index.php?path=user/userprofile', '2019-09-28 15:33:02'),
(427, 2, '/index.php?path=user/userprofile', '2019-09-28 15:33:09'),
(428, 2, '/index.php?path=user/userprofile', '2019-09-28 15:33:14'),
(429, 2, '/index.php?path=user/userprofile', '2019-09-28 15:33:53'),
(430, 2, '/index.php?path=user/userprofile', '2019-09-28 15:34:07'),
(431, 2, '/index.php?path=user/userprofile', '2019-09-28 15:34:50'),
(432, 2, '/index.php?path=user/userprofile', '2019-09-28 15:35:29'),
(433, 2, '/index.php?path=user/userprofile', '2019-09-28 15:35:42'),
(434, 2, '/index.php?path=user/userprofile', '2019-09-28 15:35:52'),
(435, 2, '/index.php?path=user/userprofile', '2019-09-28 15:36:00'),
(436, 2, '/index.php?path=user/userprofile', '2019-09-28 15:36:11'),
(437, 2, '/index.php?path=user/userprofile', '2019-09-28 15:42:20'),
(438, 2, '/index.php?path=user/userprofile', '2019-09-28 15:43:33'),
(439, 2, '/index.php?path=user/userprofile', '2019-09-28 15:43:55'),
(440, 2, '/index.php?path=user/userprofile', '2019-09-28 15:45:24'),
(441, 2, '/index.php?path=user/userprofile', '2019-09-28 15:45:42'),
(442, 2, '/index.php?path=user/userprofile', '2019-09-28 15:47:42'),
(443, 2, '/index.php?path=user/userprofile', '2019-09-28 15:47:52'),
(444, 2, '/index.php?path=user/userprofile', '2019-09-28 15:49:50'),
(445, 2, '/index.php?path=user/userprofile', '2019-09-28 15:50:17'),
(446, 2, '/index.php?path=user/userprofile', '2019-09-28 15:51:17'),
(447, 2, '/index.php?path=user/userprofile', '2019-09-28 15:51:33'),
(448, 2, '/index.php?path=user/userprofile', '2019-09-28 15:53:44'),
(449, 2, '/index.php?path=user/userprofile', '2019-09-28 15:54:00'),
(450, 2, '/index.php?path=user/userprofile', '2019-09-28 15:54:50'),
(451, 2, '/index.php?path=user/userprofile', '2019-09-28 15:57:57'),
(452, 2, '/index.php?path=user/userprofile', '2019-09-28 15:58:51'),
(453, 2, '/index.php?path=user/userprofile', '2019-09-28 16:10:14'),
(454, 2, '/', '2019-09-29 04:42:03'),
(455, 2, '/', '2019-09-29 05:16:28'),
(456, 2, '/index.php?path=catalog', '2019-09-29 05:16:29'),
(457, 2, '/index.php?path=contacts', '2019-09-29 05:16:30'),
(458, 2, '/index.php?path=contacts', '2019-09-29 05:16:37'),
(459, 2, '/index.php?path=contacts', '2019-09-29 05:59:18'),
(460, 2, '/index.php?path=contacts', '2019-09-29 06:34:09'),
(461, 2, '/', '2019-09-29 06:34:11'),
(462, 2, '/index.php?path=delivery', '2019-09-29 06:34:13'),
(463, 2, '/index.php?path=contacts', '2019-09-29 06:34:14'),
(464, 2, '/index.php?path=delivery', '2019-09-29 06:34:15'),
(465, 2, '/', '2019-09-29 06:34:16'),
(466, 2, '/index.php?path=catalog', '2019-09-29 06:34:17'),
(467, 2, '/index.php?path=catalog', '2019-09-29 06:58:14'),
(468, 2, '/index.php?path=catalog', '2019-09-29 06:58:36'),
(469, 2, '/index.php?path=catalog', '2019-09-29 06:59:14'),
(470, 2, '/index.php?path=catalog', '2019-09-29 06:59:15'),
(471, 2, '/index.php?path=catalog', '2019-09-29 06:59:16'),
(472, 2, '/index.php?path=catalog', '2019-09-29 07:01:36'),
(473, 2, '/index.php?path=catalog', '2019-09-29 07:01:37'),
(474, 2, '/index.php?path=catalog', '2019-09-29 07:05:18'),
(475, 2, '/', '2019-09-29 07:05:21'),
(476, 2, '/index.php?path=catalog', '2019-09-29 07:05:22'),
(477, 2, '/index.php?path=catalog', '2019-09-29 07:05:53'),
(478, 2, '/', '2019-09-29 07:06:02'),
(479, 2, '/index.php?path=catalog', '2019-09-29 07:06:03'),
(480, 2, '/index.php?path=delivery', '2019-09-29 07:06:04'),
(481, 2, '/index.php?path=catalog', '2019-09-29 07:06:05'),
(482, 2, '/index.php?path=contacts', '2019-09-29 07:06:07'),
(483, 2, '/', '2019-09-29 07:06:08'),
(484, 2, '/', '2019-09-29 07:30:43'),
(485, 2, '/index.php?path=catalog', '2019-09-29 07:30:45'),
(486, 2, '/', '2019-09-29 07:30:46'),
(487, 2, '/', '2019-09-29 07:33:10'),
(488, 2, '/', '2019-09-29 07:33:12'),
(489, 2, '/index.php?path=catalog', '2019-09-29 07:33:12'),
(490, 2, '/index.php?path=catalog/show/3', '2019-09-29 07:33:14'),
(491, 2, '/index.php?path=catalog', '2019-09-29 07:33:15'),
(492, 2, '/index.php?path=contacts', '2019-09-29 07:33:17'),
(493, 2, '/index.php?path=contacts', '2019-09-29 07:33:21'),
(494, 2, '/', '2019-09-29 08:24:45'),
(495, 2, '/index.php?path=user/logout', '2019-09-29 10:36:29'),
(496, 18, '/index.php?path=user/login', '2019-09-29 10:38:00'),
(497, 18, '/index.php', '2019-09-29 10:38:00'),
(498, 18, '/index.php?path=user/userprofile', '2019-09-29 10:38:04'),
(499, 18, '/index.php?path=catalog', '2019-09-29 10:38:25'),
(500, 18, '/index.php?path=user/userprofile', '2019-09-29 10:38:26'),
(501, 18, '/index.php?path=user/userprofile', '2019-09-29 10:39:12'),
(502, 18, '/index.php?path=user/userprofile', '2019-09-29 10:39:54'),
(503, 18, '/index.php?path=catalog', '2019-09-29 11:28:49'),
(504, 18, '/index.php?path=user/logout', '2019-09-29 12:39:51'),
(505, 2, '/index.php?path=user/login', '2019-09-29 16:04:34'),
(506, 2, '/index.php', '2019-09-29 16:04:34'),
(507, 2, '/index.php?path=catalog', '2019-09-29 16:04:41'),
(508, 2, '/index.php?path=user/logout', '2019-09-29 16:04:43'),
(509, 2, '/index.php?path=user/login', '2019-09-29 19:05:48'),
(510, 2, '/index.php', '2019-09-29 19:05:48'),
(511, 2, '/index.php?path=catalog', '2019-09-29 19:05:51'),
(512, 2, '/', '2019-09-29 19:05:52'),
(513, 2, '/', '2019-09-29 19:05:57'),
(514, 2, '/index.php?path=user/userprofile', '2019-09-29 19:08:19'),
(515, 2, '/index.php?path=user/userprofile', '2019-09-29 19:08:37'),
(516, 2, '/index.php?path=user/userprofile', '2019-09-29 19:14:46'),
(517, 2, '/index.php?path=user/userprofile', '2019-09-29 19:15:24'),
(518, 2, '/index.php?path=user/userprofile', '2019-09-29 19:15:42'),
(519, 2, '/index.php?path=user/userprofile', '2019-09-29 19:16:25'),
(520, 2, '/index.php?path=user/userprofile', '2019-09-29 19:16:49'),
(521, 2, '/index.php?path=user/userprofile', '2019-09-29 19:17:27'),
(522, 2, '/index.php?path=user/userprofile', '2019-09-29 19:17:45'),
(523, 2, '/index.php?path=user/userprofile', '2019-09-29 19:19:12'),
(524, 2, '/index.php?path=user/userprofile', '2019-09-29 19:19:16'),
(525, 2, '/index.php?path=user/userprofile', '2019-09-29 19:19:27'),
(526, 2, '/index.php?path=user/userprofile', '2019-09-29 19:19:32'),
(527, 2, '/index.php?path=user/userprofile', '2019-09-29 19:20:40'),
(528, 2, '/index.php?path=user/userprofile', '2019-09-29 19:35:16'),
(529, 2, '/index.php?path=user/userprofile', '2019-09-29 19:35:45'),
(530, 2, '/index.php?path=user/userprofile', '2019-09-29 19:36:04'),
(531, 2, '/', '2019-09-30 17:17:15'),
(532, 2, '/index.php?path=catalog', '2019-09-30 17:17:27'),
(533, 2, '/index.php?path=delivery', '2019-09-30 17:17:29'),
(534, 2, '/index.php?path=contacts', '2019-09-30 17:17:43'),
(535, 2, '/', '2019-09-30 17:17:46'),
(536, 2, '/index.php?path=contacts', '2019-09-30 17:17:47'),
(537, 2, '/index.php?path=contacts', '2019-09-30 19:12:33'),
(538, 2, '/index.php?path=contacts', '2019-09-30 19:16:32'),
(539, 2, '/index.php?path=delivery', '2019-09-30 19:16:33'),
(540, 2, '/index.php?path=catalog', '2019-09-30 19:16:34'),
(541, 2, '/index.php?path=contacts', '2019-09-30 19:16:35'),
(542, 2, '/', '2019-09-30 19:16:36'),
(543, 2, '/index.php?path=user/userprofile', '2019-09-30 19:16:38'),
(544, 2, '/index.php?path=user/userprofile', '2019-09-30 19:16:43'),
(545, 2, '/index.php?path=catalog', '2019-09-30 19:16:45'),
(546, 2, '/index.php?path=catalog/show/2', '2019-09-30 19:16:47'),
(547, 2, '/index.php?path=catalog/show/2', '2019-09-30 19:18:02'),
(548, 2, '/index.php?path=catalog/change/2', '2019-09-30 19:19:38'),
(549, 2, '/index.php?path=catalog/show/2', '2019-09-30 19:19:41'),
(550, 2, '/index.php?path=catalog/change/2', '2019-09-30 19:19:45'),
(551, 2, '/', '2019-09-30 19:19:51'),
(552, 2, '/index.php?path=contacts', '2019-09-30 19:24:50'),
(553, 2, '/index.php?path=contacts', '2019-09-30 19:32:32'),
(554, 2, '/index.php?path=contacts', '2019-09-30 19:38:27'),
(555, 2, '/index.php?path=contacts', '2019-09-30 19:55:10'),
(556, 2, '/index.php?path=catalog', '2019-09-30 19:56:50'),
(557, 2, '/index.php?path=catalog/show/3', '2019-09-30 19:56:51'),
(558, 2, '/index.php?path=contacts', '2019-09-30 19:56:57'),
(559, 2, '/index.php?path=contacts', '2019-09-30 20:04:38'),
(560, 2, '/index.php?path=contacts', '2019-09-30 20:04:47'),
(561, 2, '/', '2019-10-01 17:14:11'),
(562, 2, '/index.php?path=catalog', '2019-10-01 17:14:13'),
(563, 2, '/index.php?path=contacts', '2019-10-01 17:14:14'),
(564, 2, '/index.php?path=contacts', '2019-10-01 17:16:09'),
(565, 2, '/index.php?path=contacts', '2019-10-01 17:21:56'),
(566, 2, '/index.php?path=contacts', '2019-10-01 17:22:01'),
(567, 2, '/index.php?path=contacts', '2019-10-01 17:35:30'),
(568, 2, '/index.php?path=contacts', '2019-10-01 18:13:31'),
(569, 2, '/index.php?path=contacts', '2019-10-01 18:14:12'),
(570, 2, '/index.php?path=contacts', '2019-10-01 18:26:56'),
(571, 2, '/index.php?path=user/userprofile', '2019-10-01 18:26:57'),
(572, 2, '/index.php?path=user/userprofile', '2019-10-01 18:27:03'),
(573, 2, '/index.php?path=user/userprofile', '2019-10-01 18:28:42'),
(574, 2, '/index.php?path=user/userprofile', '2019-10-01 18:30:12'),
(575, 2, '/index.php?path=user/userprofile', '2019-10-01 18:30:33'),
(576, 2, '/index.php?path=user/userprofile', '2019-10-01 18:32:22'),
(577, 2, '/index.php?path=user/userprofile', '2019-10-01 18:32:25'),
(578, 2, '/index.php?path=user/userprofile', '2019-10-01 18:47:23'),
(579, 2, '/index.php?path=user/createorder', '2019-10-01 18:47:39'),
(580, 2, '/index.php?path=user/createorder', '2019-10-01 18:54:09'),
(581, 2, '/index.php?path=user/userprofile', '2019-10-01 19:12:59'),
(582, 2, '/', '2019-10-02 16:57:46'),
(583, 2, '/index.php?path=contacts', '2019-10-02 16:58:54'),
(584, 2, '/', '2019-10-02 16:58:57'),
(585, 2, '/index.php?path=catalog', '2019-10-02 16:58:57'),
(586, 2, '/', '2019-10-02 16:58:59'),
(587, 2, '/index.php?path=catalog', '2019-10-02 17:01:43'),
(588, 2, '/', '2019-10-02 17:01:45'),
(589, 2, '/', '2019-10-02 17:03:10'),
(590, 2, '/', '2019-10-02 17:15:21'),
(591, 2, '/', '2019-10-02 17:16:27'),
(592, 2, '/', '2019-10-02 17:24:13'),
(593, 2, '/', '2019-10-02 17:24:31'),
(594, 2, '/', '2019-10-02 17:26:47'),
(595, 2, '/', '2019-10-02 17:33:55'),
(596, 2, '/', '2019-10-02 17:33:56'),
(597, 2, '/', '2019-10-02 17:36:24'),
(598, 2, '/', '2019-10-02 17:36:33'),
(599, 2, '/', '2019-10-02 17:36:36'),
(600, 2, '/', '2019-10-02 17:37:01'),
(601, 2, '/', '2019-10-02 17:37:03'),
(602, 2, '/', '2019-10-02 17:37:59'),
(603, 2, '/', '2019-10-02 17:38:06'),
(604, 2, '/', '2019-10-02 17:38:07'),
(605, 2, '/index.php?path=user/userprofile', '2019-10-02 17:53:27'),
(606, 2, '/index.php?path=user/userprofile', '2019-10-02 17:53:49'),
(607, 2, '/index.php?path=user/userprofile', '2019-10-02 18:18:18'),
(608, 2, '/index.php?path=user/userprofile', '2019-10-02 18:18:23'),
(609, 2, '/index.php?path=user/userprofile', '2019-10-02 18:18:26'),
(610, 2, '/index.php?path=user/userprofile', '2019-10-02 18:18:27'),
(611, 2, '/index.php?path=user/userprofile', '2019-10-02 18:18:34'),
(612, 2, '/index.php?path=user/userprofile', '2019-10-02 18:18:45'),
(613, 2, '/index.php?path=user/userprofile', '2019-10-02 18:20:46'),
(614, 2, '/index.php?path=catalog', '2019-10-02 18:20:54'),
(615, 2, '/index.php?path=user/createorder', '2019-10-02 18:20:57'),
(616, 2, '/index.php?path=user/userprofile', '2019-10-02 18:21:03'),
(617, 2, '/index.php?path=catalog', '2019-10-02 18:21:21'),
(618, 2, '/index.php?path=user/createorder', '2019-10-02 18:21:24'),
(619, 2, '/index.php?path=user/userprofile', '2019-10-02 18:21:26'),
(620, 2, '/index.php?path=catalog', '2019-10-02 18:21:32'),
(621, 2, '/index.php?path=catalog', '2019-10-02 18:35:03'),
(622, 2, '/index.php?path=user/createorder', '2019-10-02 18:35:08'),
(623, 2, '/index.php?path=user/createorder', '2019-10-02 18:36:22'),
(624, 2, '/index.php?path=user/createorder', '2019-10-02 18:36:28'),
(625, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:05'),
(626, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:09'),
(627, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:11'),
(628, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:12'),
(629, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:13'),
(630, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:14'),
(631, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:15'),
(632, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:15'),
(633, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:16'),
(634, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:17'),
(635, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:18'),
(636, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:20'),
(637, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:22'),
(638, 2, '/index.php?path=user/userprofile', '2019-10-02 18:38:30'),
(639, 2, '/index.php?path=catalog', '2019-10-02 18:49:36'),
(640, 2, '/index.php?path=catalog/add', '2019-10-02 18:49:37'),
(641, 2, '/index.php?path=catalog', '2019-10-02 18:50:09'),
(642, 2, '/index.php?path=catalog/add', '2019-10-02 18:58:27'),
(643, 2, '/index.php?path=catalog', '2019-10-02 18:58:30'),
(644, 2, '/index.php?path=catalog/show/563', '2019-10-02 18:58:35'),
(645, 2, '/index.php?path=catalog', '2019-10-02 18:58:53'),
(646, 2, '/index.php?path=catalog/add', '2019-10-02 19:04:51'),
(647, 2, '/index.php?path=catalog', '2019-10-02 19:04:53'),
(648, 2, '/index.php?path=catalog/show/563', '2019-10-02 19:05:00'),
(649, 2, '/index.php?path=catalog/show/563', '2019-10-02 19:05:55'),
(650, 2, '/index.php?path=catalog/show/563', '2019-10-02 19:07:38'),
(651, 2, '/index.php?path=catalog', '2019-10-02 19:07:40'),
(652, 2, '/index.php?path=catalog/show/562', '2019-10-02 19:07:46'),
(653, 2, '/index.php?path=catalog', '2019-10-02 19:07:49'),
(654, 2, '/index.php?path=catalog/show/564', '2019-10-02 19:07:54'),
(655, 2, '/', '2019-10-02 19:08:35'),
(656, 2, '/index.php?path=user/userprofile', '2019-10-02 19:08:38'),
(657, 2, '/', '2019-10-02 19:09:27'),
(658, 2, '/index.php?path=catalog', '2019-10-02 19:09:30'),
(659, 2, '/index.php?path=catalog', '2019-10-02 19:15:43'),
(660, 2, '/index.php?path=catalog', '2019-10-02 19:16:19'),
(661, 2, '/index.php?path=catalog', '2019-10-02 19:17:59'),
(662, 2, '/index.php?path=catalog', '2019-10-02 19:18:04'),
(663, 2, '/index.php?path=catalog', '2019-10-02 19:19:23'),
(664, 2, '/index.php?path=catalog', '2019-10-02 19:19:27'),
(665, 2, '/index.php?path=catalog', '2019-10-02 19:20:27'),
(666, 2, '/index.php?path=catalog', '2019-10-02 19:21:04'),
(667, 2, '/index.php?path=catalog', '2019-10-02 19:21:47'),
(668, 2, '/index.php?path=catalog', '2019-10-02 19:21:51'),
(669, 2, '/index.php?path=catalog', '2019-10-02 19:22:51'),
(670, 2, '/index.php?path=catalog', '2019-10-02 19:22:53'),
(671, 2, '/index.php?path=catalog', '2019-10-02 19:27:43'),
(672, 2, '/index.php?path=catalog', '2019-10-02 19:30:00'),
(673, 2, '/index.php?path=catalog', '2019-10-02 19:32:50'),
(674, 2, '/index.php?path=catalog', '2019-10-02 19:34:30'),
(675, 2, '/index.php?path=catalog', '2019-10-02 19:39:35'),
(676, 2, '/index.php?path=catalog', '2019-10-02 19:41:51'),
(677, 2, '/index.php?path=catalog', '2019-10-02 19:41:55'),
(678, 2, '/index.php?path=catalog', '2019-10-02 19:41:58'),
(679, 2, '/index.php?path=catalog', '2019-10-02 19:42:01'),
(680, 2, '/index.php?path=catalog', '2019-10-02 19:42:12'),
(681, 2, '/index.php?path=catalog', '2019-10-02 19:42:17'),
(682, 2, '/index.php?path=catalog', '2019-10-02 19:42:22'),
(683, 2, '/index.php?path=catalog', '2019-10-02 19:43:18'),
(684, 2, '/index.php?path=catalog', '2019-10-02 19:43:46'),
(685, 2, '/index.php?path=catalog', '2019-10-02 19:48:29'),
(686, 2, '/index.php?path=catalog', '2019-10-02 19:50:21'),
(687, 2, '/index.php?path=catalog', '2019-10-02 19:50:53'),
(688, 2, '/index.php?path=catalog', '2019-10-02 19:52:33'),
(689, 2, '/index.php?path=catalog', '2019-10-02 19:53:07'),
(690, 2, '/index.php?path=catalog', '2019-10-02 19:53:29'),
(691, 2, '/index.php?path=catalog', '2019-10-02 19:54:11'),
(692, 2, '/index.php?path=catalog', '2019-10-02 19:54:24'),
(693, 2, '/index.php?path=catalog', '2019-10-02 19:54:33'),
(694, 2, '/index.php?path=catalog', '2019-10-02 19:55:12'),
(695, 2, '/index.php?path=catalog', '2019-10-02 19:55:24'),
(696, 2, '/index.php?path=catalog', '2019-10-02 19:58:15'),
(697, 2, '/index.php?path=catalog', '2019-10-02 19:58:46'),
(698, 2, '/index.php?path=catalog', '2019-10-02 19:59:56'),
(699, 2, '/index.php?path=catalog', '2019-10-02 20:00:01'),
(700, 2, '/index.php?path=catalog', '2019-10-02 20:01:39'),
(701, 2, '/index.php?path=catalog', '2019-10-02 20:03:03'),
(702, 2, '/index.php?path=catalog', '2019-10-02 20:14:54'),
(703, 2, '/index.php?path=catalog', '2019-10-02 20:16:13'),
(704, 2, '/index.php?path=catalog', '2019-10-02 20:16:14'),
(705, 2, '/index.php?path=catalog', '2019-10-02 20:16:57'),
(706, 2, '/index.php?path=catalog', '2019-10-02 20:17:05'),
(707, 2, '/index.php?path=catalog', '2019-10-02 20:17:16'),
(708, 2, '/index.php?path=catalog', '2019-10-02 20:17:17'),
(709, 2, '/index.php?path=catalog', '2019-10-02 20:17:25'),
(710, 2, '/index.php?path=catalog', '2019-10-02 20:18:29'),
(711, 2, '/index.php?path=catalog', '2019-10-02 20:18:37'),
(712, 2, '/index.php?path=catalog', '2019-10-02 20:18:38'),
(713, 2, '/index.php?path=catalog', '2019-10-02 20:18:39'),
(714, 2, '/index.php?path=catalog', '2019-10-02 20:19:23'),
(715, 2, '/index.php?path=catalog', '2019-10-02 20:19:53'),
(716, 2, '/index.php?path=catalog', '2019-10-02 20:20:04'),
(717, 2, '/index.php?path=catalog', '2019-10-02 20:20:22'),
(718, 2, '/index.php?path=catalog', '2019-10-02 20:20:30'),
(719, 2, '/index.php?path=catalog', '2019-10-02 20:20:32'),
(720, 2, '/index.php?path=catalog', '2019-10-02 20:20:40'),
(721, 2, '/index.php?path=catalog', '2019-10-02 20:21:18'),
(722, 2, '/index.php?path=catalog', '2019-10-02 20:24:59'),
(723, 2, '/', '2019-10-03 19:08:48'),
(724, 2, '/index.php?path=catalog', '2019-10-03 19:08:56'),
(725, 2, '/index.php?path=contacts', '2019-10-03 19:08:58'),
(726, 2, '/index.php?path=catalog', '2019-10-03 19:09:00'),
(727, 2, '/index.php?path=catalog', '2019-10-03 19:11:27'),
(728, 2, '/index.php?path=contacts', '2019-10-03 19:11:54'),
(729, 2, '/index.php?path=catalog', '2019-10-03 19:11:56'),
(730, 2, '/index.php?path=catalog', '2019-10-03 19:12:20'),
(731, 2, '/index.php?path=catalog', '2019-10-03 19:14:11'),
(732, 2, '/index.php?path=catalog', '2019-10-03 19:14:22'),
(733, 2, '/index.php?path=catalog', '2019-10-03 19:14:29'),
(734, 2, '/index.php?path=catalog', '2019-10-03 19:15:56'),
(735, 2, '/index.php?path=contacts', '2019-10-03 19:16:10'),
(736, 2, '/index.php?path=catalog', '2019-10-03 19:16:12'),
(737, 2, '/index.php?path=catalog', '2019-10-03 19:17:41'),
(738, 2, '/index.php?path=catalog', '2019-10-03 19:18:10'),
(739, 2, '/index.php?path=catalog', '2019-10-03 19:19:42'),
(740, 2, '/index.php?path=catalog', '2019-10-03 19:20:03'),
(741, 2, '/index.php?path=catalog', '2019-10-03 19:20:29'),
(742, 2, '/index.php?path=catalog', '2019-10-03 19:21:00'),
(743, 2, '/index.php?path=catalog', '2019-10-03 19:22:02'),
(744, 2, '/index.php?path=catalog', '2019-10-03 19:25:16'),
(745, 2, '/index.php?path=catalog', '2019-10-03 19:26:47'),
(746, 2, '/index.php?path=catalog', '2019-10-03 19:28:26'),
(747, 2, '/index.php?path=catalog', '2019-10-03 19:28:55'),
(748, 2, '/index.php?path=catalog', '2019-10-03 19:31:02'),
(749, 2, '/index.php?path=catalog', '2019-10-03 19:32:18'),
(750, 2, '/index.php?path=catalog', '2019-10-03 19:33:25'),
(751, 2, '/index.php?path=catalog', '2019-10-03 19:34:16'),
(752, 2, '/index.php?path=catalog', '2019-10-03 19:34:34'),
(753, 2, '/index.php?path=catalog', '2019-10-03 19:35:35'),
(754, 2, '/index.php?path=catalog', '2019-10-03 19:36:02'),
(755, 2, '/index.php?path=catalog', '2019-10-03 19:37:06'),
(756, 2, '/index.php?path=catalog', '2019-10-03 19:37:44'),
(757, 2, '/', '2019-10-06 16:22:44'),
(758, 2, '/index.php?path=catalog', '2019-10-06 16:22:46'),
(759, 2, '/index.php?path=contacts', '2019-10-06 16:22:51'),
(760, 2, '/index.php?path=contacts', '2019-10-06 16:23:00'),
(761, 2, '/index.php?path=catalog', '2019-10-06 16:24:34'),
(762, 2, '/index.php?path=catalog/show/1', '2019-10-06 16:47:19'),
(763, 2, '/index.php?path=catalog/show/1', '2019-10-06 16:47:30'),
(764, 2, '/index.php?path=catalog/change/1', '2019-10-06 16:47:33'),
(765, 2, '/index.php?path=catalog/change/1', '2019-10-06 16:47:47'),
(766, 2, '/index.php?path=catalog/change/1', '2019-10-06 16:48:34'),
(767, 2, '/index.php?path=catalog/change/1', '2019-10-06 16:55:07'),
(768, 2, '/index.php?path=catalog/change/1', '2019-10-06 16:55:16'),
(769, 2, '/index.php?path=catalog/change/1', '2019-10-06 16:55:24'),
(770, 2, '/index.php?path=catalog/change/1', '2019-10-06 16:59:34'),
(771, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:02:40'),
(772, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:02:59'),
(773, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:03:09'),
(774, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:03:20'),
(775, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:03:24'),
(776, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:08:34'),
(777, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:09:29'),
(778, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:10:56'),
(779, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:12:08'),
(780, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:12:56'),
(781, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:16:17'),
(782, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:16:23'),
(783, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:17:08'),
(784, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:20:19'),
(785, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:23:14'),
(786, 2, '/index.php?path=catalog/change/1', '2019-10-06 17:23:24'),
(787, 2, '/index.php?path=catalog', '2019-10-06 17:23:33'),
(788, 2, '/index.php?path=catalog', '2019-10-06 17:24:18'),
(789, 2, '/index.php?path=catalog', '2019-10-06 17:39:30'),
(790, 2, '/', '2019-10-07 04:53:24'),
(791, 2, '/index.php?path=catalog', '2019-10-07 04:53:36'),
(792, 2, '/index.php?path=catalog', '2019-10-07 04:56:47'),
(793, 2, '/index.php?path=catalog', '2019-10-07 04:57:54'),
(794, 2, '/index.php?path=catalog', '2019-10-07 04:57:59'),
(795, 2, '/index.php?path=catalog', '2019-10-07 04:58:17'),
(796, 2, '/index.php?path=catalog', '2019-10-07 04:58:38'),
(797, 2, '/index.php?path=catalog', '2019-10-07 05:17:29'),
(798, 2, '/index.php?path=catalog', '2019-10-07 05:25:47'),
(799, 2, '/index.php?path=catalog', '2019-10-07 05:26:29'),
(800, 2, '/index.php?path=catalog', '2019-10-07 05:27:12'),
(801, 2, '/index.php?path=catalog', '2019-10-07 05:27:34'),
(802, 2, '/index.php?path=catalog', '2019-10-07 05:28:31'),
(803, 2, '/index.php?path=catalog', '2019-10-07 05:31:18'),
(804, 2, '/index.php?path=catalog', '2019-10-07 05:31:39'),
(805, 2, '/index.php?path=catalog', '2019-10-07 05:33:45'),
(806, 2, '/index.php?path=catalog', '2019-10-07 05:34:02'),
(807, 2, '/index.php?path=catalog', '2019-10-07 05:34:14'),
(808, 2, '/index.php?path=catalog', '2019-10-07 05:35:08'),
(809, 2, '/index.php?path=catalog', '2019-10-07 05:36:49'),
(810, 2, '/index.php?path=catalog', '2019-10-07 05:37:56'),
(811, 2, '/index.php?path=catalog', '2019-10-07 05:39:35'),
(812, 2, '/index.php?path=catalog', '2019-10-07 05:40:20'),
(813, 2, '/index.php?path=catalog', '2019-10-07 05:40:20'),
(814, 2, '/index.php?path=catalog', '2019-10-07 05:40:52'),
(815, 2, '/index.php?path=catalog', '2019-10-07 05:42:36'),
(816, 2, '/index.php?path=catalog', '2019-10-07 05:43:20'),
(817, 2, '/index.php?path=catalog', '2019-10-07 05:49:38'),
(818, 2, '/index.php?path=catalog', '2019-10-07 05:53:26'),
(819, 2, '/index.php?path=catalog', '2019-10-07 05:54:00'),
(820, 2, '/index.php?path=catalog', '2019-10-07 05:54:26'),
(821, 2, '/index.php?path=catalog', '2019-10-07 05:55:40'),
(822, 2, '/index.php?path=catalog', '2019-10-07 05:55:48'),
(823, 2, '/index.php?path=catalog', '2019-10-07 05:57:38'),
(824, 2, '/index.php?path=catalog', '2019-10-07 05:57:42'),
(825, 2, '/index.php?path=user/logout', '2019-10-07 06:02:00'),
(826, 2, '/index.php?path=user/login', '2019-10-07 07:01:08'),
(827, 2, '/index.php', '2019-10-07 07:01:08'),
(828, 2, '/', '2019-10-07 07:01:09'),
(829, 2, '/index.php?path=catalog', '2019-10-07 07:01:11'),
(830, 2, '/index.php?path=catalog', '2019-10-07 07:01:17'),
(831, 2, '/index.php?path=catalog', '2019-10-07 07:01:26'),
(832, 2, '/index.php?path=user/logout', '2019-10-07 07:03:04'),
(833, 2, '/index.php?path=user/login', '2019-10-07 08:38:39'),
(834, 2, '/index.php', '2019-10-07 08:38:39'),
(835, 2, '/index.php', '2019-10-07 08:42:30'),
(836, 2, '/index.php?path=user/createorder', '2019-10-07 08:42:33'),
(837, 2, '/index.php?path=user/userprofile', '2019-10-07 08:42:46'),
(838, 2, '/index.php?path=user/userprofile', '2019-10-07 08:44:51'),
(839, 2, '/index.php?path=catalog', '2019-10-07 08:44:53'),
(840, 2, '/index.php?path=user/createorder', '2019-10-07 08:44:59'),
(841, 2, '/index.php?path=user/createorder', '2019-10-07 08:45:08'),
(842, 2, '/index.php?path=user/createorder', '2019-10-07 08:46:00'),
(843, 2, '/index.php?path=user/createorder', '2019-10-07 08:46:03'),
(844, 2, '/index.php?path=catalog', '2019-10-07 08:46:04'),
(845, 2, '/index.php?path=user/createorder', '2019-10-07 08:46:07'),
(846, 2, '/index.php?path=user/userprofile', '2019-10-07 08:46:09'),
(847, 2, '/index.php?path=user/userprofile', '2019-10-07 08:46:27'),
(848, 2, '/index.php?path=catalog', '2019-10-07 08:46:28'),
(849, 2, '/index.php?path=catalog', '2019-10-07 15:38:57'),
(850, 2, '/index.php?path=catalog', '2019-10-07 15:39:02'),
(851, 2, '/index.php?path=catalog', '2019-10-07 15:39:28'),
(852, 2, '/index.php?path=catalog', '2019-10-07 15:39:57'),
(853, 2, '/index.php?path=catalog', '2019-10-07 15:40:20'),
(854, 2, '/index.php?path=catalog', '2019-10-07 15:40:26'),
(855, 2, '/index.php?path=catalog', '2019-10-07 15:41:06'),
(856, 2, '/index.php?path=catalog', '2019-10-07 15:41:12'),
(857, 2, '/index.php?path=catalog', '2019-10-07 15:43:30'),
(858, 2, '/index.php?path=catalog', '2019-10-07 15:45:30'),
(859, 2, '/index.php?path=catalog', '2019-10-07 15:45:36'),
(860, 2, '/index.php?path=catalog', '2019-10-07 15:46:27'),
(861, 2, '/index.php?path=catalog', '2019-10-07 15:47:57');
INSERT INTO `users_history` (`id`, `userId`, `page`, `date`) VALUES
(862, 2, '/index.php?path=catalog', '2019-10-07 15:48:02'),
(863, 2, '/index.php?path=catalog', '2019-10-07 15:48:12'),
(864, 2, '/index.php?path=catalog', '2019-10-07 15:48:22'),
(865, 2, '/index.php?path=catalog', '2019-10-07 15:48:32'),
(866, 2, '/index.php?path=catalog', '2019-10-07 15:48:41'),
(867, 2, '/index.php?path=catalog', '2019-10-07 15:49:03'),
(868, 2, '/index.php?path=catalog', '2019-10-07 15:49:09'),
(869, 2, '/index.php?path=catalog', '2019-10-07 15:49:23'),
(870, 2, '/index.php?path=catalog', '2019-10-07 15:49:33'),
(871, 2, '/index.php?path=catalog', '2019-10-07 15:49:42'),
(872, 2, '/index.php?path=catalog', '2019-10-07 15:50:13'),
(873, 2, '/index.php?path=catalog', '2019-10-07 15:50:31'),
(874, 2, '/index.php?path=catalog', '2019-10-07 15:50:40'),
(875, 2, '/index.php?path=catalog', '2019-10-07 15:51:00'),
(876, 2, '/index.php?path=catalog', '2019-10-07 15:51:22'),
(877, 2, '/index.php?path=catalog', '2019-10-07 15:52:48'),
(878, 2, '/index.php?path=catalog', '2019-10-07 15:53:01'),
(879, 2, '/index.php?path=catalog', '2019-10-07 15:53:08'),
(880, 2, '/index.php?path=catalog', '2019-10-07 15:53:30'),
(881, 2, '/index.php?path=catalog', '2019-10-07 15:53:52'),
(882, 2, '/index.php?path=catalog', '2019-10-07 15:54:16'),
(883, 2, '/index.php?path=catalog', '2019-10-07 15:54:30'),
(884, 2, '/index.php?path=catalog', '2019-10-07 15:54:52'),
(885, 2, '/index.php?path=catalog', '2019-10-07 15:55:40'),
(886, 2, '/index.php?path=catalog', '2019-10-07 15:56:09'),
(887, 2, '/index.php?path=catalog', '2019-10-07 15:56:40'),
(888, 2, '/index.php?path=catalog', '2019-10-07 15:56:54'),
(889, 2, '/index.php?path=catalog', '2019-10-07 15:57:04'),
(890, 2, '/index.php?path=catalog', '2019-10-07 15:57:13'),
(891, 2, '/index.php?path=catalog', '2019-10-07 15:59:27'),
(892, 2, '/index.php?path=catalog', '2019-10-07 16:01:16'),
(893, 2, '/index.php?path=catalog', '2019-10-07 16:01:33'),
(894, 2, '/index.php?path=catalog', '2019-10-07 16:24:40'),
(895, 2, '/index.php?path=catalog', '2019-10-07 16:36:48'),
(896, 2, '/index.php?path=catalog', '2019-10-07 16:37:05'),
(897, 2, '/index.php?path=catalog', '2019-10-07 17:45:38'),
(898, 2, '/index.php?path=catalog', '2019-10-07 17:49:54'),
(899, 2, '/index.php?path=catalog', '2019-10-07 17:50:36'),
(900, 2, '/index.php?path=catalog', '2019-10-07 17:51:00'),
(901, 2, '/index.php?path=catalog', '2019-10-07 17:51:26'),
(902, 2, '/index.php?path=catalog', '2019-10-07 17:52:30'),
(903, 2, '/index.php?path=catalog', '2019-10-07 17:52:55'),
(904, 2, '/index.php?path=catalog', '2019-10-07 17:53:10'),
(905, 2, '/index.php?path=catalog', '2019-10-07 17:56:30'),
(906, 2, '/index.php?path=catalog', '2019-10-07 17:57:23'),
(907, 2, '/index.php?path=catalog', '2019-10-07 17:58:08'),
(908, 2, '/index.php?path=catalog', '2019-10-07 17:58:35'),
(909, 2, '/index.php?path=catalog', '2019-10-07 18:00:21'),
(910, 2, '/index.php?path=catalog', '2019-10-07 18:00:43'),
(911, 2, '/index.php?path=catalog', '2019-10-07 18:00:50'),
(912, 2, '/index.php?path=catalog', '2019-10-07 18:01:50'),
(913, 2, '/index.php?path=catalog', '2019-10-07 18:09:04'),
(914, 2, '/', '2019-10-07 18:10:20'),
(915, 2, '/index.php?path=catalog', '2019-10-07 18:12:44'),
(916, 2, '/index.php?path=catalog', '2019-10-07 18:14:58'),
(917, 2, '/index.php?path=catalog', '2019-10-07 18:16:32'),
(918, 2, '/index.php?path=catalog', '2019-10-07 18:16:43'),
(919, 2, '/index.php?path=catalog', '2019-10-07 18:18:28'),
(920, 2, '/index.php?path=catalog', '2019-10-07 18:19:56'),
(921, 2, '/index.php?path=catalog', '2019-10-07 18:25:30'),
(922, 2, '/index.php?path=catalog', '2019-10-07 18:26:31'),
(923, 2, '/index.php?path=catalog', '2019-10-07 18:27:49'),
(924, 2, '/index.php?path=catalog', '2019-10-07 18:28:17'),
(925, 2, '/index.php?path=catalog', '2019-10-07 18:28:22'),
(926, 2, '/index.php?path=catalog', '2019-10-07 18:28:26'),
(927, 2, '/index.php?path=catalog', '2019-10-07 18:28:39'),
(928, 2, '/index.php?path=catalog', '2019-10-07 18:28:43'),
(929, 2, '/index.php?path=catalog', '2019-10-07 18:28:47'),
(930, 2, '/index.php?path=catalog', '2019-10-07 18:28:51'),
(931, 2, '/index.php?path=catalog', '2019-10-07 18:29:19'),
(932, 2, '/index.php?path=catalog', '2019-10-07 18:29:42'),
(933, 2, '/index.php?path=catalog', '2019-10-07 18:34:45'),
(934, 2, '/index.php?path=catalog', '2019-10-07 18:35:03'),
(935, 2, '/index.php?path=catalog', '2019-10-07 18:37:18'),
(936, 2, '/index.php?path=catalog', '2019-10-07 18:37:37'),
(937, 2, '/index.php?path=catalog', '2019-10-07 18:49:58'),
(938, 2, '/index.php?path=catalog', '2019-10-07 18:52:29'),
(939, 2, '/index.php?path=catalog', '2019-10-07 18:54:01'),
(940, 2, '/index.php?path=catalog', '2019-10-07 19:01:55'),
(941, 2, '/index.php?path=catalog', '2019-10-07 19:02:18'),
(942, 2, '/index.php?path=catalog', '2019-10-07 19:02:26'),
(943, 2, '/index.php?path=catalog', '2019-10-07 19:02:42'),
(944, 2, '/index.php?path=catalog', '2019-10-07 19:10:25'),
(945, 2, '/index.php?path=catalog', '2019-10-07 19:12:28'),
(946, 2, '/index.php?path=catalog', '2019-10-07 19:16:00');

--
-- Триггеры `users_history`
--
DELIMITER $$
CREATE TRIGGER `Auto clear` AFTER DELETE ON `users_history` FOR EACH ROW DELETE FROM `users_history` where 'date' < DATEADD(DAY, -2, GETDATE())
$$
DELIMITER ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `idProduct` (`idProduct`),
  ADD KEY `userID` (`userID`);

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`idCategory`),
  ADD UNIQUE KEY `idCategory` (`idCategory`),
  ADD UNIQUE KEY `nameCategory` (`nameCategory`);

--
-- Индексы таблицы `orderproducts`
--
ALTER TABLE `orderproducts`
  ADD PRIMARY KEY (`orderID`,`idProduct`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `orderID` (`orderID`),
  ADD KEY `idProduct` (`idProduct`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `userID` (`userID`),
  ADD KEY `status` (`status`);

--
-- Индексы таблицы `orderstatuses`
--
ALTER TABLE `orderstatuses`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `category` (`category`),
  ADD KEY `price` (`price`),
  ADD KEY `views` (`views`);

--
-- Индексы таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`),
  ADD KEY `id` (`id`);

--
-- Индексы таблицы `users_history`
--
ALTER TABLE `users_history`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `userId` (`userId`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `idCategory` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `orderproducts`
--
ALTER TABLE `orderproducts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT для таблицы `orderstatuses`
--
ALTER TABLE `orderstatuses`
  MODIFY `id` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=565;

--
-- AUTO_INCREMENT для таблицы `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `users_history`
--
ALTER TABLE `users_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=947;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`idProduct`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `orderproducts`
--
ALTER TABLE `orderproducts`
  ADD CONSTRAINT `orderproducts_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderproducts_ibfk_2` FOREIGN KEY (`idProduct`) REFERENCES `products` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`id`) ON DELETE NO ACTION,
  ADD CONSTRAINT `orders_orderStatuses` FOREIGN KEY (`status`) REFERENCES `orderstatuses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category`) REFERENCES `categories` (`idCategory`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
