grant create table to pdbadmin;
alter user pdbadmin quota unlimited on users;


column value new_value diagtrace
select value from v$diag_info where name = 'Diag Trace';

drop directory if exists TRACEDIR;
create directory TRACEDIR as '&diagtrace';
grant read on TRACEDIR TO pdbadmin;
exit;