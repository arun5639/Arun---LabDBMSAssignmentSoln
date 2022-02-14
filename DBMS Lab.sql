/*
An E-commerce website manages its data in the form of various tables.

1)	You are required to create tables for supplier,customer,category,product,productDetails,order,rating to store the data for the E-commerce with the schema definition given below.
	Supplier(SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE)	
*/
create database EcommerceDB;
use EcommerceDB;

create table if not exists Supplier
	(SUPP_ID int not null, 
    SUPP_NAME varchar(20) default null, 
    SUPP_CITY varchar(10) default null, 
    SUPP_PHONE long, 
    primary key(SUPP_ID));
    
/*
Customer(CUS__ID,CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER)
*/
    
create table if not exists Customer
	(CUS_ID int not null,
    CUS_NAME varchar(20) default null,
    CUS_PHONE long,
    CUS_CITY varchar(20) default null,
    CUS_GENDER varchar(01) default null,
    primary key(CUS_ID));
    
/*
Category(CAT_ID,CAT_NAME)
*/
    
create table if not exists Category
	(CAT_ID int not null,
    CAT_NAME varchar(20) default null,
    primary key(CAT_ID));
   
/*
Product(PRO_ID,PRO_NAME,PRO_DESC,CAT_ID)
*/

create table if not exists Product
	(PRO_ID int not null,
    PRO_NAME varchar(20) default null,
    PRO_DESC varchar (40) default null,
    CAT_ID int default 0,
    primary key(PRO_ID),
    foreign key(CAT_ID) references Category(CAT_ID));

/*
ProductDetails(PROD_ID,PRO_ID,SUPP_ID,PRICE)
*/

create table if not exists Product_Details
	(PROD_ID int not null,
    PRO_ID int default 0,
    SUPP_ID int default 0,
    PRICE float default 0.0,
    primary key(PROD_ID),
    foreign key(PRO_ID) references Product(PRO_ID),
    foreign key(SUPP_ID) references Supplier(SUPP_ID));
    
/*
Order(ORD_ID,ORD_AMOUNT,ORD_DATE,CUS_ID,PROD_ID)
*/

create table if not exists Order_tb
	(ORD_ID int not null,
    ORD_AMOUNT float default 0.0,
    ORD_DATE date default "0001-01-01",
    CUS_ID int default null,
    PROD_ID int default null,
    primary key(ORD_ID),
    foreign key(CUS_ID) references Customer(CUS_ID),
    foreign key(PROD_ID) references Product_Details(PROD_ID));

/*
Rating(RAT_ID,CUS_ID,SUPP_ID,RAT_RATSTARS)
*/

create table if not exists Rating
	(RAT_ID int not null,
    CUS_ID int default 0,
    SUPP_ID int default 0,
    RAT_RATSTARS int default 0,
    primary key(RAT_ID),
    foreign key(CUS_ID) references Customer(CUS_ID),
    foreign key(SUPP_ID) references Supplier(SUPP_ID));

/*
Insert into Supplier
*/

insert into Supplier values(1, "Rajesh Retails", "Delhi", 1234567890);
insert into Supplier values(2, "Appario Ltd.", "Mumbai", 2589631470);
insert into Supplier values(3, "Knome products", "Bangalore", 9785462315);
insert into Supplier values(4, "Bansal Retails", "Kochi", 8975463285);
insert into Supplier values(5, "Mittal Ltd.", "Lucknow", 7898456532);

/*
Insert into Customer
*/
insert into Customer values(1, "AAKASH", 999999999, "Delhi", "M");
insert into Customer values(2, "AMAN", 9785463215, "Noida", "M");
insert into Customer values(3, "NEHA", 9999999999, "Mumbai", "F");
insert into Customer values(4, "MEGHA", 9994562399, "Kolkata", "F");
insert into Customer values(5, "PULKIT", 7895999999, "Lucknow", "M");

/*
Insert into Category
*/
insert into Category values(1, "Books");
insert into Category values(2, "Games");
insert into Category values(3, "Groceries");
insert into Category values(4, "Electronics");
insert into Category values(5, "Clothes");

