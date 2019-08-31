-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3305
-- Время создания: Авг 04 2019 г., 21:43
-- Версия сервера: 5.7.23
-- Версия PHP: 7.2.10

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
  `price` int(32) DEFAULT NULL,
  `quantity` int(30) NOT NULL DEFAULT '1',
  `dateAdd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateChange` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `userID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `carts`
--

INSERT INTO `carts` (`id`, `idProduct`, `price`, `quantity`, `dateAdd`, `dateChange`, `userID`) VALUES
(1, 1, 8000, 2, '2019-07-28 12:03:06', NULL, '0'),
(9, 5, NULL, 2, '2019-07-28 17:36:24', NULL, '5'),
(10, 3, NULL, 4, '2019-07-28 17:36:24', NULL, '5'),
(11, 1, NULL, 6, '2019-07-28 17:36:24', NULL, '5');

-- --------------------------------------------------------

--
-- Структура таблицы `orderproducts`
--

CREATE TABLE `orderproducts` (
  `id` int(11) NOT NULL,
  `orderID` int(11) NOT NULL,
  `idProduct` int(30) NOT NULL,
  `price` int(32) DEFAULT NULL,
  `quantity` int(30) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `orderproducts`
--

INSERT INTO `orderproducts` (`id`, `orderID`, `idProduct`, `price`, `quantity`) VALUES
(10, 8, 4, 35000, 3),
(11, 8, 1, 8000, 1),
(12, 10, 4, 35000, 1),
(13, 10, 3, 45000, 2),
(14, 11, 8, 30000, 1),
(15, 12, 7, 15000, 1),
(16, 13, 5, 25000, 1),
(17, 14, 3, 45000, 10),
(18, 15, 4, 35000, 4),
(19, 15, 8, 30000, 1),
(20, 15, 6, 50000, 1),
(21, 16, 3, 45000, 3),
(22, 17, 6, 50000, 2),
(23, 17, 5, 25000, 4),
(24, 17, 1, 8000, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `userID` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `dateCreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateChange` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '1 - не обработан, 2 - отменен, 3 - оплачен, 4 - доставлен'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `userID`, `address`, `dateCreate`, `dateChange`, `status`) VALUES
(8, '2', 'домой', '2019-07-31 19:05:12', '2019-08-03 10:40:12', 4),
(10, '2', 'ddd', '2019-07-31 19:10:56', '2019-08-03 11:01:34', 3),
(11, '2', 'ddd', '2019-07-31 19:11:36', '2019-08-03 10:04:28', 2),
(12, '2', 'сюда', '2019-07-31 19:12:25', '2019-08-03 10:04:25', 4),
(13, '2', 'ddd', '2019-07-31 19:13:00', '2019-08-03 10:04:22', 3),
(14, '2', 'туда', '2019-07-31 19:13:33', NULL, 1),
(15, '3', 'user1 адрес', '2019-08-03 09:51:59', '2019-08-04 15:56:21', 3),
(16, '3', 'мне', '2019-08-03 10:03:36', '2019-08-03 10:39:31', 4),
(17, '4', 'адрес пользователя 2', '2019-08-03 10:45:26', '2019-08-04 15:55:30', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `phones`
--

CREATE TABLE `phones` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `description` text,
  `price` int(32) NOT NULL,
  `views` int(32) DEFAULT '0',
  `isActive` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dateChange` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `img2` varchar(255) DEFAULT NULL,
  `img3` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `phones`
--

