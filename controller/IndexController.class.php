<?php
class IndexController extends Controller {
    public $title = '';
    public $mainTitle;
    public $pageName = 'main_page';

    public function __construct() {
        parent::__construct();
        $this->mainTitle .= ' | Главная';
    } 

	public function index($data) {
		// $products=db::getInstance()->getProductsRange('product',[0,3]);
	
		return 	$data;			
	}
	
}