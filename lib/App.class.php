<?PHP
class App {
	public static function Init() {
		/*установка часового пояса*/	
		date_default_timezone_set('Europe/Moscow');
		if (isset($_SERVER) && !empty($_POST)) {
			self::api($_POST);		
		}
		if (isset($_SERVER) && isset($_GET)) {
			self::web(isset($_GET['path']) ? $_GET['path'] : '');		
		}
	}
	
	//http://site.ru/index.php?path=news/edit/5
	protected function web($url) {
		/*парсинг строки*/
		$url=explode("/",$url);
		if (!empty($url[0]))
			{
			$_GET['page']=$url[0];//часть имени контроллера
			if (isset($url[1]))
				{
				if (is_numeric($url[1]))
					{
					$_GET['id']=$url[1];
					}
				else
					{
					$_GET['action']=$url[1];	
					}	
				if (isset($url[2]))	
					$_GET['id']=$url[2];
				}				
			}
		else {
			$_GET['page']='Index';	
		}	
		//$_GET['page']='Index';	
		/*парсинг строки*/	
		/*поиск контролера*/
		if (isset($_GET['page'])) {
			$controllerName=ucfirst($_GET['page'])."Controller";
		//	echo ($controllerName)."<br>";
			$methodName=isset($_GET['action'])?$_GET['action']:'index';
		//	echo ($methodName)."<br>";
			$controller=new $controllerName(); //создаем контролер класса с указанным именем
		/*поиск контролера*/	
		/*формирование контроллером данных для шаблона*/	
			$data=[
					'content' => $controller->$methodName($_GET),
					'mainTitle' => $controller->mainTitle, 
					'head' => $controller->headcontent,
					'title' => $controller->title,
					'linkupdir' => '',
					'menu' => $controller->showMenu(),
					'pagename' => $controller->pageName,
					'userCheck'=> $controller->checkUser($_SESSION['login']),   //проверка юзера
					'user'=> $_SESSION['login'],
			];
		/*формирование контроллером данных для шаблона*/		
		/*вытаскинвание из контроллера название шаблона и подгрузка twig*/	
			$view=$controller->view.'.tpl';
			$loader=new Twig_Loader_Filesystem('../templates');
			$twig= new Twig_Environment($loader);
			$template=$twig->loadtemplate($view);
			echo $template->render($data);	
		/*вытаскинвание из контроллера название шаблона и подгрузка twig c отрисовкой страницы с посланными данными*/					
		}
		
	}	

	protected function api($post) {

		if (isset($post['apiMethod'])) {
			$methodName = $post['apiMethod'];
			$model = new ApiMethod($post); //создаем модуль класса api
			$data = $model->$methodName($post); 
			
			header('Content-Type: application/json');
			echo json_encode($data);
			exit();	
		} else {
			header('Content-Type: application/json');
			echo json_encode([
				'error' => true,
				'error_text' => 'Не передан api метод!',
				'data' => null
			]);
			exit();
		}
	}
}

?>
