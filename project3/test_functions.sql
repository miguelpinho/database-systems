/* 4. test count the total consults in a year */
SELECT total_consults_year('Charlie', 63799, 2017);

SELECT * FROM consult WHERE name = 'Charlie' AND VAT_owner = 63799;


/* 5. change units milligrams to to_centigrams */
SELECT name, reference_value, units FROM indicator
WHERE units = "milligrams";

SELECT M.name, M.VAT_owner, M.date_timestamp, M.num, M.indicator_name,
       M.p_value, I.units
FROM produced_indicator M
INNER JOIN indicator I
    ON M.indicator_name = I.name
WHERE I.units = "milligrams";

CALL to_centigrams();

SELECT name, reference_value, units FROM indicator
WHERE units = "centigrams";

SELECT M.name, M.VAT_owner, M.date_timestamp, M.num, M.indicator_name,
       M.p_value, I.units
FROM produced_indicator M
INNER JOIN indicator I
    ON M.indicator_name = I.name
WHERE I.units = "centigrams";
