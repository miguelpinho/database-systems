/* 1. */
SELECT DISTINCT animal.name, d.name, animal.species_name, animal.age
FROM animal, client, person d
WHERE d.VAT=client.VAT AND animal.VAT=client.VAT AND d.name IN (
  SELECT DISTINCT d.name from consult, person d,person, veterinary WHERE consult.VAT_vet=veterinary.VAT AND veterinary.VAT=person.VAT AND person.name="John Smith" AND d.VAT=consult.VAT_owner);

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
WHERE units="miligrams" AND reference_value>100.0
ORDER BY reference_value DESC;

/* 3. */

/* 4. */

/* 5. */

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
/*
SELECT breed, name disease
FROM diagnosis_code D
RIGHT JOIN (
    SELECT breed, any_value(code) as code, max(freq)
    FROM (
        SELECT species_name breed, code, count(code) freq
        FROM (
            SELECT *
            FROM animal
            WHERE species_name in (select name1 breed from generalization_species where name2 = 'dog')
        ) AS dog
        RIGHT JOIN consult_diagnosis C
        ON dog.VAT = C.VAT_owner and dog.name = C.name
        GROUP BY breed, code
    ) AS disease
    GROUP BY breed
) AS by_breed
ON by_breed.code = D.code;
*/

SELECT species_name breed, code, COUNT(code) freq
FROM consult_diagnosis diagnosis
INNER JOIN animal
    ON diagnosis.name = animal.name AND diagnosis.VAT_owner = animal.VAT
WHERE animal.species_name in (select name1 breed from generalization_species where name2 = 'dog')
GROUP BY breed, code;
/*
SELECT *
FROM (
    SELECT species_name breed, code, count(code) freq
    FROM (
        SELECT *
        FROM animal
        WHERE species_name in (select name1 breed from generalization_species where name2 = 'dog')
    ) AS dog
    INNER JOIN consult_diagnosis C
    ON dog.VAT = C.VAT_owner and dog.name = C.name
    GROUP BY breed, code
) AS disease
ORDER BY breed, freq DESC;
*/

/*
SELECT *
FROM ( select name1 breed from generalization_species where name2 = 'dog') AS S LEFT JOIN animal A ON S.breed = A.species_name;
*/

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
