<?php
class ProductController extends Controller {
    public $title;
    public $mainTitle;
    public $pageName = 'productPage';

    public function __construct() {
        parent::__construct();
        $this->mainTitle .= ' | Каталог';
        $this->title = 'Страница товара';
    } 

	public function index($data) {
		$product=SQL_Product::getProduct($data['id']);
		if (!$product) {
			  echo "Нет доступа к БД";	
			}	
		return $product;			
	}
}

?>