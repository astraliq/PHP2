<?php

//------------ Задание 1
abstract class AbstractItem {
	protected $type; 

	protected function __construct($type) {
        $this->type = $type;
    }

	abstract protected function getType();
    abstract protected function getPrice();
    abstract protected function getFinalCost();
	public function showFinalCost() {
		echo "Доход с продаж категории $this->type равен {$this->getFinalCost()} руб. <hr>"; 
	}
}

class PiecesGood extends AbstractItem {
	protected $title;
	protected $price;
	protected $quantity;

	public function __construct($type, $title, $price, $quantity) {
        parent::__construct($type);
        $this -> title = $title;
        $this -> price = $price;
        $this -> quantity = $quantity;
    }
	public function getType() {
		return $this->type;
	}
	public function getTitle() {
		return $this->title;
	}
	public function getPrice() {
		return $this->price;
	}
	public function getQuantity() {
		return $this->quantity;
	}
	public function setType($type) {
		return $this->type = $type;
	}
	public function setTitle($title) {
		return $this->title = $title;
	}
	public function setPrice($price) {
		return $this->price = $price;
	}
	public function setQuantity($quantity) {
		return $this->quantity = $quantity;
	}
	public function getFinalCost(){
		return $finalCost = ($this->price * $this->quantity);
	}
}

class SoftwareItem extends PiecesGood {
	protected $numberOfLicenses;

	public function __construct($type, $title, $price, $quantity, $numberOfLicenses) {
        parent::__construct($type, $title, $price, $quantity);
        $this -> numberOfLicenses = $numberOfLicenses;
    }
	public function setPrice($price) {
		return $this->price = parent::price / 2;
	}
	public function getFinalCost(){
		return $finalCost = ($this->price * $this->quantity * $this->numberOfLicenses);
	}
}

class WeightItem extends PiecesGood {
	protected $discount; // скидка в процентах

	public function __construct($type, $title, $price, $quantity, $discount) {
        parent::__construct($type, $title, $price, $quantity);
        $this -> discount = $discount;
    }
	public function getFinalCost(){
		return $finalCost = ($this->price * $this->quantity * (1 - $this->discount / 100));
	}
}

$iPhone = new PiecesGood("PiecesGood", "iPhone X", 55000, 2);
$msWord = new SoftwareItem ("Softwares", "MS Word 2017", $iPhone->getPrice() / 2, 5, 10);
$sugar = new WeightItem("WeightItems", "Сахар", 50, 5, 10);
echo $iPhone->showFinalCost();
echo $msWord->showFinalCost();
echo $sugar->showFinalCost();


//------------ Задание 2

trait SingletonTrait {
   
    private static $instances = [];
    // Защищаем от создания через new Singleton
	private function __construct () { /* ... @return Singleton */ }
    // Защищаем от создания через клонирование
	private function __clone () { /* ... @return Singleton */ }
	// Защищаем от создания через unserialize
	private function __wakeup () { /* ... @return Singleton */ }

	public static function single() {
        if (!isset(self::$instances[static::class])) {
            self::$instances[static::class] = new static;
        }
        return self::$instances[static::class];
    }
}

class Test {
    use SingletonTrait;
    public $value = 1;
}