<?php
declare(strict_types=1);
class UserModel extends Model {
	// public $dataBase;
	public $usersTable = 'users';
	public $usersReviews = 'reviews';
	public $usersHistory = 'users_history';

	public function __construct() {
		parent::__construct();
    }

	public function regUser($login, $password, $name, $surname) {
		$pass = SQL::cryptPassword($password, null);
		$whereObject = [
			'login' => $login,
			'password' => $pass,
			'name' => $name,
			'surname' => $surname
		];

		// $sql = "INSERT INTO `users` (`id`, `login`, `password`, `name`, `surname`, `dateReg`) VALUES (NULL, '$login', '$password', NULL, NULL, CURRENT_TIMESTAMP)";

		// if ($this->dataBase->uniInsert($this->usersTable, $object);) {
		// 	return true;
		// }
		return $this->dataBase->uniInsert($this->usersTable, $whereObject);
	}

	public function checkUser($login) {
		$whereObject = [
			'login' => $login
		];
		return $this->dataBase->uniSelect($this->usersTable, $whereObject);
	}

	public function updateUserReview($login) {
		$id = (int) $id;
		$object = [
			'name' => $name,
			'comment' => $comment
		];
		$where = "`id` = $id";
		// $sql = "UPDATE `reviews` SET `name`='$name',`comment`='$comment' WHERE `id` = $id";
		return $this->dataBase->uniUpdate($this->reviewsTable, $object, $where);
	}

	public function deleteUser($login) {
		$where = [
			'login' => $login
		];
		// $sql = "DELETE FROM `reviews` WHERE `id` = $id";
		return $this->dataBase->uniDelete($this->usersTable, $where);
	}

	public function addPageToUserHistory($userId, $page = '/index.php') {
		$object = [
			'userId' => $userId,
			'page' => $page
		];
		// $sql = "INSERT INTO `users_history` (`userId`, `page`) VALUES ('$userId', '$page')";
		return $this->dataBase->uniInsert($this->usersHistory, $object);
	}

	public function getPagesOfUserHistory($userId) {
		$quantityOfLastPages = 10;
		$userId = (int) $userId;
		$sql = "SELECT * FROM $this->usersHistory WHERE `userId` = $userId ORDER BY `date` DESC LIMIT $quantityOfLastPages";
		return $this->dataBase->getRows($sql, null);
	}
}

?>