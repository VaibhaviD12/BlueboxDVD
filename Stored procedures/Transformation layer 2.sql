CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_TRANS_HOP2`()
BEGIN
    DECLARE SOURCE1_TABLE VARCHAR(30);
    DECLARE TARGET1_TABLE VARCHAR(30);
    DECLARE SOURCE2_TABLE VARCHAR(30);
    DECLARE TARGET2_TABLE VARCHAR(30);
    DECLARE SOURCE3_TABLE VARCHAR(30);
    DECLARE TARGET3_TABLE VARCHAR(30);
    DECLARE SOURCE4_TABLE VARCHAR(30);
    DECLARE TARGET4_TABLE VARCHAR(30);
    DECLARE SOURCE1_COUNT INT;
    DECLARE TARGET1_COUNT INT;
     DECLARE SOURCE2_COUNT INT;
    DECLARE TARGET2_COUNT INT;
     DECLARE SOURCE3_COUNT INT;
    DECLARE TARGET3_COUNT INT;
     DECLARE SOURCE4_COUNT INT;
    DECLARE TARGET4_COUNT INT;
	DECLARE PROCESS_NAME VARCHAR(30);
    DECLARE OPERATION_TYPE VARCHAR(50);
    DECLARE LOG_DETAILS VARCHAR(50);
    
    SELECT 'tbl_trans1_actor' INTO SOURCE1_TABLE;
    SELECT 'tbl_trans2_actor' INTO TARGET1_TABLE;
    SET OPERATION_TYPE = 'CONCATENATING TWO COLUMNS IN THE TABLE';
    SET PROCESS_NAME = 'SP_TRANS_HOP2';
    
    SELECT COUNT(*) INTO SOURCE1_COUNT FROM tbl_trans1_actor;
    
    INSERT INTO tbl_trans2_actor
        SELECT 
         actor_id,
         concat(first_name,'',last_name) actor_name
        FROM
            tbl_trans1_actor;
            
    SELECT COUNT(*) INTO TARGET1_COUNT FROM tbl_trans2_actor;
    
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


 SELECT 'tbl_trans1_customer' INTO SOURCE2_TABLE;
    SELECT 'tbl_trans2_customer' INTO TARGET2_TABLE;
    SET OPERATION_TYPE = 'CONCATENATING TWO COLUMNS IN THE TABLE AND REPLACING EMAIL DOMAIN';
    SET PROCESS_NAME = 'SP_TRANS_HOP2';
    
    SELECT COUNT(*) INTO SOURCE2_COUNT FROM tbl_trans1_customer;
    
    INSERT INTO tbl_trans2_customer
        SELECT 
        customer_id,
        store_id,
		concat(first_name,'',last_name) customer_name,
        replace(email,sakilacustomer.org,blueboxdvd.com),
        address_id,
        active
        FROM
            tbl_trans1_customer;
            
    SELECT COUNT(*) INTO TARGET2_COUNT FROM tbl_trans2_customer;
    
    IF SOURCE2_COUNT <> TARGET2_COUNT THEN
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
        SOURCE_TABLE,
        TARGET2_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE2_COUNT,
        TARGET2_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());


SELECT 'tbl_trans1_address' INTO SOURCE3_TABLE;
    SELECT 'tbl_trans2_address' INTO TARGET3_TABLE;
    SET OPERATION_TYPE = 'HANDLING NULLS';
    SET PROCESS_NAME = 'SP_TRANS_HOP2';
    
    SELECT COUNT(*) INTO SOURCE3_COUNT FROM tbl_trans1_address;
    
    INSERT INTO tbl_trans2_address
        SELECT 
        address_id,
        address,
        district,
		city_id ,
         ifnull(postal_code,0),
        ifnull(phone,0000000000)
        FROM
            tbl_trans1_customer;
            
    SELECT COUNT(*) INTO TARGET3_COUNT FROM tbl_trans2_address;
    
    IF SOURCE3_COUNT <> TARGET3_COUNT THEN
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
        SOURCE3_TABLE,
        TARGET3_TABLE,
        PROCESS_NAME,
        OPERATION_TYPE,
        SOURCE3_COUNT,
        TARGET3_COUNT,
        LOG_DETAILS,
        CURRENT_USER(),
        CURRENT_TIMESTAMP());
        
        
        SELECT 'tbl_trans1_film' INTO SOURCE4_TABLE;
    SELECT 'tbl_trans2_film' INTO TARGET4_TABLE;
    SET OPERATION_TYPE = 'CHANGE RATING TEXT';
    SET PROCESS_NAME = 'SP_TRANS_HOP2';
    
    SELECT COUNT(*) INTO SOURCE4_COUNT FROM tbl_trans1_film;
    
    INSERT INTO tbl_trans2_film
        SELECT 
        film_id,
title,
description,
release_year,
language_id,
original_language_id,
rental_duration ,
rental_rate,
length,
replacement_cost 
rating,
special_features
FROM
            tbl_trans1_film;
            
     update tbl_trans2_film
     set rating = (CASE WHEN rating= 'G'  THEN "General Audience"
				 WHEN rating= 'PG' THEN "Parental Guidance"
                 WHEN rating= 'PG-13' THEN "Parents Strongly Cautioned "
                 WHEN rating= 'R' then "Restricted"
                 WHEN rating= 'NC-17' THEN "Adults only"
                 else null
			END);
            
    SELECT COUNT(*) INTO TARGET4_COUNT FROM tbl_trans4_customer;
    
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
END