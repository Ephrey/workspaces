<?php

namespace Framework;

use GuzzleHttp\Psr7\Response;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;

class App
{
  public function __construct(array $modules = [])
  {
    foreach ($modules as $module) {
      $this->modules[] = new $module();
    }
  }

  public function run(ServerRequestInterface $request): ResponseInterface
  {
    $uri = $request->getUri()->getPath();

    if (!empty($uri) and $uri[-1] === "/") {
      return (new Response())
        ->withStatus(301)
        ->withHeader('Location', substr($uri, 0, -1));
    }

    if ($uri === '/blog') {
      return new Response(200, [], '<h1>Welcome to the blog</h1>');
    }

    if ($uri === '/login') {
      return new Response(200, [], 'logins');
    }

    $response = new Response();
    $response->getBody()->write('Hello, world :)');

    return $response;
  }
}
