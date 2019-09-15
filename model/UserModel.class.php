<?php
	class UserModel extends Model {

	public function regUser($login, $password, $name, $surname) {
		$login = SQL::getInstance()->escapeString($login);
		$name = SQL::getInstance()->escapeString($name);
		$surname = SQL::getInstance()->escapeString($surname);

		$sql = "INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `dateReg`) VALUES (NULL, '$login', '$password', NULL, NULL, CURRENT_TIMESTAMP)";

		$result = SQL::getInstance()->execQuery($sql);
		return $result;
	}

	public function checkUser($login) {
		$result = SQL::getInstance()->uniSelect('users', 'login', $login);
		return $result;
	}

	// доделать
	public function updateUser($login) {
		$link = createConnection();

		$id = (int)$id;
		$name = $name = SQL::getInstance()->escapeString($name);
		$comment = $name = SQL::getInstance()->escapeString($comment);

		$sql = "UPDATE `reviews` SET `name`='$name',`comment`='$comment' WHERE `id` = $id";

		$result = mysqli_query($link, $sql);
		mysqli_close($link);
		return $result;
	}

	public function deleteUser($login) {
		$id = (int)$id;

		$sql = "DELETE FROM `reviews` WHERE `id` = $id";
		return execQuery($sql);
	}
}

?>