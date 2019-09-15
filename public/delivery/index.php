<?php

require_once __DIR__ . '/../../config/config.php';

$login = NULL;

if (isset($_SESSION['login'])) {
	$login = $_SESSION['login'];
}

echo render(TEMPLATES_DIR . 'index.tpl', [
	'mainTitle' => 'Доставка и оплата',
	'head' => render(TEMPLATES_DIR . $head, [
		'login' => $login,
	]),
	'title' => 'Доставка и оплата',
	'linkupdir' => '../',
	'menu' => showMenu($mainMenu),
	'content' => render(TEMPLATES_DIR . 'delivery.tpl', [
			'content' => ' '
		])
]);

