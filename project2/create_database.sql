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
	 birth_year DATE,
	 age INTEGER,
	 PRIMARY KEY(name, VAT),
	 FOREIGN KEY(VAT) REFERENCES client(VAT),
	 FOREIGN KEY(species_name) REFERENCES species(name));


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

create table diagnosis_code
	(code varchar(50),
	 name varchar(35),
	 primary key(code));

create table consult_diagnosis
	(code varchar(50),
	 name varchar(35),
	 VAT_owner integer,
	 date_timestamp timestamp,
	 primary key(code, name, VAT_owner, date_timestamp),
	 foreign key(name) references consult(name),
	 foreign key(VAT_owner) references consult(VAT_owner),
	 foreign key(date_timestamp) references consult(date_timestamp),
	 foreign key(code) references diagnosis_code(code));

create table medication
	(name VARCHAR(35),
	 lab VARCHAR(35),
	 dosage INTEGER,
	 PRIMARY KEY(name, lab, dosage));

CREATE TABLE prescription 
	(code VARCHAR(50),
	 name VARCHAR(35),
	 VAT_owner INTEGER,
	 date_timestamp TIMESTAMP,
	 name_med VARCHAR(35),
	 lab VARCHAR(35),
	 dosage INTEGER,
	 regime VARCHAR(50),
	 PRIMARY KEY(code, name, VAT_owner, date_timestamp, name_med, lab,dosage),
	 FOREIGN KEY(code) REFERENCES consult_diagnosis(code),
	 FOREIGN KEY(name) REFERENCES consult_diagnosis(name),
	 FOREIGN KEY(VAT_owner) REFERENCES consult_diagnosis(VAT_owner),
	 FOREIGN KEY(date_timestamp) REFERENCES consult_diagnosis(date_timestamp),
	 FOREIGN KEY(name_med) REFERENCES medication(name),
	 FOREIGN KEY(lab) REFERENCES medication(lab),
	 FOREIGN KEY(dosage) REFERENCES medication(dosage));

CREATE TABLE indicator
	(name VARCHAR(35),
	 reference_value INTEGER,
	 units VARCHAR(10),
	 descriptions VARCHAR(255),
	 PRIMARY KEY(name),
	);

CREATE TABLE procedures
	(name VARCHAR(35),
	 VAT_owner INTEGER,
	 date_timestamp TIMESTAMP,
	 num INTEGER,
	 descriptions VARCHAR(255),
	 PRIMARY KEY(name, VAT_owner, date_timestamp, num),
	 FOREIGN KEY(name) REFERENCES consult(name),
	 FOREIGN KEY(VAT_owner) REFERENCES consult(VAT_owner),
	 FOREIGN KEY(date_timestamp) REFERENCES consult(date_timestamp));

CREATE TABLE performed
	(name VARCHAR(35),
	 VAT_owner INTEGER,
	 date_timestamp TIMESTAMP,
	 num INTEGER,
	 VAT_assistant INTEGER,
	 PRIMARY KEY(name, VAT_owner, date_timestamp, num, VAT_assistant),
	 FOREIGN KEY(name) REFERENCES procedures(name),
	 FOREIGN KEY(VAT_owner) REFERENCES procedures(VAT_owner),
	 FOREIGN KEY(date_timestamp) REFERENCES procedures(date_timestamp),
	 FOREIGN KEY(num) REFERENCES procedures(num),
	 FOREIGN KEY(VAT_assistant) REFERENCES assistant(VAT));

CREATE TABLE radiography
	(name VARCHAR(35),
	 VAT_owner INTEGER,
	 date_timestamp TIMESTAMP,
	 num INTEGER,
	 file_path VARCHAR(50),
	 PRIMARY KEY(name, VAT_owner, date_timestamp, num),
	 FOREIGN KEY(name) REFERENCES procedures(name),
	 FOREIGN KEY(VAT_owner) REFERENCES procedures(VAT_owner),
	 FOREIGN KEY(date_timestamp) REFERENCES procedures(date_timestamp),
	 FOREIGN KEY(num) REFERENCES procedures(num));

CREATE TABLE test_procedure
	(name VARCHAR(35),
	 VAT_owner INTEGER,
	 date_timestamp TIMESTAMP,
	 num INTEGER,
	 test_type VARCHAR(35),
	 PRIMARY KEY(name, VAT_owner, date_timestamp, num),
	 FOREIGN KEY(name) REFERENCES procedures(name),
	 FOREIGN KEY(VAT_owner) REFERENCES procedures(VAT_owner),
	 FOREIGN KEY(date_timestamp) REFERENCES procedures(date_timestamp),
	 FOREIGN KEY(num) REFERENCES procedures(num)
	);

CREATE TABLE produced_indicator
	(name VARCHAR(35),
	 VAT_owner INTEGER,
	 date_timestamp TIMESTAMP,
	 num INTEGER,
	 indicator_name VARCHAR(35),
	 p_value INTEGER,
	 PRIMARY KEY(name, VAT_owner, date_timestamp, num, indicator_name),
	 FOREIGN KEY(name) REFERENCES test_procedure(name),
	 FOREIGN KEY(VAT_owner) REFERENCES test_procedure(VAT_owner),
	 FOREIGN KEY(date_timestamp) REFERENCES test_procedure(date_timestamp),
	 FOREIGN KEY(num) REFERENCES test_procedure(num),
	 FOREIGN KEY(indicator_name) REFERENCES indicator(name));