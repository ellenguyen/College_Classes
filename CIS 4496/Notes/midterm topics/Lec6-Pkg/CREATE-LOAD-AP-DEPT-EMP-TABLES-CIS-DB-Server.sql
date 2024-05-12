DROP TABLE emp;

DROP TABLE dept;

CREATE TABLE dept(
  deptno  NUMBER(2)    PRIMARY KEY,
  dname   VARCHAR2(14), 
  loc     VARCHAR2(13)
);

CREATE TABLE emp(
  empno    NUMBER(4)  PRIMARY KEY,  
  ename    VARCHAR2(10), 
  job      VARCHAR2(9),
  mgr      NUMBER(4) REFERENCES emp(empno),    
  hiredate     DATE,
  sal          NUMBER(7,2),  
  comm         NUMBER(7,2),  
  deptno       NUMBER(2) REFERENCES dept(deptno)
);

INSERT INTO dept(deptno, dname, loc)         
VALUES(10, 'ACCOUNTING',  'NEW YORK');

INSERT INTO dept(deptno, dname, loc)         
VALUES(20, 'RESEARCH', 'DALLAS');

INSERT INTO dept(deptno, dname, loc)         
VALUES(30, 'SALES',  'CHICAGO');

INSERT INTO dept(deptno, dname, loc)         
VALUES(40, 'OPERATIONS',  'BOSTON');

COMMIT;

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7839, 'KING', 'PRESIDENT', NULL, TO_DATE('17-NOV-81', 'DD-MON-RR'), 5000, NULL, 10);

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7698, 'BLAKE', 'MANAGER',7839, TO_DATE('01-MAY-81', 'DD-MON-RR'), 2850, NULL, 30);

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7782, 'CLARK', 'MANAGER',7839, TO_DATE('09-JUN-81', 'DD-MON-RR'), 2450, NULL, 10);

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7566, 'JONES','MANAGER',7839, TO_DATE('02-APR-81','DD-MON-RR'), 2975, NULL, 20); 

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7788, 'SCOTT','ANALYST',7566, TO_DATE('09-DEC-82','DD-MON-RR'), 3000, NULL, 20);      
        
INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7902, 'FORD', 'ANALYST',7566, TO_DATE('03-DEC-81','DD-MON-RR'), 3000, NULL, 20);            

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7369, 'SMITH', 'CLERK',7902, TO_DATE('17-DEC-80','DD-MON-RR'), 800, NULL, 20);

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7499, 'ALLEN', 'SALESMAN', 7698, TO_DATE('20-FEB-81','DD-MON-RR'), 1600, 300, 30); 

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7521, 'WARD', 'SALESMAN', 7698, TO_DATE('22-FEB-81','DD-MON-RR'), 1250, 500, 30);

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7654, 'MARTIN','SALESMAN', 7698, TO_DATE('28-SEP-81','DD-MON-RR'), 1250, 1400, 30);

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7844, 'TURNER','SALESMAN', 7698, TO_DATE('08-SEP-81','DD-MON-RR'), 1500, 0, 30); 

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7876, 'ADAMS', 'CLERK', 7788, TO_DATE('12-JAN-83','DD-MON-RR'), 1100, NULL, 20);

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7900, 'JAMES', 'CLERK', 7698, TO_DATE('03-DEC-81','DD-MON-RR'), 950, NULL, 30);            

INSERT INTO emp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7934, 'MILLER', 'CLERK', 7782, TO_DATE('23-JAN-82','DD-MON-RR'), 1300, NULL, 10);

COMMIT;

