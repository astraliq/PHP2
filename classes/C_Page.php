<?php
//
// include_once('m/model.php');

class C_Page extends C_Base {
	//
	public function __construct($head, $mainMenu, $login) {
        parent::__construct($head, $mainMenu, $login);
    }

	public function action_index(){
		$this->title = '';
		$this->mainTitle .= '';
		$this->content = $this->Template(TEMPLATES_DIR . 'main_page.tpl');
		$this->headcontent = $this->Template(TEMPLATES_DIR . $this->head, [
			'login' => $this->login,
		]);	
	}
	
    /*
	public function action_edit(){
		$this->title .= '::EDIT';
		
		if($this->isPost())
		{
			text_set($_POST['text']);
			header('location: index.php');
			exit();
		}
		
		$text = text_get();
		$this->content = $this->Template('v/v_edit.php', array('text' => $text));		
	}
	*/
}
