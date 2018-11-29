<html>
<body>    
    <?php
        $VAT_client = (integer)$_REQUEST['VAT_client'];
        $owner_name = $_REQUEST['owner_name'];
        $animal_name = $_REQUEST['animal_name'];
           
    
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

        $stmt = $connection->prepare("SELECT * FROM person WHERE VAT =:VAT");
        $result=$stmt ->execute([
            'VAT' => $VAT_client,
        ]);   

        if ($result== FALSE)
        {
            echo("Client search query");
            $info = $connection->errorInfo();
            echo("<p>Error: {$info[2]}</p>");
            exit();
        }
        $clients=$stmt->fetchAll();

        if(count($clients)>0)
        {
            foreach($clients as $client)
            {
                echo("<h4>Client:</h4>");
                echo("<table style=\"margin-bottom: 20px;\">");        
                echo("<tr>");                     
                echo("<td>{$client['VAT']}</td>");
                echo("<td>{$client['name']}</td>");
                echo("<td>{$client['address_street']}</td>");
                echo("<td>{$client['address_city']}</td>");
                echo("<td>{$client['address_zip']}</td>");                                     
                echo("</tr>\n"); 
                echo("</table>");
            }
        }else
        {
            echo("<p>Client not found</p>\n");
            echo("<form action='search_animal_form.php' method='post'> 
            <input type='submit' value='Go To Homepage'/>           
            </form>");
        }
        /*
        $sql="SELECT distinct animal.name as animals_name, animal.VAT as owner_vat, person.name as owner_name 
            FROM animal, person 
            WHERE person.VAT=animal.VAT AND  animal.name LIKE '%$animal_name%' AND person.name LIKE '%$owner_name%'";
        $result = $connection->query($sql);
        $rows = $result->fetchAll(); 
        $num_rows = count($rows);
        */
        /*echo("$owner_name");*/

        $stmt = $connection->prepare("SELECT distinct animal.name as animals_name, animal.VAT as owner_vat, person.name as owner_name 
        FROM animal, person 
        WHERE person.VAT=animal.VAT AND  animal.name= :animal_name AND person.name LIKE CONCAT('%',:owner_name,'%')");
        $result=$stmt ->execute([
            'animal_name' => $animal_name,
            'owner_name' => $owner_name,
        ]);

        if ($result== FALSE)
        {
            echo("Animal search query");
            $info = $connection->errorInfo();
            echo("<p>Error: {$info[2]}</p>");
            exit();
        }

        $result =$stmt->fetchAll();
        $num_rows = count($result);
                  
        if($num_rows > 0 && count($clients)>0)
        {
            echo("<h4>Animals:</h4>");
            echo("<table border=\"1\">
                    <tr>
                    <td><em>animal name</em></td>
                    <td><em>VAT_owner</em></td>
                    <td><em>Owner name</em></td>                
                    </tr>"
                );
            foreach($result as $row)
            {           
                    echo("<tr>");                     
                    echo("<td>{$row['animals_name']}</td>");
                    echo("<td>{$row['owner_vat']}</td>");
                    echo("<td>{$row['owner_name']}</td>");
                    echo("<td><a href=\"animal_consults.php?animal_name=");
                    echo($row['animals_name']);
                    echo("&owner_vat=");  
                    echo($row['owner_vat']);
                    echo("&client_vat=");  
                    echo($VAT_client);
                    echo("\">See Medical Record</a></td>\n");                               
                    echo("</tr>\n");   
            }  
            echo("</table>");  
            echo("<form action='search_animal_form.php' method='post'> 
             <input type='submit' value='Go To Homepage'/>           
        </form>"); 
        }
        elseif(count($clients)>0)
        {
            echo("<h3>No animal found</h3>\n");
            echo("<h2>Add animal:</h2>\n");
            echo("<form action='search_animal_form.php' method='post'> 
            <input type='submit' value='Go To Homepage'/>           
            </form>"); 
            echo("<form action='create_animal.php' method='post'>
                    <p>Name:
                        <input type='text' name='animal_name'/>
                    </p>
                    <p>
                        <input type='hidden' name='VAT_owner' value='$VAT_client'/>
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