REATE DEFINER=`root`@`localhost` PROCEDURE `SP_MASTER_SCRIPT`(IN STEP_TYPE VARCHAR(50), OUT OUTPUT VARCHAR(50))
BEGIN

IF STEP_TYPE = 'SP_CREATE_TABLES' THEN
        CALL SP_CREATE_TABLES();
        SET OUTPUT = 'SP_CREATE_TABLE RAN SUCCESSFULLY';
ELSEIF STEP_TYPE = 'SP_TRANS_HOP1' THEN
		CALL SP_TRANS_HOP1();
        SET OUTPUT = 'SP_TRANS_HOP1 RAN SUCCESSFULLY';
ELSEIF STEP_TYPE = 'SP_TRANS_HOP2' THEN 
		CALL SP_TRANS_HOP2();
        SET OUTPUT = 'SP_TRANS_HOP2 RAN SUCCESSFULLY';
ELSEIF STEP_TYPE = 'SP_FNL_HOP3' THEN
		CALL SP_FNL_HOP3();
        SET OUTPUT = 'SP_FNL_HOP3 RAN SUCCESSFULLY';
ELSEIF STEP_TYPE = 'SP_CONSTRAINT_ENABLE' THEN
		CALL SP_CONSTRAINT_ENABLE();
        SET OUTPUT = 'SP_CONSTRAINT_ENABLE RAN SUCCESSFULLY';
ELSE  SET OUTPUT = 'ENTER THE VALID OPTION';   
END IF;
    
END