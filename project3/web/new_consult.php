<html>
<body>
    <?php
    $animal_name=$_REQUEST['animal_name'];
    $vat_owner=$_REQUEST['owner_vat'];
    $vat_client=$_REQUEST['client_vat'];
    ?>
    <h1> Add a new consult for <?=$animal_name?></h>
    <h2>Please fill the form for a new consult</h2>

    <form id="myForm" action='add_consult.php?animal_name=<?=$animal_name?>&owner_vat=<?=$vat_owner?>&client_vat=<?=$vat_client?>' method="post">
        <h4>Identification</h4>
        <p>Veterinary  VAT:
            <select name="vet_vat">
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

            $sql = "SELECT VAT FROM veterinary";
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
        <p>Animal weight:
            <input type="number" min="0.001" step="0.001" max="999.999" type="text" name="weight" required/>
        </p>
        <p>
            <input type='hidden' name='date' value='<?=date("Y-m-d H:i:s") ?>'/>
        </p>
        <h4>Consult notes</h4>
        <p>
            <p>S:</p>
            <textarea name="s" rows="3" cols="40" required></textarea>
        </p>
        <p>
            <p>O:</p>
            <textarea name="o" rows="3" cols="40" required></textarea>
        </p>
        <p>
            <p>A:</p>
            <textarea name="a" rows="3" cols="40" required></textarea>
        </p>
        <p>
            <p>P:</p>
            <textarea name="p" rows="3" cols="40" required></textarea>
        </p>
        <p id="myDIV" >
            <h4 style="margin:5px">Diagnosis Codes</h4>

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

            $sql = "SELECT code FROM diagnosis_code";
            $result = $connection->query($sql);
            if ($result == FALSE)
            {
                $info = $connection->errorInfo();
                echo("<p>Error: {$info[2]}</p>");
                exit();
            }

            foreach($result as $row)
            {
                $code = $row['code'];

                echo("<input style=\"margin-left: 20px\" type=\"checkbox\"  name=\"codes[$code]\" value=\"$code\"> $code<br>");
                /*echo("<option value=\"$code\">$code</option>");*/
            }

            $connection = null;
            ?>

        </p>
        <p><input onclick="myFunction()" type="submit" value="Submit"/></p>
    </form>

</body>
</html>
