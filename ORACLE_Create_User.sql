alter session set "_ORACLE_SCRIPT"=true;

CREATE USER JOHN identified BY abcd1234;

SELECT * FROM DBA_USERS WHERE account_status='OPEN';

SELECT * FROM DBA_USERS_WITH_DEFPWD ;

GRANT CREATE SESSION TO john;

SELECT * FROM v$session;

SELECT * FROM session_privs;


ALTER USER john QUOTA UNLIMITED ON USERS; -- FOR insertions IN tables;

GRANT SELECT ANY TABLE TO jack;

ALTER USER john Account LOCK;
ALTER USER dolphin PASSWORD EXPIRE;

ALTER USER john Account Unlock;

-- CREATE profile 
CREATE PROFILE ocean LIMIT
    SESSIONS_PER_USER          UNLIMITED 
    CPU_PER_SESSION            UNLIMITED 
    CPU_PER_CALL               3000 
    CONNECT_TIME               60;
    
 -- assign profile TO john
   
   ALTER USER john profile ocean;
   
  SELECT * FROM session_roles;
  
 -- CREATE ROLE
 
 CREATE ROLE OBJECT_USERS_ORA;
 
GRANT CREATE TABLE, CREATE VIEW TO OBJECT_USERS_ORA;

GRANT OBJECT_USERS_ORA TO sudeep; -- USER MUST SIGN OF AND SING IN AGAIN TO GET THE EFFECTOF ROLE

SELECT * FROM session_roles;

SELECT * FROM session_privs;
CREATE ROLE super;

GRANT ALL PRIVILEGES TO super;

SELECT * FROM all_tables; 




CREATE PROCEDURE grant_select(
    username VARCHAR2, 
    grantee VARCHAR2)
AS   
BEGIN
    FOR r IN (
        SELECT owner, table_name 
        FROM all_tables 
        WHERE owner = username
    )
    LOOP
        EXECUTE IMMEDIATE 
            'GRANT SELECT ON '||r.owner||'.'||r.table_name||' to ' || grantee;
    END LOOP;
END; 


SELECT * FROM dba_users;

SELECT * FROM user_users;

GRANT mdm TO alice;

SET ROLE mdm;

SET ROLE role IDENTIFIED BY password;

SET ROLE ALL EXCEPT except_role;

SET ROLE NONE;