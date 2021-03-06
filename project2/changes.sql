/*** 1. ***/
/* VERIFICATION */
SELECT * FROM person WHERE name = 'John Smith';

/* CHANGE */
UPDATE person
SET address_street = 'Rua Comandante', address_city = 'Alcanena'
    WHERE name = 'John Smith';

/* VERIFICATION */
SELECT * FROM person WHERE name = 'John Smith';

/* 2. */
/* VERIFICATION */
SELECT indicator.name, units, test_type, reference_value
    FROM indicator INNER JOIN
        (test_procedure LEFT JOIN
            produced_indicator using
            (name, VAT_owner, date_timestamp, num))
        on produced_indicator.indicator_name = indicator.name;

/* CHANGE */
update indicator
    inner join
        (test_procedure left join
            produced_indicator using
            (name, VAT_owner, date_timestamp, num))
        on produced_indicator.indicator_name = indicator.name
set reference_value = 1.1 *  reference_value
    where test_procedure.test_type = 'blood'
    and indicator.units = 'milligrams';

/* VERIFICATION */
select indicator.name, units, test_type, reference_value
    from indicator inner join
        (test_procedure left join
            produced_indicator using
            (name, VAT_owner, date_timestamp, num))
        on produced_indicator.indicator_name = indicator.name;

/*** 3. ***/
/* VERIFICATION */
select person.name, count(client.VAT) as n_clients from person left join client on client.VAT = person.VAT where person.name = 'John Smith' group by person.name;

select person.name, count(veterinary.VAT) as n_veterinaries from person left join veterinary on veterinary.VAT = person.VAT where person.name = 'John Smith' group by person.name;

select person.name, count(animal.VAT) as n_animals from person left join animal on person.VAT = animal.VAT where person.name = 'John Smith' group by person.name;

select person.name, count(consult.name) as n_consults from person left join consult on consult.VAT_owner = VAT where person.name = 'John Smith' group by person.name;

/* CHANGE */
delete from client
    where VAT in
        (select VAT
        from person
            where name = 'John Smith');

/* VERIFICATION */
select person.name, count(client.VAT) as n_clients from person left join client on client.VAT = person.VAT where person.name = 'John Smith' group by person.name;

select person.name, count(veterinary.VAT) as n_veterinaries from person left join veterinary on veterinary.VAT = person.VAT where person.name = 'John Smith' group by person.name;

select person.name, count(animal.VAT) as n_animals from person left join animal on person.VAT = animal.VAT where person.name = 'John Smith' group by person.name;

select person.name, count(consult.name) as n_consults from person left join consult on consult.VAT_owner = VAT where person.name = 'John Smith' group by person.name;


/*** 4. ***/
/* VERIFICATION */
select * from diagnosis_code where name = 'end-stage renal disease';

 select test_type, diagnosis_code.name as diagnosis, indicator_name, p_value
 from diagnosis_code inner join (
     consult_diagnosis inner join (
         consult inner join (
             procedures inner join (
                 test_procedure inner join produced_indicator using (name, VAT_owner, date_timestamp, num))
            using(name, VAT_owner, date_timestamp, num))
        using (name, VAT_owner, date_timestamp))
    using(name, VAT_owner, date_timestamp))
on diagnosis_code.code = consult_diagnosis.code;

/* CHANGE */
select code
from diagnosis_code
    where name = 'kidney failure';

INSERT INTO diagnosis_code
    VALUES ('AAHA 3333', 'end-stage renal disease');

update consult_diagnosis
    inner join (
        consult inner join (
            procedures inner join (
                test_procedure inner join produced_indicator using (name, VAT_owner, date_timestamp, num))
            using(name, VAT_owner, date_timestamp, num))
        using (name, VAT_owner, date_timestamp))
    using(name, VAT_owner, date_timestamp)
    set code = (select code
                    from diagnosis_code
                    where name = 'end-stage renal disease'),
        name = name,
        VAT_owner = VAT_owner,
        date_timestamp = date_timestamp
    where produced_indicator.indicator_name = 'creatine level' and consult_diagnosis.code =
        (select code
        from diagnosis_code
        where name = 'kidney failure') and produced_indicator.p_value > 1.0 and test_procedure.test_type = 'blood';

/* VERIFICATION */
select * from diagnosis_code where name = 'end-stage renal disease';

select test_type, diagnosis_code.name as diagnosis, indicator_name, p_value
 from diagnosis_code inner join (
     consult_diagnosis inner join (
         consult inner join (
             procedures inner join (
                 test_procedure inner join produced_indicator using (name, VAT_owner, date_timestamp, num))
            using(name, VAT_owner, date_timestamp, num))
        using (name, VAT_owner, date_timestamp))
    using(name, VAT_owner, date_timestamp))
on diagnosis_code.code = consult_diagnosis.code;
