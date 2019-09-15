<?php
	class CatalogModel extends Model {

		public static $productsFromVue = '<products ref="products"></products>';


		public function getAllProducts() {
			return SQL::getInstance()->uniSelect('products', false, false, true);
		}

		public function getProduct($product_id) {
			return SQL::getInstance()->uniSelect('products', 'id', $product_id);
		}

		public function getProductsByIds($ids) {
			return SQL::getInstance()->selectWhereValues('products', 'id', $ids);
		}

		public function deleteProduct($productId) {
			$productId = (int) $productId;
			$where = "`products`.`id` = $productId";
			return SQL::getInstance()->uniDelete('products', $where);
		}

		// добавление товара-------------------
		public function insertProduct($title, $category, $description, $price, $file) {
			if($file) {
				$fileName = loadFile('image', 'img/img_phones/');
			} else {
				$fileName = 'default.png';
			}

			$categoryId = $category ?? 1;
			//Избавляемся от всех инъекций в $title и $content
			$title = SQL::getInstance()->escapeString($title);
			$description = SQL::getInstance()->escapeString($description);
			$price = (float) $price;
			$array = [
				'title' => $title,
				'category' => $categoryId,
				'description' => $description,
				'price' => $price,
				'img' => $fileName
			];
			return SQL::getInstance()->uniInsert('products', $array);
		}

		public function changeProduct($productId, $title, $description, $price, $file) {
			$productId = (int) $productId;
			$check = SQL::getInstance()->execQuery("SELECT * FROM `products` WHERE `id` = $productId");
			if ($check) {
				if($file) {
					$fileName = loadFile('image', 'img/img_phones/');
				} else {
					$fileName = 'default.png';
				}

				//Избавляемся от всех инъекций в $title и $content
				$title = SQL::getInstance()->escapeString($title);
				$description = SQL::getInstance()->escapeString($description);
				$price = (float) $price;
				//генерируем SQL добавления в БД

				$sql = empty($file) 
				? "UPDATE `products` SET `title`= '$title', `description`= '$description', `price`= $price WHERE `id` = $productId"
				: "UPDATE `products` SET `title`= '$title', `description`= '$description', `price`= $price, `img`= $fileName, WHERE `id` = $productId";
				//выполняем запрос
				return SQL::getInstance()->execQuery($sql);
			}
		}
	}
?>