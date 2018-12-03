<html>
<body>
    
    <?php
    $animal_name=$_REQUEST['animal_name'];
    $vat_owner=$_REQUEST['owner_vat'];
    $date= $_REQUEST['date'];
    ?>
    
    <form action="add_procedure.php" method="post">
        <p>Assistant VAT:
            <select name="vat_assistant">
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

            $sql = "SELECT VAT FROM assistant";
            $result = $connection->query($sql);
            if ($result == FALSE)
            {
                $info = $connection->errorInfo();
                echo("<p>Error: {$info[2]}</p>");
                exit();
            }

            foreach($result as $row)
            {
                $vat = $row['VAT'];
                echo("<option value=\"$vat\">$vat</option>");
            }

            $connection = null;
            ?>
            </select>
        </p>
        <p>Description:
            <input type="text" name="desc"/>
        </p>
        <p>White Blood Cell amount:
            <input type="text" name="white_cell"/>
        </p>  
        <p>Blood Pressure:
            <input type="text" name="blood_pressure"/>
        </p>
        <p>Hemoglobin:
            <input type="text" name="hemoglobin"/>
        </p>
            <input type="hidden" name="animal_name" value='<?=$animal_name?>'/>
        </p>
            <input type="hidden" name="date" value='<?=$date?>'/>
        </p>
            <input type="hidden" name="owner_vat" value='<?=$vat_owner?>'/>
        </p>
        </p>
            <input type="hidden" name="client_vat" value='<?=$_REQUEST['client_vat']?>'/>
        </p>
        <p><input type="submit" value="Add"/></p>
        </form>

</body>
</html>