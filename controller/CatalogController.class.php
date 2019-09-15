<?php
class CatalogController extends Controller {
    public $title = '';
    public $mainTitle;
    public $pageName;
    public $model;
    
    public function __construct() {
        parent::__construct();
        $this->model = new CatalogModel();
    }

	public function index($data) {
		$this->title = 'Каталог товаров';
		$this->mainTitle .= ' | Каталог';
		$this->pageName = 'catalog';
		$arrayContent = [
			'productsFromVue' => CatalogModel::$productsFromVue,
		];
		return $arrayContent;			
	}

	public function show($data) {
		$this->pageName = 'item';
		$this->mainTitle .= ' | Каталог';
		$product = CatalogModel::getProduct($data['id']);
		$this->title = $product['title'];
		return $product;			
	}
	
	public function change($data) {
		if ($_SESSION['login'] != 'admin') {
			parent::redirectToMain();
		}
		$this->pageName = 'createProduct';
		$this->mainTitle .= ' | Изменение товара';
		$this->title = 'Изменение товара';
		$product = [
			'product' => CatalogModel::getProduct($data['id']),
			'button' => 'Изменить товар',
			'method' => 'change',
		];
		
		return $product;			
	}

	public function add($data) {
		if ($_SESSION['login'] != 'admin') {
			parent::redirectToMain();
		}
		$this->pageName = 'createProduct';
		$this->mainTitle .= ' | Добавление товара';
		$this->title = 'Добавление товара';
		$product = [
			'product' => NULL,
			'button' => 'Добавить товар',
			'method' => 'add',
		];
		
		return $product;			
	}
}

?>