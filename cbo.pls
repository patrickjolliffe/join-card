create or replace package body cbo as 
    procedure begin_trace is 
    begin
        execute immediate 'alter session set tracefile_identifier="'||sys_guid()||'"';
        execute immediate 'alter session set events ''10053 trace name context forever, level 1''';
        sys.dbms_monitor.session_trace_disable;
    end;

    procedure end_trace is
        tracefile v$diag_info.value%type;
        command clob;
    begin
        execute immediate 'alter session set events ''10053 trace name context off''';
        select value into tracefile from v$diag_info where name = 'Default Trace File';
        sys.dbms_output.put_line(tracefile);
    end; 
end;
/
exit;
