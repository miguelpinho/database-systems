DROP FUNCTION IF EXISTS total_consults_year;
DROP PROCEDURE IF EXISTS to_centigrams;

DELIMITER $$

/* 4. calculate consults in a year */
CREATE FUNCTION total_consults_year(name VARCHAR(35),
    VAT_owner INTEGER, c_year INTEGER)
    RETURNS INTEGER
BEGIN
    DECLARE c_count INTEGER;
    SELECT COUNT(*) INTO c_count
    FROM consult
    WHERE consult.name = name AND consult.VAT_owner = VAT_owner
        AND YEAR(consult.date_timestamp) = c_year;
    RETURN c_count;
END$$

/* 5. change milligrams to centigrams */
CREATE PROCEDURE to_centigrams()
BEGIN
    UPDATE produced_indicator AS M
    INNER JOIN indicator AS I
    ON M.indicator_name = I.name
    SET M.p_value = M.p_value / 10.0 , M.name = M.name,
        M.VAT_owner = M.VAT_owner, M.date_timestamp = M.date_timestamp,
        M.num = M.num , M.indicator_name = M.indicator_name
    WHERE units = "milligrams";

    UPDATE indicator
    SET units = "centigrams", reference_value = reference_value / 10.0
    WHERE units = "milligrams";
end$$

DELIMITER ;
