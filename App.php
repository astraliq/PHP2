<?PHP
require ("autoload.php");
try {
	App::init();	
	}
catch (Exception $e)
	{
	echo $e->getMessage();
	}
 ?>