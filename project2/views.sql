/* 1. */
create view dim_date as 
    (select date_timestamp,DAY(date_timestamp) as day, MONTH(date_timestamp) as month,YEAR(date_timestamp) as year 
        from consult);

/* VERIFICATION */
select * 
    from dim_date;

/* 2. */
create view dim_animal as 
    (select name as animal_name, VAT as animal_vat, species_name as species, age as age from 
        animal);

/* VERIFICATION */
select * 
    from dim_animal;

/* 3. */
create view facts_consults as 
    (select dim_animal.animal_name, dim_animal.animal_vat , dim_date.date_timestamp, count(distinct num) as num_procedures, count(distinct name_med) as num_medications
        from dim_date inner join (dim_animal 
            inner join ((consult 
                left join prescription using (name, VAT_owner, date_timestamp)) 
                    left join procedures using (name, VAT_owner, date_timestamp)) 
            on dim_animal.animal_name = consult.name and dim_animal.animal_vat = consult.VAT_owner) 
        on dim_date.date_timestamp = consult.date_timestamp
    group by dim_animal.animal_name, dim_animal.animal_vat, dim_date.date_timestamp);

/* VERIFICATION */
select * 
    from facts_consults;
