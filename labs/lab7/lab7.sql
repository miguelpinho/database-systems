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
end $$



/*Question 3*/
select customer_name, MAX(abs_balance(customer_name)) 
from (
   select customer_name, abs_balance(customer_name) 
   from customer where abs_balance(customer_name)>0
   ) AS M $$


/*Question 4*/
create procedure list_accounts(in branch varchar(255)) 
begin 
   select customer_name 
   from depositor as d, account as a 
   where d.account_number=a.account_number 
   and 
   a.branch_name=branch; 
end$$


/*Question 6- Trigger*/

create trigger check_amount before update on loan 
for each row 
begin 
   if new.amount < 0 then  
      insert into account values (new.loan_number, new.branch_name, (-1)*new.amount); 
      insert into depositor (
         select customer_name, loan_number 
         from borrower as d 
         where d.loan_number=new.loan_number); 
      set new.amount=0; 
   end if; 
end$$

/*Question 7- Test Trigger*/
 update loan 
   set amount=amount-1200 
   where loan_number ='L-17';