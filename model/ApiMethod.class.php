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

	public $dataBase;
	public $method;
	public $catalogModel;
	public $cartModel;
	public $orderModel;
	public $reviewsModel;
	public $userModel;

    public function __construct($method) {
        $this->method = $method;
        $this->dataBase = SQL::getInstance();
        $this->catalogModel = new CatalogModel();
        $this->cartModel = new CartModel();
        $this->orderModel = new OrderModel();
        $this->reviewsModel = new ReviewsModel();
        $this->userModel = new UserModel();
    }

	//Функция вывода ошибки
	private static function error($error_text) {
		//Вариант с json
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode([
			'error' => true,
			'error_text' => $error_text,
			'data' => null
		], JSON_UNESCAPED_UNICODE);
		exit();

		//Вариант без json
		// 	echo "Ошибка: $error_text";
		// 	exit();
	}

	//Функция успешного ответа
	private static function success($data = true) {
		//Вариант с json
		header('Content-Type: application/json; charset=utf-8');
		echo json_encode($data, JSON_UNESCAPED_UNICODE);
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
			$this->error('Логин или пароль не введены');
		}

		//приводим пароль к тому же виду, как он хранится в базе
		$password = SQL::cryptPassword($password, null);

		$whereObj = [
			'login' => $login,
			'password' => $password
		];

		//пытаемся найти пользователя
		$user = $this->dataBase->uniSelect($this->userModel->usersTable, $whereObj);
		//Если пользователь найден, записываем информацию о пользователе в сессию,
		//что бы к ней можно было обратиться с любой страницы
		//Если пользователь не найден, возвращаем ошибку
		// /index.php?path=user/createorder
		if ($user) {
			$_SESSION['user'] = $user;
			$data['result'] = 'OK';
			$data['referrer'] = $_SESSION['referrer']; 
			if (!$this->cartModel->getUserCart($_SESSION['user']['id']) && !empty($_COOKIE['cart'])) {
				if ($this->cartModel->insertCookieInCart($_COOKIE['cart'], $_SESSION['user']['id'])) {
					$this->success($data);
				}
			}
			$this->success($data);
		} else {
			$this->error('Неверный логин или пароль');
		}
	}

	public function reg() {
		//Получаем логин и пароль из postData
		$login = $_POST['postData']['login'] ?? '';
		$password = $_POST['postData']['password'] ?? '';
		$password_repeat = $_POST['postData']['password_repeat'] ?? '';
		$name = $_POST['postData']['name'] ?? NULL;
		$surname = $_POST['postData']['surname'] ?? NULL;
		//Если нет логина или пароля вызываем ошибку

		if (!$login || !$password) {
			$this->error('Логин или пароль не введены');
		}
		if (!$password_repeat) {
			$this->error('Повторите пароль');
		}
		if ($password != $password_repeat) {
			$this->error('Пароли не совпадают');
		}
		if ($this->userModel->checkUser($login)) {
			$this->error('Пользователь с данным логином уже зарегистрирован');
		}

		//генерируем запрос и пытаемся добавить пользователя в базу
		$result = $this->userModel->regUser($login, $password, $name, $surname);

		//Если пользователь найден, записываем информацию о пользователе в сессию,
		//что бы к ней можно было обратиться с любой страницы
		//Если пользователь не найден, возвращаем ошибку
		if ($result) {
			$_SESSION['user']['login'] = $login;
			$this->success('OK');
		} else {
			$this->error('Ошибка записи пользователя в БД');
		}
	}

	public function readCatalog() {
		$where = [
			'isActive' => 1
		];
		$orderBy = 'id';
		$limit = [0, (int) $_POST['numberOfLoadProducts'] ?? 1];
		$sort = 'ASC';
		$catalog = $this->catalogModel->getProductsByParams($where, $orderBy, $limit, $sort);

		if ($catalog) {
			$this->success($catalog);
		} else {
			$this->error('Ошибка чтения каталога из БД');
		}
	}

	public function loadMore() {
		$lastNumberOfProd = (int) $_POST['lastNumberOfProd'] ?? '';
		$numberOfLoadProducts = (int) $_POST['numberOfLoadProducts'] ?? '';
		$where = [
			'isActive' => 1
		];
		$orderBy = 'id';
		$limit = [$lastNumberOfProd, $numberOfLoadProducts];
		$sort = 'ASC';
		$moreProducts = $this->catalogModel->getProductsByParams($where, $orderBy, $limit, $sort);

		if ($moreProducts) {
			$this->success($moreProducts);
		} else {
			$this->error('Ошибка чтения из БД');
		}
	}

	public function getProduct() {
		$productId = (int) $_POST['productId'] ?? NULL;
		$product = $this->catalogModel->getProduct($productId);
		if ($product) {
			$this->success($product);
		} else {
			$this->error('Ошибка чтения из БД');
		}
	}