INSERT INTO `phones` (`id`, `title`, `img`, `description`, `price`, `views`, `isActive`, `dateCreate`, `dateChange`, `img2`, `img3`) VALUES
(1, 'Lumia 650', '1.png', 'Откройте для себя преимущества бесперебойного взаимодействия с Windows 10 в точной упаковке. Lumia 650 с изысканной производительностью и превосходным дизайном — это разумный выбор для вашего бизнеса.\nНаслаждайтесь четким и ярким просмотром даже под прямыми солнечными лучами с супер острым 5-дюймовым HD OLED-дисплеем, который элегантно расположен в точно обработанной металлической рамке с алмазной огранкой. Благодаря легкому дизайну, тонкому 6,9-миллиметровому профилю и внутренней памяти объемом до 16 ГБ, Lumia 650 имеет идеальное сочетание превосходного внешнего вида и характеристик, ориентированных на производительность.\nПолучите персональный снимок вашего дня с информацией о пробках, прогнозом погоды и расписанием, предоставленным Кортаной. Делайте четкие и четкие снимки с помощью 8-мегапиксельной камеры, а приложение «Фотографии» автоматически создает резервные копии снимков и синхронизирует их на устройствах Windows 10.', 8000, 0, 1, '2019-07-19 18:16:56', '2019-08-04 15:33:29', NULL, NULL),
(2, 'Xiaomi Mi8 6/256GB', '2.png', 'Xiaomi Mi&nbsp;8&nbsp;&mdash; новый аппарат от&nbsp;изготовителя, который славится выпуском надежных и&nbsp;производительных смартфонов. 					Эта модель девайса характеризуется уникальным сочетанием технических параметров, стильного внешнего исполнения и&nbsp;доступного ценника. Приобрести подобное устройство сможет каждый желающий, причем без особых для себя трат и&nbsp;расходов.', 31200, 0, 1, '2019-07-19 18:16:56', NULL, '2-1.jpg', '2-2.jpg'),
(3, 'iPhone X', '3.png', 'Дисплей выполнен с&nbsp;применением матрицы типа Amoled. Диагональ дисплея составляет 5,8&nbsp;дюйма, разрешение&nbsp;&mdash; 2436&times;1125&nbsp;пикселей, плотность изображения&nbsp;&mdash; 458 точек на&nbsp;дюйм. Используются технологии Dolby Vision, HDR 10&nbsp;и&nbsp;ранее опробованная на&nbsp;iPad Pro система оптимизации цвета True Tone. Дисплей произведен компанией Samsung, применяющей дисплеи типа AMOLED и&nbsp;в&nbsp;собственных смартфонах. Характерное расположение субпикселей основных цветов имеет название Diamond Pixel, эта схема сменила PenTile в&nbsp;2013 году для всех экранов AMOLED Samsung. Экран Super Retina с&nbsp;разрешением 2436&times;1125, при диагонали 5,8&nbsp;дюйма, 458ppi[5]; впервые среди продуктов Apple используется технология OLED. Поддерживается HDR, Dolby Vision и&nbsp;True Tone. Сенсорный модуль дисплея распознает жесты &laquo;3D&nbsp;Touch&raquo;. В&nbsp;верхней части дисплея имеется вырез для фронтальной камеры и&nbsp;прочих сенсоров, по&nbsp;краям от&nbsp;выреза расположена информация из&nbsp;верхней статусной полосы (сигнал сетей связи, уровень заряда).', 45000, 0, 1, '2019-07-19 18:16:56', NULL, '3-1.jpg', '3-2.jpg'),
(4, 'Apple iPhone 7', '4.png', '', 35000, 1, 1, '2019-07-19 18:16:56', NULL, NULL, NULL),
(5, 'Apple iPhone 6se', '5.png', '', 25000, 0, 1, '2019-07-19 18:33:41', NULL, NULL, NULL),
(6, 'Samsung Galaxy s10', '6.png', '', 50000, 0, 1, '2019-07-19 18:33:45', NULL, NULL, NULL),
(7, 'Nokia 5', '7.png', '', 15000, 0, 1, '2019-07-19 18:36:35', NULL, NULL, NULL),
(8, 'Nokia 6', '8.png', '', 30000, 0, 1, '2019-07-19 18:36:35', NULL, NULL, NULL),
(22, 'Apple Watch 3', 'apple-watch-series-3.png', 'Apple Watch Series 4 GPS. Часы с абсолютно новым дизайном и новыми технологиями. Они помогают вести ещё более активный образ жизни, лучше следить \nза здоровьем и всегда оставаться на связи. \n\nАбсолютно новый дизайн. Изменения, которые меняют всё.\nСамый большой дисплей в линейке Apple Watch. Новый электрический датчик сердечной активности. Усовершенствованное колёсико Digital Crown с тактильным откликом. Такие знакомые и вместе с тем принципиально новые Apple Watch Series 4 меняют все представления о возможностях часов.\n\nПродвинутый трекер активности. Мотивация. Мотивация. Мотивация.\nНовый вид соревнований: один на один. Возможность делиться показателями активности с друзьями. Персональные тренерские подсказки. Ежемесячные мотивирующие цели. Виртуальные награды за достижения. Всё, чтобы вдохновить вас закрывать кольца Активности каждый день.\n\nПроактивный монитор здоровья. Почувствует. Позаботится. Подскажет.\nУведомления о слишком низком и высоком пульсе. Функции обнаружения падения и вызова экстренных служб. Новые циферблаты «Дыхание». Эти часы созданы, чтобы защищать вас и помогать вам вести более здоровый образ жизни.\n', 33990, 0, 1, '2019-08-04 15:37:59', NULL, NULL, NULL);

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
(1, 'Алексей', 5, 'Все отлично', '2019-07-20 13:32:29', NULL),
(2, 'Лекса', 4, 'Все Хорошо', '2019-07-20 13:32:33', NULL),
(3, 'Антонио', NULL, 'Жили были у бабуси 2 веселых гуся', '2019-07-20 18:31:38', NULL),
(5, 'Петр', 3, 'все отлично', '2019-07-20 19:05:12', '2019-07-21 06:01:27'),
(12, 'Петр', 2, 'гавносайт', '2019-07-20 19:13:40', '2019-07-21 06:01:16'),
(13, 'Косолапый', 1, 'Плохой отзыв, очень плохой', '2019-07-20 19:19:43', '2019-07-21 05:59:38'),
(14, 'Вениамин', 4, 'Ничо так', '2019-07-21 06:12:20', '2019-07-21 07:39:16'),
(22, 'Саша Белый', 2, 'Могло быть и лучше!!', '2019-07-21 07:39:39', '2019-07-21 07:39:57');

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
(2, 'admin', '21232f297a57a5a743894a0e4a801fc3', NULL, NULL, '2019-07-28 10:51:56'),
(3, 'user1', '24c9e15e52afc47c225b757e7bee1f9d', NULL, NULL, '2019-07-28 11:45:06'),
(4, 'user2', '7e58d63b60197ceb55a1c487989a3720', NULL, NULL, '2019-07-28 11:46:21'),
(5, 'user3', '99942f41d4dd829a0ff7dbba83a6601e', NULL, NULL, '2019-07-28 11:53:39');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `carts`
--
ALTER TABLE `carts`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `orderproducts`
--
ALTER TABLE `orderproducts`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `phones`
--
ALTER TABLE `phones`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `orderproducts`
--
ALTER TABLE `orderproducts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `phones`
--
ALTER TABLE `phones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
