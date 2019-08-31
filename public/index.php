<?php

require_once __DIR__ . '/../config/config.php';

require_once VENDOR_DIR . 'autoload.php';

try {
	$loader = new \Twig\Loader\FilesystemLoader(TEMPLATES_DIR);

	$twig = new \Twig\Environment($loader);

	$template = $twig->loadTemplate('index.tpl');

	//список файлов из папки
	// $imgList = array_slice(scandir(IMG_DIR . 'img_phones/'), 2); 

	//список файлов из папки из БД
	$imgFromBD = getAssocResult("SELECT `img` FROM `products`");
	$imgList = [];
	foreach ($imgFromBD as $key=>$img) {
		$imgList[$key] = $img['img'];
	}

	echo $template->render(array (
		'mainTitle' => 'Галерея',
		'title' => 'Галерея',
		'imgList' => $imgList,
		'imglink' => '/img/img_phones/',
	));
} catch (Exception $e) {
	die ('ERROR: ' . $e->getMessage());
};