// ИЗМЕНИТЬ SQL функцию
	public function addToCart() {
		$prod = $_POST['prod'] ? json_decode($_POST['prod'], true) : null;
		if(!$prod) {
			error('ID не передан');
		}
		//Получаем данные корзины
		if ($_SESSION['user']['login']) {
			// $cart = getUserCart($_SESSION['user']['login']['id'])
			$this->cartModel->insertProductInCart($prod['id'], $prod['price'], $prod['quantity'], $_SESSION['user']['id']);
		} else {
			$cart = $_COOKIE['cart'] ?? [];
			$id = $prod['id'];
			//устанавливаем новое куки
			setcookie("cart[$id]", (string)$prod['quantity']);
		}
		$this->success('OK');
	}


	public function readCart() {
		//Получаем корзину пользователя из БД
		if ($_SESSION['user']['login']) {
			$result = $this->cartModel->getUserCart($_SESSION['user']['id']);
		} else {
			if ($_COOKIE['cart']) {
				$result = $this->cartModel->getUserCartFromCookie(array_keys($_COOKIE['cart']));
				foreach ($result as $product => $value) {
					foreach ($_COOKIE['cart'] as $idProduct => $quantity) {
						if ($value['id'] == $idProduct) {
							$result[$product]['quantity'] = $quantity;
						}
					}
				}
			}
		}
		$this->success($result);
	}

	public function updateCart() {
		$productId = (int) $_POST['id'];
		$userId = $_SESSION['user']['id'];
		$changingQuantity = (int) $_POST['quantity'];
		if ($_SESSION['user']['login']) {
			$result = $this->cartModel->updateCartQuantity($productId, $userId, $changingQuantity);

			if ($result) {
				$this->success('OK');
			} else {
				$this->error('Ошибка записи в БД');
			}
		} else {
			$count = $_COOKIE['cart'][$productId] ?? 0;
			//изменяем количество в корзине
			$count += $changingQuantity;
			setcookie("cart[$productId]", (string) $count);
			$this->success('OK');
		}
	}

	public function deleteProductCart() {
		$productId = (int) $_POST['id'];
		$userId = (int) $_SESSION['user']['id'];
		if ($_SESSION['user']['login']) {
			$result = $this->cartModel->deleteProductFromCart($productId, $userId);
			if ($result) {
				$this->success('OK');
			} else {
				$this->error('Ошибка записи в БД');
			}
		} else {
			$count += $_COOKIE['cart'][$id];
			unset($_COOKIE['cart'][$id]);
			setcookie("cart[$id]", null, -1);
			$this->success('OK');
		}
	}

	public function resetCart() {
		$userID = (int) $_SESSION['user']['id'];
		if ($_SESSION['user']['login']) {
			if ($this->cartModel->clearUserCart($userID)) {
				$this->success('OK');
			} else {
				$this->error('Ошибка записи в БД');
			}
		} else {
			if ($this->cartModel->clearCookieCart()) {
				$this->success('OK');
			} else {
				$this->error('Ошибка записи в БД');
			}
		}
	}

	public function createOrder() {
		//Получаем логин и пароль из postData
		$address = $_POST['postData']['address'] ?? '';

		if (!$address) {
			$this->error('Не заполнено поле адрес доставки');
		}

		//генерируем запрос и пытаемся добавить заказ в базу данных
		$result = $this->orderModel->addOrderToBD($_SESSION['user']['id'],$address);
		if ($result) {
			$this->success('OK');
		} else {
			$this->error('Ошибка создания заказа');
		}
	}

	public function changeOrderStatus() {
		$orderId = $_POST['postData']['orderId'];
		$newStatus = $_POST['postData']['newStatus'];

		if (!$orderId || !$newStatus) {
			$this->error('Недостаточно данных');
		}
		if ($this->orderModel->changeOrderStatus($orderId, $newStatus)) {
			$this->success('OK');
		} else {
			$this->error('Произошла ошибка');
		}
	}

	public function deleteOrder() {
		$orderId = $_POST['postData']['orderId'];

		if (!$orderId) {
			$this->error('Недостаточно данных');
		}
		
		if ($this->orderModel->deleteOrder($orderId)) {
			$this->success('OK');
		} else {
			$this->error('Произошла ошибка');
		}
	}

	public function addProduct() {
		$title = $_POST['title'] ?? '';
		$description = $_POST['description'] ?? '';
		$price = $_POST['price'] ?? NULL;
		$image = $_FILES['image'] ?? [];

		if (!$title || !$description || !$price) {
			$this->error('Не все данные введены');
		}

		if($title && $description && $price) {
			//пытаемся добавить новый товар
			$result = $this->catalogModel->insertProduct($title, null, $description, $price, $image);

			//если товар добавлен обнуляем $title и $content
			if($result) {
				$this->success('OK');
			} else {
				$this->error('Произошла ошибка');
			}
		}
	}

	public function changeProduct() {
		$title = $_POST['title'] ?? '';
		$description = $_POST['description'] ?? '';
		$price = $_POST['price'] ?? NULL;
		$image = $_FILES['image'] ?? NULL;
		$productId = $_POST['productId'] ?? NULL;

		if (!$title || !$description || !$price || !$productId) {
			$this->error('Не все данные введены');
		}

		if($title && $description && $price && $productId) {
			$result = $this->catalogModel->changeProduct($productId, $title, $description, $price, $image);

			if($result) {
				$this->success('OK');
			} else {
				$this->error('Произошла ошибка');
			}
		}
	}

	public function deleteProduct() {
		$productId = $_POST['postData']['productId'];

		if (!$productId) {
			$this->error('Недостаточно данных');
		}
		
		if ($this->catalogModel->deleteProduct($productId)) {
			$this->success('OK');
		} else {
			$this->error('Произошла ошибка');
		}
	}

	public function createReview() {
		$name = $_POST['name'] ?? '';
		$comment = $_POST['comment'] ?? '';
		$rate = $_POST['rate'] ?? '';

		if ($name === '' || $comment === '') {
			$this->error('Передано пустое значение имени или комментария');
		}

		$result = $this->reviewsModel->createReview($name, $comment, $rate);

		if($result) {
			$data['admin'] = $_SESSION['user']['login'] === 'admin' ? true : false;
			$data['result'] = 'OK';
			header("Location: /index.php?path=contacts");
			// $this->success($data);
		} else {
			$this->error('Произошла ошибка');
		}
	}

	public function readReviews() {
		$numberOfLoadReviews = (int) $_POST['numberOfLoadReviews'] ?? '';
		$reviews = $this->reviewsModel->getLastReviews($numberOfLoadReviews);
		if ($reviews) {
			$data['reviews'] = $reviews;
			$data['admin'] = $_SESSION['user']['login'] === 'admin' ? true : false;
			$this->success($data);
		} else {
			$this->error('Ошибка чтения из БД');
		}
	}
