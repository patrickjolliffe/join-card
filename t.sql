set termout on
set feed on
set echo on

SPOOL n

DROP TABLE d;
CREATE TABLE d (id NUMBER PRIMARY KEY);
INSERT INTO d VALUES (1);
INSERT INTO d VALUES (10);
COMMIT;
    
drop table f;
create table f(id NUMBER);
insert into f select 1  from dual;
insert into f select 10 from dual connect by level <= 10;
insert into f select 100 from dual connect by level <= 100;
insert into f select 1000 from dual connect by level <= 1000;
insert into f select 10000 from dual connect by level <= 10000;
COMMIT;

exec dbms_stats.gather_table_stats(null, 'D', METHOD_OPT=>'FOR COLUMNS ID SIZE 255');
EXEC dbms_stats.gather_table_stats(NULL, 'F', METHOD_OPT=>'FOR COLUMNS ID SIZE 255');

alter session set events '10053 trace name context forever, level 1';
explain plan for 
SELECT NULL  
FROM
    d, f
WHERE f.id = d.id;

select * from dbms_xplan.display();
alter session set events '10053 trace name context off';

column tracefile new_value tracefile
select substr(value, instr(value, '/', -1)+1) tracefile from v$diag_info where name = 'Default Trace File';
select * from v$diag_trace_file_contents where trace_filename = '&&tracefile';


explain plan for 
SELECT NULL  
FROM
    d, f
WHERE 2*f.id = d.id
    AND      (f.id IN (10, 100, 10000));

select * from dbms_xplan.display();

explain plan for 
SELECT NULL  
FROM
    f
WHERE id IN (select d.id FROM d)
    AND      (f.id IN (10, 10000));

select * from dbms_xplan.display();

exit;
