<?php

define('SITE_DIR', __DIR__ . '/../');
define('CONFIG_DIR', SITE_DIR . 'config/');
define('DATA_DIR', SITE_DIR . 'data/');
define('ENGINE_DIR', SITE_DIR . 'engine/');
define('WWW_DIR', SITE_DIR . 'public/');
define('TEMPLATES_DIR', SITE_DIR . 'templates/');

define('IMG_GALLERY', WWW_DIR . 'img/img_phones/');
define('IMG_DIR', 'img/');
define('VENDOR_DIR', SITE_DIR . 'vendor/');
require_once ENGINE_DIR . 'functions.php';



define('DB_HOST', 'localhost');
define('DB_USER', 'admin');
define('DB_PASS', 'admin');
define('DB_NAME', 'allsmarts');


require_once ENGINE_DIR . 'db.php';
