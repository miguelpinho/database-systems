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

/* 4. */
