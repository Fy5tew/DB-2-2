-- ������� �1
CREATE TABLE T_RANGE(
    KEY NUMBER,
    DATA NVARCHAR2(30)
)
PARTITION BY RANGE (KEY) (
    PARTITION T_RANGE_0 VALUES LESS THAN (101),
    PARTITION T_RANGE_1 VALUES LESS THAN (201),
    PARTITION T_RANGE_OTHER VALUES LESS THAN (maxvalue)
);
/


-- ������� �2
CREATE TABLE T_INTERVAL(
    KEY DATE,
    DATA NVARCHAR2(30)
)
PARTITION BY RANGE (KEY)
INTERVAL (NUMTOYMINTERVAL(1, 'YEAR')) (
    PARTITION T_INTERVAL_LOWER VALUES LESS THAN ('01-01-2000')
);
/


-- ������� �3
CREATE TABLE T_HASH(
    KEY VARCHAR2(10),
    DATA NVARCHAR2(30)
)
PARTITION BY HASH (KEY)
PARTITIONS 3;
/


-- ������� �4
CREATE TABLE T_LIST(
    KEY CHAR(1),
    DATA NVARCHAR2(30)
)
PARTITION BY LIST (KEY) (
    PARTITION T_LIST_ABC VALUES ('A', 'B', 'C'),
    PARTITION T_LIST_DEF VALUES ('D', 'E', 'F'),
    PARTITION T_LIST_OTHER VALUES (DEFAULT)
);
/


-- ������� �5
INSERT ALL
    INTO T_RANGE(KEY, DATA) VALUES(45, 'first')
    INTO T_RANGE(KEY, DATA) VALUES(134, 'second')
    INTO T_RANGE(KEY, DATA) VALUES(256, 'other')
SELECT * FROM DUAL;
/

INSERT ALL
    INTO T_INTERVAL(KEY, DATA) VALUES('05-10-1985', 'first')
    INTO T_INTERVAL(KEY, DATA) VALUES('07-12-2001', 'second')
    INTO T_INTERVAL(KEY, DATA) VALUES('23-02-2002', 'other')
SELECT * FROM DUAL;
/

INSERT ALL
    INTO T_HASH(KEY, DATA) VALUES('SJKLHV', 'first')
    INTO T_HASH(KEY, DATA) VALUES('GCYICR', 'second')
    INTO T_HASH(KEY, DATA) VALUES('ERASDP', 'third')
SELECT * FROM DUAL;
/

INSERT ALL
    INTO T_LIST(KEY, DATA) VALUES('A', 'first')
    INTO T_LIST(KEY, DATA) VALUES('E', 'second')
    INTO T_LIST(KEY, DATA) VALUES('Z', 'third')
SELECT * FROM DUAL;
/

SELECT * FROM USER_TAB_PARTITIONS;
/

SELECT * FROM T_RANGE PARTITION(T_RANGE_0);
/
SELECT * FROM T_RANGE PARTITION(T_RANGE_1);
/
SELECT * FROM T_RANGE PARTITION(T_RANGE_OTHER);
/

SELECT * FROM T_INTERVAL PARTITION(T_INTERVAL_LOWER);
/
SELECT * FROM T_INTERVAL PARTITION(SYS_P712);
/
SELECT * FROM T_INTERVAL PARTITION(SYS_P713);
/

SELECT * FROM T_HASH PARTITION(SYS_P692);
/
SELECT * FROM T_HASH PARTITION(SYS_P693);
/
SELECT * FROM T_HASH PARTITION(SYS_P694);
/

SELECT * FROM T_LIST PARTITION(T_LIST_ABC);
/
SELECT * FROM T_LIST PARTITION(T_LIST_DEF);
/
SELECT * FROM T_LIST PARTITION(T_LIST_OTHER);
/


-- ������� �6
ALTER TABLE T_RANGE ENABLE ROW MOVEMENT;
/
ALTER TABLE T_INTERVAL ENABLE ROW MOVEMENT;
/
ALTER TABLE T_HASH ENABLE ROW MOVEMENT;
/
ALTER TABLE T_LIST ENABLE ROW MOVEMENT;
/

UPDATE T_RANGE
SET KEY = 90
WHERE KEY = 256;
/

UPDATE T_INTERVAL
SET KEY = '23-02-2001'
WHERE KEY = '23-02-2002';
/

UPDATE T_HASH
SET KEY = 'EUIGXF'
WHERE KEY = 'SJKLHV';
/

UPDATE T_LIST
SET KEY = 'D'
WHERE KEY = 'Z';
/


-- ������� �7
ALTER TABLE T_LIST
MERGE PARTITIONS T_LIST_ABC, T_LIST_DEF
INTO PARTITION T_LIST_ABCDEF;
/


-- ������� �8
ALTER TABLE T_RANGE
SPLIT PARTITION T_RANGE_OTHER
AT (301) INTO (
    PARTITION T_RANGE_2,
    PARTITION T_RANGE_OTHER
);
/


-- ������� �9
CREATE TABLE T_RANGE_EXCHANGED (
    KEY NUMBER,
    DATA NVARCHAR2(30)
);
/

ALTER TABLE T_RANGE
EXCHANGE PARTITION T_RANGE_OTHER
WITH TABLE T_RANGE_EXCHANGED;
/

SELECT * FROM T_RANGE_EXCHANGED;
/


-- ������� �10
SELECT * FROM USER_PART_TABLES;
/

SELECT * FROM USER_TAB_PARTITIONS WHERE TABLE_NAME = 'T_RANGE';
/

SELECT * FROM T_LIST PARTITION(T_LIST_ABCDEF);
/

SELECT * FROM T_INTERVAL PARTITION FOR('07-12-2001');
/


-- ��������
DROP TABLE T_LIST;
/

DROP TABLE T_HASH;
/

DROP TABLE T_INTERVAL;
/

DROP TABLE T_RANGE;
/

DROP TABLE T_RANGE_EXCHANGED;
/
