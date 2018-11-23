<html>
<body>
    <?php
    $animal_name=$_REQUEST['animal_name'];
    $vat_owner=$_REQUEST['owner_vat'];
    $date= $_REQUEST['date'];

    $host = "db.ist.utl.pt";
    $user = "ist425321";
    $pass = "mknc9851";
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
    ?>

    <h1>Consult: <?=$date?></h1>
    <h2>Animal description:</h2>
    <h3 style="display: inline"> Name:</h3> <p style="display: inline"><?=$animal_name?></p>
    
    <?php      

    $sql= "SELECT distinct consult.VAT_owner as owner_vat ,owner.name as owner_name, consult.VAT_client as client_vat,
    client.name as client_name, consult.VAT_vet as vet_vat, vet.name as vet_name, s, o, a, p, weight 
    from consult 
    INNER JOIN person AS owner 
        ON consult.VAT_owner=owner.VAT 
    INNER JOIN person AS client 
        ON consult.VAT_client=client.VAT 
    INNER JOIN person AS vet 
        ON consult.VAT_vet=vet.VAT 
    WHERE consult.name='$animal_name' AND consult.VAT_owner=$vat_owner AND consult.date_timestamp='$date'";

     $result = $connection->query($sql);
     if ($result == FALSE)
     {
         $info = $connection->errorInfo();
         echo("<p>Error: {$info[2]}</p>");
         exit();
     }
     $consult = $result->fetch();

    ?>
    <p>
        <h3 style="margin-bottom: 0;" >Owner identification:</h3>
        <p style="display: inline; margin-left: 20px"> <?=$vat_owner?></p>
        <p style="display: inline"><?=$consult['owner_name']?></p>
    </p>
    <p>
        <h3 style="margin-bottom: 0;" >Client identification:</h3>
        <p style="display: inline; margin-left: 20px"> <?=$consult['client_vat']?></p>
        <p style="display: inline"><?=$consult['client_name']?></p>
    </p>
    <p>
        <h3 style="margin-bottom: 0;" >Veterinary identification:</h3>
        <p style="display: inline; margin-left: 20px"> <?=$consult['vet_vat']?></p>
        <p style="display: inline"><?=$consult['vet_name']?></p>
    </p>
    
    <h3>SOAP Notes:</h3>
    <table border="1" style="margin-left:20px; border-collapse: collapse;width: 600px;">
    <tr>
        <th>S</th>
        <th>O</th>
        <th>A</th>
        <th>P</th>
    </tr>
    <tr>
        
        <td><?=$consult['s']?></td>    
        <td><?=$consult['o']?></td>
        <td><?=$consult['a']?></td>
        <td><?=$consult['p']?></td>
    </tr>  
    </table>
    <p>
        <h3 style="display: inline"> Weight:</h3> 
        <p style="display: inline"><?=$consult['weight']?> Kg</p>
    </p>

    <?php
        $sql = "SELECT species_name, colour, gender, birth_year, age FROM animal WHERE name='$animal_name' AND VAT=$vat_owner " ;
        $result = $connection->query($sql);
        if ($result == FALSE)
        {
            $info = $connection->errorInfo();
            echo("<p>Error: {$info[2]}</p>");
            exit();
        }
        $animal = $result->fetch();    
    ?>
    
    
    <h3>Animal characteristics:</h3>
    <table border="1" style="margin-left:20px; border-collapse: collapse;width: 600px;">
    <tr>
        <th>Specie</th>
        <th>Colour</th>
        <th>Gender</th>
        <th>Birth Date</th>
        <th>Age</th>
    </tr>
    <tr>
        
        <td><?=$animal['species_name']?></td>    
        <td><?=$animal['colour']?></td>
        <td><?=$animal['gender']?></td>
        <td><?=$animal['birth_year']?></td>
        <td><?=$animal['age']?></td>
    </tr>  
    </table>
    
   
    <?php
    $sql="SELECT code, name_med, lab, dosage, regime FROM prescription WHERE name='$animal_name' AND VAT_owner=$vat_owner AND date_timestamp='$date'";
    $result = $connection->query($sql);
    if ($result == FALSE)
    {
        $info = $connection->errorInfo();
        echo("<p>Error: {$info[2]}</p>");
        exit();
    }
    $prescriptions = $result->fetchAll();

    if( count($prescriptions)>0)
    {
        echo("
        <h3>Codes and Prescriptions:</h3>
        <table border=\"1\" style=\"margin-left:20px; border-collapse: collapse;width: 600px;\">
        <tr>
            <th>Code</th>
            <th>Medicine</th>
            <th>Laboratory</th>
            <th>Dosage</th>
            <th>Regime</th>                  
        </tr>
        ");
        foreach($prescriptions as $prescription)
        {           
            echo("<tr>");                     
            echo("<td>{$prescription['code']}</td>");
            echo("<td>{$prescription['name_med']}</td>");
            echo("<td>{$prescription['lab']}</td>");
            echo("<td>{$prescription['dosage']}</td>"); 
            echo("<td>{$prescription['regime']}</td>");                                   
            echo("</tr>\n");   
        }  
        echo("</table>"); 
    }  
    $connection = null;
    ?>

</body>
</html>
