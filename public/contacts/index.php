<?php

require_once __DIR__ . '/../../config/config.php';

$login = $_SESSION['login'] ?? NULL;
$postAction = $_POST['action'] ?? NULL;
$postID = $_POST['id'] ?? NULL;
$getAction = $_GET['action'] ?? NULL;
$getID = $_GET['id'] ?? NULL;
$name = $_POST['name'] ?? '';
$comment = $_POST['comment'] ?? '';
$rate = $_POST['rate'] ?? '';
$message = '';


if ($name && $comment && $postAction === 'create') {
	if (createReview($name, $comment, $rate)) {
		$message .= "Комментарий добавлен";
		$name = '';
		$comment = '';
	} else {
		$message .= "Что-то пошло не так";
	}
} else if ($_SERVER['REQUEST_METHOD'] === 'POST') {
	if (!$name) {
		$message .= "Введите имя<br>";
	}
	if (!$comment) {
		$message .= "Добавьте Комментарий<br>";
	}
}

if ($postAction === 'update' && $postID && $name && $comment) {
	updateReview($postID, $name, $comment);
};

if ($getAction === 'delete' && isset($getID)) {
	deleteReview($getID);
};


echo render(TEMPLATES_DIR . 'index.tpl', [
	'mainTitle' => 'Контакты и отзывы',
		'head' => render(TEMPLATES_DIR . $head, [
		'login' => $login,
	]),
	'title' => 'Контакты и отзывы',
	'linkupdir' => '../',
	'menu' => showMenu($mainMenu),
	'content' => render(TEMPLATES_DIR . 'contacts.tpl',[
		'reviews' => renderReviews($login),
		'message' => $message
	])
]);
