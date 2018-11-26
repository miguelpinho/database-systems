<html>
<body>
    <?php
        $date=$_REQUEST['date'];        
        $animal_name =$_REQUEST['animal_name'];
        $owner_vat=(integer)$_REQUEST['owner_vat'];
        $client_vat=(integer)$_REQUEST['client_vat'];
        $num_codes=(integer)$_REQUEST['num_codes'];
        $vet_vat=(integer)$_REQUEST['vet_vat'];
        $weight=floatval($_REQUEST['weight']);
        $s=$_REQUEST['s'];
        $o=$_REQUEST['o'];
        $a=$_REQUEST['a'];
        $p=$_REQUEST['p'];
        
        $host = "db.ist.utl.pt";
        $user = "ist425321";
        $pass = "mknc9851";
        $dsn = "mysql:host=$host;dbname=$user";
        $connection = new PDO($dsn, $user, $pass); 

        for ($i = 1; $i <= $num_codes; $i++){
            echo ($_REQUEST[$i]);
            echo("\n");
        }
        $connection->beginTransaction();
        $sql = "INSERT INTO consult (name, VAT_owner, date_timestamp, VAT_client, VAT_vet, weight,s, o, a, p)
                values ('$animal_name', $owner_vat, '$date', $client_vat, $vet_vat, $weight, '$s', '$o', '$a', '$p' )";
        $result = $connection->query($sql);
        if ($result == FALSE)
        {
            $info = $connection->errorInfo();
            echo("<p>Error: {$info[2]}</p>");
            exit();
        }
        $connection->commit();
        
        /*
        $stmt ->execute([
            'name' => $animal_name,
            'vat_owner' => $owner_vat,
            'date_time' => $date,
            's'=> $s,
            'o'=> $o,
            'a'=>$a,
            'p'=> $p,
            'vat_client' => $client_vat,
            'vet_vat' => $vet_vat,
            'weight' =>$weight,
        ]);*/
        
        $stmt=$connection->prepare("INSERT INTO consult_diagnosis (code, name, VAT_owner, date_timestamp)
                                        values (:code, :name, :vat_owner, :date)");
        $stmt->bindParam(':code', $_REQUEST['1']);
        $stmt->bindParam(':name', $animal_name);
        $stmt->bindParam(':vat_owner', $owner_vat);
        $stmt->bindParam(':date', $date);
        $result=$stmt->execute();
        if ($result == FALSE)
        {
            $info = $connection->errorInfo();
            echo("<p>Error: {$info[2]}</p>");
            exit();
        }
        
        $connection = null;
        echo("<a style=\" margin-top:20px;\" href=\"animal_consults.php?animal_name=");
        echo($animal_name);
        echo("&owner_vat=");  
        echo($owner_vat);
        echo("&client_vat=");  
        echo($client_vat); 
        echo("\"><button style=\" margin-top:20px;\">Back to animal consults</button></a>\n");        

    ?>
</body>
</html>