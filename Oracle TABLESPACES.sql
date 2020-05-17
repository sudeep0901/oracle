
--Create table space
 CREATE TABLESPACE tbs1 DATAFILE 'tbs1_data.dbf' SIZE 1 m;

SELECT
	*
FROM
	dba_data_files;

SELECT
	tablespace_name,
	file_name,
	bytes / 1024 / 1024 MB
FROM
	dba_data_files;
BEGIN
	FOR counter IN 1..10000
LOOP
		INSERT
	INTO
	t1(c1)
VALUES(sys_guid());
END
LOOP;
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
 ORA-01653: unable TO extend TABLE OT.T1 BY 8 IN tablespace TBS1
-- Change tabelspace size
 ALTER DATABASE DATAFILE 'TBLS_DATA.dbf' RESIZE 10 m;
-- DELETE TABLESPACE
 DROP TABLESPACE TBLS2 INCLUDING contents;
-- Extending a tablespace by adding a new datafile
-- https://www.oracletutorial.com/oracle-administration/oracle-extend-tablespace/
 ALTER TABLESPACE TBLS ADD DATAFILE 'TBLS_DBF21.dbf' SIZE 50 m;
-- auto extend the size of tablespace
 ALTER TABLESPACE tablespace_name ADD DATAFILE 'path_to_datafile' SIZE SIZE AUTOEXTEND ON;
-- Introduction to Oracle temporary tablespaces
-- A temporary tablespace, as its name implied, stores the temporary data that only exists during the database session.

-- Deafult Temp TABLESPACE
 SELECT
	property_name,
	property_value
FROM
	database_properties
WHERE
	property_name = 'DEFAULT_TEMP_TABLESPACE';

SELECT
	*
FROM
	database_properties;

SELECT
	*
FROM
	dba_temp_free_space;

CREATE TEMPORARY TABLESPACE TEMP2 TEMPFILE 'temp2.dbf' SIZE 10 m;
--Next, find all temporary tablespaces in the current Oracle Database:
 SELECT
	*
FROM
	dba_temp_files;
	

ALTER DATABASE DEFAULT TEMPORARY TABLESPACE temp2;

DROP tablespace temp2 INCLUDING contents AND DATAFILEs;
--SQL Error [12906] [72000]: ORA-12906: cannot drop default temporary tablespace

