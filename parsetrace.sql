create or replace procedure parsetrace as
  f UTL_FILE.FILE_TYPE;
  s VARCHAR2(32767);
  tracefile v$diag_info.value%type;
BEGIN
    select substr(value, instr(value, '/', -1)+1) into tracefile from v$diag_info where name = 'Default Trace File';
    DBMS_OUTPUT.PUT_LINE('Opening '|| tracefile);
  f := UTL_FILE.FOPEN( 'TRACEDIR', tracefile, 'R', 32767 );
  LOOP    
    UTL_FILE.GET_LINE( f, s );
    if s like '%Card:%' or s like '%Table:%'
    then
        DBMS_OUTPUT.PUT_LINE( s );
    end if;
  END LOOP;  
EXCEPTION
WHEN NO_DATA_FOUND THEN 
    UTL_FILE.FCLOSE( f );
END;
/
