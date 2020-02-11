<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

final class OrderModelTest extends TestCase
{
    protected $fixture;
    public $userId = 2;
    public $address = 'testAddress';

    protected function setUp() :void
    {
        $this->fixture = new OrderModel();
    }

    protected function tearDown() :void
    {
        $this->fixture = NULL;
    }

    public function testAddOrderToBD()
    {
        $cart = new CartModel();
        $cart->insertProductInCart(2, 9999, 1, $this->userId);
        $resultOfSql = $this->fixture->addOrderToBD($this->userId, $this->address);
        $orderId = SQL::getInstance()->lastId('orders');
        $this->assertGreaterThan(0, $resultOfSql);
        return $orderId['MAX(id)'];
    }

    public function testGetOrdersById() :void
    {
        $resultOfSql = $this->fixture->getOrdersById($this->userId);
        $this->assertIsArray($resultOfSql);
    }

    public function testGetProductsByOrder() :void
    {
        $resultOfSql = $this->fixture->getProductsByOrder($this->userId);
        $this->assertIsArray($resultOfSql);
    }

    /**
    * @depends testAddOrderToBD
    */
    public function testChangeOrderStatus($orderId)
    {
        $resultOfSql = $this->fixture->changeOrderStatus($orderId, 4);
        $this->assertEquals(1, $resultOfSql);
        return $orderId;
    }

    /**
    * @depends testChangeOrderStatus
    */
    public function testDeleteOrder($orderId)
    {
        $resultOfSql = $this->fixture->deleteOrder($orderId);
        $this->assertEquals(1, $resultOfSql);
        return $orderId;
    }

}
?>