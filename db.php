<?php
$pdo = new PDO(
    'mysql:host=127.0.0.1;dbname=agent_manager;charset=utf8mb4',
    'root',
    'root',
    [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
);
