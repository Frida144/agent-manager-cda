<?php
require 'db.php';
session_start();

$message = "";
$title = "Agent of Shield";
$listAgents = [];
date_default_timezone_set('Europe/Paris');


if (isset($_POST["action"]) && $_POST["action"] === "add") {
    $_SESSION["name"] = $_POST["name"];
    $_SESSION["dob"] = $_POST["dob"];
    $_SESSION["created_at"] = date("Y-m-d H:i:s");
    $_SESSION["archetype"] = $_POST["archetype"];
    $_SESSION["abilities"] = $_POST["abilities"];
    $message = " Nouvel agent ajouté !";
    $listAgents[] = "<li>" . $_SESSION["name"] . " - " . $_SESSION["dob"] . " - " . $_SESSION["created_at"] . " - " . $_SESSION["archetype"] . " - " . $_SESSION["abilities"] . "</li>";
}
 

include './header.php';
?>
<main>
    <form action="" method="post">
            <input type="hidden" name="action" value="add">
            <input type="text" name="name" placeholder="Nom" required>
            <input type="text" name="dob" placeholder="Dob" required>
            <input type="text" name="archetype" placeholder="Archetype">
            <input type="text" name="abilities" placeholder="Abilities">
            <button type="submit" name="submit">Créer</button>

    </form>
    <p><?php echo ($message); ?></p>
    <div>
        <p>Liste des agents :</p>
        <ul>
            <?php echo implode("", $listAgents); ?>
        </ul>
    </div>
</main>
</body>

</html>