<?php
include "dataBase.php";

if ($conn) {
    echo "Підключення успішне!";
} else {
    echo "Помилка підключення!";
}
?>
