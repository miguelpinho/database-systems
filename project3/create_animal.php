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

        $owner_name = $_REQUEST['owner_name'];
        
        echo("$VAT_client, $owner_name, $animal_name");    
    
        $host = "db.ist.utl.pt";
        $user = "ist425321";
        $pass = "mknc9851";
        $dsn = "mysql:host=$host;dbname=$user";
        $connection = new PDO($dsn, $user, $pass);

        $sql = " insert into animal (name, VAT, species_name, colour, gender, birth_year, age) 
            values ('$animal_name', $VAT_owner, '$species_name', '$animal_color', '$animal_gender', '$animal_birth_year', $animal_age)";
    
        

?>
</body>
</html>