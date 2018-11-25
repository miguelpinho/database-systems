<html>
<body>
    <?php
        $date=$_REQUEST['date'];        
        $animal_name =$_REQUEST['animal_name'];
        $owner_vat=(integer)$_REQUEST['owner_vat'];
        $num_codes=(integer)$_REQUEST['num_codes'];
        $vet_vat=(integer)$_REQUEST['vet_vat'];
        $weight=(integer)$_REQUEST['weight'];
        $s=$_REQUEST['s'];
        $o=$_REQUEST['o'];
        $a=$_REQUEST['a'];
        $p=$_REQUEST['p'];
        

        for ($i = 1; $i <= $num_codes; $i++){
            echo ($_REQUEST[$i]);
            echo("\n");
        }
       

    ?>
</body>
</html>