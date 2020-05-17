INSERT ALL
    INTO table_name(col1,col2,col3) VALUES(val1,val2, val3)
    INTO table_name(col1,col2,col3) VALUES(val4,val5, val6)
    INTO table_name(col1,col2,col3) VALUES(val7,val8, val9)
Subquery;

SELECT CURRENT_DATE FROM dual;


-- check if any object is locked
SELECT * FROM v$LOCKED_OBJECT ;


select sid,serial#,username from v$session;

SELECT * FROM v$parameter;


SELECT
    name,
    value
FROM
    v$parameter
WHERE
    name = 'max_string_size';
    
--   SHOW PARAMETER max_string_size;
   
   SELECT
    *
FROM
    nls_database_parameters
WHERE
    PARAMETER = 'NLS_NCHAR_CHARACTERSET';
    
   SELECT * FROM cat;
   
  
  SELECT
  *
FROM
  nls_database_parameters
WHERE
  parameter = 'NLS_CHARACTERSET';
  
 
