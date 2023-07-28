create table bank_customers
(id number generated always as identity primary key,
first_name varchar2(30),
last_name varchar2(30),
father_name varchar2(30),
email varchar2(50) not null,
mob_number varchar2(50),
country_id number, constraint 
fk_bank_customers_country_id foreign key (country_id) references  bank_countries(id),
resident number,
regdate date);
