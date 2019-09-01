<?php

require_once __DIR__ . '/../config/config.php';

$login = NULL;

if (isset($_SESSION['login'])) {
	$login = $_SESSION['login'];
}


echo render(TEMPLATES_DIR . 'index.tpl', [
	'mainTitle' => 'Allsmarts',
	'head' => render(TEMPLATES_DIR . $head, [
		'login' => $login,
	]),
	'title' => '',
	'linkupdir' => '',
	'menu' => showMenu($mainMenu),
	'content' => render(TEMPLATES_DIR . 'main_page.tpl')
]);

// $link = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// mysqli_set_charset($link, "utf8");
// $result = mysqli_query($link, "SELECT * FROM phones");

// $rows = [];
// while ($row = mysqli_fetch_assoc($result)) {
// 	$rows[] = $row;
// };
// var_dump($rows);
// die;

// var_dump($link);