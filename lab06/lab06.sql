-- Задание №1-2
SHOW PARAMETER spfile;
-- %ORACLE_HOME%\database\SPFILE%DBNAME%.ORA
-- D:\Apps\Oracle\OracleDB\OracleDB19cHome\database\SPFILEORACLEDB.ORA
SELECT NAME, VALUE, DESCRIPTION FROM V$PARAMETER;


-- Задание №3-4
-- as sysdba
CREATE PFILE = 'D:\Study\DB\lab06\PFILEORACLEDB.ORA' from SPFILE;


-- Задание №5-6
-- as sysdba
CREATE SPFILE FROM PFILE = 'D:\Study\DB\lab06\PFILEORACLEDB.ORA';

SELECT NAME, VALUE, DESCRIPTION 
FROM V$PARAMETER
WHERE NAME = 'open_cursors'
;


-- Задание №7
ALTER SYSTEM SET open_cursors = 300 SCOPE = SPFILE;


-- Задание №8
SELECT * FROM V$CONTROLFILE;


-- Задание №9
-- %ORACLE_HOME%\database\CONTROLFILE.TXT
-- D:\Apps\Oracle\OracleDB\OracleDB19cHome\database\CONTROLFILE.TXT
ALTER DATABASE BACKUP CONTROLFILE TO TRACE AS 'CONTROLFILE1.TXT';


-- Задание №10-11
-- %ORACLE_HOME%\database\PWD%DBNAME%.ora
-- D:\Apps\Oracle\OracleDB\OracleDB19cHome\database\PWDoracledb.ora
SELECT * FROM V$PASSWORDFILE_INFO;


-- Задание №12
SELECT * FROM V$DIAG_INFO;


-- Задание №13
-- D:\Apps\Oracle\OracleDB\OracleDB19c\diag\rdbms\oracledb\oracledb\alert\log.xml
SELECT * FROM V$DIAG_INFO WHERE NAME = 'Diag Alert';


-- Задание №14
-- D:\Apps\Oracle\OracleDB\OracleDB19c\diag\rdbms\oracledb\oracledb\trace
