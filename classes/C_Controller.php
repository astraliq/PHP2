<?php////abstract class C_Controller{	// Ãåíåðàöèÿ âíåøíåãî øàáëîíà	protected abstract function render();		// Ôóíêöèÿ îòðàáàòûâàþùàÿ äî îñíîâíîãî ìåòîäà	protected abstract function before();		public function Request($action)	{		$this->before();		$this->$action();   //$this->action_index		$this->render();	}		//	// Çàïðîñ ïðîèçâåäåí ìåòîäîì GET?	//	protected function IsGet()	{		return $_SERVER['REQUEST_METHOD'] == 'GET';	}	//	// Çàïðîñ ïðîèçâåäåí ìåòîäîì POST?	//	protected function IsPost()	{		return $_SERVER['REQUEST_METHOD'] == 'POST';	}	//	// Шаблонизация.	//	protected function Template($file, $variables = []) {		if (!is_file($file)) {			echo 'Template file "' . $file . '" not found';			exit();		}		if (filesize($file) === 0) {			echo 'Template file "' . $file . '" is empty';			exit();		}		$templateContent = file_get_contents($file);		foreach ($variables as $key => $value) {			$key = '{{' . strtoupper($key) . '}}';			$templateContent = str_replace($key, $value, $templateContent);		}		return $templateContent;	}		// Обработка ошибок	public function __call($name, $params){        die('Ошибка!!! Метод отсутствует.');	}}