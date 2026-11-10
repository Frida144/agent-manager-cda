<?php
require 'db.php';
//Démarrage de la session
session_start();

//Variable d'affichage
$title = "Mon Compte";

//Page MonCompte non accessible à des personnes non connectées
// Tester si la $_SESSION existe. Si ce n'est pas le cas, on le redirige
if(!isset($_SESSION["firstname"])){
    header('Location:index.php');
    exit;
}

include 'header.php';

?>
    <main>
        <p>Prénom : <?php echo($_SESSION["firstname"]); ?></p>
        <p>Nom : <?php echo($_SESSION["lastname"]); ?></p>
        <p>Email : <?php echo($_SESSION["email"]); ?></p>
        <p>Rôle : <?php echo($_SESSION["role"]); ?></p>
        <p>Date de creation : <?php echo($_SESSION["created_at"]); ?></p>
    </main>
</body>
</html>