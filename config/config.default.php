<?php
$config['db_user'] = 'admin';
$config['db_pass'] = 'admin';
$config['db_base'] = 'allsmarts';
$config['db_host'] = 'localhost';
$config['db_charset'] = 'UTF-8';
$config['db_driver'] = 'mysql';


$config['path_root'] = __DIR__;
$config['path_public'] = $config['path_root'] . '/../public';
// $config['path_model'] = $config['path_root'] . '/../model';
$config['path_controller'] = $config['path_root'] . '/../controller';
// $config['path_cache'] = $config['path_root'] . '/../cache';
// $config['path_data'] = $config['path_root'] . '/data';
// $config['path_fixtures'] = $config['path_data'] . '/fixtures';
// $config['path_migrations'] = $config['path_data'] . '/../migrate';
// $config['path_commands'] = $config['path_root'] . '/../lib/commands';
$config['path_libs'] = $config['path_root'] . '/../lib';
$config['path_templates'] = $config['path_root'] . '/../templates';

$config['path_logs'] = $config['path_root'] . '/../logs';

$config['sitename'] = 'Allsmarts';

$config['mainMenu'] = [
	[
		'title' => 'Главная',
		'link' => '/'
	],
	[
		'title' => 'Каталог',
		'link' => '/index.php?path=catalog',
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
		'link' => '/index.php?path=delivery'
	],
	[
		'title' => 'Контакты',
		'link' => '/index.php?path=contacts'
	],

];