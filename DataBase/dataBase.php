<?php
$config = require 'config.php';

$conn = new mysqli($config['host'], $config['user'], $config['password'], $config['dbname']);

if ($conn->connect_error) {
    die("Помилка підключення: " . $conn->connect_error);
}

$conn->set_charset("utf8");
?>
