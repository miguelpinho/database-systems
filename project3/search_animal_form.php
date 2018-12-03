<html>
<body>
    <form action="execsearch.php" method="post">
        <p>Client VAT:
            <input type="number" min="0" name="VAT_client" required/>
        </p>
        <p>Owner Name:
            <input type="text" name="owner_name" required/>
        </p>  
        <p>Animal Name:
            <input type="text" name="animal_name" required/>
        </p>
        <p><input type="submit" value="Search"/></p>
        </form>
</body>
</html>