<html>
<body>
<h1>Animal consults: <?=$_REQUEST['animal_name']?></h1>
<?php

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

        $animal_name=$_REQUEST['animal_name'];
        $owner_VAT=(integer)$_REQUEST['owner_vat'];
        echo("$owner_VAT, $animal_name");
        $sql=" SELECT * from consult WHERE consult.name='$animal_name' AND consult.VAT_owner=$owner_VAT";
        $result = $connection->query($sql);
        if ($result == FALSE)
        {
            $info = $connection->errorInfo();
            echo("<p>Error: {$info[2]}</p>");
            exit();
        }
        $rows = $result->fetchAll();
        $num_rows = count($rows);

        if($num_rows<1){
            echo("<p>There are no consults</p>");

        }
        else
        {
            echo("<p>There are: $num_rows different consults</p>");

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
                    echo("</tr>\n");      
                    $aux++;              
                
            }  
            echo("</table>"); 
        }
        $connection = null;

        ?>

</body>
</html>