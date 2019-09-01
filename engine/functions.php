<?php


function render($file, $variables = []) {
	if (!is_file($file)) {
		echo 'Template file "' . $file . '" not found';
		exit();
	}

	if (filesize($file) === 0) {
		echo 'Template file "' . $file . '" is empty';
		exit();
	}


	$templateContent = file_get_contents($file);

	foreach ($variables as $key => $value) {
		$key = '{{' . strtoupper($key) . '}}';

		$templateContent = str_replace($key, $value, $templateContent);
	}

	return $templateContent;
}

function loadFile($fileName, $path)
{
	//$fileName - имя name заданное для input типа file
	//Если $_FILES[$fileName] не существует, и есть ошибоки
	// var_dump($_FILES[$fileName]);
	if(empty($_FILES[$fileName]) || $_FILES[$fileName]['error']) {
		return 'default.png';
	}

	$file = $_FILES[$fileName];

	//выбираем деррикторию куда загружать изображение
	$uploaddir = WWW_DIR . $path;

	//выбираем конечное имя файла
	$uploadfile = $uploaddir . basename($file['name']);

	//Пытаемся переместить файл из временного местонахождения в постоянное
	if (move_uploaded_file($file['tmp_name'], $uploadfile)) {
		return basename($file['name']);
	} else {
		return 0;
	}
}

function getItems() {
	$itemList = getAssocResult("SELECT * FROM `products`");
	$itemArray = [];
	foreach ($itemList as $key => $item) {
		$itemArray[] = render(TEMPLATES_DIR . 'items.tpl', $variables = [
				'name' => $item["name"],
				'img' => '/img/img_phones/' . $item["img"],
				'imglink' => '/img/img_phones/' . $item["img"],
				'imgid' => $item["id"],
				'price' => $item["price"],
				'views' => $item["views"],
				'desc' => $item["description"]
			]);
	};
	return implode(' ', $itemArray);
}


$mainMenu = [
	[
		'title' => 'Главная',
		'link' => '/'
	],
	[
		'title' => 'Каталог',
		'link' => '/catalog/',
		'children' => [
			// [
			// 	'title' => 'Lumia 650',
			// 	'link' => '/lumia'
			// ],
			// [
			// 	'title' => 'Apple iphone 7',
			// 	'link' => '/iphone7'
			// ],
			// [
			// 	'title' => 'Xiaomi Mi8',
			// 	'link' => '/xiaomi_mi8'
			// ]
		]
	],
	[
		'title' => 'Доставка и оплата',
		'link' => '/delivery'
	],
	[
		'title' => 'Контакты',
		'link' => '/contacts'
	],

];

function showMenu($menu) {
	$i = '';
	// $i++;
	$menuText = '<ul class="menu' . $i . '">';
	foreach ($menu as $key => $val) {
		$menuText .= '<li><a href="' . $val['link'] . '">' . $val['title'] . '</a>';
		if (isset($val['children'])) {
			$menuText .= showMenu($val['children'], $i);
		}
		$menuText .= '</li>';
	}
	$menuText .= '</ul>';
	return $menuText;

}


function mathOperaion($arg1,$arg2,$operation) {
	$arg1 = (int)$arg1;
	$arg2 = (int)$arg2;
	switch($operation) {
        case 'Сложение':
            return $arg1 + $arg2;
        case 'Вычитание':
            return $arg1 - $arg2;
        case 'Умножение':
            return $arg1 * $arg2;
        case 'Деление':
            return $arg2 === 0 ? 'Результат деления на 0: бесконечность' : ($arg1 / $arg2);
        default:
            return 'операция отсутствует или неверная';
    };
}

// Получение данных из тела запроса
function getFormData($method) {
 
    // GET или POST: данные возвращаем как есть
    if ($method === 'GET') return $_GET;
    if ($method === 'POST') return $_POST;
 
    // PUT, PATCH или DELETE
    $data = array();
    $exploded = explode('&', file_get_contents('php://input'));
 
    foreach($exploded as $pair) {
        $item = explode('=', $pair);
        if (count($item) == 2) {
            $data[urldecode($item[0])] = urldecode($item[1]);
        }
    }
 
    return $data;
}