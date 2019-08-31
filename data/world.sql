-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3305
-- Время создания: Авг 31 2019 г., 15:43
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
-- База данных: `lesson3`
--

-- --------------------------------------------------------

--
-- Структура таблицы `city`
--

CREATE TABLE `city` (
  `ID` int(10) NOT NULL,
  `CountryCode` int(255) NOT NULL,
  `Name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `city`
--

INSERT INTO `city` (`ID`, `CountryCode`, `Name`) VALUES
(1, 3, 'Санкт-Петербург'),
(2, 2, 'Нью-Йорк'),
(3, 3, 'Москва'),
(4, 2, 'Вашингтон'),
(5, 4, 'Лондон'),
(6, 1, 'Берлин');

-- --------------------------------------------------------

--
-- Структура таблицы `country`
--

CREATE TABLE `country` (
  `id` int(32) NOT NULL,
  `Code` int(128) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Region` varchar(255) NOT NULL,
  `Population` bigint(255) NOT NULL,
  `Capital` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `country`
--

INSERT INTO `country` (`id`, `Code`, `Name`, `Region`, `Population`, `Capital`) VALUES
(1, 1, 'Германия', 'Европа', 5, 'Берлин'),
(2, 2, 'Соединенные Штаты Америки', 'Северная Америка', 1, 'Вашингтон'),
(3, 3, 'Россия', 'Европа', 15, 'Москва'),
(4, 4, 'Англия', 'Европа', 13, 'Лондон');

-- --------------------------------------------------------

--
-- Структура таблицы `countrylanguage`
--

CREATE TABLE `countrylanguage` (
  `id` int(10) NOT NULL,
  `CountryCode` int(255) NOT NULL,
  `Language` varchar(255) NOT NULL,
  `IsOfficial` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `countrylanguage`
--

INSERT INTO `countrylanguage` (`id`, `CountryCode`, `Language`, `IsOfficial`) VALUES
(1, 3, 'Русский', 'T'),
(2, 4, 'Английский', 'T'),
(3, 1, 'Немецкий', 'T'),
(4, 2, 'Американский', 'T');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `city_countrycode` (`CountryCode`);

--
-- Индексы таблицы `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `Code_2` (`Code`),
  ADD KEY `Code` (`Code`);

--
-- Индексы таблицы `countrylanguage`
--
ALTER TABLE `countrylanguage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `countrylang_countrycode` (`CountryCode`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `city`
--
ALTER TABLE `city`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `country`
--
ALTER TABLE `country`
  MODIFY `id` int(32) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `countrylanguage`
--
ALTER TABLE `countrylanguage`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `city`
--
ALTER TABLE `city`
  ADD CONSTRAINT `city_countrycode` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `countrylanguage`
--
ALTER TABLE `countrylanguage`
  ADD CONSTRAINT `countrylang_countrycode` FOREIGN KEY (`CountryCode`) REFERENCES `country` (`Code`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
