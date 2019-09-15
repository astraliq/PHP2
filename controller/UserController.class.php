<?php
class UserController extends Controller {
    public $title;
    public $mainTitle;
    public $pageName = 'login';
    public $model;
    
    public function __construct() {
        parent::__construct();
        $this->model = new UserModel();
    } 

	public function index($data) {
		// parent::redirectToMain();
		return $data;			
	}

	public function login($data) {
		if ($_SESSION) {
			parent::redirectToMain();
		}
		$this->pageName = 'login';
		$this->mainTitle .= ' | Авторизация';
		$this->title = 'Вход';
		return $data;			
	}

	public function reg($data) {
		if ($_SESSION) {
			parent::redirectToMain();
		}
		$this->pageName = 'reg';
		$this->mainTitle .= ' | Регистрация';
		$this->title = 'Регистрация';
		return $data;			
	}

	public function logout($data) {
		session_destroy();
		header("Location: /index.php?path=user/login");			
	}

	public function createorder($data) {
		if (!$_SESSION) {
			parent::redirectToLogin();
		}
		$this->pageName = 'createOrder';
		$this->mainTitle .= ' | Формирование заказа';
		$this->title = 'Профиль';
		$arrayCart = [];
		
		return $arrayCart;			
	}
}

?>
