<?php

require_once '../config/config.php';

//Убиваем сессию и тем самым разлогиниваем пользователя
session_destroy();

header("Location: /index.php?act=login&c=user");
