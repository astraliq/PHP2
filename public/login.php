<?php

require_once __DIR__ . '/../config/config.php';

$login = NULL;

if (isset($_SESSION['login'])) {
	$login = $_SESSION['login'];
}

if($_SESSION) {
	header("Location: /index.php");
};

echo render(TEMPLATES_DIR . 'index.tpl', [
	'mainTitle' => 'Вход',
	'head' => render(TEMPLATES_DIR . $head, [
		'login' => $login,
	]),
	'title' => 'Вход в личный кабинет',
	'linkupdir' => '',
	'menu' => showMenu($mainMenu),
	'content' => render(TEMPLATES_DIR . 'login.tpl')
]);
