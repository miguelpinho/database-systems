/* 1. */
SELECT DISTINCT animal.name pet_name, owner.name owner_name, animal.species_name species, animal.age age
FROM consult
INNER JOIN person AS vet
    ON consult.VAT_vet = vet.VAT
INNER JOIN person AS owner
    ON consult.VAT_owner = owner.VAT
INNER JOIN animal
    ON consult.VAT_owner = animal.VAT and consult.name = animal.name
WHERE vet.name = "John Smith";

/* 2. */
SELECT name, reference_value
FROM indicator
WHERE units = "miligrams" AND reference_value > 100.0
ORDER BY reference_value DESC;

/* 3. */
SELECT animal.name,person.name ,animal.species_name, animal.age 
FROM animal 
INNER JOIN consult
    ON animal.VAT=consult.VAT_owner 
INNER JOIN person 
    ON animal.VAT=person.VAT 
WHERE s LIKE '%obese%' OR s LIKE '%obesity%' OR o LIKE '%obese%' OR o LIKE '%obesity%' OR  a LIKE '%obese%' OR a LIKE '%obesity%' OR  p LIKE '%obese%' OR p LIKE '%obesity%' AND weight>30;

/*NEW version*/
SELECT animal.name, person.name AS owner, animal.species_name, animal.age 
FROM
    ( 
        SELECT consult.name, consult.VAT_owner, consult.date_timestamp, consult.weight 
        FROM consult 
        WHERE consult.date_timestamp 
        IN ( 
            SELECT MAX(date_timestamp) 
            FROM consult 
            GROUP BY consult.VAT_owner
            ) 
        AND consult.weight>30
    )AS A 
    INNER JOIN 
    (
        SELECT * 
        FROM consult 
        WHERE o LIKE '%obese%' OR o LIKE '%obesity%'
    )AS B 
        ON A.VAT_owner=B.VAT_owner 
    INNER JOIN animal 
        ON  A.VAT_owner=animal.VAT 
    INNER JOIN person 
        ON animal.VAT=person.VAT;


/* 4. */
select person.name, person.VAT, person.address_street,person.address_city,person.address_zip 
FROM person 
INNER JOIN  client 
    ON person.VAT=client.VAT 
LEFT JOIN animal 
    ON client.VAT=animal.VAT 
WHERE animal.VAT IS NULL;

/* 5. */

/*PRIMEIRA SOLUCÃO*/
select distinct diagnosis_code.code, diagnosis_code.name, count(distinct prescription.name_med) 
FROM diagnosis_code 
INNER JOIN consult_diagnosis 
    ON diagnosis_code.code=consult_diagnosis.code 
LEFT JOIN  prescription 
    ON consult_diagnosis.code=prescription.code 
GROUP BY diagnosis_code.code
ORDER BY count(distinct prescription.name_med);

/*SEGUNDA SOLUÇÃO*/
select prescription.code,prescription.name_med, count(distinct name_med) 
FROM prescription 
GROUP BY code;

/* 6. */
SELECT AVG(consults2017.assists), AVG(consults2017.procds), AVG (consults2017.diagnos), AVG(consults2017.prescript)
FROM (
    SELECT name, VAT_owner, date_timestamp, assists, procds, diagnos, COUNT(code) AS prescript
    FROM (
        SELECT name, VAT_owner, date_timestamp, assists, procds, COUNT(code) AS diagnos
        FROM (
            SELECT name, VAT_owner, date_timestamp, assists, COUNT(num) AS procds
            FROM (
                SELECT name, VAT_owner, date_timestamp, COUNT(VAT_assistant) AS assists
                FROM consult
                LEFT JOIN participation
                    USING (name, VAT_owner, date_timestamp)
                WHERE YEAR(date_timestamp) IN (2017)
                GROUP BY name, VAT_owner, date_timestamp
            ) AS C
            LEFT JOIN procedures
                USING (name, VAT_owner, date_timestamp)
            GROUP BY name, VAT_owner, date_timestamp, assists
        ) AS C
        LEFT JOIN consult_diagnosis
            USING (name, VAT_owner, date_timestamp)
        GROUP BY name, VAT_owner, date_timestamp, assists, procds
    ) AS C
    LEFT JOIN prescription
        USING (name, VAT_owner, date_timestamp)
    GROUP BY name, VAT_owner, date_timestamp, assists, procds, diagnos
) AS consults2017;

