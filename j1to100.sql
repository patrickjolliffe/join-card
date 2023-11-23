drop table if exists t1;
drop table if exists t2;

create table t1
as
select
    rownum id,
	trunc(dbms_random.value(0, 100 ))	filter,
	lpad(rownum,10)				v1,    
	rpad('x',100)				padding
from
	all_objects
where 
	rownum <= 1000;

begin
	for loopy in 1..100
	loop
		execute immediate 'alter table t1 add j'|| loopy || ' number';		
		execute immediate 'alter table t1 add f'|| loopy || ' number';		
        execute immediate 'update t1 set j'|| loopy || '=mod(id, '|| loopy ||')';		
		execute immediate 'update t1 set f'|| loopy || '=mod(id, '|| loopy ||')';		
        commit;
	end loop;
end;
/

create table t2 as select * from t1;
exec sys.dbms_stats.gather_table_stats(null, 't1', method_opt=>'for all columns size 1');
exec sys.dbms_stats.gather_table_stats(null, 't2', method_opt=>'for all columns size 1');

