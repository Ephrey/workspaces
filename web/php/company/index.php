<?php
$dsn = 'mysql:dbname=company;host=localhost';
$dbuser = "root";
$dbpwd = "bq512@97";
$pdo = new PDO($dsn, $dbuser, $dbpwd);
$pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

$stm = $pdo->query('SELECT * FROM employee');
$employees = $stm->fetchAll();

// $pdo->query("INSERT INTO employee(first_name, last_name, phone) VALUES('ephraim', 'ilunga', '0710545597')");
// $stm->exec();

echo '<pre>';
$name = json_decode(json_encode($employees));
var_dump($name[0]->last_name);
echo '</pre>';