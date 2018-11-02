CREATE TABLE person
	(VAT INTEGER,
	 name VARCHAR(35),
	 address_street VARCHAR(35),
	 address_city VARCHAR(15),
	 address_zip VARCHAR(15),
	 PRIMARY KEY(VAT));

CREATE TABLE phone_number
	(VAT integer,
	 phone integer,
	 PRIMARY KEY(VAT, phone),
	 FOREIGN KEY(VAT) REFERENCES person(VAT));

CREATE TABLE client
	(VAT INTEGER,
	 PRIMARY KEY(VAT),
	 FOREIGN KEY(VAT) REFERENCES person(VAT));

CREATE TABLE veterinary
	(VAT INTEGER,
	 specialization VARCHAR(20),
	 bio VARCHAR(255),
	 PRIMARY KEY(VAT),
	 FOREIGN KEY(VAT) REFERENCES person(VAT));

CREATE TABLE assistant
	(VAT INTEGER,
	 PRIMARY KEY(VAT),
	 FOREIGN KEY(VAT) REFERENCES person(VAT));

CREATE TABLE species
	(name VARCHAR(35),
	 descript VARCHAR(100),
	 PRIMARY KEY(name));

CREATE TABLE generalization_species
	(name1 VARCHAR(35),
	 name2 VARCHAR(35),
	 PRIMARY KEY(name1),
	 FOREIGN KEY(name1) REFERENCES species(name),
	 FOREIGN KEY(name2) REFERENCES species(name));
	 
CREATE TABLE animal
	(name VARCHAR(35),
	 VAT INTEGER,
	 species_name VARCHAR(35),
	 colour VARCHAR(15),
	 gender VARCHAR(15),
	 birth_year DATE);
/*Falta acabar o animal, não sei como se faz  A  idade xD*/

CREATE TABLE consult
	(name VARCHAR(35),
	 VAT_owner INTEGER,
	 date_timestamp timestamp,
	 s VARCHAR(255),
	 o VARCHAR(255),
	 a VARCHAR(255),
	 p VARCHAR(255),
	 VAT_client INTEGER,
	 VAT_vet INTEGER,
	 weight INTEGER NOT NULL, /*COnfimei se é assim por favor!!!*/
	 PRIMARY KEY(name, VAT_owner, date_timestamp),
	 FOREIGN KEY(name) REFERENCES animal(name),
	 FOREIGN KEY(VAT_owner) REFERENCES animal(VAT),
	 FOREIGN KEY(VAT_client) REFERENCES client(VAT),
	 FOREIGN KEY(VAT_vet) REFERENCES veterinary(VAT),
     CHECK (weight > 0));

CREATE TABLE participation
	(name VARCHAR(35),
	 VAT_owner INTEGER,
	 date_timestamp TIMESTAMP,
	 VAT_assistant INTEGER,
	 PRIMARY KEY(name, VAT_owner, date_timestamp, VAT_assistant),
	 FOREIGN KEY(name, VAT_owner, date_timestamp) REFERENCES consult(name, VAT_owner, date_timestamp),
	 FOREIGN KEY(VAT_assistant) references assistant(VAT));

CREATE TABLE diagnosis_code
	(code VARCHAR(255),
	 name VARCHAR(255),
	 PRIMARY KEY(code));