// ИСПРАВИТЬ
	// public function loadMoreReviews() {
	// 	$lastNumberOfProd = (int) $_POST['lastNumberOfProd'] ?? '';
	// 	$numberOfLoadProducts = (int) $_POST['numberOfLoadProducts'] ?? '';

	// 	$sql = "SELECT * FROM `products` WHERE `isActive` = 1 ORDER BY `id` LIMIT $lastNumberOfProd, $numberOfLoadProducts";
	// 	$moreProducts = $this->dataBase->getRows($sql, null);

	// 	if ($moreProducts) {
	// 		$this->success($moreProducts);
	// 	} else {
	// 		$this->error('Ошибка чтения из БД');
	// 	}
	// }

	public function changeReview() {
		$id = $_POST['reviewId'] ?? NULL;
		$name = $_POST['reviewAuthor'] ?? '';
		$comment = $_POST['changedComment'] ?? '';

		if ($name === '' || $comment === '') {
			$this->error('Передано пустое значение имени или комментария');
		}

		$result = $this->reviewsModel->updateReview($id, $name, $comment);

		if($result) {
			$data['admin'] = $_SESSION['user']['login'] === 'admin' ? true : false;
			$data['result'] = 'OK';
			$this->success($data);
		} else {
			$this->error('Произошла ошибка');
		}
	}

	public function deleteReview() {
		$reviewId = $_POST['reviewId'] ?? NULL;

		if (!$reviewId) {
			$this->error('Не передан ID отзыва');
		}

		$result = $this->reviewsModel->deleteReview($reviewId);

		if ($result) {
			$data['admin'] = $_SESSION['user']['login'] === 'admin' ? true : false;
			$data['result'] = 'OK';
			$this->success($data);
		} else {
			$this->error('Произошла ошибка');
		}
	}

}

?>