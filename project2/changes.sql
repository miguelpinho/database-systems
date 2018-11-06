/* 1. */
update person 
set address_street = 'Rua Comandante', address_city = 'Alcanena', address_zip = '2380-048' 
	where name = 'John Smith';

/* 2. */
update indicator 
	inner join produced_indicator 
		on indicator.name = produced_indicator.indicator_name 
	inner join test_procedure 
		on test_procedure.num = produced_indicator.num 
set reference_value = 1.1 *  reference_value
	where test_procedure.test_type = 'Blood analysis' 
	and indicator.units = 'miligrams';

/* 3. */
delete from client 
	where VAT in 
		(select VAT 
		from person 
			where name = 'John Smith')

/* 4. */
select code 
from diagnosis_code 
	where name = 'kidney failure';

INSERT INTO diagnosis_code
	VALUES ('AAHA 3333', 'end-stage renal disease');

update consult_diagnosis natural join (consult natural join (procedures natural join (test_procedure natural join produced_indicator))) set code = (select code from diagnosis_code where name = 'end-stage renal disease') where test_procedure.test_type = 'Blood analysis' and produced_indicator.p_value > 1.0;

