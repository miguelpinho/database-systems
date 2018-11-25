<html>
<body>
    <?php
    $animal_name=$_REQUEST['animal_name'];
    $vat_owner=$_REQUEST['owner_vat'];
    $vat_client=$_REQUEST['client_vat'];
    ?>
    <h1> Add a new consult for <?=$animal_name?></h>
    <h2>Please fill the form for a new consult</h2>

    <form id="myForm" action='add_consult.php?animal_name=<?=$animal_name?>&owner_vat=<?=$vat_owner?>&client_vat=<?=$vat_client?>&num_codes=' method="post">
        <h4>Identification</h4>
        <p>Veterinary  VAT:
            <input type="text" name="vet_vat"/>
        </p>
        <p>Animal weight:
            <input type="text" name="weight"/>
        </p> 
        <p>
            <input type='hidden' name='date' value='<?=date("Y-m-d H:i:s") ?>'/>
        </p>
        <h4>Consult notes</h4>
        <p>
            <p>S:</p>
            <textarea name="s" rows="3" cols="40"></textarea>
        </p>
        <p>
            <p>O:</p>
            <textarea name="o" rows="3" cols="40"></textarea>
        </p>
        <p>
            <p>A:</p>
            <textarea name="a" rows="3" cols="40"></textarea>
        </p>
        <p>
            <p>P:</p>
            <textarea name="p" rows="3" cols="40"></textarea>
        </p>
        <div id="myDIV" >
            <h4 style="margin:5px">Diagnosis Codes</h4>
            <input type="text" id="myInput" placeholder="Code...">
            <span onclick="newElement()" >Add</span>
        </div>

        <ul id="mycodes">                   
        </ul>

        <script>
        // Create a new list item when clicking on the "Add" button
        var num_codes=0;
        // Create a new list item when clicking on the "Add" button
            function newElement() {
                var li = document.createElement("li");
                var input = document.createElement("input");
                var inputValue = document.getElementById("myInput").value;
                var t = document.createTextNode(inputValue);                
                li.appendChild(t);
                
                if (inputValue === '') {
                    alert("You must write something!");
                } else {
                	num_codes++;
                    input.setAttribute("type", "hidden");
                    input.setAttribute("value", inputValue);    
                    input.setAttribute("name", num_codes);
                   
                    document.getElementById("mycodes").appendChild(li);
                    document.getElementById("mycodes").appendChild(input);
                }
                document.getElementById("myInput").value = ""; 
            };
            function myFunction(){
                var x = document.getElementById("myForm").action;                
                var z=x+num_codes;               
                document.getElementById("myForm").action=z;
            }
            
        </script>
            
        <p><input onclick="myFunction()" type="submit" value="Submit"/></p>
    </form>
    
</body>
</html>