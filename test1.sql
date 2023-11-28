set serveroutput on size unlimited
set linesize 200
drop table if exists t;
set echo on
create table t as select rownum c from dual connect by level <= 10000;
exec dbms_stats.gather_table_stats(null, 'T', method_opt=>'FOR TABLE');
exec dbms_stats.delete_column_stats(null, 'T', 'C');

select num_rows from user_tables where table_name = 'T';
select column_name, num_distinct, low_value, high_value from user_tab_col_statistics where table_name = 'T';

alter session set optimizer_dynamic_sampling=0;
exec cbo.begin_trace
explain plan for select * from t where c = 0;
exec cbo.end_trace
drop table t;
exit;