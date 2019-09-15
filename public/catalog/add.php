<?php

require_once __DIR__ . '/../../config/config.php';

$login = NULL;

if (isset($_SESSION['login'])) {
	$login = $_SESSION['login'];
}

if($login !== 'admin') {
	header('Location: /catalog/');
}

$title = '';
$description = '';
$price = '';
$method = 'addProduct()';
$itemImage = '';
$titlePage = 'Добавление товара';
$btnName = 'Добавить товар';


if (isset($_GET['id'])) {
	$id = $_GET['id'] ?? '';
	$id = (int) $id;
	$sql = "SELECT * FROM products WHERE id = $id";
	$itemCurrent = show($sql);
	
	if ($itemCurrent) {
		$title = $itemCurrent["title"];
		$description = $itemCurrent["description"];
		$price = $itemCurrent["price"];
		$method = "changeProduct(" . $itemCurrent["id"] . ")";
		if ($itemCurrent["img"] !== 'default.png') {
			$itemImage = "<h5>Текущее изображение</h5><img src='/img/img_phones/" . $itemCurrent["img"] . "' height='150' width='150' class='basket_img'>";
		};
		$btnName = 'Изменить товар';
		$titlePage = 'Редактирование товара';
	}
}


echo render(TEMPLATES_DIR . 'index.tpl', [
	'mainTitle' => $titlePage,
	'head' => render(TEMPLATES_DIR . $head, [
		'login' => $login,
	]),
	'linkupdir' => '../',
	'title' => $titlePage,
	'menu' => showMenu($mainMenu),
	'content' => render(TEMPLATES_DIR . 'createProduct.tpl', [
			'title' => $title,
			'description' => $description,
			'price' => $price,
			'method' => $method,
			'image' => $itemImage,
			'btnname' => $btnName
		])
]);

