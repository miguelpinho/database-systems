create table person
	(VAT integer,
	 name varchar(35),
	 address_street varchar(35),
	 address_city varchar(15),
	 address_zip varchar(15),
	 primary Key(VAT));

create table phone_number
	(VAT integer,
	 phone integer,
	 primary key(VAT, phone),
	 foreign key(VAT) references person(VAT));

create table client
	(VAT integer,
	 primary key(VAT),
	 foreign key(VAT) references person(VAT));

create table veterinary
	(VAT integer,
	 specialization varchar(20),
	 bio varchar(255),
	 primary key(VAT),
	 foreign key(VAT) references person(VAT));

create table assistant
	(VAT integer,
	 primary key(VAT),
	 foreign key(VAT) references person(VAT));

create table species
	(name varchar(35),
	 descript varchar(100),
	 primary key(name));

create table generalization_species
	(name1 varchar(35),
	 name2 varchar(35),
	 primary key(name1),
	 foreign key(name1) references species(name),
	 foreign key(name2) references species(name));
	 
create table animal
	(name varchar(35),
	 VAT integer,
	 species_name varchar(35),
	 colour varchar(15),
	 gender varchar(15),
	 birth_year date);
/*Falta acabar o animal, não sei como se faz  A  idade xD*/

create table consult
	(name varchar(35),
	 VAT_owner integer,
	 date_timestamp timestamp,
	 s varchar(255),
	 o varchar(255),
	 a varchar(255),
	 p varchar(255),
	 VAT_client integer,
	 VAT_vet integer,
	 weight integer not NULL, /*COnfimei se é assim por favor!!!*/
	 primary key(name, VAT_owner, date_timestamp),
	 foreign key(name) references animal(name),
	 foreign key(VAT_owner) references animal (VAT),
	 foreign key(VAT_client) references client(VAT),
	 foreign key( VAT_vet) references veterinary(VAT)
     check (weight >= 0));

create table participation
	(name varchar(255),
	 VAT_owner integer,
	 date_timestamp timestamp,
	 VAT_assistant integer,
	 primary key(name, VAT_owner, date_timestamp, VAT_assistant),
	 foreign key(name) references consult(name),
	 foreign key(VAT_owner) references consult(VAT_owner),
	 foreign key(date_timestamp) references consult(date_timestamp),
	 foreign key(VAT_assistant) references assistant(VAT));

create table diagnosis_code
	(code varchar(255),
	 name varchar(255),
	 primary key(code));
