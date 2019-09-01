<?php

require_once ENGINE_DIR . 'cart.php';
/**
 * Функция получени всех продуктов
 * @return array
 */
function getProducts()
{
	$sql = "SELECT * FROM `products`";

	return getAssocResult($sql);
}

/**
 * Функция получает один продукт по его id
 * @param int $id
 * @return array|null
 */
function getProduct($id)
{
	//для безопасности превращаем id в число
	$id = (int) $id;

	$sql = "SELECT * FROM `products` WHERE `id` = $id";

	return show($sql);
}

/**
 * Функция генерации списка продуктов
 * @return string
 */
function renderProductList()
{
	//инициализируем результирующую строку
	$result = '';
	//получаем все изображения
	$products = getProducts();

	//для каждого изображения
	foreach ($products as $product) {
		//если изображение существует
		if(empty($product['image'])) {
			$product['image'] = 'img/no-image.jpeg';
		}
		$result .= render(TEMPLATES_DIR . 'productsListItem.tpl', $product);
	}
	return render(TEMPLATES_DIR . 'productsList.tpl', ['list' => $result]);
}

function getProductsByIds($ids)
{
	$sql = "SELECT * FROM `products` WHERE `id` IN (" . implode(', ', $ids) . ")";
	return getAssocResult($sql);
}

/**
 * Генерирует страницу корзины
 * @param array $cart
 * @return string
 */
function renderProductsCart($cart)
{
	if(empty($cart)) {
		return 'корзина пуста';
	}

	//получаем айдишники товаров
	$ids = array_keys($cart);

	//генерируем запрос
	$products = getProductsByIds($ids);


	//инициализируем строку контента и сумму корзины
	$content = '';
	$cartSum = 0;
	foreach ($products as $product) {
		$count = $cart[$product['id']];
		$price = $product['price'];
		$productSum = $count * $price;
		//генерируем элемент корзины
		$content .= render(TEMPLATES_DIR . 'cartListItem.tpl', [
			'name' => $product['name'],
			'id' => $product['id'],
			'count' => $count,
			'price' => $price,
			'sum' => $productSum
		]);

		$cartSum += $productSum;
	}

	return render(TEMPLATES_DIR . 'cartList.tpl', [
		'content' => $content,
		'sum' => $cartSum,
		'button' => empty($_SESSION['login'])
			? '<a href="/login.php">Войти</a>'
			: '<a href="/products/createOrder.php" class="btn">Оформить заказ</a>'
	]);
}

/**
 * @param int $id
 * @return string
 */
function showProduct($id)
{
	//для безопасности превращаем id в число
	//получаем товар
	$product = getProduct((int) $id);

	if(!$product) {
		return '404';
	}

	//возвращаем render шаблона
	return render(TEMPLATES_DIR . 'productPage.tpl', $product);
}

/**
 * Создание нового продукта
 * @param string $name
 * @param string $description
 * @param float $price
 * @param array $file
 * @return bool
 */
function insertProduct($title, $category, $description, $price, $file)
{
	if($file) {
		$fileName = loadFile('image', 'img/img_phones/');
	} else {
		$fileName = 'default.png';
	}

	$categoryId = $category ?? 1;

	//создаем соединение с БД
	$db = createConnection();
	//Избавляемся от всех инъекций в $title и $content
	$title = escapeString($db, $title);
	$description = escapeString($db, $description);
	$price = (float) $price;

	//генерируем SQL добавления в БД
	$sql = "INSERT INTO `products`(`title`, `category`, `description`, `price`, `img`) VALUES ('$title', $categoryId, '$description', $price, '$fileName')";

	//выполняем запрос
	return execQuery($sql);
}


function changeProduct($productId, $title, $description, $price, $file)
{
	$productId = (int) $productId;
	$check = getAssocResult("SELECT * FROM `products` WHERE `id` = $productId");
	if ($check) {
		if($file) {
			$fileName = loadFile('image', 'img/img_phones/');
		} else {
			$fileName = 'default.png';
		}

		//создаем соединение с БД
		$db = createConnection();
		//Избавляемся от всех инъекций в $title и $content
		$title = escapeString($db, $title);
		$description = escapeString($db, $description);
		$price = (float) $price;
		//генерируем SQL добавления в БД

		$sql = empty($file) 
		? "UPDATE `products` SET `title`= '$title', `description`= '$description', `price`= $price WHERE `id` = $productId"
		: "UPDATE `products` SET `title`= '$title', `description`= '$description', `price`= $price, `img`= $fileName, WHERE `id` = $productId";
		//выполняем запрос
		return execQuery($sql);
	}
}

function deleteProduct($productId)
{
	$productId = (int) $productId;
	$sql = "DELETE FROM `products` WHERE `products`.`id` = $productId";
	return execQuery($sql);
}

/**
 * Генерирует страницу моих заказов
 * @return string
 */
