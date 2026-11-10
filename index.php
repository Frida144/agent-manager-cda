<?php
require 'db.php';
session_start();

$message = "";
$title = "Accueil";
$listUsers = "";
date_default_timezone_set('Europe/Paris');


if (isset($_POST["action"]) && $_POST["action"] === "login") {
    $_SESSION["firstname"] = $_POST["firstname"];
    $_SESSION["lastname"] = $_POST["lastname"];
    $_SESSION["email"] = $_POST["email"];
    $_SESSION["password"] = $_POST["password"];
    $_SESSION["role"] = trim($_POST["role"] ?? "") ?: "manager"; 
    $_SESSION["created_at"] = date("Y-m-d H:i:s");
    $message = "Bonjour " . $_SESSION["firstname"] . " Vous êtes connecté !";
}
 
if (strtolower($_SESSION["role"] ?? "") === "manager") {
    $listUsers .= "<li>" . $_SESSION["firstname"] . " " . $_SESSION["lastname"] . " - " . $_SESSION["email"] . " - Manager</li>";
}

if (isset($_POST["action"]) && $_POST["action"] === "logout") {
    $_SESSION = [];
    session_destroy();
    $message = "Vous êtes déconnecté !";
    $listUsers = "";
}


include './header.php';
?>
<main>
    <form action="" method="post">
            <input type="hidden" name="action" value="login">
            <input type="text" name="firstname" placeholder="Prénom" required>
            <input type="text" name="lastname" placeholder="Nom" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Mot de passe" required>
            <input type="text" name="role" placeholder="Rôle">
            <button type="submit" name="submit">Se connecter</button>

    </form>

    <p><?php echo ($message); ?></p>
    <div>
        <p>Liste des utilisateurs connectés :</p>
        <ul>
            <?php echo ($listUsers); ?>
        </ul>
    </div>
    <form action="" method="post">
         <input type="hidden" name="action" value="logout">
         <button type="submit">Se déconnecter</button>
    </form>
</main>
</body>

</html>