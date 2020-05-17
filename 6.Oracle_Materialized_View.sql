CREATE MATERIALIZED VIEW mv_employee_department_count refresh complete ON
demand AS
SELECT
	e.DEPARTMENT_ID,
	count(*) AS EMPLOYE_IN_DEPT
FROM
	HR.EMPLOYEES e
GROUP BY
	e.DEPARTMENT_ID;
	


SELECT
	*
FROM
	mv_employee_department_count e
INNER JOIN DEPARTMENTS d   ON
	e.DEPARTMENT_ID =  d.DEPARTMENT_ID 
ORDER BY e.EMPLOYE_IN_DEPT desc;


-- How TO refresh

INSERT INTO HR.EMPLOYEES (EMPLOYEE_ID , FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID) VALUES 
(1201,'Sudeep','Patel','SUDEEP','650.123.1234',TIMESTAMP '2020-07-18 00:00:00.000000','ST_MAN',8000,NULL,100,50)
;
SELECT * FROM mv_employee_department_count;-- record NOT fould which was inserted IN previous STATEMENT

EXEC dbms_mview.refresh('mv_employee_department_count', atomic_refresh=>True);

SELECT * FROM mv_employee_department_count;-- record found which was inserted IN previous STATEMENT



DROP MATERIALIZED VIEW mv_employee_department_count;


-- ON COMMIT MV 
CREATE MATERIALIZED VIEW mv_employee_department_count refresh 
COMPLETE ON
commit AS
SELECT
	e.DEPARTMENT_ID,
	count(*) AS EMPLOYE_IN_DEPT
FROM
	HR.EMPLOYEES e
GROUP BY
	e.DEPARTMENT_ID;