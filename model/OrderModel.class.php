<?php
class OrderModel extends Model {

	public function getOrdersById($userId) {
		$userLogin = $_SESSION['login'] ?? NULL;
		if ($userLogin === 'admin') {
			$orders = SQL::getInstance()->sqlGetArray("SELECT `orders`.*, `orderstatuses`.`statusName` FROM `orders` 
			INNER JOIN `orderstatuses` ON `orders`.`status` = `orderstatuses`.`id`
			ORDER BY `dateCreate` DESC");
		} else {
			$orders = SQL::getInstance()->sqlGetArray("SELECT * FROM `orders` WHERE `userID` = $userId ORDER BY `dateCreate` DESC");
		};
		return $orders;
	}

	public function getProductsByOrder() {
		//получаем id пользователя и и получаем все заказы пользователя
		$userId = $_SESSION['id'] ?? NULL;
		$orders = self::getOrdersById($userId);
		$result = [];
		foreach ($orders as $order) {
			$orderId = $order['id'];
			//получаем продукты, которые есть в заказе
			$products = SQL::getInstance()->sqlGetArray("
				SELECT *, `op`.`price` FROM `orderproducts` as op
				JOIN `products` as p ON `p`.`id` = `op`.`idProduct`
				WHERE `op`.`orderID` = $orderId
			");
			$result += [$order['id'] => $products];
		}
		return $result;
	}

	public function changeOrderStatus($orderId, $newStatus) {
		$orderId = (int)$orderId;
		$newStatus = (int)$newStatus;
		$sql = "UPDATE `orders` SET `status` = $newStatus WHERE `id` = $orderId";
		return SQL::getInstance()->execQuery($sql);
	}

	public function deleteOrder($orderId) {
		$orderId = (int)$orderId;
		$sqlOrder = "DELETE FROM `orders` WHERE `orders`.`id` = $orderId";
		$sqlOrderProducts = "DELETE FROM `orderproducts` WHERE `orderproducts`.`orderID` = $orderId";
		SQL::getInstance()->execQuery($sqlOrderProducts);
		return SQL::getInstance()->execQuery($sqlOrder);
	}

	public function getCartForOrderList($userId) {
		if ($userId == NULL) {
			return false;
		}
		$userCart = CartModel::getUserCart($userId);
		return $userCart;
	}

	public function addOrderToBD($userId,$address) {
		$userCart = CartModel::getUserCart($userId);
		
		$sqlOrder = "INSERT INTO `orders` (`userID`, `address`, `dateCreate`, `status`) VALUES ('$userId', '$address', CURRENT_TIMESTAMP, '1')";

		$addOrder = SQL::getInstance()->execQuery($sqlOrder);
		$lastID = SQL::getInstance()->getLastInsertId('orders');

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
}
?>