SELECT AVG(consults2017.assists), AVG(consults2017.procds), AVG (consults2017.diagnos), AVG(consults2017.prescript)
FROM (
    SELECT name, VAT_owner, date_timestamp, COUNT(distinct prescription.code, name_med, lab, dosage) AS prescript, COUNT(distinct consult_diagnosis.code) AS diagnos, COUNT(distinct num) AS procds, COUNT(distinct VAT_assistant) AS assists
    FROM (((
        consult
            LEFT JOIN participation
                USING (name, VAT_owner, date_timestamp))
            LEFT JOIN procedures
                USING (name, VAT_owner, date_timestamp))
        LEFT JOIN consult_diagnosis
            USING (name, VAT_owner, date_timestamp))
    LEFT JOIN prescription
        USING (name, VAT_owner, date_timestamp)
		WHERE YEAR(date_timestamp) IN (2017)
    GROUP BY name, VAT_owner, date_timestamp
) AS consults2017;

/* 7. */
SELECT breed, name, freq
FROM (
    SELECT species_name breed, code, COUNT(code) freq
    FROM consult_diagnosis diagnosis
    INNER JOIN animal
        ON diagnosis.name = animal.name AND diagnosis.VAT_owner = animal.VAT
    WHERE animal.species_name in (select name1 breed from generalization_species where name2 = 'dog')
    GROUP BY breed, code
) AS disease_count
INNER JOIN diagnosis_code
    USING (code)
WHERE (breed, freq) IN (
    SELECT breed, max(freq) freq
    FROM (
        SELECT species_name breed, code, COUNT(code) freq
        FROM consult_diagnosis diagnosis
        INNER JOIN animal
            ON diagnosis.name = animal.name AND diagnosis.VAT_owner = animal.VAT
        WHERE animal.species_name in (select name1 breed from generalization_species where name2 = 'dog')
        GROUP BY breed, code
    ) AS disease_count
    GROUP BY breed
);

SELECT species_name breed, disease.name, COUNT(code) freq
FROM consult_diagnosis diagnosis
INNER JOIN animal
    ON diagnosis.name = animal.name AND diagnosis.VAT_owner = animal.VAT
INNER JOIN diagnosis_code disease
    using (code)
WHERE animal.species_name in (select name1 breed from generalization_species where name2 = 'dog')
GROUP BY breed, code
HAVING (breed, freq) IN (
    SELECT breed, max(freq) freq
    FROM (
        SELECT species_name breed, code, COUNT(code) freq
        FROM consult_diagnosis diagnosis
        INNER JOIN animal
            ON diagnosis.name = animal.name AND diagnosis.VAT_owner = animal.VAT
        WHERE animal.species_name in (select name1 breed from generalization_species where name2 = 'dog')
        GROUP BY breed, code
    ) AS disease_count
    GROUP BY breed
);

/* 8. */
SELECT name
FROM (
    select distinct VAT from animal
    UNION
    select distinct VAT_client VAT from consult
) AS costumer INNER JOIN (
    select VAT from veterinary
    UNION
    select VAT from assistant
) AS staff USING(VAT)
INNER JOIN person USING(VAT);

/* 9. */
SELECT name, address_street, address_city, address_zip
FROM client
INNER JOIN person
    USING (VAT)
WHERE VAT IN (SELECT DISTINCT VAT FROM animal A WHERE A.species_name = 'bird')
      AND VAT NOT IN (SELECT DISTINCT VAT FROM animal A WHERE A.species_name <> 'bird');
