--deadlock demo
 
update emp
set sal = 10000
where empno = 7900;

update emp
set job = 'MANAGER'
where empno = 7788;

--Rollback;

--T2

 update emp set sal = 30000 where empno = 7788;
 
 update emp set job = 'MANAGER' where empno = 7900;
 
 
 
/* 
update emp set job = 'MANAGER' where empno = 7900
       *
ERROR at line 1:
ORA-00060: deadlock detected while waiting for resource 
*/
 