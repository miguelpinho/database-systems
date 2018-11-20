<html>
<body>    
    <?php
        $VAT_client = (integer)$_REQUEST['VAT_client'];
        $owner_name = $_REQUEST['owner_name'];
        $animal_name = $_REQUEST['animal_name'];
        echo("$VAT_client, $owner_name, $animal_name");    
    
        $host = "db.ist.utl.pt";
        $user = "ist425321";
        $pass = "mknc9851";
        $dsn = "mysql:host=$host;dbname=$user";
        $connection = new PDO($dsn, $user, $pass);    

        $sql="SELECT distinct animal.name as animals_name, animal.VAT as owner_vat, person.name as owner_name 
            FROM animal, person 
            WHERE person.VAT=animal.VAT AND  animal.name LIKE '%$animal_name%' AND person.name LIKE '%$owner_name%'";
        $result = $connection->query($sql);
        $rows = $result->fetchAll(); 
        $num_rows = count($rows);

        if($num_rows > 0)
        {
            echo("<table border=\"1\">
                    <tr>
                    <td><em>animal name</em></td>
                    <td><em>VAT_owner</em></td>
                    <td><em>Owner name</em></td>                
                    </tr>"
                );
            foreach($rows as $row)
            {           
                    echo("<tr>");                     
                    echo("<td>{$row['animals_name']}</td>");
                    echo("<td>{$row['owner_vat']}</td>");
                    echo("<td>{$row['owner_name']}</td>");
                    echo("<td><a href=\"animal_consults.php?animal_name=");
                    echo($row['animals_name']);
                    echo("&owner_vat=");  
                    echo($row['owner_vat']);
                    echo("\">See Medical Record</a></td>\n");                               
                    echo("</tr>\n");   
            }  
            echo("</table>");  
            echo("<form action='search_animal_form.php' method='post'> 
             <input type='submit' value='Go To Homepage'/>           
        </form>"); 
        }
        else
        {
            echo("<h3>No animal found</h3>\n");
            echo("<form action='create_animal.php' method='post'>
                    <p>Name:
                        <input type='text' name='animal_name'/>
                    </p>
                    <p>VAT:
                        <input type='text' name='VAT_owner'/>
                    </p>
                    <p>Species Name:
                        <input type='text' name='species_name'/>
                    </p>
                    <p>Animal Color:
                        <input type='text' name='animal_color'/>
                    </p>
                    <p>Animal Gender:
                        <input type='text' name='animal_gender'/>
                    </p>
                    <p>Birth Year:
                        <input type='text' name='animal_birth_year'/>
                    </p>
                    <p>Age:
                        <input type='text' name='animal_age'/>
                    </p>
                    <p>
                        <input type='submit' value='Add Animal'/>
                    </p>
                </form>");
           
        }
        $connection = null;
        ?>
        
        
        
       
        

        
</body>
</html>