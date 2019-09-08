<?php

require_once __DIR__ . '/../config/config.php';
/*
function __autoload($classname){
	include_once("inc/$classname.php");
}
*/

spl_autoload_register(function($classname){
	include_once("../classes/$classname.php");
});

/*
spl_autoload_register(function($name){
	$dirs = ["inc","test","test2"];
	$file = $name.".php";
	$check=false;
	foreach()
	
	include_once("inc/$name.php");
	
});
*/

$login = NULL;

if (isset($_SESSION['login'])) {
	$login = $_SESSION['login'];
}

/*
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
*/
//site.ru/index.php?act=login&c=user
$action = 'action_';
$action .= (isset($_GET['act'])) ? $_GET['act'] : 'index';

// $reqUrl =  (empty($_SERVER["REQUEST_URI"])) ? str_replace('/', '', $_SERVER["REQUEST_URI"]) : 'index';

switch ($_GET['c'])
{
	case 'page':
		$controller = new C_Page($head, $mainMenu, $login);
		break;
	case 'user':
		$controller = new C_User($head, $mainMenu, $login);
		break;
	default:
		$controller = new C_Page($head, $mainMenu, $login);
}

$controller->Request($action);