<?php

namespace Tests\Framework;

use PHPUnit\Framework\TestCase;
use Framework\App;
use \GuzzleHttp\Psr7\ServerRequest;

class AppTest extends TestCase
{

  public function testRedirectTrailingSlash()
  {
    $app = new App();
    $request = new ServerRequest('GET', "/test/");
    $response = $app->run($request);
    $this->assertContains('/test', $response->getHeader('Location'));
    $this->assertEquals(301, $response->getStatusCode());
  }

  public function testOutput()
  {
    $app = new App();
    $request = new ServerRequest('GET', '/blog');
    $response = $app->run($request);
    $this->assertContains('<h1>Welcome to the blog</h1>', $response->getBody());
    $this->assertEquals(200, $response->getStatusCode());
  }
}
