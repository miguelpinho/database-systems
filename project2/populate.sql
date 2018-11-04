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
INSERT INTO assistant VALUES (1010);
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
VALUES (3366, 'Joana Jovane', 'Av. da Igreja', 'Lisboa', '1700-230');
INSERT INTO assistant VALUES (3366);
INSERT INTO phone_number VALUES (3366, '311412741');

INSERT INTO person
VALUES (4731, 'Poppy Pomfrey', 'Infirmary', 'Hogwarts', '12314-676');
INSERT INTO assistant VALUES (4731);
INSERT INTO phone_number VALUES (4731, '741-51251');

INSERT INTO person
VALUES (5766, 'Maester Luwin', 'Winterfell', 'The North',  '76132-312');
INSERT INTO assistant VALUES (5766);
INSERT INTO phone_number VALUES (5766, '671-21341');

INSERT INTO person
VALUES (12311, 'Harry Potter', 'Gryffindor Hall', 'Hogwartz', '12314-676');
INSERT INTO client VALUES (12311);
INSERT INTO phone_number VALUES (12311, '222-22222');

INSERT INTO person
VALUES (21321, 'Neville Longbottom', 'Gryffindor Hall', 'Hogwartz', '12314-676');
INSERT INTO client VALUES (21321);
INSERT INTO phone_number VALUES (21321, '111-11111');

INSERT INTO person
VALUES (71321, 'Arya Stark', 'Unkown', 'Unkown', 'xxx-xxxx');
INSERT INTO client VALUES (71321);

INSERT INTO person
VALUES (86137, 'Brandon Stark', 'Winterfell', 'The North', '76132-312');
INSERT INTO client VALUES (86137);
INSERT INTO phone_number VALUES (86137, '923-61233'), (86137, '134-31242'), (86137, '561-23141');

INSERT INTO person
VALUES (90909, 'Hodor', 'Hodor', 'Hodor', '90909-909');
INSERT INTO client VALUES (90909);
INSERT INTO phone_number VALUES (90909, '909-90909');

INSERT INTO person
VALUES (77777, 'John Snow', 'The Wall', 'The North', '67131-974');
INSERT INTO client VALUES (77777);
INSERT INTO phone_number VALUES (77777, '412-34212');

INSERT INTO person
VALUES (51361, 'Gandalf, the White', 'White Tower', 'Middle Earth', '41731-312');
INSERT INTO client VALUES (51361);
INSERT INTO phone_number VALUES (51361, '841-31412');

INSERT INTO person
VALUES (15467, 'Steven White', '1910 Pine Tree Lane', 'Washington', '20005'),
       (84698, 'Sarah Madrigal', '3097 Hinkle Lake Road', 'Binghamton', '13901'),
       (63799, 'Philip Fry', '1497 Giraffe Hill Drive', 'Irving', '75060'),
       (62736, 'Kelly Mueller', '2797 Bird Street', 'Columbus', '88029'),
       (41461, 'Joseph Mueller', '2797 Bird Street', 'Columbus', '88029'),
       (70627, 'Enrique Edwards', '2425 Penn Street', 'Columbia', '65202');
INSERT INTO client VALUES (15467), (84698), (63799), (62736), (70627);
INSERT INTO phone_number
VALUES (15467, '(309)218-6902'), (84698, '(914)545-5719'), (63799, '(702)454-7299'), (62736, '(860)359-0003'), (70627, '(254)298-0325');

/* species */
INSERT INTO species
VALUES ('mammal', 'Mammals are vertebrates, distinguished from reptiles (including birds) by the possession of a neocortex (a region of the brain), hair, three middle ear bones, and mammary glands.'),
       ('canidae', 'The biological family Canidae is a lineage of carnivorans that includes domestic dogs, wolves, coyotes, foxes, jackals, dingoes, and many other extant and extinct dog-like mammals.'),
       ('direwolf', 'The dire wolf (Canis dirus, "fearsome dog") is an extinct species of the genus Canis.'),
       ('dog', 'The domestic dog is a member of the genus Canis, which forms part of the wolf-like canids, and is the most widely abundant terrestrial carnivore'),
       ('pug', 'The Pug is a breed of dog with physically distinctive features of a wrinkly, short-muzzled face, and curled tail.'),
       ('golden retriever', 'The Golden Retriever is a large-sized breed of dog bred as gun dogs to retrieve shot waterfowl, such as ducks and upland game birds, during hunting and shooting parties.'),
       ('german sheppard', 'The German Shepherd is a breed of medium to large-sized working dog that originated in Germany.'),
       ('beagle', 'The Beagle is a breed of small hound that is similar in appearance to the much larger foxhound.'),
       ('border terrier', 'The Border Terrier is a small, rough-coated breed of dog in the terrier group.'),
       ('staffordshire bull terrier', 'The Staffordshire Bull Terrier is a medium-sized, short-coated breed of dog of English lineage and may be considered to be within the pit bull type.');

