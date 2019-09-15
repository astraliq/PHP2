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

		$loginId = $_SESSION['id'] ?? NULL;
		$this->pageName = 'createOrder';
		$this->mainTitle .= ' | Формирование заказа';
		$this->title = 'Формирование заказа';
		$arrayCart = OrderModel::getCartForOrderList($loginId);
		return $arrayCart;			
	}

	public function userprofile($data) {
		if (!$_SESSION) {
			parent::redirectToLogin();
		}
		$login = $_SESSION['login'] ?? NULL;
		$loginId = $_SESSION['id'] ?? NULL;
		if ($login === 'admin') {
			$this->title = 'Управление заказами';
		} else {
			$this->title = 'Мои заказы';
		}
		$this->pageName = 'userprofile';
		$this->mainTitle .= ' | Личный кабинет';
		$content = [
			'orders' => OrderModel::getOrdersById($loginId),
			'productsInOrders' => OrderModel::getProductsByOrder(),
			'history' => 'История',
		];
		return $content;			
	}
}

?>
