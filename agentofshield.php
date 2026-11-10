<?php
require 'db.php';
session_start();

$message = "";
$title = "Agent of Shield";
$listAgents = "";
date_default_timezone_set('Europe/Paris');
$listArchetype = "";
$listAbilities = "";
$listTiers = "";


if (isset($_POST["action"]) && $_POST["action"] === "add") {
    $_SESSION["name"] = $_POST["name"];
    $_SESSION["dob"] = $_POST["dob"];
    $_SESSION["created_at"] = date("Y-m-d H:i:s");
    $_SESSION["archetype"] = $_POST["archetype"];
    $_SESSION["tier"] = $_POST["tier"];

    $stmt = $pdo->prepare(
        "INSERT INTO agents (name, dob, Id_Archetype, Id_Tier)
            VALUES (:name, :dob, :Id_Archetype, :Id_Tier)"

    );
    try {
        $stmt->execute([
            ":name" => $_POST["name"],
            ":dob" => $_POST["dob"],
            ":Id_Archetype" => $_SESSION["archetype"],
            ":Id_Tier" => $_SESSION["tier"]
        ]);
            $message = " Nouvel agent ajouté !";
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }

}

$agents = $pdo->query(
    "SELECT a.name, a.dob, ar.archetype,
            GROUP_CONCAT(ab.ability SEPARATOR ', ') AS abilities,
            a.created_at
    FROM agents a
    JOIN archetypes ar ON a.Id_Archetype = ar.Id_Archetype
    LEFT JOIN archetypes_abilities aa ON ar.Id_Archetype = aa.Id_Archetype
    LEFT JOIN abilities ab ON aa.Id_Ability = ab.Id_Ability
    GROUP BY a.Id_Agent
    ORDER BY a.created_at DESC"
)->fetchAll(PDO::FETCH_ASSOC);

foreach ($agents as $agent) {
    $listAgents .="<li>"
        .htmlspecialchars($agent["name"] ." " .$agent["dob"])
        ." - ".htmlspecialchars($agent["archetype"])
        ." - ".htmlspecialchars($agent["abilities"])
        ." - ".htmlspecialchars($agent["created_at"])
        ."</li>";
    }
 
$archetypes = $pdo->query(
    "SELECT a.Id_Archetype, a.archetype
     FROM archetypes a
     ORDER BY a.archetype ASC"
)->fetchAll(PDO::FETCH_ASSOC);

foreach ($archetypes as $archetype) {
    $listArchetype .= "<option value=\"" . $archetype["Id_Archetype"] . "\">"
        . htmlspecialchars($archetype["archetype"])
        . "</option>";
}

$tiers = $pdo->query(
    "SELECT t.Id_Tier, t.tier
     FROM tiers t
     ORDER BY t.level DESC
     ")->fetchAll(PDO::FETCH_ASSOC);

foreach ($tiers as $tier) {
    $listTiers .="<option value=\"".$tier["Id_Tier"]."\">"
        .htmlspecialchars($tier["tier"])
        ."</option>";
    }
include './header.php';
?>
<main>
    <form action="" method="post">
            <input type="hidden" name="action" value="add">
            <input type="text" name="name" placeholder="Nom" required>
            <input type="date" name="dob" placeholder="date de naissance" required>
            <select name="archetype" required>
                <option value="">Sélectionnez un archetype</option>
                <?php echo ($listArchetype); ?>
            </select>
            <select name="tier" required>
                <option value="">Sélectionnez un tier</option>
                <?php echo ($listTiers); ?>
            </select>
            <button type="submit" name="submit">Créer</button>

    </form>
    <p><?php echo ($message); ?></p>
    <div>
        <p>Liste des agents :</p>
        <ul>
            <?php echo ($listAgents); ?>
        </ul>
    </div>
</main>
</body>

</html>