/* persons */
INSERT INTO person
VALUES (1221, 'John Smith', '5th Street', 'Manhathan', '12311-213');
INSERT INTO veterinary
VALUES (1221, 'surgeon', 'Bacon ipsum dolor amet sausage tongue drumstick, pork chop picanha shankle pork loin capicola corned beef shank porchetta bacon.');
INSERT INTO client VALUES (1221);
INSERT INTO phone_number VALUES (1221, '312-14124')
INSERT INTO phone_number VALUES (1221, '131-16514')

INSERT INTO person
VALUES (9126, 'Maddison Livy', '11th Street', 'Manhathan', '12311-301');
INSERT INTO veterinary
VALUES (9126, 'anesthesiologist', 'Veggies es bonus vobis, proinde vos postulo essum magis kohlrabi welsh onion daikon amaranth tatsoi tomatillo melon azuki bean garlic.');
INSERT INTO phone_number VALUES (9126, '412-13131')

INSERT INTO person
VALUES (5121, 'Ralph Lifshitz', 'The Bronx', 'New York City', '521231-123');
INSERT INTO assistant VALUES (5121)
INSERT INTO phone_number VALUES (5121, '231-81411')

INSERT INTO person
VALUES (12311, 'Harry Potter', 'Gryffindor Hall', 'Hogwartz', '12314-676');
INSERT INTO client VALUES (12311);
INSERT INTO phone_number VALUES (12311, '222-22222')

INSERT INTO person
VALUES (21321, 'Neville Longbottom', 'Gryffindor Hall', 'Hogwartz', '12314-676');
INSERT INTO client VALUES (21321);
INSERT INTO phone_number VALUES (21321, '111-11111')

/* species */
INSERT INTO species VALUES('mammal', 'Mammals are vertebrates, distinguished from reptiles (including birds) by the possession of a neocortex (a region of the brain), hair, three middle ear bones, and mammary glands.');

INSERT INTO species VALUES('bird', 'Birds are a group of endothermic vertebrates, characterised by feathers, toothless beaked jaws, the laying of hard-shelled eggs, ...');
INSERT INTO species VALUES('owl', 'Owls area a species of mostly solitary and nocturnal birds of prey typified by an upright stance, a large, broad head, binocular vision, binaural hearing, sharp talons, and feathers adapted for silent flight. ');
INSERT INTO generalization_species VALUES ('owl', 'bird');

INSERT INTO species VALUES('amphibian', 'Amphibians are ectothermic, tetrapod vertebrates of the class Amphibia.');
INSERT INTO species VALUES('frog', 'A frog is any member of a diverse and largely carnivorous group of short-bodied, tailless amphibians composing the order Anura');
INSERT INTO generalization_species VALUES ('frog', 'amphibian');

/* animals */
INSERT INTO animal
VALUES ('Hedwig', 12311, 'owl', 'white', 'female', '2009-12-12', 9);

INSERT INTO animal
VALUES ('Trevor', 21321, 'frog', 'green', 'male', '1992-12-12', 26);

/* consult */
