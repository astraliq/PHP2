<?php
class CartModel extends Model {

	/**
	 * Функция получени всех продуктов
	 * @return array
	 */
	public function getProductsInCart() {
		$sql = "SELECT * FROM `carts`";

		return SQL::getInstance()->sqlGetArray($sql);
	}

	/**
	 * Функция получает один продукт по его id
	 * @param int $id
	 * @return array|null
	 */
	public function getUserCart($userId) {
		//для безопасности превращаем id в число
		$userId = (int) $userId;

		$sql = "SELECT * FROM `carts` AS carts JOIN `products` AS products ON `products`.`id` = `carts`.`idProduct` WHERE `carts`.`userID` = $userId";

		return SQL::getInstance()->sqlGetArray($sql);
	}

	public function clearUserCart($userID) {
		$sql = "DELETE FROM `carts` WHERE `userID` = $userID";
		
		return SQL::getInstance()->execQuery($sql);
	}

	public function getUserCartFromCookie($cookieIDs) {
		$ids = join("','", $cookieIDs);   
		$sql = "SELECT * FROM `products` WHERE id IN ('$ids')";
		// $sql = "SELECT * FROM `products` WHERE `id` = $id";
		return SQL::getInstance()->sqlGetArray($sql);
	}


	/**
	 * Создание добавления в корзину продукта
	 * @param string $name
	 * @param string $description
	 * @param float $price
	 * @param array $file
	 * @return bool
	 */
	public function insertProductInCart($idProd, $price, $quantity, $userId) {
		//Избавляемся от всех инъекций в $title и $content
		$idProd = (int) $idProd;
		$price = (float) $price;
		$userId = (int) $userId;

		//генерируем SQL добавления в БД

		$sql = "INSERT INTO `carts` (`idProduct`, `price`, `userID`) VALUES ('$idProd', $price, '$userId')";

		//выполняем запрос
		return SQL::getInstance()->execQuery($sql);
	}

	public function insertCookieInCart($cookie, $userId) {
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

		return SQL::getInstance()->execQuery($sql);
	}

	public function renderProductsCart($cart) {
		if(empty($cart)) {
			return 'корзина пуста';
		}

		//получаем айдишники товаров
		$ids = array_keys($cart);

		//генерируем запрос
		$products = CatalogModel::getProductsByIds($ids);

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

}
?>