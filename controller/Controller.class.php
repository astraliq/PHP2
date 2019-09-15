<?php
class Controller {
	public $view = 'index';
    public $mainTitle;
    public $mainMenu;
    public $model;

    public function __construct() {
        $this->mainTitle = Config::get('sitename');
        $this->mainMenu = Config::get('mainMenu');
        $this->model = new Model();
    }

    public function redirectToMain() {
		$this->model->redirectToMainPage();
	}

    public function redirectToLogin() {
		$this->model->redirectToLogin();
	}

    public function checkUser($userLogin) {
		if (empty($userLogin)) {
			return false;
		}
		return true;			
	}

	public function showMenu() {
		return $this->model->getMenu($this->mainMenu);			
	}

}
?>