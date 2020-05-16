<?php

namespace Tests\Framework;

use GuzzleHttp\Psr7\Request;
use PHPUnit\Framework\TestCase;


class RouterTest extends TestCase
{

  public function setUp(): void
  {
    $this->router = new Router();
  }

  public function testGetMethod()
  {
    $request = new Request('GET', '/blog');
    $this->router->get('/blog', function () {
      return 'hello';
    }, 'blog');
    $route = $this->router->match($request);
    $this->assertEquals('blog', $route->getName());
    $this->assertEquals('blog', call_user_func_array($route->getCallback(), [$request]));
  }


  public function testGetMethodIfURLDoesNotExist()
  {
    $request = new Request('GET', '/blog');
    $this->router->get('/blog', function () {
      return 'hello';
    }, 'blog');
    $route = $this->router->match($request);
    $this->assertEquals(null, $route);
  }

  public function testGetMethodWithParameters()
  {
    $request = new Request('GET', '/blog/mon-slug-7');

    $this->router->get('/blog', function () {
      return 'azeaze';
    }, 'posts');
    $this->router->get('/blog/{slug:[a-z0-9\-]+}-{id:\d+}', function () {
      return 'hello';
    }, 'post.show');
    $route = $this->router->match($request);
    $this->assertEquals('post.show', $route->getName());
    $this->assertEquals('hello', call_user_func_array($route->getCallback(), [$request]));
    $this->assertEquals(['slug' => 'mon-slog', 'id' => '7'], $route->getParameters());
  }
}
