/*Question 1*/
 
 create function abs_balance( c_name varchar(255)) 
 returns numeric(20,2) 
 begin 
    declare have numeric(20,2); 
    declare no_money numeric(20,2); 
    select sum(balance) into have  
    from account 
    natural join depositor 
    where customer_name=c_name; 
    select sum(amount) into no_money 
    from loan 
    natural join borrower
    where customer_name=c_name; 
    return have-no_money; 