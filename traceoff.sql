create or replace procedure traceoff as
begin
    execute immediate 'alter session set events ''10053 trace name context off''';
end;
/
