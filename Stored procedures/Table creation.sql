CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_CREATE_TABLES`()
BEGIN

/*DECLARING THE VARIABLES*/

DECLARE TABLE_COUNT INT;
DECLARE OPERATION_TYPE VARCHAR(50);
DECLARE LOG_DETAILS VARCHAR(50);
DECLARE PROCESS_NAME VARCHAR(30);
SET OPERATION_TYPE = 'CREATING THE TABLE FOR ALL THE LAYERS';
SET PROCESS_NAME = 'SP_CREATE_TABLES';


    
/*THIS IS THE AUDIT TABLE WHERE WE WILL CAPTURE ALL THE OPERATION AND DETAILS FOR AUDITING*/
CREATE TABLE HRDB_SYS_AUDIT_CONTROL
(OP_ID INT PRIMARY KEY AUTO_INCREMENT,  
SOURCE_NAME VARCHAR(30),
TARGET_NAME VARCHAR(30),
PROCESS_NAME VARCHAR(30),
OPERATION_TYPE VARCHAR(50),
SOURCE_COUNT INT,
TARGET_COUNT INT,
LOG_DETAILS VARCHAR(50),
OPERATED_BY VARCHAR(20),
OPERATION_DATE TIMESTAMP);

/*THIS IS THE STAGING AREA, WHERE WE ARE GOING TO DUMP ALL THE DATA COMING FROM THE CSV SOURCE*/

CREATE TABLE tbl_stg_actor
(
actor_id smallint,
first_name varchar(45),
last_name varchar(45),
last_update timestamp
); 

CREATE TABLE tbl_stg_country
(
country_id smallint,
country varchar(50),
last_update timestamp
); 

CREATE TABLE tbl_stg_film_category
(
film_id smallint,
category_id tinyint,
last_update timestamp
); 

CREATE TABLE tbl_stg_payment
(
payment_id smallint,
customer_id smallint,
staff_id tinyint,
rental_id int,
amount decimal(5,2),
payment_date datetime,
last_update timestamp
); 

CREATE TABLE tbl_stg_address
(
address_id smallint,
address varchar(50),
address2 varchar(50),
district varchar(20),
city_id smallint,
postal_code varchar(10),
phone varchar(20),
last_update timestamp
); 

CREATE TABLE tbl_stg_customer
(
customer_id smallint,
store_id tinyint,
first_name varchar(45),
last_name varchar(45),
email varchar(50),
address_id smallint,
active boolean,
create_date datetime,
last_update timestamp
); 

CREATE TABLE tbl_stg_film_text
(
film_id smallint,
title varchar(255),
description text
);

CREATE TABLE tbl_stg_rental
(
rental_id int,
rental_date datetime,
inventory_id mediumint,
customer_id smallint,
return_date datetime,
staff_id tinyint,
last_update timestamp
); 

CREATE TABLE tbl_stg_category
(
category_id tinyint,
name varchar(25),
last_update timestamp
); 

CREATE TABLE tbl_stg_film
(
film_id smallint,
title varchar(128),
description text,
release_year year,
language_id tinyint,
original_language_id tinyint,
rental_duration tinyint,
rental_rate decimal (4,2),
length smallint,
replacement_cost decimal(5,2),
rating varchar(5),
special_features varchar(20),
last_update timestamp); 

CREATE TABLE tbl_stg_inventory
(
inventory_id mediumint,
film_id smallint,
store_id tinyint,
last_update timestamp
); 

CREATE TABLE tbl_stg_staff
(
staff_id tinyint,
first_name varchar(45),
last_name varchar(45),
address_id smallint,
picture blob,
email varchar(50),
store_id tinyint,
active boolean,
username varchar(16),
password varchar(40),
last_update timestamp
); 

CREATE TABLE tbl_stg_city
(
city_id smallint,
city varchar(50),
country_id smallint,
last_update timestamp
); 


CREATE TABLE tbl_stg_film_actor
(
actor_id smallint,
film_id smallint,
last_update timestamp
); 

CREATE TABLE tbl_stg_language
(
language_id tinyint,
name char(20),
last_update timestamp
); 

CREATE TABLE tbl_stg_store
(
store_id tinyint,
manager_staff_id tinyint,
address_id smallint,
last_update timestamp
); 

/* This is transformation layer 1 where we will delete columns according to BRD */


CREATE TABLE tbl_trans1_actor
(
actor_id smallint,
first_name varchar(45),
last_name varchar(45),
last_update timestamp
); 

CREATE TABLE tbl_trans1_country
(
country_id smallint,
country varchar(50),
last_update timestamp
); 

CREATE TABLE tbl_trans1_film_category
(
film_id smallint,
category_id tinyint,
last_update timestamp
); 

CREATE TABLE tbl_trans1_payment
(
payment_id smallint,
customer_id smallint,
staff_id tinyint,
rental_id int,
amount decimal(5,2),
payment_date datetime,
last_update timestamp
); 

CREATE TABLE tbl_trans1_address
(
address_id smallint,
address varchar(50),
address2 varchar(50),
district varchar(20),
city_id smallint,
postal_code varchar(10),
phone varchar(20),
last_update timestamp
); 

CREATE TABLE tbl_trans1_customer
(
customer_id smallint,
store_id tinyint,
first_name varchar(45),
last_name varchar(45),
email varchar(50),
address_id smallint,
active boolean,
create_date datetime,
last_update timestamp
); 

CREATE TABLE tbl_trans1_film_text
(
film_id smallint,
title varchar(255),
description text
);

CREATE TABLE tbl_trans1_rental
(
rental_id int,
rental_date datetime,
inventory_id mediumint,
customer_id smallint,
return_date datetime,
staff_id tinyint,
last_update timestamp
); 

CREATE TABLE tbl_trans1_category
(
category_id tinyint,
name varchar(25),
last_update timestamp
); 

CREATE TABLE tbl_trans1_film
(
film_id smallint,
title varchar(128),
description text,
release_year year,
language_id tinyint,
original_language_id tinyint,
rental_duration tinyint,
rental_rate decimal (4,2),
length smallint,
replacement_cost decimal(5,2),
rating varchar(5),
special_features varchar(20),
last_update timestamp); 

CREATE TABLE tbl_trans1_inventory
(
inventory_id mediumint,
film_id smallint,
store_id tinyint,
last_update timestamp
); 

CREATE TABLE tbl_trans1_staff
(
staff_id tinyint,
first_name varchar(45),
last_name varchar(45),
address_id smallint,
picture blob,
email varchar(50),
store_id tinyint,
active boolean,
username varchar(16),
password varchar(40),
last_update timestamp
); 

CREATE TABLE tbl_trans1_city
(
city_id smallint,
city varchar(50),
country_id smallint,
last_update timestamp
); 


CREATE TABLE tbl_trans1_film_actor
(
actor_id smallint,
film_id smallint,
last_update timestamp
); 

CREATE TABLE tbl_trans1_language
(
language_id tinyint,
name char(20),
last_update timestamp
); 

CREATE TABLE tbl_trans1_store
(
store_id tinyint,
manager_staff_id tinyint,
address_id smallint,
last_update timestamp
); 

/*This is transformation layer 2 where we will concatenate columns,replace rating based on requirements and handle nulls*/

CREATE TABLE tbl_trans2_actor
( 
actor_id smallint,
first_name varchar(45),
last_name varchar(45),
last_update timestamp
);


CREATE TABLE tbl_trans2_address
(
address_id smallint,
address varchar(50),
address2 varchar(50),
district varchar(20),
city_id smallint,
postal_code varchar(10),
phone varchar(20),
last_update timestamp
); 

CREATE TABLE tbl_trans2_customer
(
customer_id smallint,
store_id tinyint,
first_name varchar(45),
last_name varchar(45),
email varchar(50),
address_id smallint,
active boolean,
create_date datetime,
last_update timestamp
); 

CREATE TABLE tbl_trans2_film
(
film_id smallint,
title varchar(128),
description text,
release_year year,
language_id tinyint,
original_language_id tinyint,
rental_duration tinyint,
rental_rate decimal (4,2),
length smallint,
replacement_cost decimal(5,2),
rating varchar(5),
special_features varchar(20),
last_update timestamp
);



/*THIS IS THE FINAL AREA, WHERE WE WE WILL HAVE ALL THE CLEANED DATA*/

CREATE TABLE tbl_fnlactor
(
actor_id smallint,
first_name varchar(45),
last_name varchar(45),
last_update timestamp
); 

CREATE TABLE tbl_fnl_country
(
country_id smallint,
country varchar(50),
last_update timestamp
); 

CREATE TABLE tbl_fnl_film_category
(
film_id smallint,
category_id tinyint,
last_update timestamp
); 

CREATE TABLE tbl_fnl_payment
(
payment_id smallint,
customer_id smallint,
staff_id tinyint,
rental_id int,
amount decimal(5,2),
payment_date datetime,
last_update timestamp
); 

CREATE TABLE tbl_fnl_address
(
address_id smallint,
address varchar(50),
address2 varchar(50),
district varchar(20),
city_id smallint,
postal_code varchar(10),
phone varchar(20),
last_update timestamp
); 

CREATE TABLE tbl_fnl_customer
(
customer_id smallint,
store_id tinyint,
first_name varchar(45),
last_name varchar(45),
email varchar(50),
address_id smallint,
active boolean,
create_date datetime,
last_update timestamp
); 

CREATE TABLE tbl_fnl_film_text
(
film_id smallint,
title varchar(255),
description text
);

CREATE TABLE tbl_fnl_rental
(
rental_id int,
rental_date datetime,
inventory_id mediumint,
customer_id smallint,
return_date datetime,
staff_id tinyint,
last_update timestamp
); 

CREATE TABLE tbl_fnl_category
(
category_id tinyint,
name varchar(25),
last_update timestamp
); 

CREATE TABLE tbl_fnl_film
(
film_id smallint,
title varchar(128),
description text,
release_year year,
language_id tinyint,
original_language_id tinyint,
rental_duration tinyint,
rental_rate decimal (4,2),
length smallint,
replacement_cost decimal(5,2),
rating varchar(5),
special_features varchar(20),
last_update timestamp); 

CREATE TABLE tbl_fnl_inventory
(
inventory_id mediumint,
film_id smallint,
store_id tinyint,
last_update timestamp
); 

CREATE TABLE tbl_fnl_staff
(
staff_id tinyint,
first_name varchar(45),
last_name varchar(45),
address_id smallint,
picture blob,
email varchar(50),
store_id tinyint,
active boolean,
username varchar(16),
password varchar(40),
last_update timestamp
); 

CREATE TABLE tbl_fnl_city
(
city_id smallint,
city varchar(50),
country_id smallint,
last_update timestamp
); 


CREATE TABLE tbl_fnl_film_actor
(
actor_id smallint,
film_id smallint,
last_update timestamp
); 

CREATE TABLE tbl_fnl_language
(
language_id tinyint,
name char(20),
last_update timestamp
); 

CREATE TABLE tbl_fnl_store
(
store_id tinyint,
manager_staff_id tinyint,
address_id smallint,
last_update timestamp
); 



SELECT COUNT(*) INTO TABLE_COUNT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='blueboxdvd';

IF TABLE_COUNT = 51 THEN
        SET LOG_DETAILS = 'ALL THE TABLES ARE CREATED SUCCESSFULLY';
ELSE
		SET LOG_DETAILS = 'THERE IS NO MISMATCH IN THE NUMBER OF TABLES';
END IF;


INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (
    PROCESS_NAME,
    OPERATION_TYPE,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        PROCESS_NAME,
        OPERATION_TYPE,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());

END