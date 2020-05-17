--Create table space
CREATE TABLESPACE tbs1 
   DATAFILE 'tbs1_data.dbf' 
   SIZE 1m;
   
   
select * from dba_data_files;

SELECT 
   tablespace_name, 
   file_name, 
   bytes / 1024/ 1024  MB
FROM
   dba_data_files;
   
   
   
   BEGIN
   FOR counter IN 1..10000 loop
      INSERT INTO t1(c1)
      VALUES(sys_guid());
   END loop;
END;
/


-- check free spalce in TABLESPACE
SELECT 
   tablespace_name, 
   bytes / 1024 / 1024 MB
FROM 
   dba_free_space
WHERE 
   tablespace_name = 'TBS1';
   
   
   
   -- tABLE SPACE FULL
   ORA-01653: unable to extend table OT.T1 by 8 in tablespace TBS1
 -- Change tabelspace size
 
  ALTER DATABASE DATAFILE 'TBLS_DATA.dbf' RESIZE 10m;
-- DELETE TABLESPACE
DROP TABLESPACE TBLS2 including contents;


-- Extending a tablespace by adding a new datafile
-- https://www.oracletutorial.com/oracle-administration/oracle-extend-tablespace/

ALTER TABLESPACE TBLS ADD DATAFILE 'TBLS_DBF21.dbf' SIZE 50m;

-- auto extend the size of tablespace
ALTER TABLESPACE tablespace_name
    ADD DATAFILE 'path_to_datafile'
    SIZE size
    AUTOEXTEND ON;
	

-- Introduction to Oracle temporary tablespaces
-- A temporary tablespace, as its name implied, stores the temporary data that only exists during the database session.
-- Deafult Temp TABLESPACE
SELECT 
    property_name, 
    property_value 
FROM 
    database_properties 
WHERE 
    property_name='DEFAULT_TEMP_TABLESPACE';
	
select * from database_properties;