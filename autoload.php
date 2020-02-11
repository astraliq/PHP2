<?PHP
require_once ("vendor/autoload.php");
// Twig_Autoloader::register();

spl_autoload_register("NewStandarAutoloader");
function NewStandarAutoloader ($className) {
	$dirs = ['controller',
		   'model',
		   'lib'];
	$found = false;
    foreach($dirs as $dir) {
			$filename = __DIR__ . '/' . $dir . '/' . $className . '.class.php';
			//echo $filename."<br>";
			if (is_file($filename)) {
				require_once ($filename);
				$found = true;
			}
	
		}
	if (!$found) {	
		throw new Exception('Error! Class ' . $className . ' not found in the directories!');
	}	
	return true;	
}

?>
