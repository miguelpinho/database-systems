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
GROUP BY diagnosis_code.code;

/*SEGUNDA SOLUÇÃO*/
select prescription.code,prescription.name_med, count(distinct name_med) 
FROM prescription 
GROUP BY code;


/* 6. */
/* old version
SELECT AVG(C.participants) FROM
    (SELECT COUNT(VAT_assistant) AS participants FROM
     consult LEFT JOIN participation USING (name, VAT_owner, date_timestamp)
     WHERE YEAR(date_timestamp) IN (2017)
     GROUP BY name, VAT_owner, date_timestamp) AS C;

SELECT AVG(C.procs) FROM
    (SELECT COUNT(num) AS procs FROM
     consult LEFT JOIN procedures USING (name, VAT_owner, date_timestamp)
     WHERE YEAR(date_timestamp) IN (2017)
     GROUP BY name, VAT_owner, date_timestamp) AS C;

SELECT AVG(C.diagnosis) FROM
    (SELECT COUNT(code) AS diagnosis FROM
     consult LEFT JOIN consult_diagnosis USING (name, VAT_owner, date_timestamp)
     WHERE YEAR(date_timestamp) IN (2017)
     GROUP BY name, VAT_owner, date_timestamp) AS C;

SELECT AVG(C.prescript) FROM
    (SELECT COUNT(code) AS prescript FROM
     consult LEFT JOIN prescription USING (name, VAT_owner, date_timestamp)
     WHERE YEAR(date_timestamp) IN (2017)
     GROUP BY name, VAT_owner, date_timestamp) AS C;
*/

SELECT AVG(consults2017.assist), AVG(consults2017.prescript), AVG(consults2017.diagnos), AVG(consults2017.proced)
FROM (
    SELECT COUNT(R.A) assist, COUNT(R.P) prescript, COUNT(R.D) diagnos, COUNT(R.M) proced
    FROM consult
    LEFT JOIN (
        SELECT name, VAT_owner, date_timestamp, VAT_assistant A, NULL P, NULL D, NULL M FROM participation
        UNION
        SELECT name, VAT_owner, date_timestamp, NULL A, num P, NULL D, NULL M FROM procedures
        UNION
        SELECT name, VAT_owner, date_timestamp, NULL A, NULL P, code D, NULL M FROM consult_diagnosis
        UNION
        SELECT name, VAT_owner, date_timestamp, NULL A, NULL P, NULL D, code M FROM prescription
    ) AS R USING (name, VAT_owner, date_timestamp)
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
