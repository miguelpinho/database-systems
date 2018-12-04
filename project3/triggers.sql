DROP TRIGGER IF EXISTS animal_age;
DROP PROCEDURE IF EXISTS check_vet_ic;
DROP TRIGGER IF EXISTS ins_assistant;
DROP TRIGGER IF EXISTS upd_assistant;
DROP PROCEDURE IF EXISTS check_assistant_ic;
DROP TRIGGER IF EXISTS ins_vet;
DROP TRIGGER IF EXISTS upd_vet;
DROP PROCEDURE IF EXISTS check_phone_ic;
DROP TRIGGER IF EXISTS ins_phone;
DROP TRIGGER IF EXISTS upd_phone;

delimiter $$

/* 1. update animal age */
CREATE TRIGGER animal_age AFTER INSERT ON consult
FOR EACH ROW
BEGIN
    DECLARE most_recent TIMESTAMP;

    SELECT MAX(date_timestamp) INTO most_recent
    FROM consult
    WHERE name = NEW.name AND VAT_owner = NEW.VAT_owner;

    UPDATE animal
    SET age = TIMESTAMPDIFF(YEAR, birth_year, most_recent), name = name,
        VAT = VAT, species_name = species_name,colour = colour,
        gender = gender, birth_year = birth_year
    WHERE name = NEW.name AND VAT = NEW.VAT_owner;
END$$


/* 2. ensure vet is not already assistant, and vice-versa */
CREATE PROCEDURE check_vet_ic
(IN VAT INTEGER)
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT assistant.VAT FROM assistant
                WHERE assistant.VAT = VAT) THEN
        SET msg = CONCAT("IC: person VAT ", VAT,
        " is already an assistant, cannot be a vet too.");

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$

CREATE TRIGGER ins_assistant BEFORE INSERT ON veterinary
FOR EACH ROW
BEGIN
    CALL check_vet_ic(NEW.VAT);
END$$

CREATE TRIGGER upd_assistant BEFORE UPDATE ON veterinary
FOR EACH ROW
BEGIN
    CALL check_vet_ic(NEW.VAT);
END$$

CREATE PROCEDURE check_assistant_ic
(IN VAT INTEGER)
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT veterinary.VAT FROM veterinary
        WHERE veterinary.VAT = VAT) THEN
        SET msg = CONCAT("IC: person VAT ", VAT,
        " is already a vet, cannot be a assistant too.");

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$

CREATE TRIGGER ins_vet BEFORE INSERT ON assistant
FOR EACH ROW
BEGIN
    CALL check_assistant_ic(NEW.VAT);
END$$

CREATE TRIGGER upd_vet BEFORE UPDATE ON assistant
FOR EACH ROW
BEGIN
    CALL check_assistant_ic(NEW.VAT);
END$$


/* 3. ensure a phone_number is unique */
CREATE PROCEDURE check_phone_ic
(IN phone VARCHAR(15))
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT phone_number.phone FROM phone_number
        WHERE phone_number.phone = phone) THEN
        SET msg = CONCAT("IC: someone already has phone number ",
           phone,  ".");

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$

CREATE TRIGGER ins_phone BEFORE INSERT ON phone_number
FOR EACH ROW
BEGIN
    CALL check_phone_ic(NEW.phone);
END$$

CREATE TRIGGER upd_phone BEFORE UPDATE ON phone_number
FOR EACH ROW
BEGIN
    CALL check_phone_ic(NEW.phone);
END$$

delimiter ;
