<?php
session_start();

function createConnection()
{
	$db = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
	mysqli_query($db, "SET CHARACTER SET 'utf8'");
	return $db;
}

function execQuery($sql)
{
	$db = createConnection();

	$result = mysqli_query($db, $sql);

	mysqli_close($db);
	return $result;
}

function getAssocResult($sql)
{
	$db = createConnection();

	$result = mysqli_query($db, $sql);

	$array_result = [];
	while ($row = mysqli_fetch_assoc($result)) {
		$array_result[] = $row;
	}

	mysqli_close($db);
	return $array_result;
}

function show($sql)
{
	$result = getAssocResult($sql);
	if(empty($result)) {
		return null;
	}
	return $result[0];
}

/**
 * Функция выполняет SQL запрос в БД и пытается получить ассоцитивный массив
 * результата выборки
 * @param mysqli ?$db - готовое подключение к БД
 * @param string $string - sql строка запроса, от которой необходимо защититься
 * @return string
 */
function escapeString($db, $string)
{
	//избавляемся от sql и html инъекций
	return mysqli_real_escape_string(
		$db,
		(string)htmlspecialchars(strip_tags($string))
	);
}


/**
 * Вставляет строку и возвращается вставленный id
 * @param string $sql
 * @return int
 */
function insert($sql)
{
	//создаем соединение с БД
	$db = createConnection();

	//выполняем запрос
	mysqli_query($db, $sql);
	$id = mysqli_insert_id($db);

	//закрываем соединение
	mysqli_close($db);
	return $id;
}