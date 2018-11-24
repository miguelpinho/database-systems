DROP TRIGGER IF EXISTS animal_age;
DROP TRIGGER IF EXISTS already_assistant;
DROP TRIGGER IF EXISTS already_vet;

delimiter $$

/* 1. update animal age */
CREATE TRIGGER animal_age AFTER INSERT ON consult
FOR EACH ROW
BEGIN
    UPDATE animal
    SET age = TIMESTAMPDIFF(YEAR, birth_year, NOW())
    WHERE name = new.name AND VAT = new.VAT_owner;
END$$

/* 2. ensure vet is not already assistant, and vice-versa */
CREATE TRIGGER already_assistant BEFORE INSERT ON veterinary
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT assistant.VAT FROM assistant WHERE assistant.VAT = new.VAT) THEN
        SET msg = "IC: person is already an assistant, cannot be a vet too.";
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$

CREATE TRIGGER already_vet BEFORE INSERT ON assistant
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT veterinary.VAT FROM veterinary WHERE veterinary.VAT = new.VAT) THEN
        SET msg = "IC: person is already a vet, cannot be a assistant too.";
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$


delimiter ;
