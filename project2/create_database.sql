/* CREATE DATABASE IF NOT EXISTS vet_clinic; */
/* USE vet_clinic; */

DROP TABLE IF EXISTS produced_indicator CASCADE;
DROP TABLE IF EXISTS test_procedure CASCADE;
DROP TABLE IF EXISTS radiography CASCADE;
DROP TABLE IF EXISTS performed CASCADE;
DROP TABLE IF EXISTS procedures CASCADE;
DROP TABLE IF EXISTS indicator CASCADE;
DROP TABLE IF EXISTS prescription CASCADE;
DROP TABLE IF EXISTS medication CASCADE;
DROP TABLE IF EXISTS consult_diagnosis CASCADE;
DROP TABLE IF EXISTS diagnosis_code CASCADE;
DROP TABLE IF EXISTS participation CASCADE;
DROP TABLE IF EXISTS consult CASCADE;
DROP TABLE IF EXISTS animal CASCADE;
DROP TABLE IF EXISTS generalization_species CASCADE;
DROP TABLE IF EXISTS species CASCADE;
DROP TABLE IF EXISTS assistant CASCADE;
DROP TABLE IF EXISTS veterinary CASCADE;
DROP TABLE IF EXISTS client CASCADE;
DROP TABLE IF EXISTS phone_number CASCADE;
DROP TABLE IF EXISTS person CASCADE;

DROP VIEW IF EXISTS dim_animal, dim_date, facts_consults CASCADE;

CREATE TABLE person
    (VAT INTEGER,
     name VARCHAR(35),
     address_street VARCHAR(35),
     address_city VARCHAR(15),
     address_zip VARCHAR(15),
     PRIMARY KEY(VAT));

CREATE TABLE phone_number
    (VAT INTEGER,
     phone VARCHAR(15),
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
    (name VARCHAR(40),
     descript VARCHAR(255),
     PRIMARY KEY(name));

CREATE TABLE generalization_species
    (name1 VARCHAR(40),
     name2 VARCHAR(40),
     PRIMARY KEY(name1),
     FOREIGN KEY(name1) REFERENCES species(name),
     FOREIGN KEY(name2) REFERENCES species(name));

CREATE TABLE animal
    (name VARCHAR(35),
     VAT INTEGER,
     species_name VARCHAR(40),
     colour VARCHAR(15),
     gender VARCHAR(15),
     birth_year DATE,
     age INTEGER,
     PRIMARY KEY(name, VAT),
     FOREIGN KEY(VAT) REFERENCES client(VAT) ON DELETE CASCADE,
     FOREIGN KEY(species_name) REFERENCES species(name));

CREATE TABLE consult
    (name VARCHAR(35),
     VAT_owner INTEGER,
     date_timestamp TIMESTAMP,
     VAT_client INTEGER,
     VAT_vet INTEGER,
     weight NUMERIC(6,3) NOT NULL, /*Confirmem se é assim por favor!!!*/
     s VARCHAR(255),
     o VARCHAR(255),
     a VARCHAR(255),
     p VARCHAR(255),
     PRIMARY KEY(name, VAT_owner, date_timestamp),
     FOREIGN KEY(name, VAT_owner) REFERENCES animal(name, VAT) ON DELETE CASCADE,
     FOREIGN KEY(VAT_client) REFERENCES client(VAT),
     FOREIGN KEY(VAT_vet) REFERENCES veterinary(VAT),
     CHECK (weight > 0));

CREATE TABLE participation
    (name VARCHAR(35),
     VAT_owner INTEGER,
     date_timestamp TIMESTAMP,
     VAT_assistant INTEGER,
     PRIMARY KEY(name, VAT_owner, date_timestamp, VAT_assistant),
     FOREIGN KEY(name, VAT_owner, date_timestamp) REFERENCES consult(name, VAT_owner, date_timestamp) ON DELETE CASCADE,
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
     foreign key(name, VAT_owner, date_timestamp) references consult(name, VAT_owner, date_timestamp) ON DELETE CASCADE,
     foreign key(code) references diagnosis_code(code) ON DELETE CASCADE);

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
     PRIMARY KEY(code, name, VAT_owner, date_timestamp, name_med, lab, dosage),
     FOREIGN KEY(code, name, VAT_owner, date_timestamp) REFERENCES consult_diagnosis(code, name, VAT_owner, date_timestamp) ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY(name_med, lab, dosage) REFERENCES medication(name, lab, dosage));

CREATE TABLE indicator
    (name VARCHAR(35),
     reference_value NUMERIC(5, 2),
     units VARCHAR(10),
     descriptions VARCHAR(255),
     PRIMARY KEY(name));

CREATE TABLE procedures
    (name VARCHAR(35),
     VAT_owner INTEGER,
     date_timestamp TIMESTAMP,
     num INTEGER,
     descriptions VARCHAR(255),
     PRIMARY KEY(name, VAT_owner, date_timestamp, num),
     FOREIGN KEY(name, VAT_owner, date_timestamp) REFERENCES consult(name, VAT_owner, date_timestamp) ON DELETE CASCADE) ;

CREATE TABLE performed
    (name VARCHAR(35),
     VAT_owner INTEGER,
     date_timestamp TIMESTAMP,
     num INTEGER,
     VAT_assistant INTEGER,
     PRIMARY KEY(name, VAT_owner, date_timestamp, num, VAT_assistant),
     FOREIGN KEY(name, VAT_owner, date_timestamp, num) REFERENCES procedures(name, VAT_owner, date_timestamp, num) ON DELETE CASCADE,
     FOREIGN KEY(VAT_assistant) REFERENCES assistant(VAT));

CREATE TABLE radiography
    (name VARCHAR(35),
     VAT_owner INTEGER,
     date_timestamp TIMESTAMP,
     num INTEGER,
     file_path VARCHAR(50),
     PRIMARY KEY(name, VAT_owner, date_timestamp, num),
     FOREIGN KEY(name, VAT_owner, date_timestamp, num) REFERENCES procedures(name, VAT_owner, date_timestamp, num) ON DELETE CASCADE) ;

CREATE TABLE test_procedure
    (name VARCHAR(35),
     VAT_owner INTEGER,
     date_timestamp TIMESTAMP,
     num INTEGER,
     test_type VARCHAR(35),
     PRIMARY KEY(name, VAT_owner, date_timestamp, num),
     FOREIGN KEY(name, VAT_owner, date_timestamp, num) REFERENCES procedures(name, VAT_owner, date_timestamp, num) ON DELETE CASCADE) ;

CREATE TABLE produced_indicator
    (name VARCHAR(35),
     VAT_owner INTEGER,
     date_timestamp TIMESTAMP,
     num INTEGER,
     indicator_name VARCHAR(35),
     p_value NUMERIC(5, 2),
     PRIMARY KEY(name, VAT_owner, date_timestamp, num, indicator_name),
     FOREIGN KEY(name, VAT_owner, date_timestamp, num) REFERENCES test_procedure(name, VAT_owner, date_timestamp, num) ON DELETE CASCADE,
     FOREIGN KEY(indicator_name) REFERENCES indicator(name));
