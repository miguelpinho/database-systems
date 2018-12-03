<html>
<body>
    
    <?php
    $animal_name=$_REQUEST['animal_name'];
    $vat_owner=$_REQUEST['owner_vat'];
    $date= $_REQUEST['date'];
    ?>
    
    <h1>Blood Test Registration</h1>
    <h2>Please fill the form for a new blood test</h2>

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
            <input type="text" name="desc" required/>
        </p>
        <p>White Blood Cell amount:
            <input type="number" min="0" step="0.01" max = "999.99" name="white_cell" required/>
        </p>  
        <p>Number of Neutrophils:
            <input type="number" min="0" step="0.01" max = "999.99" name="neutrophils_nr" required/>
        </p>
        <p>Number of Lymphocytes:
            <input type="number" min="0" step="0.01" max = "999.99" name="lymphocytes_nr" required/>
        </p>
        <p>Number of Monocytes:
            <input type="number" min="0" step="0.01" max = "999.99" name="monocytes_nr" required/>
        </p>
            <input type="hidden" name="animal_name" value='<?=$animal_name?>' required/>
        </p>
            <input type="hidden" name="date" value='<?=$date?>' required/>
        </p>
            <input type="hidden" name="owner_vat" value='<?=$vat_owner?>' required/>
        </p>
        <p><input type="submit" value="Add"/></p>
        </form>

</body>
</html>