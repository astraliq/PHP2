<?php
class CartModel extends Model {
	public $cartsTable = 'carts';
	public $catalog;

	public function __construct() {
		parent::__construct();
		$this->catalog = new CatalogModel();
    }

	public function getUserCart($userId) {
		$objectON = [
			'idProduct' => 'id'
		];
		$whereObj1 = [
			'userID' => $userId
		];

		return $this->dataBase->uniJoinWhere($this->cartsTable, $this->catalog->productsTable, $objectON, $whereObj1, NULL);
	}

	public function clearUserCart($userID) {
		$whereObject = [
			'userID' => $userID
		];
		return $this->dataBase->uniDelete($this->cartsTable, $whereObject);
	}

	public function clearCookieCart() {
		foreach ($_COOKIE['cart'] as $id => $quantity) {
			unset($_COOKIE['cart'][$id]);
			setcookie("cart[$id]", null, -1);
		};
		return true;
	}

	public function getUserCartFromCookie($cookieIDs) {
		$whereColumn = 'id';
		return $this->dataBase->selectWhereValues($this->catalog->productsTable, $whereColumn, $cookieIDs);
	}

	public function insertProductInCart($idProd, $price, $quantity, $userId) {
		$object = [
			'idProduct' => $idProd,
			'price' => $price,
			'quantity' => $quantity,
			'userID' => $userId
		];

		return $this->dataBase->uniInsert($this->cartsTable, $object);
	}

	public function insertProductsInCart($products, $userId) {
		$columns = ['idProduct', 'price', 'quantity', 'userID'];

		$object = array();
		foreach ($products as $key => $product) {
			$object[] = [$product['id'], $product['price'], $product['quantity'], $userId];
		};
		return $this->dataBase->uniInsertArray($this->cartsTable, $columns, $object);
	}

	public function insertCookieInCart($cookie, $userId) {
		//Избавляемся от всех инъекций
		$cookieIDs = array_keys($cookie);
		$productsInCookie = $this->getUserCartFromCookie($cookieIDs);
		foreach ($productsInCookie as $key => $product) {
			foreach ($cookie as $idProd => $quantity) {
				if ( (int) $product['id'] === $idProd) {
					$productsInCookie[$key]['quantity'] = (int) $quantity; 
				}
			}
		}
		$this->clearCookieCart();
		return $this->insertProductsInCart($productsInCookie, $userId);
	}

	public function updateCartQuantity($productId, $userId, $changingQuantity) {
		$object = [
			'quantity' => $changingQuantity
		];
		$whereObject = [
			'idProduct' => $productId,
			'userID' => $userId
		];
		// $sql = "UPDATE `carts` SET `quantity` = `quantity` + $quantityCart WHERE `idProduct` = $id AND `userID` = $userID";
		return $this->dataBase->uniUpdateChanging($this->cartsTable, $object, $whereObject);
	}

	public function deleteProductFromCart($productId, $userId) {
		$whereObject = [
			'idProduct' => $productId,
			'userID' => $userId
		];
		// $sql = "DELETE FROM `carts` WHERE `idProduct` = $id AND `userID` = $userID";
		return $this->dataBase->uniDelete($this->cartsTable, $whereObject);
	}

}
?>