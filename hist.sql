drop table t1;

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

drop table t2;
create table t2 as select * from t1;

exec dbms_stats.gather_table_stats(null, 't1', method_opt => 'for all columns size 1');
exec dbms_stats.gather_table_stats(null, 't2', method_opt => 'for all columns size 1');

explain plan for select * from t1, t2 where t2.f3 = 1 and t1.j14 = t2.j16;
explain plan for select * from t1, t2 where t1.f16 = 1 and t2.f16 = 1 and t1.j14 = t2.j16;
tail -f FREE_ora_671_HJ.trc | grep  t1|join




exec dbms_stats.gather_table_stats(null, 't1', method_opt => 'for all columns size 255');
exec dbms_stats.gather_table_stats(null, 't2', method_opt => 'for all columns size 255');



drop table t1;
create table t1 (j1 number, j2 number, j3 number, j4 number, j5 number, j6 number, j7 number, j8 number, j9 number, j10 number);

declare
	ins clob;
	cols clob;
	vals clob;
begin
	for val in 1..10
	loop		
		cols := '';
		vals := '';
		for col in 1..10
		loop
			cols := cols ||  'j' || col || ',';
			if (col < val)
			then 
				vals := vals ||'null,';
			else
				vals := vals || val || ',';
			end if;
		end loop;
		cols := substr(cols, 1, length(cols)-1);
		vals := substr(vals, 1, length(vals)-1);		
		ins := 'insert into t1 (' || cols || ') values ('|| vals || ')';
		for ins_l in 1.. val
		loop
			execute immediate ins;
		end loop;
	end loop;
	commit;
end;
/
drop table t2;
create table t2 as select * from t1;
exec dbms_stats.gather_table_stats(null, 't1', method_opt=>'for all columns size 255');
exec dbms_stats.gather_table_stats(null, 't2', method_opt=>'for all columns size 255');

explain plan for select null from t1, t2 where t1.j3 = t2.j4;
Join Card:  14.000000 = outer (10.000000) * inner (6.000000) * sel (0.233333)

jc=14/10*6
1 + 2 * 2 + 3 * 3
9+4+1=14
JC = (SUM OF MATCHING HISTORAMS MULTIPLIED TOGEHER)/((NUMBER OF NON NULL IN T1)*(NUMBER OF NON NULL IN T2) 
= 14 /(10*6)

explain plan for select null from t1, t2 where t1.j3 = t2.j4 and t1.j10 = 10;

explain plan for select null from t1 where t1.j3 is not null and t1.j10 = 10;
10 * 1 * 0.233333=3            

explain plan for select null from t1 where t1.j3 is not null and t1.j10 = 10;

1.036364

explain plan for select null from t1 where t1.j3 is not null;
card: 6.000000
t3 is not null: sel=6/55
j10 = 10 sel = 10/55

60/(55*55)*55=60.






jsel=1*2+2*2+3*3+4*4+5*5+6*6+7*7+8*8+9*9+10*10
=386
55*55/386

explain plan for select null from t1, t2 where t1.j3 = t2.j4;
1+2+4+9=16
55*55/16




1    1       1    1
null 2       2    2
null 2       2    2
null null    3    3
null null    3    3
null null    3    3
null null null    4
null null null    4
null null null    4
null null null    4


select * from t t1, t t2 where t2.filter = 1 and t1.j32 = t2.j4


begin
    for loopy1 in 1..1
	    for loopy2 in 1..100
	loop
        execute immediate 'explain plan for select * from t t1, t t2 where t2.filter = 1 and t1.j'|| loopy1 || ' = t2.j'|| loopy2;		
	end loop;
end;
/

begin
	dbms_stats.gather_table_stats(
		user,
		't2',
		cascade => true,
		estimate_percent => null,
		method_opt => 'for all columns size 1'
	);
end;
/



spool join_card_01a

set autotrace traceonly explain

rem	alter session set events '10053 trace name context forever';

prompt	Join condition: t2.join1 = t1.join1
prompt	Filter on just T1

explain plan for 
select	t1.v1, t2.v1
from
	t1,
	t2
where
	t2.join1 = t1.join1
and	t1.filter = 1
;

prompt	Join condition: t2.join1 = t1.join1
prompt	Filter on just T2

select	t1.v1, t2.v1
from
	t1,
	t2
where
	t2.join1 = t1.join1
and	t2.filter = 1
;

alter session set events '10053 trace name context off';

set autotrace off

spool off

rem	exit

set doc off
doc


#

When we have a filter only on t2, we use thenum distinct of 30 from table t1, rather than thelarger num distinct of 40 required by the standard formula.


drop table t1;
drop table t2;

create table t1 
as
select
	trunc(dbms_random.value(0, 100 ))	filter,
	trunc(dbms_random.value(0, 1 ))	j1,
	trunc(dbms_random.value(0, 2 ))	j2,
	trunc(dbms_random.value(0, 4 ))	j4,
	trunc(dbms_random.value(0, 8 ))	j8,
	trunc(dbms_random.value(0, 16))	j16,
	trunc(dbms_random.value(0, 32))	j32,
	trunc(dbms_random.value(0, ))	j64,
	lpad(rownum,10)				v1,
	rpad('x',100)				padding
from
	all_objects
where 
	rownum <= 1000
;


create table t2
as
select
	trunc(dbms_random.value(0, 100 ))	filter,
	trunc(dbms_random.value(0, 1 ))	j1,
	trunc(dbms_random.value(0, 2 ))	j2,
	trunc(dbms_random.value(0, 4 ))	j4,
	trunc(dbms_random.value(0, 8 ))	j8,
	trunc(dbms_random.value(0, 16))	j16,
	trunc(dbms_random.value(0, 32))	j32,
	lpad(rownum,10)				v1,
	rpad('x',100)				padding
from
	all_objects
where
	rownum <= 1000
;


exec dbms_stats.gather_table_stats(null, 't1', method_opt => 'for all columns size 1');
exec dbms_stats.gather_table_stats(null, 't2', method_opt => 'for all columns size 1');

explain plan for select * from t1, t2 where t1.j4 = t2.j4;
1000*1000*.25
explain plan for select * from t1, t2 where t1.j4 = t2.j8;
1000*1000*.125
explain plan for select * from t1, t2 where t1.filter = 1 and t1.j4 = t2.j8;
1000*10*.125
explain plan for select * from t1, t2 where t2.filter = 1 and t1.j4 = t2.j8;
10*1000*1/6
explain plan for select * from t1, t2 where t2.filter = 1 and t1.c = t2.c;
explain plan for select * from t1, t2 where t2.filter = 1 and t1.j4 = t2.j16;
10*1000*1/10
explain plan for select * from t1, t2 where t2.filter = 1 and t1.j1 = t2.j16;



1/max(ndv(t1.c), (ndv(t1.c)+ndv(t2.c))/2)

16,4=>1/16
32,4=>1/32

1,16=>1/8
2,16=>1/8
4,16=>1/8
4,32=>1/9
4,64=>1/



where j10=j20

1*1 + 2*2 + 3 * 3
        j1,   j2,
insert into t1 (j1) values (1);
insert      t1 (j2) values (1)
insert      t1 (j2) values (2)
insert      t1 (j2) values (2)
insert (null, 2, 2, 2)
insert (0, 2, 3, 3)
insert (0, 2, 3, 4)

1    1       1    1
null 2       2    2
null 2       2    2
null null    3    3
null null    3    3
null null    3    3
null null null    4
null null null    4
null null null    4
null null null    4

for i in 1..10
loop
	
end loop;

where j3=j4

histogram  1*1+2*2+3*3=15
j3 has 3 values 1,2,3






