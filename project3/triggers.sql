DROP TRIGGER IF EXISTS animal_age;
DROP TRIGGER IF EXISTS ins_vet;
DROP TRIGGER IF EXISTS upd_vet;
DROP TRIGGER IF EXISTS ins_assistant;
DROP TRIGGER IF EXISTS upd_assistant;
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
    WHERE name = new.name AND VAT_owner = new.VAT_owner;

    UPDATE animal
    SET age = TIMESTAMPDIFF(YEAR, birth_year, most_recent), name = name,
        VAT = VAT, species_name = species_name,colour = colour,
        gender = gender, birth_year = birth_year
    WHERE name = new.name AND VAT = new.VAT_owner;
END$$


/* 2. ensure vet is not already assistant, and vice-versa */
CREATE TRIGGER ins_assistant BEFORE INSERT ON veterinary
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT assistant.VAT FROM assistant
                WHERE assistant.VAT = new.VAT) THEN
        SET msg =
        "IC: person is already an assistant, cannot be a vet too.";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$

CREATE TRIGGER upd_assistant BEFORE UPDATE ON veterinary
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT assistant.VAT FROM assistant
        WHERE assistant.VAT = new.VAT) THEN
        SET msg =
        "IC: person is already an assistant, cannot be a vet too.";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$

CREATE TRIGGER ins_vet BEFORE INSERT ON assistant
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT veterinary.VAT FROM veterinary
        WHERE veterinary.VAT = new.VAT) THEN
        SET msg =
        "IC: person is already a vet, cannot be a assistant too.";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$

CREATE TRIGGER upd_vet BEFORE UPDATE ON assistant
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT veterinary.VAT FROM veterinary
        WHERE veterinary.VAT = new.VAT) THEN
        SET msg =
        "IC: person is already a vet, cannot be a assistant too.";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$


/* 3. ensure a phone_number is unique */
CREATE TRIGGER ins_phone BEFORE INSERT ON phone_number
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT phone_number.phone FROM phone_number
        WHERE phone_number.phone = new.phone) THEN
        SET msg =
        "IC: someone already has this phone number.";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$

CREATE TRIGGER upd_phone BEFORE UPDATE ON phone_number
FOR EACH ROW
BEGIN
    DECLARE msg VARCHAR(255);
    IF EXISTS (SELECT P.phone FROM phone_number P
        WHERE P.phone = new.phone AND P.VAT <> new.VAT) THEN
        SET msg =
        "IC: someone already has this phone number.";

        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END$$

delimiter ;
