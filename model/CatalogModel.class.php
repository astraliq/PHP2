<?php
	class CatalogModel extends Model {

		public $product_id, $product_image, $product_title, $product_content, $product_price;
		public static $productsFromVue = '<products ref="products"></products>';


		public function getAllProducts() {
			return parent::uniSelect('products', false, false, true);
		}

		public function getProduct($product_id) {
			return parent::uniSelect('products', 'id', $product_id);
		}

		public function getProductsByIds($ids) {
			return parent::selectWhereValues('products', 'id', $ids);
		}

		public function deleteProduct($productId) {
			$productId = (int) $productId;
			$where = "`products`.`id` = $productId";
			return parent::uniDelete('products', $where);
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
			$title = escapeString($db, $title);
			$description = escapeString($db, $description);
			$price = (float) $price;
			$array = [
				'title' => $title,
				'category' => $categoryId,
				'description' => $description,
				'price' => $price,
				'img' => $fileName
			];
			return parent::uniInsert('products', $array);
		}

		public function changeProduct($productId, $title, $description, $price, $file) {
			/*$productId = (int) $productId;
			$check = getAssocResult("SELECT * FROM `products` WHERE `id` = $productId");
			if ($check) {
				if($file) {
					$fileName = loadFile('image', 'img/img_phones/');
				} else {
					$fileName = 'default.png';
				}

				//создаем соединение с БД
				$db = createConnection();
				//Избавляемся от всех инъекций в $title и $content
				$title = escapeString($db, $title);
				$description = escapeString($db, $description);
				$price = (float) $price;
				//генерируем SQL добавления в БД

				$sql = empty($file) 
				? "UPDATE `products` SET `title`= '$title', `description`= '$description', `price`= $price WHERE `id` = $productId"
				: "UPDATE `products` SET `title`= '$title', `description`= '$description', `price`= $price, `img`= $fileName, WHERE `id` = $productId";
				//выполняем запрос
				return execQuery($sql);
			}*/
		}
	}
?>