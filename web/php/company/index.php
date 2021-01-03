<?php
$dsn = 'mysql:dbname=users;host=127.0.0.1';
$dbuser = "root";
$dbpwd = "@root";
$pdo = new PDO($dsn, $dbuser, $dbpwd);
$pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

$stm = $pdo->query('SELECT * FROM email');
$employees = $stm->fetchAll();

// $pdo->query("INSERT INTO employee(first_name, last_name, phone) VALUES('ephraim', 'ilunga', '0710545597')");
// $stm->exec();

echo '<pre>';
$name = json_decode(json_encode($employees));
var_dump($name[0]->last_name);
var_dump($name[0]->first_name);
echo '</pre>';
