<?php

require_once __DIR__ . '/../config/config.php';

$id = isset($_GET['id']) ? $_GET['id'] : false;

$sql = "SELECT * FROM products WHERE id = $id";
$itemCurrent = show($sql);

if ($itemCurrent) {
	$description = $itemCurrent["description"] != '' ? $itemCurrent["description"] : 'Информация о товаре отсутствует';

	echo render(TEMPLATES_DIR . 'index.tpl', [
		'mainTitle' => 'Описание товара',
			'head' => render(TEMPLATES_DIR . $head, [
			'login' => $_SESSION['login'],
		]),
		'title' => 'Описание',
		'linkupdir' => '',
		'menu' => showMenu($mainMenu),
		'content' => render(TEMPLATES_DIR . 'item.tpl', [
			'id' => $itemCurrent["id"],
			'name' => $itemCurrent["name"],
			'imglink' => '/img/img_phones/' . $itemCurrent["img"],
			'itemid' => $itemCurrent["id"],
			'price' => $itemCurrent["price"],
			'views' => $itemCurrent["views"],
			'desc' => $description
		])
	]);
	echo '<getdatalist ref="getdatalist"></getdatalist>';
} else {
	header("Location: /catalog.php");
}
