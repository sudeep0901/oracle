-- mount and start plugabble database
--
--CREATE OR REPLACE TRIGGER pdb_startup AFTER STARTUP ON DATABASE
--BEGIN
--EXECUTE IMMEDIATE 'alter pluggable database all open';
--END pdb_startup;

-- Default values

CREATE TABLE customer1 (
customer_id NUMBER,
customer_name varchar2(50),
exp_date DATE DEFAULT to_date('31-Dec-2099','dd-mon-yyyy')
);

INSERT INTO customer1(customer_id, CUSTOMER_NAME ) values(1, 'sudeep');
INSERT INTO customer1(customer_id, CUSTOMER_NAME ) values(2, 'patel');

SELECT * FROM CUSTOMER1 c ;

-- virtual columns

CREATE TABLE sales1 
(
	sales_date DATE,
	order_id NUMBER, 
	total_amount number(10,2),
	commision NUMBER GENERATED ALWAYS AS (total_amount*0.01) virtual
	
);


INSERT INTO SALES1 (sales_date, order_id, total_amount) values('01-jan-2020', 1, 15000);

SELECT * FROM SALES1 ;
UPDATE SALES1 SET total_amount = 50000 WHERE order_id = 1;
SELECT * FROM SALES1 ;


--arithmatic calculation OF NULL values
SELECT 10 + NULL FROM DUAL;


SELECT CAST(avg(commission_pct) AS NUMBER(10,4))  FROM EMPLOYEES e ; -- 0.2228571428571428571428571428571428571429
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES e ;

-- exclude NULL Values from calculation, nvl will consider NULL values in calculation

SELECT CAST(avg(nvl(commission_pct, 0)) AS NUMBER(10,4))  FROM EMPLOYEES e ; -- 0.2228571428571428571428571428571428571429
SELECT COUNT(nvl(COMMISSION_PCT,0)) FROM EMPLOYEES e ;


--multi TABLE inserts, IN BELOW STATUS TABLES CAN BE DIFFERENT ALSO

INSERT ALL 
INTO CUSTOMER1 (CUSTOMER_ID , CUSTOMER_NAME ) VALUES (3, 'MANASVI')
INTO CUSTOMER1 (CUSTOMER_ID , CUSTOMER_NAME ) VALUES (4, 'MANAV')
SELECT * FROM DUAL;

SELECT * FROM CUSTOMER1 c ;


--hierarchical queries
SELECT EMPLOYEE_ID ,FIRST_NAME , LEVEL , MANAGER_ID FROM EMPLOYEES e 
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID 
START WITH 
MANAGER_ID IS NULL
ORDER BY 1;


SELECT concat(LPAD(' ',LEVEL*3-3) ,EMPLOYEE_ID) AS HIERARCHY ,FIRST_NAME FROM EMPLOYEES e 
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID 
START WITH 
MANAGER_ID IS NULL;
ORDER BY 1;



SELECT concat(LPAD(' ',LEVEL*3-3) ,EMPLOYEE_ID) AS HIER_CHY ,FIRST_NAME FROM EMPLOYEES e 
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID 
START WITH 
MANAGER_ID IS NULL
ORDER SIBLINGS BY E.FIRST_NAME  ;

-- connect by root

SELECT FIRST_NAME , LEVEL, MANAGER_ID ,CONNECT_BY_ROOT FIRST_NAME AS top_brass FROM EMPLOYEES e 
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID 
START WITH 
MANAGER_ID IS NULL
 

SELECT FIRST_NAME , LEVEL, MANAGER_ID ,CONNECT_BY_ROOT FIRST_NAME AS top_brass FROM EMPLOYEES e 
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID 
START WITH 
MANAGER_ID = 108;

-- SYS_CONNECT_BY_PATH
SELECT FIRST_NAME , LEVEL, MANAGER_ID ,SYS_CONNECT_BY_PATH(FIRST_NAME,':ismanager of:') AS hier FROM EMPLOYEES e 
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID 
START WITH 
MANAGER_ID IS null;

-- generate series OF numbers USING CONNECT BY

SELECT LEVEL * 2 AS c_number  FROM dual CONNECT BY LEVEL*2  <100;

-- Extension OF GROUP BY Functions

SELECT TRUNC(TO_DATE('27-OCT-92','DD-MON-YY'), 'YEAR')
  "New Year" FROM DUAL;
  
 
-- ROLLUP
SELECT TRUNC(e.HIRE_DATE , 'mon') AS hire_month ,JOB_ID, sum(e.SALARY ) FROM EMPLOYEES e 
GROUP BY ROLLUP(TRUNC(e.HIRE_DATE , 'mon'), job_id) 
ORDER BY job_id,TRUNC(e.HIRE_DATE , 'mon');


-- Grouping used to add flag to specify which row cotain total and which is subtotal
SELECT TRUNC(e.HIRE_DATE , 'mon') AS hire_month , e.JOB_ID, 
grouping(TRUNC(e.HIRE_DATE , 'mon')) AS flag1 ,
grouping(job_id) AS flag2,
sum(e.SALARY ) 
FROM EMPLOYEES e 
GROUP BY CUBE(TRUNC(e.HIRE_DATE , 'mon'), job_id) 
ORDER BY job_id,TRUNC(e.HIRE_DATE , 'mon');


-- Grouping_ID used to add flag to specify which row cotain total and which is subtotal but only single flag is created in grouping it create n colums
SELECT TRUNC(e.HIRE_DATE , 'mon') AS hire_month , e.JOB_ID, 
grouping_ID(TRUNC(e.HIRE_DATE , 'mon'),  e.JOB_ID) AS flag_id ,
 sum(e.SALARY ) 
FROM EMPLOYEES e 
GROUP BY CUBE(TRUNC(e.HIRE_DATE , 'mon'), job_id) 
ORDER BY job_id,TRUNC(e.HIRE_DATE , 'mon');

SELECT * FROM EMPLOYEES e ;
