<?php
class OrderModel extends Model {

	public function generateMyOrdersPage() {
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

	public function changeOrderStatus($orderId, $newStatus) {
		$orderId = (int)$orderId;
		$newStatus = (int)$newStatus;
		$sql = "UPDATE `orders` SET `status`= $newStatus WHERE `id` = $orderId";
		return execQuery($sql);
	}

	public function deleteOrder($orderId) {
		$orderId = (int)$orderId;
		$sqlOrder = "DELETE FROM `orders` WHERE `orders`.`id` = $orderId";
		$sqlOrderProducts = "DELETE FROM `orderproducts` WHERE `orderproducts`.`orderID` = $orderId";
		execQuery($sqlOrderProducts);
		return execQuery($sqlOrder);
	}

	public function generateOrderList($userId) {
		$userCart = CartModel::getUserCart($userId);
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

	public function addOrderToBD($userId,$address) {
		$userCart = CartModel::getUserCart($userId);
		
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
}
?>