INSERT INTO generalization_species
VALUES ('canidae', 'mammal'), ('direwolf', 'canidae'), ('dog', 'canidae'),
       ('pug', 'dog'), ('golden retriever', 'dog'), ('german sheppard', 'dog'), ('beagle', 'dog'), ('border terrier', 'dog'), ('staffordshire bull terrier', 'dog');

INSERT INTO species
VALUES ('bird', 'Birds are a group of endothermic vertebrates, characterised by feathers, toothless beaked jaws, the laying of hard-shelled eggs, ...'),
       ('owl', 'Owls area a species of mostly solitary and nocturnal birds of prey typified by an upright stance, a large, broad head, binocular vision, binaural hearing, sharp talons, and feathers adapted for silent flight. ');
INSERT INTO generalization_species VALUES ('owl', 'bird');

INSERT INTO species
VALUES ('amphibian', 'Amphibians are ectothermic, tetrapod vertebrates of the class Amphibia.'),
       ('frog', 'A frog is any member of a diverse and largely carnivorous group of short-bodied, tailless amphibians composing the order Anura');
INSERT INTO generalization_species VALUES ('frog', 'amphibian');

/* animals */
INSERT INTO animal
VALUES ('Hedwig', 12311, 'owl', 'white', 'female', '2009-04-06', 9),
       ('Trevor', 21321, 'frog', 'green', 'male', '2008-12-12', 9),
       ('Hawk1', 51361, 'bird', 'white', 'male', '2001-06-10', 17),
       ('Hawk2', 51361, 'bird', 'white', 'male', '2001-06-11', 17),
       ('Hawk3', 51361, 'bird', 'white', 'male', '2001-06-12', 17),
       ('Summer', 86137, 'direwolf', 'silverly grey', 'male', '2010-04-10', 8),
       ('Nymeria', 71321, 'direwolf', 'grey', 'female', '2010-04-10', 8),
       ('Ghost', 77777, 'direwolf', 'white', 'male', '2010-04-10', 8);

