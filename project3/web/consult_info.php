<html>
<body>
    <?php
    $animal_name=$_REQUEST['animal_name'];
    $vat_owner=$_REQUEST['owner_vat'];
    $date= $_REQUEST['date'];

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
    ?>

    <h1>Consult: <?=$date?></h1>
    <h2>Animal description:</h2>
    <h3 style="display: inline"> Name:</h3> <p style="display: inline"><?=$animal_name?></p>

    <?php
    $stmt=$connection->prepare("SELECT distinct consult.VAT_owner as owner_vat ,owner.name as owner_name, consult.VAT_client as client_vat,
    client.name as client_name, consult.VAT_vet as vet_vat, vet.name as vet_name, s, o, a, p, weight
    from consult
    INNER JOIN person AS owner
        ON consult.VAT_owner=owner.VAT
    INNER JOIN person AS client
        ON consult.VAT_client=client.VAT
    INNER JOIN person AS vet
        ON consult.VAT_vet=vet.VAT
    WHERE consult.name=:name AND consult.VAT_owner=:vat_owner AND consult.date_timestamp=:date");

    $stmt->bindParam(':name',$animal_name);
    $stmt->bindParam(':vat_owner', $vat_owner);
    $stmt->bindParam(':date', $date);

    $result=$stmt->execute();
    if ($result == FALSE)
    {
        echo("Consult info");
        echo("<p><button onclick='history.go(-1)';>Back</button>");
        exit();
    }

    $consult = $stmt->fetch();

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
        $stmt=$connection->prepare("SELECT species_name, colour, gender, birth_year, age FROM animal WHERE name=:name AND VAT=:vat_owner ");
        $stmt->bindParam(':name',$animal_name);
        $stmt->bindParam(':vat_owner', $vat_owner);
        $result=$stmt->execute();
        if ($result == FALSE)
        {
            echo("Animal info");
            echo("<p><button onclick='history.go(-1)';>Back</button>");
            exit();
        }

        $animal = $stmt->fetch();
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
    $stmt= $connection->prepare("SELECT code from consult_diagnosis WHERE name=:name AND VAT_owner=:vat_owner AND date_timestamp=:date");
    $stmt->bindParam('name',$animal_name);
    $stmt->bindParam(':vat_owner', $vat_owner);
    $stmt->bindParam(':date', $date);
    $result=$stmt->execute();
    if ($result == FALSE)
    {
        echo("Error");
        echo("<p><button onclick='history.go(-1)';>Back</button>");
        exit();
    }
    $d_codes =$stmt->fetchAll();

    if(count($d_codes)>0)
    {
        echo("<h3>Diagnostic codes:</h3>");
        echo("<ul style=\"padding-left: 0\" >");
        foreach($d_codes as $d_code)
        {
            echo("<li>{$d_code['code']}</li>");
        }
        echo("</ul>");
    }

    $stmt=$connection->prepare("SELECT code, name_med, lab, dosage, regime FROM prescription
                                WHERE name=:name AND VAT_owner=:vat_owner AND date_timestamp=:date");
    $stmt->bindParam('name',$animal_name);
    $stmt->bindParam(':vat_owner', $vat_owner);
    $stmt->bindParam(':date', $date);

    $result=$stmt->execute();
    if ($result == FALSE)
    {
        echo("prescriptions query");
        echo("<p><button onclick='history.go(-1)';>Back</button>");
        exit();
    }

    $prescriptions = $stmt->fetchAll();

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
    <button style="margin-top: 20px;margin-bottom:40px" onclick="history.go(-1);">Back to <?=$animal_name?> consults </button>
</body>
</html>
