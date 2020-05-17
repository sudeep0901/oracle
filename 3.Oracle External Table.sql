CREATE directory lang_external AS 'E:\git\oracle';

GRANT READ, WRITE ON directory lang_external TO john;


--3) Creating the external TABLE

CREATE TABLE ORA_METADATA (
id INT,
table_name VARCHAR2(100),
description varchar2(200)
) 
ORGANIZATION EXTERNAL (
TYPE ORACLE_LOADER
DEFAULT DIRECTORY lang_external
ACCESS PARAMETERS
(FIELD TERMINATED BY ',')
LOCATION('OracleExtTable.csv')
);

--
--CREATE DATABASE LINK dblink 
--CONNECT TO root IDENTIFIED BY admin
--USING 'mariadb';


CREATE DATABASE LINK dblink 
    CONNECT TO root IDENTIFIED BY admin
    USING '(DESCRIPTION=
                (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=3309))
                (CONNECT_DATA=(SERVICE_NAME=localhost))
            )';

SELECT * FROM ORA_METADATA;


CREATE DATABASE LINK dblink 
    CONNECT TO root IDENTIFIED BY admin
    USING '(DESCRIPTION=
                (ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=3309))
                (CONNECT_DATA=(SERVICE_NAME=practice))
            )';

           
 SELECT  * FROM authors@dblink;



CREATE TABLE dup AS SELECT * FROM user_tables WHERE rownum =0;

SELECT * FROM dup;

SELECT rownum FROM user_tables;