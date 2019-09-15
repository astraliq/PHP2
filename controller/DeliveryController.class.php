<?php
class DeliveryController extends Controller {
    public $title = 'Доставка и оплата';
    public $mainTitle;
    public $mainMenu;
    public $pageName = 'delivery';

    public function __construct() {
        parent::__construct();
        $this->mainTitle .= ' | Доставка и оплата';
    } 

	public function index($data) {
		return 	'';			
	}
	
}