/*
Insert into Product
*/
insert into product values(1, "GTAV", "DFJDJFDJFDJFDJFJF", 2);
insert into product values(2, "TSHIRT", "DFDFJDFJDKFD", 5);
insert into product values(3, "ROG LAPTOP", "DFNTTNTNTERND", 4);
insert into product values(4, "OATS", "REURENTBTOTH", 3);
insert into product values(5, "HARRY POTTER", "NBEMCTHTJTH", 1);

/*
Insert into Product_Details
*/
insert into Product_Details values(1, 1, 2, 1500);
insert into Product_Details values(2, 3, 5, 30000);
insert into Product_Details values(3, 5, 1, 3000);
insert into Product_Details values(4, 2, 3, 2500);
insert into Product_Details values(5, 4, 1, 1000);

/*
Insert into Order_tb
*/
insert into Order_tb values(20, 1500, "2021-10-12", 3, 5);
insert into Order_tb values(25, 30500, "2021-09-16", 5, 2);
insert into Order_tb values(26, 2000, "2021-10-05", 1, 1);
insert into Order_tb values(30, 3500, "2021-08-16", 4, 3);
insert into Order_tb values(50, 2000, "2021-10-06", 2, 1);

/*
Insert into Rating
*/
insert into Rating values(1, 2, 2, 4);
insert into Rating values(2, 3, 4, 3);
insert into Rating values(3, 5, 1, 5);
insert into Rating values(4, 1, 3, 2);
insert into Rating values(5, 4, 5, 4);

/*
3)	Display the number of the customer group by their genders 
	who have placed any order of amount greater than or equal to Rs.3000.
*/
select CUS_GENDER, count(CUS_ID) 
from Customer 
where CUS_ID in (Select CUS_ID from Order_tb where ORD_AMOUNT >= 3000) 
group by CUS_GENDER;

/*
4)	Display all the orders along with the product name ordered 
    by a customer having Customer_Id=2.
*/
select PRO_NAME, ORD_ID, ORD_AMOUNT, ORD_DATE, PROD_ID, PRICE
from Order_tb 
inner join Product_Details using (PROD_ID)
inner join Product using (PRO_ID)
where CUS_ID = 2;

/*
5)	Display the Supplier details who can supply more than one product.
*/
select SUPP_ID, SUPP_NAME, SUPP_CITY, SUPP_PHONE from Supplier 
inner join Product_Details using (SUPP_ID)
group by SUPP_ID
having count(SUPP_ID) > 1;

/*
6)	Find the category of the product whose order amount is minimum.
*/
select CAT_NAME as Category_with_Minimum_Order_Amt, min(ORD_AMOUNT) as Order_amount
from Order_tb
inner join Product_Details using (PROD_ID)
inner join Product using (PRO_ID)
inner join Category using (CAT_ID);

/*
7)	Display the Id and Name of the Product ordered after “2021-10-05”.
*/
select PRO_ID, PRO_NAME
from Order_tb 
inner join Product_Details using (PROD_ID)
inner join Product using (PRO_ID)
where ORD_DATE > "2021-10-05";

/*
8)	Display customer name and gender whose names start or end with character 'A'.
*/
select CUS_NAME, CUS_GENDER
from Customer
where CUS_NAME like "A%"
or CUS_NAME like "%A";

/*
9)	Create a stored procedure to display the Rating for a Supplier if 
	any along with the Verdict on that rating if any like if rating >4 
    then “Genuine Supplier” if rating >2 “Average Supplier” 
    else “Supplier should not be considered”.
*/
Delimiter //;
create procedure Rating_Det_proc()
begin
	select SUPP_ID, SUPP_NAME,
    case
		when RAT_RATSTARS > 4 then "Genuine Supplier"
        when RAT_RATSTARS > 2 then "Average Supplier"
        else "Supplier should not be considered"
    end as Verdict
    from Supplier 
    inner join Rating using (SUPP_ID);    
end //
Delimiter ;

call Rating_Det_proc();









    