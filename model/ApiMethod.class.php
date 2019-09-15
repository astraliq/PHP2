<?php

/*
 * Файл работы API
 * Файл ожидает что в _POST придет apiMethod с задачей, которую нужно выполнить
 * И (при необходимости) postData с информацией, необходимой для этой задачи
 *
 */

/*
 * Комментарий по json
 * Если использовать header('Content-Type: application/json');
 * То весь текст на странице попытается преобразоваться в json.
 * Следовательно нельзя будет увидеть ошибки, которые вам покажет php,
 * поэтому задает заголовок передаем в последний момент
 *
 * Если до этого были ошибки на php заголовок задать не получится
 *
 */
class ApiMethod {
	public $post;

    public function __construct($post) {
        $this->post = $post;
    }

	//Функция вывода ошибки
	private static function error($error_text) {
		//Вариант с json
		header('Content-Type: application/json');
		echo json_encode([
			'error' => true,
			'error_text' => $error_text,
			'data' => null
		]);
		exit();

		//Вариант без json
		// 	echo "Ошибка: $error_text";
		// 	exit();
	}

	//Функция успешного ответа
	private static function success($data = true) {
		//Вариант с json
		header('Content-Type: application/json');
		echo json_encode($data);
		exit();

		//Вариант без json
		// echo "OK";
		// exit();
	}

	public function login() {
		//Получаем логин и пароль из postData
		$login = $_POST['postData']['login'] ?? '';
		$password = $_POST['postData']['password'] ?? '';

		//Если нет логина или пароля вызываем ошибку
		if (!$login || !$password) {
			self::error('Логин или пароль не переданы');
		}

		//приводим пароль к тому же виду, как он хранится в базе
		$password = md5($password);

		//генерируем запрос и пытаемся найти пользователя
		$sql = "SELECT * FROM `users` WHERE `login` = '$login' AND `password` = '$password'";
		$user = SQL::getInstance()->sqlGetOne($sql);

		//Если пользователь найден, записываем информацию о пользователе в сессию,
		//что бы к ней можно было обратиться с любой страницы
		//Если пользователь не найден, возвращаем ошибку
		if ($user) {
			$_SESSION = $user;
			// if (!getUserCart($user['id'])) {
			// 	insertCookieInCart($_COOKIE['cart'], $_SESSION['id']);
			// }
			self::success('OK');
		} else {
			self::error('Неверный логин или пароль');
		}
	}
// ИЗМЕНИТЬ функцию регистрации
	public function reg() {
		//Получаем логин и пароль из postData
		$login = $_POST['postData']['login'] ?? '';
		$password = $_POST['postData']['password'] ?? '';
		$password_repeat = $_POST['postData']['password_repeat'] ?? '';
		$name = $_POST['postData']['name'] ?? NULL;
		$surname = $_POST['postData']['surname'] ?? NULL;
		//Если нет логина или пароля вызываем ошибку

		if ($login && $password && !$password_repeat) {
			self::error('Повторите пароль');
		}

		if (!$login || !$password || !$password_repeat) {
			self::error('Логин или пароль не переданы');
		}

		if ($password != $password_repeat) {
			self::error('Пароли не совпадают');
		}

		if (UserModel::checkUser($login)) {
			self::error('Пользователь с данным логином уже зарегистрирован');
		}

		//приводим пароль к тому же виду, как он хранится в базе
		$password = md5($password);
		//генерируем запрос и пытаемся добавить пользователя
		$result = UserModel::regUser($login, $password, $name, $surname);

		//Если пользователь найден, записываем информацию о пользователе в сессию,
		//что бы к ней можно было обратиться с любой страницы
		//Если пользователь не найден, возвращаем ошибку
		if ($result) {
			$_SESSION['login'] = $login;
			self::success('OK');
		} else {
			self::error('Неведома ошибка регистрации');
		}
	}

	public function readCatalog() {
		$numberOfLoadProducts = (int) $_POST['numberOfLoadProducts'] ?? '';
		$sql = "SELECT * FROM `products` WHERE `isActive` = 1 ORDER BY `id` LIMIT 0, $numberOfLoadProducts";
		$catalog = SQL::getInstance()->sqlGetArray($sql);
		// var_dump($catalog);
		if ($catalog) {
			self::success($catalog);
		} else {
			self::error('Ошибка чтения из базы данных');
		}
	}

	public function loadMore() {
		$lastNumberOfProd = (int) $_POST['lastNumberOfProd'] ?? '';
		$numberOfLoadProducts = (int) $_POST['numberOfLoadProducts'] ?? '';

		$sql = "SELECT * FROM `products` WHERE `isActive` = 1 ORDER BY `id` LIMIT $lastNumberOfProd, $numberOfLoadProducts";
		$moreProducts = SQL::getInstance()->sqlGetArray($sql);

		if ($moreProducts) {
			self::success($moreProducts);
		} else {
			self::error('Ошибка чтения из базы данных');
		}
	}

	public function getProduct() {
		$productId = (int) $_POST['productId'] ?? NULL;
		$product = CatalogModel::getProduct($productId);
		if ($product) {
			self::success($product);
		} else {
			self::error('Ошибка чтения из базы данных');
		}
	}
// ИЗМЕНИТЬ SQL функцию
	public function addToCart() {
		$prod = $_POST['prod'] ? json_decode($_POST['prod'], true) : null;
		if(!$prod) {
			error('ID не передан');
		}
		//Получаем данные корзины
		if ($_SESSION) {
			// $cart = getUserCart($_SESSION['login']['id'])
			CartModel::insertProductInCart($prod['id'], $prod['price'], $prod['quantity'], $_SESSION['id']);
		} else {
			$cart = $_COOKIE['cart'] ?? [];
			$id = $prod['id'];
			//устанавливаем новое куки
			setcookie("cart[$id]", 1);
		}
		self::success('OK');
	}


