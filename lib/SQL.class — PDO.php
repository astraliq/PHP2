<?php
require_once __DIR__ . '/../autoload.php';
	class SQL {
		private static $instance;
		
		public static function getInstance() {
			
			if (self::$instance == null) {
				setlocale(LC_ALL, 'ru_RU.UTF8');
				// var_dump(Config::get('db_driver') . ':host='. Config::get('db_host') . ';dbname=' . Config::get('db_base'), Config::get('db_user'), Config::get('db_pass'));

				self::$instance = new PDO('mysql:host=localhost;dbname=allsmarts', 'adminPDO', '');

				// self::$instance = mysqli_connect('localhost', 'admin', 'admin', 'allsmarts');
				// mysqli_query($this->instance,'set names utf-8');

				// self::$instance->exec('SET NAMES UTF8');
				// self::$instance->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
			}
			return self::$instance;
		}
		
		private static function sql($sql,$args) {
			$stmt = self::getInstance()->prepare($sql);
			$stmt->execute($args);
			return $stmt;
		}
	   	/*
	     * Запрещаем копировать объект
	     */
	    private function __construct() {}
	    private function __sleep() {}
	    private function __wakeup() {}
	    private function __clone() {}

		public static function getRows($sql, $args) {
			return self::sql($sql, $args)->fetchAll();
		}

		public static function getRow($sql, $args) {
			return self::sql($sql, $args)->fetch();
		}

		public static function insert($sql, $args) {
			return self::sql($sql, $args)->lastInsertId();
		}

		public static function update($sql, $args) {
			return self::sql($sql, $args)->rowCount();
		}

		public static function delete($sql, $args) {
			return self::sql($sql, $args)->rowCount();
		}

		// Универсальный select ------------  (проверить на HTML инъекции)
		public function uniSelect($table, $where_key = false, $where_value = false, $fetchAll = false) {
			
			if ($where_key AND $where_value) {
				$query = "SELECT * FROM " . $table . " WHERE " . $where_key . " = '" . $where_value . "'";
			} else {
				$query = "SELECT * FROM " . $table;
			}

			if ($where_key AND $where_value) {
				return self::getRow($query,null);
			} else {
				return self::getRows($query,null);
			}
		}

		public function selectWhereValues($table, $where_key, $where_values) {
			$query = "SELECT * FROM " . $table . " WHERE " . $where_key . " IN (" . implode(', ', $where_values) . ")";
			return self::getRows($query,null);
		}
		
		public function uniInsert($table, $object) {
			
			$columns = array();
			
			foreach ($object as $key => $value) {
			
				$columns[] = $key;
				$masks[] = ":$key";
				
				if ($value === null) {
					$object[$key] = 'NULL';
				}
			}
			
			$columns_s = implode(',', $columns);
			$masks_s = implode(',', $masks);
			
			$query = "INSERT INTO $table ($columns_s) VALUES ($masks_s)";
			
			return self::insert($query, $object);
		}
		
		public function uniUpdate($table, $object, $where) {
			
			$sets = array();
			 
			foreach ($object as $key => $value) {
				
				$sets[] = "$key=:$key";
				
				if ($value === NULL) {
					$object[$key]='NULL';
				}
			 }
			 
			$sets_s = implode(',',$sets);
			$query = "UPDATE $table SET $sets_s WHERE $where";

			return self::update($query, $object);
		}
		
		// ------------  (проверить на HTML инъекции)
		public function uniDelete($table, $where) {
			
			$query = "DELETE FROM $table WHERE $where";
			return self::delete($query, null);
		}

		// шифрование пароля
		public function cryptPassword ($name, $password) {
			return strrev(md5($name)) . md5($password);
		}
	}
?>