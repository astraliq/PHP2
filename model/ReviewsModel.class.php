<?php
declare(strict_types=1);
class ReviewsModel extends Model {
	public $reviewsTable = 'reviews';
	public $reviewsFromVue = '<reviews ref="reviews"></reviews>';

	public function __construct() {
		parent::__construct();
    }

	public function getLastReviews($quantityOfReviews) {
		$sql = "SELECT * FROM `$this->reviewsTable` ORDER BY `date` DESC LIMIT $quantityOfReviews";
		// var_dump($this->dataBase->getRows($sql, null));
		return $this->dataBase->getRows($sql, null);
	}

	public function getReviewById($id) {
		$whereObject = [
			'id' => $id
		];
		return $this->dataBase->uniSelect($this->reviewsTable, $whereObject);
	}

	public function createReview($name, $comment, $rate) {
		$object = [
			'name' => $name,
			'comment' => $comment,
			'rate' => $rate
		];
		// $sql = "INSERT INTO `reviews`(`name`, `comment`, `rate`) VALUES ('$name', '$comment', '$rate')";
		return $this->dataBase->uniInsert($this->reviewsTable, $object);
	}

	public function updateReview($id, $name, $comment) {
		$object = [
			'name' => $name,
			'comment' => $comment
		];
		$whereObject = [
			'id' => $id
		];
		// $sql = "UPDATE `reviews` SET `name`='$name',`comment`='$comment' WHERE `id` = $id";
		return $this->dataBase->uniUpdate($this->reviewsTable, $object, $whereObject);
	}

	public function deleteReview($id) {
		$whereObject = [
			'id' => $id
		];
		// $sql = "DELETE FROM `reviews` WHERE `id` = $id";
		return $this->dataBase->uniDelete($this->reviewsTable, $whereObject);
	}
}
?>