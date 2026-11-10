<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <header>
        <h1><?php echo($title) ?></h1>
        <nav>
            <a href="index.php">Accueil</a>    
            <?php 
            //Test si on connecté. Si c'est le cas, on affiche les pages accessibles uniquement aux utilisateurs connectés
            if(isset($_SESSION["firstname"])){ ?>
                <a href="monprofile.php">Mon profile</a>
                <a href="agentofshield.php">Agent of Shield</a>

            <?php } ?>
        </nav>
    </header>