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
WHERE units = "milligrams" AND reference_value > 100.0
ORDER BY reference_value DESC;

/*NEW version*/
SELECT animal.name, person.name AS owner, animal.species_name, animal.age
FROM (
    SELECT consult.name name, consult.VAT_owner
    FROM consult
    WHERE (consult.name, consult.VAT_owner, consult.date_timestamp)
    IN (
        SELECT consult.name, consult.VAT_owner, MAX(date_timestamp)
        FROM consult
        GROUP BY consult.name, consult.VAT_owner
    )
    AND consult.weight > 30
) AS A
INNER JOIN (
    SELECT DISTINCT consult.name name, consult.VAT_owner
    FROM consult
    WHERE o LIKE '%obese%' OR o LIKE '%obesity%'
)AS B
    ON A.VAT_owner = B.VAT_owner AND A.name = B.name
INNER JOIN animal
    ON  A.VAT_owner=animal.VAT
INNER JOIN person
    ON animal.VAT=person.VAT;

/* 4. */
SELECT person.name, person.VAT, person.address_street, person.address_city, person.address_zip
FROM person
INNER JOIN client
    USING (VAT)
LEFT JOIN animal
    ON person.VAT = animal.VAT
WHERE animal.VAT IS NULL;

/* 5. */
SELECT DISTINCT diagnosis_code.code, diagnosis_code.name, COUNT(DISTINCT prescription.name_med) AS n_medication
FROM diagnosis_code
LEFT JOIN consult_diagnosis
    USING (code)
LEFT JOIN  prescription
    USING (code)
GROUP BY diagnosis_code.code
ORDER BY COUNT(DISTINCT prescription.name_med);

/* 6. */
SELECT AVG(consults2017.assists) AS assistants_avg, AVG(consults2017.procds) AS procedures_avg, AVG (consults2017.diagnos) AS diagnosis_avg, AVG(consults2017.prescript) AS prescriptions_avg
FROM (
    SELECT name, VAT_owner, date_timestamp, COUNT(distinct prescription.code, name_med, lab, dosage) AS prescript, COUNT(distinct consult_diagnosis.code) AS diagnos, COUNT(distinct num) AS procds, COUNT(distinct VAT_assistant) AS assists
    FROM consult
    LEFT JOIN participation
        USING (name, VAT_owner, date_timestamp)
    LEFT JOIN procedures
        USING (name, VAT_owner, date_timestamp)
    LEFT JOIN consult_diagnosis
        USING (name, VAT_owner, date_timestamp)
    LEFT JOIN prescription
        USING (name, VAT_owner, date_timestamp)
    WHERE YEAR(date_timestamp) IN (2017)
    GROUP BY name, VAT_owner, date_timestamp
) AS consults2017;

/* 7. */
SELECT breed, name disease, freq
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
