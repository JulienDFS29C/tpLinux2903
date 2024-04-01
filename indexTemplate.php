<?php
$servername = "localhost";
$dbname = "contenu_du_frigo";
$username = "admin";
$password = "admin";

try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $mariadb = "SELECT boissons, charcuterie, fromage FROM inventaire";
        $stmt = $conn->prepare($mariadb);
        $stmt->execute();

        $result = $stmt->setFetchMode(PDO::FETCH_ASSOC);

        if($stmt->rowCount() > 0) {
            foreach($stmt->fetchAll() as $row) {
                echo "Boissons: " . htmlspecialchars($row["boissons"]).
                " - Charcuterie: " . htmlspecialchars($row["charcuterie"]).
                " - Fromage: " . htmlspecialchars($row["fromage"]). "<br>";
            }
        } else {
            echo "0 results";
        }
} catch(PDOException $e) {
        echo "Erreur : " . $e->getMessage();
}

$conn = null;
?>
