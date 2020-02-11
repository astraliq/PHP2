<?php
	class SQL {
		protected static $instance = null;
		private $dataBase;
		
		public static function getInstance() {
			if (self::$instance == null) {
				self::$instance = new SQL();
			}
			return self::$instance;
		}
		
		public function __construct() {
			setlocale(LC_ALL, 'ru_RU.UTF8');
			// Data Source Name
			$dsn = Config::get('db_driver') . ':host='. Config::get('db_host') . ';dbname=' . Config::get('db_base');
			$user = Config::get('db_user');
			$pass = Config::get('db_pass');
			$this->dataBase = new PDO($dsn, $user, $pass);
			$this->dataBase->exec('SET NAMES UTF8');
			$this->dataBase->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
		}

		/*
	     * Запрещаем копировать объект
	     */
	    private function __sleep() {}
	    private function __wakeup() {}
	    private function __clone() {}

		public function execQuery($sql,$args) {
			$stmt = $this->dataBase->prepare($sql);
			$stmt->execute($args);
			return $stmt;
		}

		public function getLastInsertId() {
			return $this->dataBase->lastInsertId();
		}

		public function getRows($sql, $args) {
			return self::execQuery($sql, $args)->fetchAll();
		}

		public function getRow($sql, $args) {
			return self::execQuery($sql, $args)->fetch();
		}

		public function insert($sql, $args) {
			self::execQuery($sql, $args);
			return $this->getLastInsertId();
		}

		public function update($sql, $args) {
			return self::execQuery($sql, $args)->rowCount();
		}

		public function delete($sql, $args) {
			return self::execQuery($sql, $args)->rowCount();
		}

		public function uniSelect($table, $whereObj) {
			if ($whereObj) {
				$sets = array();
				foreach ($whereObj as $key => $value) {
					$sets[] = "`$key` = :$key";
					if ($value === NULL) {
						$whereObj[$key] = 'NULL';
					}
				};
				$sets_s = implode(' AND ',$sets);

				$query = "SELECT * FROM `$table` WHERE $sets_s";

				return self::getRow($query, $whereObj);
			} else {
				$query = "SELECT * FROM `$table`";

				return self::getRows($query,null);
			};
		}
		
		public function uniSelectOrderLimitSort($table, $whereObj, $order, $limit = [0, 1], $sort = null) {
			$sort = is_null($sort) ? 'ASC' : $sort;
			if ($whereObj) {
				$sets = array();
				foreach ($whereObj as $key => $value) {
					$sets[] = "`$key` = :$key";
					if ($value === NULL) {
						$whereObj[$key] = 'NULL';
					}
				};
				$sets_s = implode(',',$sets);

				$query = "SELECT * FROM `$table` WHERE $sets_s ORDER BY `$order` $sort LIMIT :limitFrom, :limitTo";
				$stmt = $this->dataBase->prepare($query);
				$stmt->bindParam(":limitFrom", $limit[0], PDO::PARAM_INT);
				$stmt->bindParam(":limitTo", $limit[1], PDO::PARAM_INT);
				foreach ($whereObj as $key => $value) {
					$stmt->bindParam(":$key", $value, $this->dataBase::PARAM_STR);
				}
				$stmt->execute($args);
				return $stmt->fetchAll();
			} else {
				$query = "SELECT * FROM `$table` ORDER BY `$order` $sort LIMIT :limitFrom, :limitTo";
				$stmt = $this->dataBase->prepare($query);
				$stmt->bindParam(":limitFrom", $limit[0], PDO::PARAM_INT);
				$stmt->bindParam(":limitTo", $limit[1], PDO::PARAM_INT);
				foreach ($whereObj as $key => $value) {
					$stmt->bindParam(":$key", $value, $this->dataBase::PARAM_STR);
				}
				$stmt->execute($args);
				return $stmt->fetchAll();
			};
		}

		public function selectWhereValues($table, $whereColumn, $whereValues) {
			$sets_s = implode(',', array_fill(0, count($whereValues), '?'));

			$query = "SELECT * FROM `$table` WHERE `$whereColumn` IN ($sets_s)";

			return self::getRows($query, $whereValues);
		}
		
		public function uniInsert($table, $object) {
			
			$columns = array();
			
			foreach ($object as $key => $value) {
				$columns[] = "`$key`";
				$masks[] = ":$key";
				if ($value === null) {
					$object[$key] = 'NULL';
				}
			};
			
			$columns_s = implode(',', $columns);
			$masks_s = implode(',', $masks);
			$query = "INSERT INTO `$table` ($columns_s) VALUES ($masks_s)";
			return self::insert($query, $object);
		}

		public function uniInsertArray($table, $columns, $object) {

			$columns_s = implode(',', $columns);
			$params = implode(',', array_fill(0, count($object[0]), '?'));
			$sets_s = '('. implode('),(', array_fill(0, count($object), $params)) . ')';
			$oneDimObject = array();
			foreach ($object as $key => $values) {
				foreach ($values as $number => $param) {
					$oneDimObject[] = $param;
				}
			}

			$query = "INSERT INTO `$table` ($columns_s) VALUES $sets_s";

			return self::insert($query, $oneDimObject);
		}
		
		public function uniUpdate($table, $object, $whereObj) {
			
			$sets = array();
			 
			foreach ($object as $key => $value) {
				$sets[] = "`$key` = :$key";
				if ($value === NULL) {
					$object[$key]='NULL';
				}
			};
			 
			$sets_s = implode(',',$sets);

			$wheres = array();
			 
			foreach ($whereObj as $key => $value) {
				$wheres[] = "`$key` = :$key";
				if ($value === NULL) {
					$whereObj[$key] = 'NULL';
				}
			};
			$wheres_s = implode(' AND ', $wheres);

			$query = "UPDATE `$table` SET $sets_s WHERE $wheres_s";
			$superObject = array_merge($object, $whereObj);
			return self::update($query, $superObject);
		}

		public function uniUpdateChanging($table, $object, $whereObj) {
			
			$sets = array();
			 
			foreach ($object as $key => $value) {
				$sets[] = "`$key` = `$key` + :$key";
				if ($value === NULL) {
					$object[$key]='NULL';
				}
			};
			 
			$sets_s = implode(',',$sets);

			$wheres = array();
			 
			foreach ($whereObj as $key => $value) {
				$wheres[] = "`$key` = :$key";
				if ($value === NULL) {
					$whereObj[$key] = 'NULL';
				}
			};
			$wheres_s = implode(' AND ', $wheres);

			$query = "UPDATE `$table` SET $sets_s WHERE $wheres_s";
			$superObject = array_merge($object, $whereObj);
			return self::update($query, $superObject);
		}
		
		public function uniDelete($table, $whereObj) {

			$sets = array();
			 
			foreach ($whereObj as $key => $value) {
				$sets[] = "`$key` = :$key";
				if ($value === NULL) {
					$whereObj[$key] = 'NULL';
				}
			};
			$sets_s = implode(',',$sets);

			$query = "DELETE FROM `$table` WHERE $sets_s";
			return self::delete($query, $whereObj);
		}

		public function lastId($table) {
			$query = "SELECT MAX(id) FROM `$table`";
			return self::getRow($query, null);
		}

		public function uniJoinWhere($table1, $table2, $objectON, $whereObj1, $whereObj2 = NULL) {
			
			$sets = array();
			foreach ($objectON as $key => $value) {
				$sets[] = "$table1.`$key` = $table2.`$value`";
				if ($value === NULL) {
					$object[$key] = 'NULL';
				}
			};
			$sets_s = implode(',',$sets);

			$wheres1 = array();
			foreach ($whereObj1 as $key => $value) {
				$wheres1[] = "$table1.`$key` = :$key";
				if ($value === NULL) {
					$whereObj1[$key] = 'NULL';
				}
			};
			$wheresMain = $wheres1;
			$superObject = $whereObj1;
			if (!is_null($whereObj2)) {
				$wheres2 = array();
				foreach ($whereObj2 as $key => $value) {
					$wheres2[] = "$table2.`$key` = :$key";
					if ($value === NULL) {
						$whereObj2[$key] = 'NULL';
					}
				};
				$wheresMain = array_merge($wheresMain, $wheres2);
				$superObject = array_merge($superObject, $whereObj2);
			};
			
			$wheres_s = implode(',', $wheresMain);

			$query = "SELECT * FROM `$table1` AS $table1 JOIN `$table2` AS $table2 ON ($sets_s) WHERE ($wheres_s)";

			return self::getRows($query, $superObject);
		}

		// шифрование пароля
		public static function cryptPassword ($password, $name) {
			return strrev(md5($password));
		}
	}
?>