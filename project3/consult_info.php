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
    <h3 style="display: inline"> Animal:</h3> <p style="display: inline"><?=$animal_name?></p>
    
    <p>
        <h3 style="display: inline">VAT_owner:</h3>
        <p style="display: inline"> <?=$vat_owner?></p>
    </p>
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


    


</body>
</html>
