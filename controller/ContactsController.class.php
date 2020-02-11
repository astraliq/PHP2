<?php
class ContactsController extends Controller {
    public $title;
    public $mainTitle;
    public $pageName = 'contacts';
    public $reviewsModel;
    
    public function __construct() {
        parent::__construct();
        $this->reviewsModel = new ReviewsModel();
    } 

	public function index($data) {
		$this->title = 'Контакты и отзывы';
		$this->mainTitle .= ' | Контакты и отзывы';
		$this->pageName = 'contacts';
		$content = [
			'reviews' => $this->reviewsModel->getLastReviews(20),
			'reviewsFromVue' => $this->reviewsModel->reviewsFromVue,
		];
		return $content;
	}

}

?>