<?php

require_once __DIR__ . '/../../config/config.php';

$login = NULL;

if (isset($_SESSION['login'])) {
	$login = $_SESSION['login'];
}

if ($login === 'admin') {
	$addproduct = '<a href="/catalog/add.php">Добавить товар в каталог</a>';
} else {
	$addproduct = '';
}

echo render(TEMPLATES_DIR . 'index.tpl', [
	'mainTitle' => 'Каталог товаров',
	'head' => render(TEMPLATES_DIR . $head, [
		'login' => $login,
	]),
	'linkupdir' => '../',
	'title' => 'Каталог товаров',
	'menu' => showMenu($mainMenu),
	'content' => $addproduct . '<products ref="products"></products>',
]);

// загрузка базы товарами
// for ($i=1; $i < 500; $i++) { 
// 	insertProduct('Товар ' . $i, null, 'Описание ' . $i, 100 * $i, '');
// }
