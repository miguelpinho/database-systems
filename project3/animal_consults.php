<html>
<body>
<h1><?=$_REQUEST['animal_name']?> consults:</h1>
<?php

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

        $animal_name=$_REQUEST['animal_name'];
        $owner_VAT=(integer)$_REQUEST['owner_vat'];
        echo("$owner_VAT, $animal_name");
        $stmt=$connection->prepare(" SELECT * from consult WHERE consult.name=:name AND consult.VAT_owner=:vat_owner");
        $stmt->bindParam('name',$animal_name);
        $stmt->bindParam(':vat_owner', $owner_VAT);
        $result=$stmt->execute();
        if ($result == FALSE)
        {
            echo("Query animal consults");
            $info = $connection->errorInfo();
            echo("<p>Error: {$info[2]}</p>");
            exit();
        }
        
        
        $rows = $stmt->fetchAll();
        $num_rows = count($rows);

        if($num_rows<1){
            echo("<p>There are no consults</p>");

        }
        else
        {
            echo("<p>There are $num_rows different consults</p>");

            echo("<h2>Consults envolve these animals:</h2>");
            echo("<table border=\"1\">
                <tr>
                
                <td><em>No.</em></td>
                <td><em>Date</em></td>
                <td><em>VAT_client</em></td>
                <td><em>VAT_vet</em></td>
                
                </tr>"
            );
            $aux=1;
            foreach($rows as $row)
            {           
                    echo("<tr>");                     
                   
                    echo("<td>$aux</td>");
                    echo("<td>{$row['date_timestamp']}</td>");
                    echo("<td>{$row['VAT_client']}</td>");
                    echo("<td>{$row['VAT_vet']}</td>");
                    echo("<td><a href=\"consult_info.php?animal_name=");
                    echo($row['name']);
                    echo("&date=");  
                    echo($row['date_timestamp']);
                    echo("&owner_vat=");  
                    echo($row['VAT_owner']);
                    echo("\">More info</a></td>\n");
                    echo("<td><a href=\"add_bt_form.php?animal_name=");
                    echo($row['name']);
                    echo("&date=");  
                    echo($row['date_timestamp']);
                    echo("&owner_vat=");  
                    echo($row['VAT_owner']);
                    echo("&client_vat=");  
                    echo($_REQUEST['client_vat']);
                    echo("\">Add Blood Test</a></td>\n");                                                    
                    echo("</tr>\n");      
                    $aux++;              
                
            }  
            echo("</table>"); 
        }

        $stmt=$connection->prepare(" SELECT name from person WHERE VAT=:vat_owner");
        
        $stmt->bindParam(':vat_owner', $row['VAT_owner']);
        $result=$stmt->execute();
        if ($result == FALSE)
        {
            echo("Query animal consults");
            $info = $connection->errorInfo();
            echo("<p>Error: {$info[2]}</p>");
            exit();
        }
        
        
        $name_owner = $stmt->fetch();
        echo("{$name_owner['name']}");
        
        $connection = null;

        
    echo("<a style=\" margin-top:20px;\" href=\"new_consult.php?animal_name=");
    echo($row['name']);
    echo("&owner_vat=");  
    echo($row['VAT_owner']);
    echo("&client_vat=");  
    echo($_REQUEST['client_vat']); 
    echo("\"><button style=\" margin-top:20px;\">Add new consult</button></a>\n");  

    
    
    ?>
    <form action="execsearch.php" method="post">
        <p>Client VAT:<?=$_REQUEST['client_vat']?>
            <input type="hidden" name="VAT_client" value="<?=$_REQUEST['client_vat']?>" />
        </p>
        <p>Owner Name: <?= $name_owner['name']?>
            <input type="hidden" name="owner_name" value="<?= $name_owner['name']?>"/>
        </p>  
        <p>Animal Name:<?=$animal_name?>
            <input type="hidden" name="animal_name" value="<?=$animal_name?>" />
        </p>
        <p><input type="submit" value="Back to animals list"/></p>
        </form>
</body>
       
</html>
