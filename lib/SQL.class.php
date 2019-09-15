<?php
	class SQL {
		private static $instance = null;
		private $connect;

		public static function getInstance() {
	        if (self::$instance == null) {
	            self::$instance = new SQL();
	        }
	        return self::$instance;
	    }
		
		private function __construct() {
			setlocale(LC_ALL,'Ru_ru.utf-8');
			$this->connect = mysqli_connect('localhost', 'admin', 'admin', 'allsmarts');
			mysqli_query($this->connect,'set names utf-8');	
		}
	   	/*
	     * Запрещаем копировать объект
	     */
	    private function __sleep() {}
	    private function __wakeup() {}
	    private function __clone() {}

		public function execQuery($query) {
			$result = mysqli_query($this->connect,$query);
			// mysqli_close($db);
			return $result;
		}

		public function getLastInsertId($table) {
			$sql = "SELECT LAST_INSERTED_ID FROM `$table`";
			return self::sqlGetOne($sql);
		}

	    public function sqlGetArray($query) {
			$result=mysqli_query($this->connect,$query);
			if(!$result) {
				die(mysqli_error($this->connect));
			}
			$array_result = [];
			while ($row = mysqli_fetch_assoc($result)) {
				$array_result[] = $row;
			}
			return $array_result;
		}

		public function sqlGetOne($query) {
			$result = self::sqlGetArray($query);
			if(empty($result)) {
				return null;
			}
			return $result[0];
		}

		//избавляемся от sql и html инъекций
		public function escapeString($string) {
			return mysqli_real_escape_string(
				$this->connect,
				(string)htmlspecialchars(strip_tags($string))
			);
		}

		// Универсальный select ------------  (проверить на HTML инъекции)
		public function uniSelect($table, $where_key = false, $where_value = false, $fetchAll = false) {
			
			if ($where_key AND $where_value) {
				if (is_numeric($where_key)) {
					$where_key = self::escapeString($where_key);
				}
				if (is_numeric($where_value)) {
					$where_value = self::escapeString($where_value);
				}
				$query = "SELECT * FROM `$table` WHERE `$where_key` = '$where_value'";
				
			} else {
				$query = "SELECT * FROM  `$table`";
			}

			if ($fetchAll) {
				return self::sqlGetArray($query);
			} else {
				return self::sqlGetOne($query);
			}
		}

		public function selectWhereValues($table, $where_key, $where_values) {
			$query = "SELECT * FROM `$table`  WHERE `$where_key` IN ( implode(', ', $where_values) )";
			return self::sqlGetArray($query);
		}
		
		public function uniInsert($table, $object) {
			
			$columns = array();
			
			foreach ($object as $key => $value) {
				if (is_numeric($key)) {
					$key = self::escapeString($key);
				}
				if (is_numeric($value)) {
					$value = self::escapeString($value);
				}

				$columns[] = $key;
				$masks[] = $value;
				
				if ($value === null) {
					$object[$key] = 'NULL';
				}
			}
			
			$columns_s = implode(', ', $columns);
			$masks_s = "' " . implode("', '", $masks) . " '";
			
			$query = "INSERT INTO `$table` ($columns_s) VALUES ($masks_s)";
			return self::execQuery($query);
		}
		
		public function uniUpdate($table, $object, $where) {
			
			$sets = array();
			 
			foreach ($object as $key => $value) {
				if (is_numeric($key)) {
					$key = self::escapeString($key);
				}
				if (is_numeric($value)) {
					$value = self::escapeString($value);
				}

				$sets[] = "$key = $value";
				
				if ($value === NULL) {
					$object[$key]='NULL';
				}
			 }
			 
			$sets_s = implode(', ', $sets);
			$query = "UPDATE `$table` SET $sets_s WHERE $where";

			return self::execQuery($query);
		}
		
		// ------------  (проверить на HTML инъекции)
		public function uniDelete($table, $where) {
			
			$query = "DELETE FROM `$table` WHERE $where";
			return self::execQuery($query);
		}

		// шифрование пароля
		public function cryptPassword ($name, $password) {
			return strrev(md5($name)) . md5($password);
		}
	}
?>