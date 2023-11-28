create or replace procedure traceon as
begin
    execute immediate 'alter session set tracefile_identifier="'||sys_guid()||'"';
    execute immediate 'alter session set events ''10053 trace name context forever, level 1''';
end;
/
