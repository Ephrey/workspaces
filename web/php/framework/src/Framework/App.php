<?php

namespace Framework;

use GuzzleHttp\Psr7\Response;
use Psr\Http\Message\ServerRequestInterface;

class App
{
  public function run(ServerRequestInterface $request)
  {
    $uri = $request->getUri()->getPath();

    if (!empty($uri) and $uri[-1] === "/") {
      return (new Response())
        ->withStatus(301)
        ->withHeader('Location', substr($uri, 0, -1));
    }

    $response = new Response();
    $response->getBody()->write('Hello, world :)');
    return $response;
  }
}
