<?php
require 'db.php';
session_start();

$message = "";
$title = "Accueil";
$listUsers = "";
$listRoles = "";
$idRole = 2;
date_default_timezone_set('Europe/Paris');


if (isset($_POST["action"]) && $_POST["action"] === "login") {
    $_SESSION["firstname"] = $_POST["firstname"];
    $_SESSION["lastname"] = $_POST["lastname"];
    $_SESSION["email"] = $_POST["email"];
    $_SESSION["password"] = $_POST["password"];
    $_SESSION["role"] = trim($_POST["role"] ?? "") ?: "manager"; 
    $_SESSION["created_at"] = date("Y-m-d H:i:s");

    $idRole = (strtolower($_SESSION["role"]) === "administrateur") ? 1 : 2;
    $stmt = $pdo->prepare(
        "INSERT INTO users (firstname, lastname, email, password, Id_Role) 
        VALUES (:firstname, :lastname, :email, :password, :Id_Role)"
    );
    try {
        $stmt->execute([
            ":firstname" => $_POST["firstname"],
            ":lastname" => $_POST["lastname"],
            ":email" => $_POST["email"],
            ":password" => $_POST["password"],
            ":Id_Role" => $idRole
        ]);
            $message = "Bonjour " . $_SESSION["firstname"] . " Vous êtes connecté !";
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }
}
if (isset($_POST["action"]) && $_POST["action"] === "logout") {
    $_SESSION = [];
    session_destroy();
    $message = "Vous êtes déconnecté !";
    $listUsers = "";
}

$users = $pdo->query(
    "SELECT u.firstname, u.lastname, u.email, r.role, u.created_at
    FROM users u
    JOIN roles r ON u.Id_Role = r.Id_Role
    WHERE r.role = 'manager'
    ORDER BY u.created_at DESC"
)->fetchAll(PDO::FETCH_ASSOC);

foreach ($users as $user) {
    $listUsers .="<li>"
        .htmlspecialchars($user["firstname"] ."" .$user["lastname"])
        ." - ".htmlspecialchars($user["email"])
        ." - ".htmlspecialchars($user["role"] ?? "" ?: "manager")
        ." - ".htmlspecialchars($user["created_at"])
        ."</li>";
    }
    
$roles = $pdo->query(
    "SELECT r.role
     FROM roles r
     ORDER BY r.role ASC
     ")->fetchAll(PDO::FETCH_ASSOC);
foreach ($roles as $role) {
    $listRoles .="<option value=\"".htmlspecialchars($role["role"])."\">"
        .htmlspecialchars($role["role"])
        ."</option>";
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
            <select name="role" required>
                <option value="">Sélectionnez un rôle</option>
                <?php echo ($listRoles); ?>
            </select>
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