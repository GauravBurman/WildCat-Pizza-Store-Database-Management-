Drop database WILDCAT_PIZZA ;
Create database WILDCAT_PIZZA;

USE WILDCAT_PIZZA;


-- Creating Customers Table --
Create Table CUSTOMER (
Customer_ID int NOT NULL,
CLName varchar(25) not null,
CFName varchar(25) not null,
Cstreet_num integer not null,
Cstreet_name varchar(100) not null,
Ccity varchar(50) not null,
Cstate char(4) not null,
Cphone char(12) not null,
Referred_by varchar(10) default null,
CONSTRAINT CUSTOMER_PK primary key Customer(CUSTOMER_ID));

-- Loading Data in CUSTOMER table --
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/WildCat_Pizza Project/customer.txt' 
INTO TABLE CUSTOMER 
FIELDS TERMINATED BY ',' 
LINES terminated by '\r\n';

-- Creating Table EMPOYEE --
Create Table Employee(
EMP_ID int NOT NULL,
EFName varchar(15) NOT NULL,
ELName varchar(15) NOT NULL,
Estreet varchar(50) NOT NULL,
Ecity varchar(35) NOT NULL,
Estate  char(4) NOT NULL,
Ezip char(7) NOT NULL,
EPhone char(12) not null,
Emp_Role varchar(40)  not null,
constraint EMPLOYEE_PK primary key employee(emp_ID));

-- Loading Data in EMPLOYEE table --
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/WildCat_Pizza Project/employee.txt' 
INTO TABLE EMPLOYEE 
FIELDS TERMINATED BY ',' 
LINES terminated by '\n';

-- Creating table PRODUCT --
Create Table Product (
Product_ID int not null,
Product_size varchar(15) not null,
Product_Crust varchar(35) not null,
Product_Toppings varchar(50) not null,
Product_Price varchar(15) not null,
constraint Product_PK primary key Product(Product_ID));

-- Loading Data in PRODUCT Table --
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/WildCat_Pizza Project/Product.txt' 
INTO TABLE Product 
FIELDS TERMINATED BY ',' enclosed by '"' -- '"' required as we have a combination of toppings in some pizzas which are separated by commas --
LINES terminated by '\n'
set Product_Price=replace(Product_Price,'$',''); -- to remove dollar sign--
ALTER TABLE PRODUCT MODIFY Product_Price Decimal(10,2);  -- to change datatype of price field --


-- Creating ORDERS table -- 
Create table ORDERS (
Order_ID int not null,
Employee_ID int not null,
Customer_ID int not null,
Order_date DATETIME not null,
Order_Total varchar(15) not null,
constraint Orders_PK primary key Orders(Order_ID),
constraint Orders_Fk1 foreign key Orders(EMployee_ID) references EMPLOYEE(Emp_ID),
constraint Orders_Fk2 foreign key Orders(Customer_ID) references CUSTOMER(Customer_ID));


-- Loading Data in ORDERS Table --
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/WildCat_Pizza Project/ORDERS.txt' 
INTO TABLE ORDERS
FIELDS TERMINATED BY ',' 
LINES terminated by '\n'
set Order_Total=replace(Order_Total,'$',''); -- to remove dollar sign--
ALTER TABLE ORDERS MODIFY Order_Total Decimal(10,2);  -- to change datatype of price field --
-- running this query was giving 'read timeout error' so had to increase timeout limit to 600 seconds and unchecked 'Limit Rows' option in Edit-> Preferences -> SQL Editor --

-- Creating ORDERLINE Table -- 
create table ORDERLINE (
Orderline_ID int not null,
Order_ID int not null,
Product_ID int not null,
Quantity int not null,
Line_cost varchar(15) not null,
Constraint ORDERLINE_PK primary key ORDERLINE(Orderline_ID),
constraint ORDERLINE_FK1 foreign key ORDERLINE(Order_ID) references ORDERS(Order_ID),
constraint ORDERLINE_FK2 foreign key ORDERLINE(Product_ID) references Product(Product_ID));

-- Loading Data in Orderline Table --
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/WildCat_Pizza Project/Orderline.txt"
into table orderline
fields terminated by ','
lines terminated by '\n'
set Line_cost = replace(Line_cost, '$', '');
alter table Orderline modify Line_cost Decimal(10,2);

-- Creating Payment Table --  
Create table PAYMENT(
Payment_ID int not null,
Order_ID int not null,
Emp_ID int not null,
Customer_ID int not null,
Payment_Date  varchar(25) not null,
Amount_received varchar(15) not null,
Constraint PAYMENT_PK primary key Payment(Payment_ID),
constraint Payment_FK1 foreign key Payment(Order_ID) references ORDERS(Order_ID),
constraint Payment_FK2 foreign key Payment(Emp_ID) references Employee(Emp_ID),
constraint Payment_fk3 foreign key Payment(Customer_ID) references Customer(Customer_ID));
	
-- Loading Data in PAYMENT Table --
load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/WildCat_Pizza Project/Payment.txt"
into table Payment
fields terminated by ','
lines terminated by '\n'
set Amount_received = replace(Amount_received, '$', '');
alter table PAYMENT modify Amount_received Decimal(10,2);

-- ALL DATA IMPORTED -- --------------------------------------------------------------------------------------------------------------------------------------------------------


