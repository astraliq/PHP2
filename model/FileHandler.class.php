<?php
class FileHandler {

	public function __construct() {
    }

	public function loadFile($fileName, $path) {
		//$fileName - имя name заданное для input типа file
		//Если $_FILES[$fileName] не существует, и есть ошибки
		// var_dump($_FILES[$fileName]);
		if(empty($_FILES[$fileName]) || $_FILES[$fileName]['error']) {
			return 'default.png';
		}

		$file = $_FILES[$fileName];

		//выбираем деррикторию куда загружать изображение
		$uploaddir = Config::get('path_public') . $path;

		//выбираем конечное имя файла
		$uploadfile = $uploaddir . basename($file['name']);
		//Пытаемся переместить файл из временного местонахождения в постоянное
		if (move_uploaded_file($file['tmp_name'], $uploadfile)) {
			return basename($file['name']);
		} else {
			return 0;
		}
	}

}
?>