<?PHP
require ("autoload.php");
try {
	$app = new App();	
	$app->init();
	}
catch (Exception $e)
	{
	echo $e->getMessage();
	}
 ?>