/* 1. */

select distinct animal.name, person.name, animal.species_name, animal.age FROM animal, client, person, consult, veterinary  WHERE animal.name=consult.name AND consult.VAT_vet=veterinary.VAT AND veterinary.VAT=person.VAT AND person.name="John Smith";
/* 2. */

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

SELECT AVG(consults2017.assist), AVG(consults2017.prescript), AVG(consults2017.diagnos), AVG(consults2017.proced)  FROM
(
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

/* 8. */

/* 9. */

