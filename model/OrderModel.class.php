<?php
class OrderModel extends Model {
	private $cartModel;
	public $orderTable = 'orders';
	public $orderProductsTable = 'orderproducts';

	public function __construct() {
		parent::__construct();
		$this->cartModel = new CartModel();
    }

	public function getOrdersById($userId) {
		$userLogin = $_SESSION['user']['login'] ?? NULL;
		if ($userLogin === 'admin') {
			$orders = $this->dataBase->getRows("SELECT `orders`.*, `orderstatuses`.`statusName` FROM `orders` 
			INNER JOIN `orderstatuses` ON `orders`.`status` = `orderstatuses`.`id`
			ORDER BY `dateCreate` DESC", null);
		} else {
			$orders = $this->dataBase->getRows("SELECT `orders`.*, `orderstatuses`.`statusName` FROM `orders` 
				INNER JOIN `orderstatuses` ON `orders`.`status` = `orderstatuses`.`id`
				WHERE `userID` = $userId ORDER BY `dateCreate` DESC", null);
		};
		if ($orders) {
			return $orders;
		}
		return false;
	}

	public function getProductsByOrder($userId) {
		//получаем id пользователя и и получаем все заказы пользователя
		$orders = $this->getOrdersById($userId);
		//проверяем есть ли у пользователя заказы
		if ($orders) {
			$result = [];
			foreach ($orders as $order) {
				$orderId = $order['id'];
				//получаем продукты, которые есть в заказе
				$products = $this->dataBase->getRows("
					SELECT *, `op`.`price` FROM `orderproducts` as op
					JOIN `products` as p ON `p`.`id` = `op`.`idProduct`
					WHERE `op`.`orderID` = $orderId
				", null);
				$result += [$order['id'] => $products];
			}
			return $result;
		}
		return false;
	}

	public function changeOrderStatus($orderId, $newStatus) {
		$object = [
			'status' => $newStatus
		];
		$whereObject = [
			'id' => $orderId
		];
		// $sql = "UPDATE `orders` SET `status` = $newStatus WHERE `id` = $orderId";
		return $this->dataBase->uniUpdate($this->orderTable, $object, $whereObject);
	}

	public function deleteOrder($orderId) {
		$where_1 = [
			'id' => $orderId
		];
		$where_2 = [
			'orderID' => $orderId
		];
		// $sqlOrderProducts = "DELETE FROM `orderproducts` WHERE `orderID` = $orderId";
		// $sqlOrder = "DELETE FROM `orders` WHERE `id` = $orderId";
		$this->dataBase->uniDelete($this->orderProductsTable, $where_2);
		return $this->dataBase->uniDelete($this->orderTable, $where_1);
	}

	public function getCartForOrderList($userId) {
		if ($userId == NULL) {
			return false;
		}
		$userCart = $this->cartModel->getUserCart($userId);
		return $userCart;
	}

	public function addOrderToBD($userId,$address) {
		$userCart = $this->cartModel->getUserCart($userId);
		$object = [
			'userID' => $userId,
			'address' => $address,
			'status' => 1
		];
		// $sqlOrder = "INSERT INTO `orders` (`userID`, `address`, `dateCreate`, `status`) VALUES ('$userId', '$address', CURRENT_TIMESTAMP, '1')";
		$addOrder = $this->dataBase->uniInsert($this->orderTable, $object);
		$lastID = $this->dataBase->getLastInsertId();

		$counter = 0;
		foreach ($userCart as $id => $data) {
			$values[$counter] = [$lastID , (int)$data['idProduct'], (float)$data['price'], (int)$data['quantity']];
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
			$sqlOrderProducts = "INSERT INTO `orderproducts`(orderID,idProduct,price,quantity) VALUES $import";
			$result = $this->dataBase->update($sqlOrderProducts, null);
			if ($result) {
				$this->cartModel->clearUserCart($userId);
			}
			return $result;
		} else {
			return false;
		};
	}
}
?>