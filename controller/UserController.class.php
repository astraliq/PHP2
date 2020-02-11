<?php
class UserController extends Controller {
    public $title;
    public $mainTitle;
    public $pageName = 'login';
    public $userModel;
    
    public function __construct() {
        parent::__construct();
        $this->userModel = new UserModel();
    } 

	public function index($data) {
		// parent::redirectToMain();
		return $data;			
	}

	public function login($data) {
		if (!empty($_SESSION['user'])) {
			parent::redirectToMain();
		}
		$this->pageName = 'login';
		$this->mainTitle .= ' | Авторизация';
		$this->title = 'Вход';
		return $data;			
	}

	public function reg($data) {
		if (!empty($_SESSION['user'])) {
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
		if (empty($_SESSION['user'])) {
			parent::redirectToLogin();
		}

		$loginId = $_SESSION['user']['id'] ?? NULL;
		$this->pageName = 'createOrder';
		$this->mainTitle .= ' | Формирование заказа';
		$this->title = 'Формирование заказа';
		$orderModel = new OrderModel();
		$arrayCart = $orderModel->getCartForOrderList($loginId);
		return $arrayCart;			
	}

	public function userprofile($data) {
		if (empty($_SESSION['user'])) {
			parent::redirectToLogin();
		}
		$this->userModel->deleteUser('testUser');
		$btnOrderName = 'Мои заказы';
		$login = $_SESSION['user']['login'] ?? NULL;
		$loginId = $_SESSION['user']['id'] ?? NULL;
		if ($login === 'admin') {
			$btnOrderName = 'Управление заказами';
		}
		$this->title = 'Личный кабинет';
		$this->pageName = 'userprofile';
		$this->mainTitle .= ' | Личный кабинет';
		$orderModel = new OrderModel();
		$content = [
			'orders' => $orderModel->getOrdersById($loginId),
			'productsInOrders' => $orderModel->getProductsByOrder($loginId),
			'history' => $this->userModel->getPagesOfUserHistory($loginId),
			'btn_order_name' => $btnOrderName
		];
		return $content;			
	}
}

?>
