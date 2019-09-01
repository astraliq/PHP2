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

$userId = (int)$loginID;

if ($login == 'admin') {
	$pageName = 'Управление заказами';
} else {
	$pageName = 'Мои заказы';
}

echo render(TEMPLATES_DIR . 'index.tpl', [
	'mainTitle' => 'Allsmarts - личный кабинет',
	'head' => render(TEMPLATES_DIR . $head, [
		'login' => $login,
	]),
	'title' => $pageName,
	'linkupdir' => '../',
	'menu' => showMenu($mainMenu),
	'content' => generateMyOrdersPage()
]);

