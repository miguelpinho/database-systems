/* 1. Test trigger update age */
INSERT INTO animal
VALUES ('Joshua', 15467, 'dog', 'yellow', 'male', '2001-03-03', 10);

SELECT age AS old_age FROM animal
WHERE name = 'Joshua' AND VAT = 15467;

INSERT INTO consult
VALUES ('Joshua', 15467, '2017-01-01 10:10:10', 12311, 4581,
        17.2, 's', 'o', 'a', 'p');

SELECT age AS new_age FROM animal
WHERE name = 'Joshua' AND VAT = 15467;

INSERT INTO consult
VALUES ('Joshua', 15467, '2016-01-01 10:10:10', 12311, 4581,
        17.2, 's', 'o', 'a', 'p');

SELECT age AS new_age FROM animal
WHERE name = 'Joshua' AND VAT = 15467;


/* 2. Test if a vet is allowed to be an assitant... */
INSERT INTO assistant VALUES (1010);
UPDATE assistant
    SET VAT = 1010
    WHERE VAT = 3366;

SELECT VAT FROM assistant;

/* ... and vice-versa */
INSERT INTO veterinary VALUES (5121, 'orthopedist', 'description');
UPDATE veterinary
    SET VAT = 5121, specialization = 'orthopedist', bio = '...'
    WHERE VAT = 1221;

SELECT VAT FROM veterinary;


/* 3. Test if the same phone_number can be used */
INSERT INTO phone_number VALUES (5121, '741-51251');
INSERT INTO phone_number VALUES (5121, '312-21189');
UPDATE phone_number
    SET phone = '741-51251'
    WHERE VAT = 77777 and phone = "412-34212";

SELECT * FROM phone_number WHERE VAT = 5121;
