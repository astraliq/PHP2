<?
class M_User {

	protected $type; 

	public function __construct($type) {
        $this->type = $type;
    }

	public function regUser($login, $password, $name, $surname) {
		$link = createConnection();

		$login = mysqli_real_escape_string($link, (string)htmlspecialchars(strip_tags($login)));
		$name = mysqli_real_escape_string($link, (string)htmlspecialchars(strip_tags($name)));
		$surname = mysqli_real_escape_string($link, (string)htmlspecialchars(strip_tags($surname)));

		$sql = "INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `dateReg`) VALUES (NULL, '$login', '$password', NULL, NULL, CURRENT_TIMESTAMP)";

		$result = mysqli_query($link, $sql);

		mysqli_close($link);
		header("Location: /index.php");
		return $result;
	}

	public function checkUser($login) {
		$link = createConnection();

		$login = mysqli_real_escape_string($link, (string)htmlspecialchars(strip_tags($login)));

		$sql = "SELECT * FROM `users` WHERE `login` = '$login'";
		$result = execQuery($sql);
		return $result;
	}

	// доделать
	public function updateUser($login) {
		$link = createConnection();

		$id = (int)$id;
		$name = mysqli_real_escape_string($link, (string)htmlspecialchars(strip_tags($name)));
		$comment = mysqli_real_escape_string($link, (string)htmlspecialchars(strip_tags($comment)));

		$sql = "UPDATE `reviews` SET `name`='$name',`comment`='$comment' WHERE `id` = $id";

		$result = mysqli_query($link, $sql);
		mysqli_close($link);
		header("Location: /contacts.php");
		return $result;
	}

	public function deleteUser($login) {
		$id = (int)$id;

		$sql = "DELETE FROM `reviews` WHERE `id` = $id";
		header("Location: /contacts.php");
		return execQuery($sql);
	}
}