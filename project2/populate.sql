/* persons */
INSERT INTO person
VALUES (1221, 'John Smith', '5th Street', 'Manhathan', '12311-213');
INSERT INTO veterinary
VALUES (1221, 'surgeon', 'Bacon ipsum dolor amet sausage tongue drumstick, pork chop picanha shankle pork loin capicola corned beef shank porchetta bacon.');
INSERT INTO client VALUES (1221);
INSERT INTO phone_number VALUES (1221, '312-14124'), (1221, '131-16514');

INSERT INTO person
VALUES (1010, 'Jorge Joaquim', 'Av. da Liberdade', 'Lisboa', '1250-144');
INSERT INTO veterinary
VALUES (1010, 'general medicine', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, nisl rutrum vestibulum.');
INSERT INTO phone_number VALUES (1010, '313671312'), (1010, '989123412');

INSERT INTO person
VALUES (9126, 'Maddison Livy', '11th Street', 'Manhathan', '12311-301');
INSERT INTO veterinary
VALUES (9126, 'anesthesiologist', 'Veggies es bonus vobis, proinde vos postulo essum magis kohlrabi welsh onion daikon amaranth tatsoi tomatillo melon azuki bean garlic.');
INSERT INTO phone_number VALUES (9126, '412-13131');

INSERT INTO person
VALUES (4581, 'João Jovane', 'Av. da Igreja', 'Lisboa', '1700-230');
INSERT INTO veterinary
VALUES (4581, 'dietician', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, nisl rutrum vestibulum.');
INSERT INTO phone_number VALUES (4581, '311312676');

INSERT INTO person
VALUES (5121, 'Ralph Lifshitz', 'The Bronx', 'New York City', '521231-123');
INSERT INTO assistant VALUES (5121);
INSERT INTO phone_number VALUES (5121, '231-81411');

INSERT INTO person
VALUES (4731, 'Poppy Pomfrey', 'Infirmary', 'Hogwarts', '12314-676');
INSERT INTO assistant VALUES (4731);
INSERT INTO phone_number VALUES (4731, '741-51251');

INSERT INTO person
VALUES (12311, 'Harry Potter', 'Gryffindor Hall', 'Hogwartz', '12314-676');
INSERT INTO client VALUES (12311);
INSERT INTO phone_number VALUES (12311, '222-22222');

INSERT INTO person
VALUES (21321, 'Neville Longbottom', 'Gryffindor Hall', 'Hogwartz', '12314-676');
INSERT INTO client VALUES (21321);
INSERT INTO phone_number VALUES (21321, '111-11111');

/* species */
INSERT INTO species
VALUES('mammal', 'Mammals are vertebrates, distinguished from reptiles (including birds) by the possession of a neocortex (a region of the brain), hair, three middle ear bones, and mammary glands.');

INSERT INTO species
VALUES('bird', 'Birds are a group of endothermic vertebrates, characterised by feathers, toothless beaked jaws, the laying of hard-shelled eggs, ...'),
      ('owl', 'Owls area a species of mostly solitary and nocturnal birds of prey typified by an upright stance, a large, broad head, binocular vision, binaural hearing, sharp talons, and feathers adapted for silent flight. ');
INSERT INTO generalization_species VALUES ('owl', 'bird');

INSERT INTO species
VALUES('amphibian', 'Amphibians are ectothermic, tetrapod vertebrates of the class Amphibia.'),
      ('frog', 'A frog is any member of a diverse and largely carnivorous group of short-bodied, tailless amphibians composing the order Anura');
INSERT INTO generalization_species VALUES ('frog', 'amphibian');

/* animals */
INSERT INTO animal
VALUES ('Hedwig', 12311, 'owl', 'white', 'female', '2009-04-06', 9),
       ('Trevor', 21321, 'frog', 'green', 'male', '2008-12-12', 9);

/* diagnosis code */
INSERT INTO diagnosis_code
VALUES ('AHAA 3124', 'kidney failure'),
       ('AHAA 1832', 'insomnia'),
       ('AHAA 2141', 'obesity'),
       ('AHAA 1923', 'stress'),
       ('AHAA 3100', 'heart problem'),
       ('AHAA 3110', 'diabetes'),
       ('AHAA 1412', 'sleepyness'),
       ('AHAA 0132', 'broken paw'),
       ('AHAA 5000', 'not aliveness');

/* medication */
INSERT INTO medication
VALUES ('Xanax', 'Niravam', 100),
       ('Snake Oil', 'Magicians Lta.', 202),
       ('Radaway', 'VaultTec', 1),
       ('Buffout', 'VaultTec', 1),
       ('Brufen', 'FP', 400),
       ('Brufen', 'FP', 600);

/* indicators */
INSERT INTO indicator
VALUES ('blood pressure', 100.0, 'miligrams', 'description'),
       ('hemoglobin', 150.0, 'miligrams', 'The RBC indices measure the size, shape, and physical characteristics of the RBCs.'),
       ('mean cell volume', 100.0, 'fL', 'The RBC indices measure the size, shape, and physical characteristics of the RBCs.'),
       ('white blood cell count', 5.0, 'x10^9/L', 'The RBC indices measure the size, shape, and physical characteristics of the RBCs.'),
       ('c-reactive protein', 5.0, 'miligrams', 'The RBC indices measure the size, shape, and physical characteristics of the RBCs.'),
       ('creatine level', 0.5, 'miligrams', 'description');

/* consult */
INSERT INTO consult
VALUES ('Hedwig', 12311, '2018-08-02 10:00:00', 12311, 4581, 14.1,
        'Biltong rump kielbasa pork pork belly bresaola kevin tail ham hock meatloaf tongue.', 'Ground round bresaola short ribs, tongue brisket chuck fatback t-bone picanha alcatra capicola.', 'Hamburger tenderloin ham, prosciutto cupim shankle chicken alcatra.', 'Corned beef cow sirloin beef leberkas salami short loin sausage ball tip pig.'),
       ('Hedwig', 12311, '2018-09-02 10:00:00', 21321, 1221, 14.7,
        's', 'o', 'a', 'p'),
       ('Hedwig', 12311, '2018-10-02 10:00:00', 12311, 9126, 15.3,
        's', 'o', 'a', 'p'),
       ('Hedwig', 12311, '2018-11-02 10:00:00', 12311, 1221, 14.9,
        's', 'o', 'a', 'p');

/* assintants participating in consults */
INSERT INTO participation
VALUES ('Hedwig', 12311, '2018-08-02 10:00:00', 4731);

/* consult diagnosis */
INSERT INTO consult_diagnosis
VALUES ('AHAA 1832', 'Hedwig', 12311, '2018-09-02 10:00:00');

/* presciption */
INSERT INTO prescription
VALUES ('AHAA 1832', 'Hedwig', 12311, '2018-09-02 10:00:00', 'Xanax', 'Niravam', 100, 'One pill one hour before bedtime');

/* procedures */
INSERT INTO procedures
VALUES ('Hedwig', 12311, '2018-09-02 10:00:00', 1, 'Complete blood analysis');

INSERT INTO test_procedure
VALUES ('Hedwig', 12311, '2018-09-02 10:00:00', 1, 'Blood analysis');

INSERT INTO produced_indicator
VALUES ('Hedwig', 12311, '2018-09-02 10:00:00', 1, 'hemoglobin', 140.0),
       ('Hedwig', 12311, '2018-09-02 10:00:00', 1, 'white blood cell count', 5.1),
       ('Hedwig', 12311, '2018-09-02 10:00:00', 1, 'creatine level', 0.4);

/* assistants performing procedures */
INSERT INTO performed
VALUES ('Hedwig', 12311, '2018-09-02 10:00:00', 1, 4731);

