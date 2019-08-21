<?php

//------------ Задание 1-4
class Item {

	public $id;
	public $title;

	public function __construct($id, $title) {
		$this -> id = $id;
		$this -> title = $title;
	}

	public function getItem($table, $id) {
		$id = (int) $id;
		$sql = "SELECT * FROM $table WHERE `id` = $id";
		return show($sql);
	}

	public function showItem($id) {
		echo "Продукт: " . $this -> title . "<br>" . "Цена: " . $this -> price . "<br>" . "ID: " . $this -> id; 
	}
}

class Product extends Item {
	public $price;
	public function __construct($id, $title, $price) {
        parent::__construct($id, $title);
        $this -> price = $price;
    }

    public function insertProductInCart($id, $price, $quantity, $userId) {
		$db = createConnection();
		$idProd = (int) $idProd;
		$price = (float) $price;
		$userId = (int) $userId;
		$sql = "INSERT INTO `carts` (`idProduct`, `price`, `userID`) VALUES ('$idProd', $price, '$userId')";
		return execQuery($sql);
	}
}

$product = new Product(1, "iPhone X", 70000);

$product -> showItem(1);

//------------ Задание 5

// class A {
//     public function foo() {
//         static $x = 0;
//         echo ++$x;
//     }
// }
// $a1 = new A();
// $a2 = new A();
// $a1->foo();  // так как в данном классе свойство Х статичное, т.е. принадлежит классу, а не объекту
// $a2->foo();	 // поэтому при изменении свойства через любой объект функции, значение сохраняется.
// $a1->foo();
// $a2->foo();

//------------ Задание 6

// class A {
//     public function foo() {
//         static $x = 0;
//         echo ++$x;
//     }
// }
// class B extends A {
// }
// $a1 = new A();
// $b1 = new B();
// $a1->foo();   // в данном случае статичное свойство принадлежит разным классам, независимо от наследования.
// $b1->foo();   // изменение свойств происходит у каждого класса по отдельности.
// $a1->foo(); 
// $b1->foo();


//------------ Задание 7

// код такойже как и в задании 6. Отличается только тем что скобок с аргументами нет после создания объекта класса.
//Значения они как я понял не имеют, если аргументов нет.

// class A {
//     public function foo() {
//         static $x = 0;
//         echo ++$x;
//     }
// }
// class B extends A {
// }
// $a1 = new A;
// $b1 = new B;
// $a1->foo(); 
// $b1->foo(); 
// $a1->foo(); 
// $b1->foo();