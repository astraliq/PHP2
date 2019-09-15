<?php


function getReviews()
{

	$sql = "SELECT * FROM reviews ORDER BY `id` DESC";

	return getAssocResult($sql);
}

function showReview($id)
{
	$id = (int)$id;
	$sql = "SELECT * FROM reviews WHERE id = $id";
	return show($sql);
}

function renderReviews($login) {
	$revList = getReviews();
	$revArray = [];
	$counter = 1;
	$getAction = NULL;
	$getID = NULL;
	$changeReview = '';
	$deleteReview = '';

	if ($login === 'admin') {
		$changeReview = '<a href="index.php?action=change&id={{ID}}" class="review_action">Изменить</a>';
		$deleteReview = '<a href="index.php?action=delete&id={{ID}}" class="review_action">Удалить</a>';
	}

	if (isset($_GET["action"])) {
		$getAction = $_GET["action"];
	}

	if (isset($_GET["id"])) {
		$getID = $_GET["id"];
	}

	foreach ($revList as $key => $rev) {
		if ($getAction === 'change' && $getID === $rev["id"] && $login === 'admin') {
			$revArray[] = render(TEMPLATES_DIR . 'review_change.tpl', $variables = [
				'changeReview' => $changeReview,
				'deleteReview' => $deleteReview,
				'id' => $rev["id"],
				'name' => $rev["name"],
				'rate' => $rev["rate"],
				'comment' => $rev["comment"],
				'date' => $rev["date"]
			]);
		} else {
			$revArray[] = render(TEMPLATES_DIR . 'reviews.tpl', $variables = [
				'changeReview' => $changeReview,
				'deleteReview' => $deleteReview,
				'id' => $rev["id"],
				'name' => $rev["name"],
				'rate' => $rev["rate"],
				'comment' => $rev["comment"],
				'date' => $rev["date_change"] != null ? $rev["date_change"] : $rev["date"]
			]);
		}
		


		if ($counter > 4) {
			break;
		}
		$counter++;
	};

	return implode(' ', $revArray);
}


function createReview($name, $comment, $rate)
{
	$link = createConnection();

	$author = mysqli_real_escape_string($link, (string)htmlspecialchars(strip_tags($name)));
	$text = mysqli_real_escape_string($link, (string)htmlspecialchars(strip_tags($comment)));
	$rate = (int)$rate;

	$sql = "INSERT INTO `reviews`(`name`, `comment`, `rate`) VALUES ('$author', '$text', '$rate')";

	$result = mysqli_query($link, $sql);

	mysqli_close($link);
	header("Location: /contacts/");
	return $result;
}

function updateReview($id, $name, $comment)
{
	$link = createConnection();

	$id = (int)$id;
	$name = mysqli_real_escape_string($link, (string)htmlspecialchars(strip_tags($name)));
	$comment = mysqli_real_escape_string($link, (string)htmlspecialchars(strip_tags($comment)));

	$sql = "UPDATE `reviews` SET `name`='$name',`comment`='$comment' WHERE `id` = $id";

	$result = mysqli_query($link, $sql);
	mysqli_close($link);
	header("Location: /contacts/");
	return $result;
}

function deleteReview($id)
{
	$id = (int)$id;

	$sql = "DELETE FROM `reviews` WHERE `id` = $id";
	header("Location: /contacts/");
	return execQuery($sql);
}