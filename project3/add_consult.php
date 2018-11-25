<html>
<body>
    <?php
        $date=$_REQUEST['date'];
        echo($date);

        
        $codes=$_REQUEST['codes'];
        foreach($codes as $code){
            echo($code);
        }
        echo("$codes");
            $codes=$_REQUEST['p'];
            echo("$codes");

    ?>
</body>
</html>