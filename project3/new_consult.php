<html>
<body>
    <?php
    $animal_name=$_REQUEST['animal_name'];
    $vat_owner=$_REQUEST['owner_vat'];
    $vat_client=$_REQUEST['VAT_client'];
    ?>
    <h1> Add a new consult for <?=$animal_name?></h>
    <h3>Fill the form for a new consult</h3>    
    <form action="add_consult.php" method="post">
    <p>Veterinary  VAT:
        <input type="text" name="vet_vat"/>
    </p>
    <p>Animal weight:
        <input type="text" name="weight"/>
    </p> 
    <h4>Consult notes</h4>
    <p>S:
        <input type="text" name="s"/>
    </p>
    <p>O:
        <input type="text" name="o"/>
    </p>
    <p>A:
        <input type="text" name="a"/>
    </p>
    <p>P:
        <input type="text" name="P"/>
    </p>
    <h4>Diagnostic Codes:
    <p><input type="submit" value="Search"/></p>
    </form>
    
</body>
</html>