<?php
include ('../config/config.default.php');
class db {
    private static $_instance = null;
    private $connect;

    private $db; // Ресурс работы с БД

    /*
     * Получаем объект для работы с БД
     */
    public static function getInstance()
    {
        if (self::$_instance == null) {
            self::$_instance = new db();
        }
        return self::$_instance;
    }


	/*
    * Выполняем соединение с базой данных
    */ 
    private function __construct() 
	{
		$config['db_user'] = 'root';
		$config['db_pass'] = '';
		$config['db_base'] = 'shopDZ';
		$config['db_host'] = 'localhost';
		$config['db_charset'] = 'UTF-8';
		setlocale(LC_ALL,'Ru_ru.utf-8');
		$this->connect=mysqli_connect($config['db_host'],$config['db_user'],$config['db_pass'],$config['db_base']);
		mysqli_query($this->connect,'set names utf-8');	
	}
	
	/*
    * Запрещаем копировать объект
    */
	
    private function __sleep() {}
    private function __wakeup() {}
    private function __clone() {}

    /*
     * Выполняем соединение с базой данных
     */
 /*   public function Connect($user, $password, $base, $host = 'localhost', $port = 3306)
    {
   
        $connectString = 'mysql:host=' . $host . ';port= ' . $port . ';dbname=' . $base . ';charset=UTF8;';
        $this->db = new PDO($connectString, $user, $password,
            [
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // возвращать ассоциативные массивы
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION // возвращать Exception в случае ошибки
            ]
        );
    }*/

    /*
     * Выполнить запрос к БД
     */
   /* public function Query($query, $params = array())
    {
        $res = $this->db->prepare($query);
        $res->execute($params);
        return $res;
    }*/

    /*
     * Выполнить запрос с выборкой данных
     */
    /*public function Select($query, $params = array())
    {
        $result = $this->Query($query, $params);
        if ($result) {
            return $result->fetchAll();
        }
    }*/
	public function getProductsRange($table,$indexArr) {
		$first = (int)$indexArr[0];
		$last = (int)$indexArr[1];
		$table=mysqli_real_escape_string($this->connect, $table);
		$sql="SELECT * FROM %s WHERE id BETWEEN %d AND %d";
		$query=sprintf($sql,$table,$first,$last);
		$res=mysqli_query($this->connect,$query);
		if(!$res)
			die(mysqli_error($this->connect));
		$t=mysqli_num_rows($res);
		$products=[];
		for($i=0;$i<$t;$i++)
		{
		 $products[]=mysqli_fetch_assoc($res);		
		}	
		//print_r($products);
		return $products;		
	}	
	public function getProductsColl($table,$indexStr) {
		print_r($table);
		print_r($indexStr);
		$table=mysqli_real_escape_string($this->connect, $table);
		$indexStr=mysqli_real_escape_string($this->connect, $indexStr);
		if (strlen($indexStr)==1)
			{
			$sql="SELECT * FROM %s WHERE id=%s";
			}
		else
			{
			$sql="SELECT * FROM %s WHERE id in(%s)";	
			}
			
		$query=sprintf($sql,$table,$indexStr);
		$res=mysqli_query($this->connect,$query);
		if(!$res)
			die(mysqli_error($this->connect));
		$t=mysqli_num_rows($res);	
		$productList=[];
		for($i=0;$i<$t;$i++)
		{
			$productList[]=mysqli_fetch_assoc($res);	
		}
		return $productList;		
	}	
	
	public function getProduct($table,$id) {
		$id = (int)$id;
		$table=mysqli_real_escape_string($this->connect, $table);
		$sql="SELECT * FROM %s WHERE id='%d'";
		$query=sprintf($sql,$table,$id);
		$res=mysqli_query($this->connect,$query);
		if(!$res)
			die(mysqli_error($this->connect));
		$t=mysqli_num_rows($res);
		$product=[];
		$product[]=mysqli_fetch_assoc($res);
		//print_r($products);
		return $product;		
	}
}

?>