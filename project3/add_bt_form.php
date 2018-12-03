<html>
<body>
    
    <?php
    $animal_name=$_REQUEST['animal_name'];
    $vat_owner=$_REQUEST['owner_vat'];
    $date= $_REQUEST['date'];
    ?>
    
    <form action="add_procedure.php" method="post">
        <p>Assistant VAT:
            <input type="text" name="vat_assistant"/>
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
        <p><input type="submit" value="Add"/></p>
        </form>

</body>
</html>