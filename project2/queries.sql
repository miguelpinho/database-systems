/* 1. */
select animal.name, person.name, animal.species_name, animal.age from consult, animal, veterinary, person WHERE consult.VAT_vet=veterinary.VAT AND veterinary.VAT=person.VAT AND person.name="john Smith";

/* 2. */

/* 3. */

/* 4. */

/* 5. */

/* 6. */
SELECT COUNT(*) FROM participation AS P WHERE YEAR(P.date_timestamp) IN (2017) GROUP BY P.name, P.VAT_owner, P.date_timestamp;

/* 7. */

/* 8. */

/* 9. */

