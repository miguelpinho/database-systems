/* 1. */

select distinct animal.name, person.name, animal.species_name, animal.age FROM animal, client, person, consult, veterinary  WHERE animal.name=consult.name AND consult.VAT_vet=veterinary.VAT AND veterinary.VAT=person.VAT AND person.name="John Smith";
select distinct animal.name, d.name, animal.species_name, animal.age from animal,client, person d where d.VAT=client.VAT and animal.VAT =client.VAT and d.name in ( select distinct d.name from consult, person d,person, veterinary where consult.VAT_vet=veterinary.VAT and veterinary.VAT=person.VAT and person.name="John Smith" and d.VAT=consult.VAT_owner);

/* 2. */
select name, reference_value from indicator where units="miligrams" order by reference_value DESC;
/*SERÁ ASSIM TÃO SIMPLES?!?!?!?!*/

/* 3. */

/* 4. */

/* 5. */

/* 6. */
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

/* 7. */

/* 8. */

/* 9. */

