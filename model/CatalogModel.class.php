<?php
	class CatalogModel extends Model {
		public $productsTable = 'products';
		public $productsFromVue = '<products ref="products"></products>';

		public function __construct() {
			parent::__construct();
	    }

		public function getProductsByParams($params, $order, $limit, $sort) {
			return $this->dataBase->uniSelectOrderLimitSort($this->productsTable, $params, $order, $limit, $sort);
		}

		public function getProduct($product_id) {
			$whereObject = [
				'id' => $product_id
			];
			return $this->dataBase->uniSelect($this->productsTable, $whereObject);
		}

		public function getProductsByIds($ids) {
			$whereObj = [
				'id' => null
			];
			return $this->dataBase->selectWhereValues($this->productsTable, $whereObj, $ids);
		}

		public function deleteProduct($productId) {
			$whereObject = [
				'id' => $productId
			];
			return $this->dataBase->uniDelete($this->productsTable, $whereObject);
		}

		// добавление товара-------------------
		public function insertProduct($title, $category, $description, $price, $file) {
			$fileHandler = new FileHandler();
			if($file) {
				$fileName = $fileHandler->loadFile('image', '/img/img_phones/');
			} else {
				$fileName = 'default.png';
			}

			$categoryId = $category ?? 1;
			$object = [
				'title' => $title,
				'category' => $categoryId,
				'description' => $description,
				'price' => $price,
				'img' => $fileName
			];
			return $this->dataBase->uniInsert($this->productsTable, $object);
		}

		public function changeProduct($productId, $title, $description, $price, $file) {
			$whereObject = [
				'id' => $productId
			];
			$check = $this->dataBase->uniSelect($this->productsTable, $whereObject);
			if ($check) {
				$object = [
					'title' => $title,
					'description' => $description,
					'price' => $price
				];
				if(!is_null($file)) {
					$newImage = new FileHandler();
					$fileName = $newImage->loadFile('image', '/img/img_phones/');
					$imgObject = ['img' => $fileName];
					$object = array_merge($object, $imgObject);
				};

				return $this->dataBase->uniUpdate($this->productsTable, $object, $whereObject);
			}
		}
	}
?>