function generateMyOrdersPage()
{
	//получаем id пользователя и и получаем все заказы пользователя
	$userLogin = $_SESSION['login'];
	$userId = $_SESSION['id'];
	if ($userLogin === 'admin') {
		$orders = getAssocResult("SELECT * FROM `orders` ORDER BY `dateCreate` DESC");
	} else {
		$orders = getAssocResult("SELECT * FROM `orders` WHERE `userID` = $userId ORDER BY `dateCreate` DESC");
	}

	$result = '';
	foreach ($orders as $order) {
		$orderId = $order['id'];

		//получаем продукты, которые есть в заказе
		//TODO вытащить из цикла
		$products = getAssocResult("
			SELECT *, `op`.`price` FROM `orderproducts` as op
			JOIN `products` as p ON `p`.`id` = `op`.`idProduct`
			WHERE `op`.`orderID` = $orderId
		");
		
		$content = '';
		$orderSum = 0;
		//генерируем элементы таблицы товаров в заказе
		foreach ($products as $product) {
			$quantity = $product['quantity'];
			$price = $product['price'];
			$productSum = $quantity * $price;
			$content .= render(TEMPLATES_DIR . 'orderTableRow.tpl', [
				'title' => $product['title'],
				'id' => $product['id'],
				'quantity' => $quantity,
				'price' => $price,
				'sum' => $productSum,
			]);
			$orderSum += $productSum;
		}

		$statuses = [
			1 => 'Не оработан',
			2 => 'Отменен',
			3 => 'Оплачен',
			4 => 'Доставлен',
		];
		if ($userLogin === 'admin') {
			$buttons = "<a class='btn' onclick='changeOrderStatus($orderId, 2)'>Отменить</a>
			<a class='btn' onclick='deleteOrder($orderId)'>Удалить заказ</a>
			<a class='btn' onclick='setOrderStatus($orderId)'>Изменить статус заказа на</a>
			<select id='select_status_$orderId'>
			  <option value='1' selected='selected'>Не обработан</option>
			  <option value='2'>Отменен</option>
			  <option value='3'>Оплачен</option>
			  <option value='4'>Доставлен</option>
			</select>";
			$userIdSend = '<p><b>ID пользователя: </b>' . $order['userID'] . '</p>';
		} else if ((int)$order['status'] === 1) {
			$buttons = "<a class='btn' onclick='changeOrderStatus($orderId, 2)'>Отменить</a>";
			$userIdSend = '';
		} else {
			$buttons = "";
			$userIdSend = '';
		}

		//генерируем полную таблицу заказа
		$result .= render(TEMPLATES_DIR . 'orderTable.tpl', [
			'id' => $orderId,
			'userid' => $userIdSend,
			'content' => $content,
			'sum' => $orderSum,
			'status' => $statuses[$order['status']],
			'buttons' => $buttons,
			'address' => $order['address']
		]);
	}
	return $result;
}

function changeOrderStatus($orderId, $newStatus)
{
	$orderId = (int)$orderId;
	$newStatus = (int)$newStatus;
	$sql = "UPDATE `orders` SET `status`= $newStatus WHERE `id` = $orderId";
	return execQuery($sql);
}

function deleteOrder($orderId)
{
	$orderId = (int)$orderId;
	$sqlOrder = "DELETE FROM `orders` WHERE `orders`.`id` = $orderId";
	$sqlOrderProducts = "DELETE FROM `orderproducts` WHERE `orderproducts`.`orderID` = $orderId";
	execQuery($sqlOrderProducts);
	return execQuery($sqlOrder);
}

function generateOrderList($userId)
{
	$userCart = getUserCart($userId);
	$orderList = '';
	$counter = 1;
	foreach ($userCart as $id => $product) {
		$orderList .= render(TEMPLATES_DIR . 'orderList.tpl', [
			'number' => $counter,
			'id' => $product['idProduct'],
			'img' => $product['img'],
			'title' => $product['title'],
			'price' => $product['price'],
			'quantity' => $product['quantity']
		]);
		$counter++;
	}
	return $orderList;
}

function addOrderToBD($userId,$address)
{
	$userCart = getUserCart($userId);
	
	$sqlOrder = "INSERT INTO `orders` (`userID`, `address`, `dateCreate`, `status`) VALUES ('$userId', '$address', CURRENT_TIMESTAMP, '1')";

	$db = createConnection();
	$addOrder = mysqli_query($db, $sqlOrder);
	$lastID = mysqli_insert_id($db);
	mysqli_close($db);

	$counter = 0;
	foreach ($userCart as $id => $data) {
		
		$values[$counter] = [$lastID ,$data['idProduct'], $data['price'], $data['quantity']];
		$counter++;
	};

	$import;
	foreach ($values as $key => $value) {
		$import .= '(';
		$import .= implode(',', $value);
		$import .= '),';
	};
	$import = substr($import, 0, -1);

	if ($addOrder) {
		$sqlOrderProducts = "INSERT INTO orderproducts(orderID,idProduct,price,quantity) VALUES $import";
		clearUserCart($userId);
		return execQuery($sqlOrderProducts);
	} else {
		return false;
	};
}