	public function readCart() {
		//Получаем корзину пользователя из базы данных
		if ($_SESSION) {
			$result = CartModel::getUserCart($_SESSION['id']);
		} else {
			$result = CartModel::getUserCartFromCookie(array_keys($_COOKIE['cart']));
			foreach ($result as $number => $value) {
				foreach ($_COOKIE['cart'] as $idProduct => $quantity) {
					if ($value['id'] == $idProduct) {
						$result[$number]['quantity'] = $quantity;
					}
				}
			}
		}
		self::success($result);
	}

	public function updateCart() {
		$id = (int) $_POST['id'];
		$userID = (int) $_SESSION['id'];
		if ($_SESSION) {
			$count = (int) $_POST['quantity'];
			$sql = "UPDATE `carts` SET `quantity` = `quantity` + $count WHERE `idProduct` = $id AND `userID` = $userID";
			if (SQL::getInstance()->execQuery($sql)) {
				self::success('OK');
			} else {
				self::error('ошибка в запросе');
			}
		} else {
			$count = $_COOKIE['cart'][$id] ?? 0;
			//увеличиваем количество в корзине
			$count += $_COOKIE['cart'][$id];
			setcookie("cart[$id]", $count);
			self::success('OK');
		}
	}

	public function deleteProductCart() {
		$id = (int) $_POST['id'];
		$userID = (int) $_SESSION['id'];
		if ($_SESSION) {
			$sql = "DELETE FROM `carts` WHERE `idProduct` = $id AND `userID` = $userID";
			if (SQL::getInstance()->execQuery($sql)) {
				self::success('OK');
			} else {
				self::error('ошибка в запросе');
			}
		} else {
			$count += $_COOKIE['cart'][$id];
			unset($_COOKIE['cart'][$id]);
			setcookie("cart[$id]", null, -1);
			self::success('OK');
		}
	}

	public function resetCart() {
		$userID = (int) $_SESSION['id'];
		if ($_SESSION) {
			
			if (CartModel::clearUserCart($userID)) {
				self::success('OK');
			} else {
				self::error('ошибка в запросе');
			}
		} else {
			// $cookie = $_COOKIE['cart'];
			foreach ($_COOKIE['cart'] as $id => $quantity) {
				unset($_COOKIE['cart'][$id]);
				setcookie("cart[$id]", null, -1);
			}
			// unset($_COOKIE['cart']);
			// setcookie("cart[$id]", null, -1);
			self::success('OK');
		}
	}

	public function createOrder() {
		//Получаем логин и пароль из postData
		$address = $_POST['postData']['address'] ?? '';

		if (!$address) {
			self::error('Не заполнено поле адрес доставки');
		}

		//генерируем запрос и пытаемся добавить заказ в базу данных
		$result = OrderModel::addOrderToBD($_SESSION['id'],$address);
		// var_dump($result);
		if ($result) {
			self::success('OK');
		} else {
			self::error('Ошибка создания заказа');
		}
	}

	public function changeOrderStatus() {
		$orderId = $_POST['postData']['orderId'];
		$newStatus = $_POST['postData']['newStatus'];

		if (!$orderId || !$newStatus) {
			self::error('Недостаточно данных');
		}
		if (OrderModel::changeOrderStatus($orderId, $newStatus)) {
			self::success('OK');
		} else {
			self::error('Произошла ошибка');
		}
	}

	public function deleteOrder() {
		$orderId = $_POST['postData']['orderId'];

		if (!$orderId) {
			self::error('Недостаточно данных');
		}
		
		if (OrderModel::deleteOrder($orderId)) {
			self::success('OK');
		} else {
			self::error('Произошла ошибка');
		}
	}

	public function addProduct() {
		$title = $_POST['title'] ?? '';
		$description = $_POST['description'] ?? '';
		$price = $_POST['price'] ?? NULL;
		$image = $_FILES['image'] ?? [];

		if (!$title || !$description || !$price) {
			self::error('Не все данные введены');
		}

		if($title && $description && $price) {
			//пытаемся добавить новый товар
			$result = CatalogModel::insertProduct($title, null, $description, $price, $image);

			//если товар добавлен обнуляем $title и $content
			if($result) {
				self::success('OK');
			} else {
				self::error('Произошла ошибка');
			}
		}
	}

	public function changeProduct() {
		$title = $_POST['title'] ?? '';
		$description = $_POST['description'] ?? '';
		$price = $_POST['price'] ?? NULL;
		$image = $_FILES['image'] ?? [];
		$productId = $_POST['productId'] ?? NULL;

		if (!$title || !$description || !$price || !$productId) {
			self::error('Не все данные введены');
		}

		if($title && $description && $price && $productId) {
			$result = CatalogModel::changeProduct($productId, $title, $description, $price, $image);

			if($result) {
				self::success('OK');
			} else {
				self::error('Произошла ошибка');
			}
		}
	}

	public function deleteProduct() {
		$productId = $_POST['postData']['productId'];

		if (!$productId) {
			self::error('Недостаточно данных');
		}
		
		if (CatalogModel::deleteProduct($productId)) {
			self::success('OK');
		} else {
			self::error('Произошла ошибка');
		}
	}

}

?>