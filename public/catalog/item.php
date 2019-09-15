<?php

require_once __DIR__ . '/../../config/config.php';

$login = NULL;

if (isset($_SESSION['login'])) {
	$login = $_SESSION['login'];
}

$id = isset($_GET['id']) ? $_GET['id'] : false;

$sql = "SELECT * FROM products WHERE id = $id";
$itemCurrent = show($sql);


if($login === 'admin') {
	$changeItem = "<a class='btn' href='add.php?id=" . $itemCurrent["id"] . "'>Изменить товар</a>";
	$deleteItem = "<a class='btn' onclick='deleteProduct(" . $itemCurrent["id"] . ")'>Удалить товар</a>";
} else {
	$changeItem = "";
	$deleteItem = "";
}

if ($itemCurrent) {
	$description = $itemCurrent["description"] != '' ? $itemCurrent["description"] : 'Информация о товаре отсутствует';

	echo render(TEMPLATES_DIR . 'index.tpl', [
		'mainTitle' => 'Описание товара',
			'head' => render(TEMPLATES_DIR . $head, [
			'login' => $login,
		]),
		'title' => $itemCurrent["name"],
		'linkupdir' => '../',
		'menu' => showMenu($mainMenu),
		'content' => render(TEMPLATES_DIR . 'item.tpl', [
			'id' => $itemCurrent["id"],
			'imglink' => '/../img/img_phones/' . $itemCurrent["img"],
			'itemid' => $itemCurrent["id"],
			'price' => $itemCurrent["price"],
			'views' => $itemCurrent["views"],
			'desc' => $description,
			'changeitem' => $changeItem,
			'deleteitem' => $deleteItem
		])
	]);
	echo '<getdatalist ref="getdatalist"></getdatalist>';
} else {
	header("Location: /catalog.php");
}