INSERT INTO animal
VALUES ('Bailey', 15467, 'pug', 'white', 'male', '2010-12-07', 7),
       ('Bailey', , 'border terrier', 'black', 'male', '2011-01-13', 7),
       ('Max', , 'golden sheppard', 'golden', 'male', '2013-02-04', 5),
       ('Max', 15467, 'pug', 'brown', 'male', '2016-05-26', 2),
       ('Charlie', , 'beagle', 'white', 'male', '2016-04-08', 2),
       ('Buddy', , 'golden retriever', 'golden', 'male', '2013-02-26', 5),
       ('Bella', , 'pug', 'silverly grey', 'female', '2011-06-11', 7),
       ('Lucy', , 'golden sheppard', 'golden', 'female', '2010-02-25', 8),
       ('Daisy', , 'beagle', 'yellow', 'female', '2013-02-14', 5),
       ('Maggie', 15467, 'pug', 'pink', 'female', '2015-09-09', 3),
       ('Molly', , 'border terrier', 'white', 'female', '2009-09-16
', 9),
       ('Molly', , 'german sheppard', 'dark brown', 'female', '2017-09-05', 1);

/* diagnosis code */
INSERT INTO diagnosis_code
VALUES ('AAHA 3124', 'kidney failure'),
       ('AAHA 1832', 'insomnia'),
       ('AAHA 2141', 'obesity'),
       ('AAHA 1923', 'stress'),
       ('AAHA 3100', 'acute myocardial infraction'),
       ('AAHA 5651', 'osteoporosis'),
       ('AAHA 5314', 'superficial injury'),
       ('AAHA 3093', 'fracture'),
       ('AAHA 6731', 'asthma'),
       ('AAHA 3110', 'diabetes'),
       ('AAHA 1412', 'sleepyness'),
       ('AAHA 1913', 'pneumonia'),
       ('AAHA 0132', 'broken paw'),
       ('AAHA 8712', 'hypertension'),
       ('AAHA 5000', 'not aliveness');

/* medication */
INSERT INTO medication
VALUES ('Xanax', 'Niravam', 100),
       ('Calming Tea', 'Lipton', 1),
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
VALUES ('Hedwig', 12311, '2017-08-02 10:00:00', 12311, 4581, 14.1,
        'Biltong rump kielbasa pork pork belly bresaola kevin tail ham hock meatloaf tongue.', 'Ground round bresaola short ribs, tongue brisket chuck fatback t-bone picanha alcatra capicola.', 'Hamburger tenderloin ham, prosciutto cupim shankle chicken alcatra.', 'Corned beef cow sirloin beef leberkas salami short loin sausage ball tip pig.'),
       ('Hedwig', 12311, '2017-09-02 10:00:00', 21321, 1221, 14.7,
        's', 'o', 'a', 'p'),
       ('Hedwig', 12311, '2018-10-02 10:00:00', 12311, 9126, 15.3,
        's', 'o', 'a', 'p'),
       ('Hedwig', 12311, '2018-11-02 10:00:00', 12311, 1221, 14.9,
        's', 'o', 'a', 'p');

INSERT INTO consult
VALUES ('Summer', 86137, '2017-03-03 15:00:00', 86137, 1010, 20.0,
        'green dreams', 'sleepyness', 'a', 'p'),
       ('Summer', 86137, '2017-04-15 08:00:00', 90909, 9126, 25.3,
        'dreams with crows', 'insomnia', 'a', 'p'),
       ('Summer', 86137, '2017-05-31 12:00:00', 90909, 4581, 31.9,
        's', 'obese, fat', 'a', 'p');

/* assintants participating in consults */
INSERT INTO participation
VALUES ('Hedwig', 12311, '2017-08-02 10:00:00', 4731),
       ('Hedwig', 12311, '2017-08-02 10:00:00', 5121);

INSERT INTO participation
VALUES ('Summer', 86137, '2017-03-03 15:00:00', 1010),
       ('Summer', 86137, '2017-03-03 15:00:00', 3366),
       ('Summer', 86137, '2017-03-03 15:00:00', 5766),
       ('Summer', 86137, '2017-04-15 08:00:00', 5121),
       ('Summer', 86137, '2017-04-15 08:00:00', 5766);

/* consult diagnosis */
INSERT INTO consult_diagnosis
VALUES ('AAHA 1832', 'Hedwig', 12311, '2017-09-02 10:00:00');

INSERT INTO consult_diagnosis
VALUES ('AAHA 1412', 'Summer', 86137, '2017-03-03 15:00:00'),
       ('AAHA 1832', 'Summer', 86137, '2017-04-15 08:00:00'),
       ('AAHA 1923', 'Summer', 86137, '2017-04-15 08:00:00'),
       ('AAHA 2141', 'Summer', 86137, '2017-05-31 12:00:00');

/* presciption */
INSERT INTO prescription
VALUES ('AAHA 1832', 'Hedwig', 12311, '2017-09-02 10:00:00', 'Xanax', 'Niravam', 100, 'One pill one hour before bedtime');

INSERT INTO prescription
VALUES ('AAHA 1412', 'Summer', 86137, '2017-03-03 15:00:00', 'Calming Tea', 'Lipton', 1, 'Two doses a day'),
       ('AAHA 1832', 'Summer', 86137, '2017-04-15 08:00:00', 'Xanax', 'Niravam', 100, 'One pill one hour before bedtime');

/* procedures */
INSERT INTO procedures
VALUES ('Hedwig', 12311, '2017-09-02 10:00:00', 1, 'Complete blood analysis');

INSERT INTO test_procedure
VALUES ('Hedwig', 12311, '2017-09-02 10:00:00', 1, 'Blood analysis');

INSERT INTO produced_indicator
VALUES ('Hedwig', 12311, '2017-09-02 10:00:00', 1, 'hemoglobin', 140.0),
       ('Hedwig', 12311, '2017-09-02 10:00:00', 1, 'white blood cell count', 5.1),
       ('Hedwig', 12311, '2017-09-02 10:00:00', 1, 'creatine level', 0.4);

/* assistants performing procedures */
INSERT INTO performed
VALUES ('Hedwig', 12311, '2017-09-02 10:00:00', 1, 4731);

