<?php 
$I = new FunctionalTester($scenario);
$I->wantTo('Test the database connection');

$I->seeInDatabase('blog_articles', array('id' => '32'));
