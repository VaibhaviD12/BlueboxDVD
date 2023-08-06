CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TRANS_HOP1`()
BEGIN
    DECLARE SOURCE1_TABLE VARCHAR(30);
    DECLARE TARGET1_TABLE VARCHAR(30);
    DECLARE SOURCE2_TABLE VARCHAR(30);
    DECLARE TARGET2_TABLE VARCHAR(30);
    DECLARE SOURCE3_TABLE VARCHAR(30);
    DECLARE TARGET3_TABLE VARCHAR(30);
	DECLARE SOURCE4_TABLE VARCHAR(30);
    DECLARE TARGET4_TABLE VARCHAR(30);
     DECLARE SOURCE5_TABLE VARCHAR(30);
    DECLARE TARGET5_TABLE VARCHAR(30);
     DECLARE SOURCE6_TABLE VARCHAR(30);
    DECLARE TARGET6_TABLE VARCHAR(30);
     DECLARE SOURCE7_TABLE VARCHAR(30);
    DECLARE TARGET7_TABLE VARCHAR(30);
     DECLARE SOURCE8_TABLE VARCHAR(30);
    DECLARE TARGET8_TABLE VARCHAR(30);
     DECLARE SOURCE9_TABLE VARCHAR(30);
    DECLARE TARGET9_TABLE VARCHAR(30);
     DECLARE SOURCE10_TABLE VARCHAR(30);
    DECLARE TARGET10_TABLE VARCHAR(30);
     DECLARE SOURCE11_TABLE VARCHAR(30);
    DECLARE TARGET11_TABLE VARCHAR(30);
     DECLARE SOURCE12_TABLE VARCHAR(30);
    DECLARE TARGET12_TABLE VARCHAR(30);
     DECLARE SOURCE13_TABLE VARCHAR(30);
    DECLARE TARGET13_TABLE VARCHAR(30);
     DECLARE SOURCE14_TABLE VARCHAR(30);
    DECLARE TARGET14_TABLE VARCHAR(30);
     DECLARE SOURCE15_TABLE VARCHAR(30);
    DECLARE TARGET15_TABLE VARCHAR(30);
    DECLARE SOURCE1_COUNT INT;
    DECLARE TARGET1_COUNT INT;
	DECLARE SOURCE2_COUNT INT;
    DECLARE TARGET2_COUNT INT;
	DECLARE SOURCE3_COUNT INT;
    DECLARE TARGET3_COUNT INT;
    DECLARE SOURCE4_TABLE INT;
    DECLARE TARGET4_TABLE INT;
     DECLARE SOURCE5_TABLE INT;
    DECLARE TARGET5_TABLE INT;
     DECLARE SOURCE6_TABLE INT;
    DECLARE TARGET6_TABLE INT;
     DECLARE SOURCE7_TABLE INT;
    DECLARE TARGET7_TABLE INT;
     DECLARE SOURCE8_TABLE INT;
    DECLARE TARGET8_TABLE INT;
     DECLARE SOURCE9_TABLE INT;
    DECLARE TARGET9_TABLE INT;
     DECLARE SOURCE10_TABLE INT;
    DECLARE TARGET10_TABLE INT;
     DECLARE SOURCE11_TABLE INT;
    DECLARE TARGET11_TABLE INT; 
     DECLARE SOURCE12_TABLE INT;
    DECLARE TARGET12_TABLE INT;
     DECLARE SOURCE13_TABLE INT;
    DECLARE TARGET13_TABLE INT;
     DECLARE SOURCE14_TABLE INT;
    DECLARE TARGET14_TABLE INT;
     DECLARE SOURCE15_TABLE INT;
    DECLARE TARGET15_TABLE INT;
    DECLARE PROCESS_NAME VARCHAR(30);
    DECLARE OPERATION_TYPE VARCHAR(50);
    DECLARE LOG_DETAILS VARCHAR(50);
    
    SELECT 'tbl_stg_actor' INTO SOURCE1_TABLE;
    SELECT 'tbl_trans1_actor' INTO TARGET1_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE1_COUNT FROM TBL_STG_EMPLOYEES;
    
    INSERT INTO tbl_trans1_actor 
        SELECT 
           actor_id,
          first_name,
          last_name ,
         last_update
        FROM
            tbl_stg_actor;
            
	alter table tbl_trans1_actor
     drop column last_update;
            
    SELECT COUNT(*) INTO TARGET1_COUNT FROM tbl_trans1_actor;
    
    IF SOURCE1_COUNT <> TARGET1_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE1_TABLE,
        TARGET1_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE1_COUNT,
        TARGET1_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());

    SELECT 'tbl_stg_country' INTO SOURCE2_TABLE;
    SELECT 'tbl_trans1_country' INTO TARGET2_TABLE;
    SET OPERATION_TYPE = 'Removing last_update column';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE2_COUNT FROM tbl_stg_country;
    
    INSERT INTO tbl_trans1_country
    SELECT 
		country_id ,
        country,
		last_update 
	FROM tbl_stg_country;
    
    alter table tbl_trans1_country
	drop column last_update;
   
            
    SELECT COUNT(*) INTO TARGET2_COUNT FROM tbl_trans1_country;
    
    IF SOURCE2_COUNT = TARGET2_COUNT THEN
        SET LOG_DETAILS = 'DATA LOADED SUCCESSFULLY';
    ELSE
        SET LOG_DETAILS = 'THERE IS SOME ISSUE, NEED TO CHECK';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE2_TABLE,
        TARGET2_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE2_COUNT,
        TARGET2_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());
        

    SELECT 'tbl_stg_film_category' INTO SOURCE3_TABLE;
    SELECT 'tbl_trans1_film_category' INTO TARGET3_TABLE;
    SET OPERATION_TYPE = 'Removing last_update column';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE3_COUNT FROM tbl_stg_film_category;
    
    INSERT INTO tbl_trans1_film_category
    SELECT 
		film_id,
        category_id,
        last_update
	FROM tbl_stg_film_category;
    
            
    SELECT COUNT(*) INTO TARGET3_COUNT FROM tbl_trans1_film_category;
    
    IF SOURCE3_COUNT = TARGET3_COUNT THEN
        SET LOG_DETAILS = 'DATA LOADED SUCCESSFULLY';
    ELSE
        SET LOG_DETAILS = 'THERE IS SOME ISSUE, NEED TO CHECK';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE3_TABLE,
        TARGET3_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE3_COUNT,
        TARGET3_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());
        
	SELECT 'tbl_stg_payment' INTO SOURCE4_TABLE;
    SELECT 'tbl_trans1_payment' INTO TARGET4_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE4_COUNT FROM tbl_stg_payment;
    
    INSERT INTO tbl_trans1_payment 
        SELECT 
          payment_id,
customer_id ,
staff_id ,
rental_id ,
amount,
payment_date ,
last_update 
        FROM
            tbl_stg_payment;
            
	alter table tbl_trans1_payment
     drop column last_update;
            
    SELECT COUNT(*) INTO TARGET4_COUNT FROM tbl_trans1_payment;
    
    IF SOURCE4_COUNT <> TARGET4_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE4_TABLE,
        TARGET4_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE4_COUNT,
        TARGET4_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());

     SELECT 'tbl_stg_address' INTO SOURCE5_TABLE;
    SELECT 'tbl_trans1_address' INTO TARGET5_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN AND ADDRESS2 COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE5_COUNT FROM tbl_stg_address;
    
    INSERT INTO tbl_trans1_address
        SELECT 
        address_id ,
address ,
address2 ,
district,
city_id,
postal_code,
phone,
last_update
FROM
            tbl_stg_address;
            
	alter table tbl_trans1_address
     drop column last_update;
     alter table tbl_trans1_address
     drop column address2;
            
    SELECT COUNT(*) INTO TARGET5_COUNT FROM tbl_trans1_payment;
    
    IF SOURCE5_COUNT <> TARGET5_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE5_TABLE,
        TARGET5_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE5_COUNT,
        TARGET5_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());
        
      SELECT 'tbl_stg_customer' INTO SOURCE6_TABLE;
    SELECT 'tbl_trans1_customer' INTO TARGET6_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN AND create date COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE6_COUNT FROM tbl_stg_address;
    
    INSERT INTO tbl_trans1_customer
        SELECT 
        customer_id ,
store_id ,
first_name,
last_name,
email,
address_id ,
active ,
create_date ,
last_update 
       
FROM
            tbl_stg_customer;
            
	alter table tbl_trans1_customer
     drop column last_update;
     alter table tbl_trans1_customer
     drop column create_date;
            
    SELECT COUNT(*) INTO TARGET6_COUNT FROM tbl_trans1_customer;
    
    IF SOURCE6_COUNT <> TARGET6_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE6_TABLE,
        TARGET6_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE6_COUNT,
        TARGET6_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());  
        
         SELECT 'tbl_stg_rental' INTO SOURCE7_TABLE;
    SELECT 'tbl_trans1_rental' INTO TARGET7_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE7_COUNT FROM tbl_stg_rental;
    
    INSERT INTO tbl_trans1_rental
        SELECT 
   rental_id,
rental_date,
inventory_id ,
customer_id,
return_date ,
staff_id,
last_update 

 FROM
            tbl_stg_rental;
            
	alter table tbl_trans1_rental
     drop column last_update;
   
            
    SELECT COUNT(*) INTO TARGET7_COUNT FROM tbl_trans1_rental;
    
    IF SOURCE7_COUNT <> TARGET7_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE7_TABLE,
        TARGET7_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE7_COUNT,
        TARGET7_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());   
        
    SELECT 'tbl_stg_category' INTO SOURCE8_TABLE;
    SELECT 'tbl_trans1_rental' INTO TARGET8_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE8_COUNT FROM tbl_stg_category;
    
    INSERT INTO tbl_trans1_category
        SELECT 
       category_id,
name ,
last_update

 FROM
            tbl_stg_category;
            
	alter table tbl_trans1_category
     drop column last_update;
   
            
    SELECT COUNT(*) INTO TARGET8_COUNT FROM tbl_trans1_category;
    
    IF SOURCE8_COUNT <> TARGET8_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE8_TABLE,
        TARGET8_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE8_COUNT,
        TARGET8_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());       
       
        SELECT 'tbl_stg_film' INTO SOURCE9_TABLE;
    SELECT 'tbl_trans1_film' INTO TARGET9_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN AND ORIGINAL_LANGUAGE_ID COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE9_COUNT FROM tbl_stg_film;
    
    INSERT INTO tbl_trans1_film
        SELECT 
       film_id,
title ,
description,
release_year,
language_id ,
original_language_id ,
rental_duration ,
rental_rate,
length,
replacement_cost ,
rating ,
special_features ,
last_update 

 FROM
            tbl_stg_film;
            
	alter table tbl_trans1_film
     drop column last_update;
   alter table tbl_trans1_film
     drop column original_language_id;
            
    SELECT COUNT(*) INTO TARGET9_COUNT FROM tbl_trans1_film;
    
    IF SOURCE9_COUNT <> TARGET9_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE9_TABLE,
        TARGET9_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE9_COUNT,
        TARGET9_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());       
        
         SELECT 'tbl_stg_inventory' INTO SOURCE10_TABLE;
    SELECT 'tbl_trans1_inventory' INTO TARGET10_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE10_COUNT FROM tbl_stg_inventory;
    
    INSERT INTO tbl_trans1_inventory
        SELECT 
       inventory_id ,
film_id ,
store_id ,
last_update 

 FROM
            tbl_stg_inventory;
            
	alter table tbl_trans1_inventory
     drop column last_update;
   
            
    SELECT COUNT(*) INTO TARGET10_COUNT FROM tbl_trans1_inventory;
    
    IF SOURCE10_COUNT <> TARGET10_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE10_TABLE,
        TARGET10_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE10_COUNT,
        TARGET10_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());    
        
   
         SELECT 'tbl_stg_staff' INTO SOURCE11_TABLE;
    SELECT 'tbl_trans1_inventory' INTO TARGET11_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE11_COUNT FROM tbl_stg_staff;
    
    INSERT INTO tbl_trans1_staff
        SELECT 
      staff_id ,
first_name,
last_name,
address_id,
picture ,
email,
store_id,
active ,
username,
password ,
last_update 
 FROM
            tbl_stg_staff;
            
	alter table tbl_trans1_staff
     drop column last_update;
   
            
    SELECT COUNT(*) INTO TARGET11_COUNT FROM tbl_trans1_staff;
    
    IF SOURCE11_COUNT <> TARGET11_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE11_TABLE,
        TARGET11_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE11_COUNT,
        TARGET11_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());      
        
        
         SELECT 'tbl_stg_city' INTO SOURCE12_TABLE;
    SELECT 'tbl_trans1_city' INTO TARGET12_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE12_COUNT FROM tbl_stg_city;
    
    INSERT INTO tbl_trans1_city
        SELECT 
      city_id ,
city ,
country_id ,
last_update 
 FROM
            tbl_stg_city;
            
	alter table tbl_trans1_city
     drop column last_update;
   
            
    SELECT COUNT(*) INTO TARGET12_COUNT FROM tbl_trans1_city;
    
    IF SOURCE12_COUNT <> TARGET12_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE12_TABLE,
        TARGET12_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE12_COUNT,
        TARGET12_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());      
        
        SELECT 'tbl_stg_film_actor' INTO SOURCE13_TABLE;
    SELECT 'tbl_trans1_film_actor' INTO TARGET13_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE13_COUNT FROM tbl_stg_film_actor;
    
    INSERT INTO tbl_trans1_film_actor
        SELECT 
     actor_id,
film_id ,
last_update 
 FROM
            tbl_stg_film_actor;
            
	alter table tbl_trans1_film_actor
     drop column last_update;
   
            
    SELECT COUNT(*) INTO TARGET13_COUNT FROM tbl_trans1_film_actor;
    
    IF SOURCE13_COUNT <> TARGET13_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE13_TABLE,
        TARGET13_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE13_COUNT,
        TARGET13_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());      
        
        
      SELECT 'tbl_stg_language' INTO SOURCE14_TABLE;
    SELECT 'tbl_trans1_language' INTO TARGET14_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE14_COUNT FROM tbl_stg_language;
    
    INSERT INTO tbl_trans1_language
        SELECT 
    language_id ,
name ,
last_update 
 FROM
            tbl_stg_language;
            
	alter table tbl_trans1_language
     drop column last_update;
   
            
    SELECT COUNT(*) INTO TARGET14_COUNT FROM tbl_trans1_language;
    
    IF SOURCE14_COUNT <> TARGET14_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE14_TABLE,
        TARGET14_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE14_COUNT,
        TARGET14_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());      
           
 
  SELECT 'tbl_stg_store' INTO SOURCE15_TABLE;
    SELECT 'tbl_trans1_store' INTO TARGET15_TABLE;
    SET OPERATION_TYPE = 'REMOVING LAST_UPDATE COLUMN';
    SET PROCESS_NAME = 'SP_TRANS_HOP1';
    
    SELECT COUNT(*) INTO SOURCE15_COUNT FROM tbl_stg_store;
    
    INSERT INTO tbl_trans1_store
        SELECT 
  store_id ,
manager_staff_id ,
address_id,
last_update 

 FROM
            tbl_stg_store;
            
	alter table tbl_trans1_store
     drop column last_update;
   
            
    SELECT COUNT(*) INTO TARGET15_COUNT FROM tbl_trans1_language;
    
    IF SOURCE15_COUNT <> TARGET15_COUNT THEN
        SET LOG_DETAILS = 'THERE IS A MISMATCH, NEED TO CHECK THE FLOW';
    ELSE
        SET LOG_DETAILS = 'THERE IS NO MISMATCH, DATA LOADED SUCCESSFULLY';
    END IF;
    
    INSERT INTO HRDB_SYS_AUDIT_CONTROL 
    (SOURCE_NAME,
    TARGET_NAME,
    PROCESS_NAME,
    OPERATION_TYPE,
    SOURCE_COUNT,
    TARGET_COUNT,
    LOG_DETAILS,
    OPERATED_BY,
	OPERATION_DATE)
    VALUES 
        (
        SOURCE15_TABLE,
        TARGET15_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE15_COUNT,
        TARGET15_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());      
    END