<html>
<body>
    <?php    
    $animal_name=$_REQUEST['animal_name'];
    $vat_owner=$_REQUEST['owner_vat'];
    $date= $_REQUEST['date'];
    $vat_assistant = $_REQUEST['vat_assistant'];
    $desc = $_REQUEST['desc'];
    $white_cell = $_REQUEST['white_cell'];
    $blood_pressure = $_REQUEST['blood_pressure'];
    $hemoglobin = $_REQUEST['hemoglobin'];

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

    $connection->beginTransaction();
    
    $stmt=$connection->prepare("SELECT num as nr_procedures FROM procedures WHERE procedures.name =:animal_name AND procedures.VAT_owner =:owner_vat AND procedures.date_timestamp =:date_time");
    $result=$stmt ->execute([
        'animal_name' => $animal_name,
        'owner_vat' => $vat_owner,
        'date_time' => $date,
    ]);   

    if ($result== FALSE)
    {
        echo("Num determination query");
        $info = $connection->errorInfo();
        echo("<p>Error: {$info[2]}</p>");
        exit();
    }

    
    $procedures=$stmt->fetchAll();

    $num = count($procedures) + 1;

    $stmt=$connection->prepare("INSERT INTO procedures (name, VAT_owner, date_timestamp, num, descriptions)
                        values (:name, :vat_owner, :date, :num, :desc)");
        $stmt->bindParam(':name', $animal_name);
        $stmt->bindParam(':vat_owner', $vat_owner);
        $stmt->bindParam(':date', $date);
        $stmt->bindParam(':num', $num);
        $stmt->bindParam(':desc', $desc);

        $result = $stmt->execute();

        if ($result== FALSE)
    {
        echo("Insert Procedure query");
        $info = $connection->errorInfo();
        echo("<p>Error: {$info[2]}</p>");
        exit();
    }

    $procedures=$stmt->fetchAll();
    
    $stmt=$connection->prepare("INSERT INTO performed (name, VAT_owner, date_timestamp, num, VAT_assistant)
                        values (:name, :vat_owner, :date, :num, :assistant_vat )");
        $stmt->bindParam(':name', $animal_name);
        $stmt->bindParam(':vat_owner', $vat_owner);
        $stmt->bindParam(':date', $date);
        $stmt->bindParam(':num', $num);
        $stmt->bindParam(':assistant_vat', $vat_assistant);

        $result = $stmt->execute();

        if ($result== FALSE)
    {
        echo("Insert Performed query");
        $info = $connection->errorInfo();
        echo("<p>Error: {$info[2]}</p>");
        exit();
    }

    $performed=$stmt->fetchAll();

    $stmt=$connection->prepare("INSERT INTO test_procedure (name, VAT_owner, date_timestamp, num, test_type)
                        values (:name, :vat_owner, :date, :num, 'blood')");
        $stmt->bindParam(':name', $animal_name);
        $stmt->bindParam(':vat_owner', $vat_owner);
        $stmt->bindParam(':date', $date);
        $stmt->bindParam(':num', $num);

        $result = $stmt->execute();

        if ($result== FALSE)
    {
        echo("Insert Test Procedure query");
        $info = $connection->errorInfo();
        echo("<p>Error: {$info[2]}</p>");
        exit();
    }

    $performed=$stmt->fetchAll();

    $stmt=$connection->prepare("INSERT INTO produced_indicator (name, VAT_owner, date_timestamp, num, indicator_name, p_value)
                        values (:name, :vat_owner, :date, :num, 'white blood cell count', :value)");
        $stmt->bindParam(':name', $animal_name);
        $stmt->bindParam(':vat_owner', $vat_owner);
        $stmt->bindParam(':date', $date);
        $stmt->bindParam(':num', $num);
        $stmt->bindParam(':value', $white_cell);

        $result = $stmt->execute();

    if ($result== FALSE)
    {
        echo("Insert White Blood query");
        $info = $connection->errorInfo();
        echo("<p>Error: {$info[2]}</p>");
        exit();
    }

    $performed=$stmt->fetchAll();

    $stmt=$connection->prepare("INSERT INTO produced_indicator (name, VAT_owner, date_timestamp, num, indicator_name, p_value)
                        values (:name, :vat_owner, :date, :num, 'blood pressure', :value)");
        $stmt->bindParam(':name', $animal_name);
        $stmt->bindParam(':vat_owner', $vat_owner);
        $stmt->bindParam(':date', $date);
        $stmt->bindParam(':num', $num);
        $stmt->bindParam(':value', $blood_pressure);

        $result = $stmt->execute();

    if ($result== FALSE)
    {
        echo("Insert Blood Pressure query");
        $info = $connection->errorInfo();
        echo("<p>Error: {$info[2]}</p>");
        exit();
    }

    $stmt=$connection->prepare("INSERT INTO produced_indicator (name, VAT_owner, date_timestamp, num, indicator_name, p_value)
                        values (:name, :vat_owner, :date, :num, 'hemoglobin', :value)");
        $stmt->bindParam(':name', $animal_name);
        $stmt->bindParam(':vat_owner', $vat_owner);
        $stmt->bindParam(':date', $date);
        $stmt->bindParam(':num', $num);
        $stmt->bindParam(':value', $hemoglobin);

        $result = $stmt->execute();

    if ($result== FALSE)
    {
        echo("Insert Hemoglobin query");
        $info = $connection->errorInfo();
        echo("<p>Error: {$info[2]}</p>");
        exit();
    }

    $performed=$stmt->fetchAll();
    $connection->commit();

    $connection = null;
    echo("<p>Test successfully inserted</p>");
    echo("<a style=\" margin-top:20px;\" href=\"animal_consults.php?animal_name=");
    echo($animal_name);
    echo("&owner_vat=");  
    echo($vat_owner);
    echo("&client_vat=");  
    echo($client_vat); 
    echo("\"><button style=\" margin-top:20px;\">Back to animal consults</button></a>\n");
    ?>

</body>
</html>
    
    
    