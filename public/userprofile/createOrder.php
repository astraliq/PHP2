<?php

require_once __DIR__ . '/../../config/config.php';

$login = NULL;
$loginID = NULL;
if (isset($_SESSION['login'])) {
	$login = $_SESSION['login'];
}

if (isset($_SESSION['id'])) {
	$loginID = $_SESSION['id'];
}

if(empty($_SESSION['login'])) {
	header('Location: /login.php');
}

$userCart = getUserCart($loginID);
$sum = 0;

foreach ($userCart as $id => $product) {
		$sum += $product['price']*$product['quantity'];
};

if(empty($userCart)) {
	header('Location: /catalog/');
};

echo render(TEMPLATES_DIR . 'index.tpl', [
	'mainTitle' => 'Оформление заказа',
	'head' => render(TEMPLATES_DIR . $head, [
		'login' => $login,
	]),
	'title' => 'Оформление заказа',
	'linkupdir' => '../',
	'menu' => showMenu($mainMenu),
	'content' => render(TEMPLATES_DIR . 'createOrder.tpl', [
			'orderitem' => generateOrderList($loginID)
		]),
	'sum' => $sum
]);

