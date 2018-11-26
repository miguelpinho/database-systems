/* 4. test count the total consults in a year */
SELECT total_consults_year('Charlie', 63799, 2017);

SELECT * FROM consult WHERE name = 'Charlie' AND VAT_owner = 63799;

/* 5. change units milligrams to to_centigrams */
select name, reference_value, units from indicator where units = "milligrams";
select M.name, M.VAT_owner, M.date_timestamp, M.num, M.indicator_name, M.p_value, I.units from produced_indicator M inner join indicator I on M.indicator_name = I.name where I.units = "milligrams";

call to_centigrams();

select name, reference_value, units from indicator where units = "centigrams";
select M.name, M.VAT_owner, M.date_timestamp, M.num, M.indicator_name, M.p_value, I.units from produced_indicator M inner join indicator I on M.indicator_name = I.name where I.units = "centigrams";
