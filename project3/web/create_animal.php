<html>
<body>
<?php
        $animal_name = $_REQUEST['animal_name'];
        $VAT_owner = (integer)$_REQUEST['VAT_owner'];
        $species_name = $_REQUEST['species_name'];
        $animal_color = $_REQUEST['animal_color'];
        $animal_gender = $_REQUEST['animal_gender'];
        $animal_birth_year = $_REQUEST['animal_birth_year'];
        $animal_age = (integer)$_REQUEST['animal_age'];

        echo("$VAT_owner, $animal_name, $species_name, $animal_color, $animal_gender, $animal_birth_year, $animal_age");

        $host = "db.ist.utl.pt";
        $user = "ist181702";
        $pass = "nqit9741";
        $dsn = "mysql:host=$host;dbname=$user";

        try
        {
            $connection = new PDO($dsn, $user, $pass);
        }
        catch(PDOException $exception)
        {
            echo("<p>Error: ");
            echo($exception->getMessage());
            echo("</p>");
            exit();
        }

        $stmt=$connection->prepare ( " INSERT INTO animal (name, VAT, species_name, colour, gender, birth_year, age)
            values (:name, :vat_owner, :specie, :color, :gender, :b_year, :age)");
        $stmt->bindParam(':name', $animal_name);
        $stmt->bindParam(':vat_owner', $VAT_owner);
        $stmt->bindParam(':specie', $species_name);
        $stmt->bindParam(':color', $animal_color);
        $stmt->bindParam(':gender', $animal_gender);
        $stmt->bindParam(':b_year', $animal_birth_year);
        $stmt->bindParam(':age', $animal_age);


        $result=$stmt->execute();
        if ($result == FALSE)
        {
            echo("<p>Couldn't add animal</p>");
            echo("<p><button onclick='history.go(-1)';>Back</button>");
            exit();
        }

        $connection = null;
        echo("<h3>Animal successfully inserted</h3>\n");
        echo("<form action='search_animal_form.php' method='post'>
             <input type='submit' value='Go To Homepage'/>
        </form>");
?>
</body>
</html>
