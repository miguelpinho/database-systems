/* 1. */
EXPLAIN
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
EXPLAIN
SELECT name, reference_value
FROM indicator
WHERE units="miligrams" AND reference_value>100.0
ORDER BY reference_value DESC;

/* 6. */
EXPLAIN
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

EXPLAIN
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

