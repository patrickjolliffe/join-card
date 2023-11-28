grant create table to pdbadmin;
grant create procedure to pdbadmin;
grant alter session to pdbadmin;

alter user pdbadmin quota unlimited on users;

column value new_value diagtrace
select value from v$diag_info where name = 'Diag Trace';

drop directory if exists tracedir;
create directory tracedir as '&diagtrace';
grant read, write on directory tracedir TO pdbadmin;
grant execute on sys.dbms_monitor to pdbadmin;
exit;