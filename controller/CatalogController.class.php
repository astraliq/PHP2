<?php
class CatalogController extends Controller {
    public $title = 'Каталог товаров';
    public $mainTitle;
    public $pageName = 'catalog';
    public $model;
    
    public function __construct() {
        parent::__construct();
        $this->mainTitle .= ' | Каталог';
        $this->model = new CatalogModel();
    }

	public function index($data) {
		$login = NULL;
		if (isset($_SESSION['login'])) {
			$login = $_SESSION['login'];
		}
		if ($login === 'admin') {
			$addProduct = '<a href="index.php?path=catalog/add">Добавить товар в каталог</a>';
		} else {
			$addProduct = '';
		}	
		$productsFromVue = CatalogModel::$productsFromVue;
		$arrayContent = [
			'productsFromVue' => $productsFromVue,
			'addProduct' => $addProduct
		];
		return $arrayContent;			
	}

	public function sort($data) {
		// $products=db::getInstance()->getProductsRange('product',[0,6]);
		// if (!$products)
		// 	{
		// 	  echo "Нет доступа к БД";	
		// 	}	
		return 	$data;			
	}
	
}

?>


