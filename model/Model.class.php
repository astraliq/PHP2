<?php
class Model {
	public $dataBase;

	public function __construct() {
		$this->dataBase = SQL::getInstance();
    }

	public function get_data() {
	}

	public function redirectToMainPage() {
		header("Location: /index.php");
	}

	public function redirectToLogin() {
		header("Location: /index.php?path=user/login");
	}

	public function redirectToCreateOrder() {
		header("Location: /index.php?path=user/createorder");
	}

	public function getMenu($menu) {
		$i = '';
		$menuText = '<ul class="menu' . $i . '">';
		foreach ($menu as $key => $val) {
			$menuText .= '<li><a href="' . $val['link'] . '">' . $val['title'] . '</a>';
			if (!empty($val['children'])) {
				$menuText .= $this->getMenu($val['children'], $i);
			}
			$menuText .= '</li>';
		}
		$menuText .= '</ul>';
		return $menuText;
	}
}
?>