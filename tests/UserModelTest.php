<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

final class UserModelTest extends TestCase
{
    protected $fixture;

    protected function setUp() :void
    {
        $this->fixture = new UserModel();
        $rand = rand(0,10000);
        $this->newUser = 'testUser$rand';
    }

    protected function tearDown() :void
    {
        $this->fixture = NULL;
    }

    public function testRegUser()
    {
        $resultOfSql = $this->fixture->regUser($this->newUser, 'qwerty', $this->newUser, null);
        $this->assertEquals(SQL::getInstance()->getLastInsertId(),  $resultOfSql);
        return $this->newUser;
    }

    /**
    * @depends testRegUser
    */
    public function testCheckUser($newUser)
    {
        $resultOfSql = $this->fixture->checkUser($newUser);
        $this->assertIsArray($resultOfSql);
        return $newUser;
    }

    /**
    * @depends testCheckUser
    */
    public function testDeleteUser($newUser)
    {
        $resultOfSql = $this->fixture->deleteUser($newUser);
        $this->assertEquals(1, $resultOfSql);
    }


}
?>