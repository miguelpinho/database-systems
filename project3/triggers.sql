delimiter $$

/* 1. update animal age */
CREATE TRIGGER animal_age AFTER INSERT ON consult
FOR EACH ROW
BEGIN
    UPDATE animal
    SET age = TIMESTAMPDIFF(YEAR, birth_year, NOW())
    WHERE name = new.name AND VAT = new.VAT_owner;
END$$

/* 2. ensure vet is not assistant, or vice-versa */
CREATE TRIGGER already_assistant before INSERT ON veterinary
FOR EACH ROW
BEGIN

END$$


delimiter ;
