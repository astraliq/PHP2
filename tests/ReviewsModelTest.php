<?php
declare(strict_types=1);

use PHPUnit\Framework\TestCase;

final class ReviewsModelTest extends TestCase
{
    protected $fixture;
    protected $name = 'testName';
    protected $comment = 'testComment';
    protected $rate = '5';

    protected function setUp() :void
    {
        $this->fixture = new ReviewsModel();
    }

    protected function tearDown() :void
    {
        $this->fixture = NULL;
    }

    public function testGetLastReviews() :void
    {
        $resultOfSql = $this->fixture->getLastReviews(20);
        $this->assertIsArray($resultOfSql);
    }

    public function testGetReviewById() :void
    {
        $resultOfSql = $this->fixture->getReviewById(2);
        $this->assertIsArray($resultOfSql);
    }

    public function testCreateReview()
    {
        $resultOfSql = $this->fixture->createReview($this->name, $this->comment, $this->rate);
        $reviewId = SQL::getInstance()->getLastInsertId();
        $this->assertEquals($reviewId, $resultOfSql);
        return $reviewId;
    }

    /**
    * @depends testCreateReview
    */
 
    public function testUpdateReview($reviewId)
    {
        $newName = 'newTestName';
        $newComment = 'newTestComment';
        $resultOfSql = $this->fixture->updateReview($reviewId, $newName, $newComment);
        $this->assertEquals(1, $resultOfSql);
        return $reviewId;
    }

    /**
    * @depends testUpdateReview
    */
    public function testDeleteReview($reviewId)
    {
        $resultOfSql = $this->fixture->deleteReview($reviewId);
        $this->assertEquals(1, $resultOfSql);
    }


}
?>