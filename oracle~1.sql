select dbms_xdb_config.gethttpsport from dual;

alter session set "_ORACLE_SCRIPT"=true;  

CREATE USER SUDEEP IDENTIFIED BY "Manasvi1108";
GRANT CREATE TABLE TO SUDEEP;

GRANT DBA TO SUDEEP;
GRANT SYSDBA TO SUDEEP;