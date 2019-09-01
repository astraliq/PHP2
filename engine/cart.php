<?php

/**
 * Функция получени всех продуктов
 * @return array
 */
function getProductsInCart()
{
	$sql = "SELECT * FROM `carts`";

	return getAssocResult($sql);
}

/**
 * Функция получает один продукт по его id
 * @param int $id
 * @return array|null
 */
function getUserCart($userId)
{
	//для безопасности превращаем id в число
	$userId = (int) $userId;

	$sql = "SELECT * FROM `carts` AS carts JOIN `products` AS products ON `products`.`id` = `carts`.`idProduct` WHERE `carts`.`userID` = $userId";

	return getAssocResult($sql);
}

function clearUserCart($userID)
{
	$sql = "DELETE FROM `carts` WHERE `userID` = $userID";
	
	return execQuery($sql);
}

function getUserCartFromCookie($cookieIDs)
{
	$ids = join("','", $cookieIDs);   
	$sql = "SELECT * FROM `products` WHERE id IN ('$ids')";
	// $sql = "SELECT * FROM `products` WHERE `id` = $id";
	return getAssocResult($sql);
}


/**
 * Создание добавления в корзину продукта
 * @param string $name
 * @param string $description
 * @param float $price
 * @param array $file
 * @return bool
 */
function insertProductInCart($idProd, $price, $quantity, $userId)
{
	//создаем соединение с БД
	$db = createConnection();
	//Избавляемся от всех инъекций в $title и $content
	$idProd = (int) $idProd;
	$price = (float) $price;
	$userId = (int) $userId;

	//генерируем SQL добавления в БД

	$sql = "INSERT INTO `carts` (`idProduct`, `price`, `userID`) VALUES ('$idProd', $price, '$userId')";

	//выполняем запрос
	return execQuery($sql);
}

function insertCookieInCart($cookie, $userId)
{
	//создаем соединение с БД
	$db = createConnection();
	//Избавляемся от всех инъекций
	$cookieIDs = join("','", array_keys($cookie));
	$userId = (int) $userId;
	// $quantity = (int) $cookie['quantity'];
	$values = [];
	$count = 0;
	foreach ($cookie as $id => $quantity) {
		
		$values[$count] = [$id, $quantity, $userId];
		$count++;
	}
	$import;
	// var_dump($values);
	foreach ($values as $key => $value) {
		$import .= '(';
		$import .= implode(',', $value);
		$import .= '),';
	}
	$import = substr($import, 0, -1);
	// var_dump($import);
	// "INSERT INTO tablename (id,blabla) VALUES(1,'werwer'),(2,'wqewqe'),(3,'qwewe');"
	//генерируем SQL добавления в БД
	$sql = "INSERT INTO `carts` (`idProduct`, `quantity`, `userID`) VALUES $import";
	// $sql2 = "INSERT INTO `carts` `price` VALUES FROM `products` WHERE id IN ('$cookieIDs')";
	//выполняем запрос

	return execQuery($sql);
}



