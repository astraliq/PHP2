<?php
class CatalogController extends Controller {
    public $title = '';
    public $mainTitle;
    public $pageName;
    public $catalogModel;
    
    public function __construct() {
        parent::__construct();
        $this->catalogModel = new CatalogModel();
    }

	public function index($data) {
		$this->title = 'Каталог товаров';
		$this->mainTitle .= ' | Каталог';
		$this->pageName = 'catalog';
		$arrayContent = [
			'productsFromVue' => $this->catalogModel->productsFromVue,
		];
		return $arrayContent;			
	}

	public function show($data) {
		$this->pageName = 'item';
		$this->mainTitle .= ' | Каталог';
		$product = $this->catalogModel->getProduct($data['id']);
		$this->title = $product['title'];
		return $product;			
	}
	
	public function change($data) {
		if ($_SESSION['user']['login'] != 'admin') {
			parent::redirectToMain();
		}
		$this->pageName = 'createProduct';
		$this->mainTitle .= ' | Изменение товара';
		$this->title = 'Изменение товара';
		$product = [
			'product' => $this->catalogModel->getProduct($data['id']),
			'button' => 'Изменить товар',
			'method' => 'change',
		];
		
		return $product;			
	}

	public function add($data) {
		if ($_SESSION['user']['login'] != 'admin') {
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