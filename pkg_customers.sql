create or replace package pkg_customers as
procedure add_new_customer
(p_first_name bank_customers.first_name%type,
p_last_name bank_customers.last_name%type,
p_father_name bank_customers.father_name%type,
p_email bank_customers.email%type,
p_mob_number bank_customers.mob_number%type,
p_country_name bank_countries.name%type,
p_regdate bank_customers.regdate%type);

procedure offer_loans_new_customers
(p_field_name varchar2);

end;

/

create or replace package body pkg_customers as
    procedure add_new_customer
        (p_first_name bank_customers.first_name%type,
        p_last_name bank_customers.last_name%type,
        p_father_name bank_customers.father_name%type,
        p_email bank_customers.email%type,
        p_mob_number bank_customers.mob_number%type,
        p_country_name bank_countries.name%type,
        p_regdate bank_customers.regdate%type)is
        
        v_country_id bank_countries.id%type;
        v_local_country constant varchar2(100):='Azerbaijan';
        v_resident number(1);
        v_datediffcount number;
    begin
        --get country id
        select id into v_country_id from bank_countries 
            where name=v_local_country;
        --get dates diff
        select sysdate-p_regdate into v_datediffcount from dual;
        --get resident or non-resident
        if upper(p_country_name)=upper(v_local_country) or  v_datediffcount>90 then 
            v_resident:=1;
            offer_loans_new_customer('Medenci');
        else 
            v_resident:=0;
        end if;
        --insert data
        insert into bank_customers(first_name,last_name,father_name,email,mob_number,country_id,resident,regdate)
        values(p_first_name,p_last_name,p_father_name,p_email,p_mob_number,v_country_id,v_resident,p_regdate);
        commit;
    end;
    
    procedure offer_loans_new_customers(p_field_name varchar2) is
    begin
        if p_field_name = 'Teacher' then
        dbms_output.put_line('5% 30000 azn');
        elsif p_field_name = 'Doctor' then
        dbms_output.put_line('4% 60000 azn');
        else
        dbms_output.put_line('kredit movcud deyil');
        end if;
    end;
end;

/
