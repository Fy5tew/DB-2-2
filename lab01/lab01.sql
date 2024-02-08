-- Задание №10
CREATE TABLE TNA_t (
    some_id number(3),
    some_name varchar2(50),
    CONSTRAINT pk_TNA_t PRIMARY KEY (some_id)
);

-- Задание №12
INSERT INTO TNA_t(some_id, some_name)
VALUES (1, 'first name')
;
INSERT INTO TNA_t(some_id, some_name)
VALUES (2, 'second name')
;
INSERT INTO TNA_t(some_id, some_name)
VALUES (3, 'third name')
;
COMMIT;
SELECT * FROM TNA_t;

-- Задание №13
UPDATE TNA_t
SET some_name = 'Second Name'
WHERE some_id = 2;
UPDATE TNA_t
SET some_name = 'Third Name'
WHERE some_id = 3;
COMMIT;
SELECT * FROM TNA_t;

-- Задание №14
SELECT *
FROM TNA_t
WHERE some_id > 1;
SELECT SUM(some_id) AS ID_SUM
FROM TNA_t;
SELECT LISTAGG(some_name, ', ') AS Names
FROM TNA_t;

-- Задание №15
DELETE FROM TNA_t WHERE some_id = 1;
SELECT * FROM TNA_t;
ROLLBACK;
SELECT * FROM TNA_t;

-- Задание №16
CREATE TABLE TNA_t_child (
    some_id number(3),
    some_data varchar2(50),
    CONSTRAINT fk_TNA_t_child FOREIGN KEY (some_id) REFERENCES TNA_t(some_id)
);
INSERT ALL
    INTO TNA_t_child(some_id, some_data) VALUES (1, 'first data')
    INTO TNA_t_child(some_id, some_data) VALUES (2, 'second data')
SELECT * FROM DUAL;
COMMIT;
SELECT * FROM TNA_t_child;

-- Задание №17
SELECT *
FROM TNA_t LEFT JOIN TNA_t_child ON TNA_t.some_id = TNA_t_child.some_id;
SELECT *
FROM TNA_t INNER JOIN TNA_t_child ON TNA_t.some_id = TNA_t_child.some_id;

-- Задание №18
DROP TABLE TNA_t_child;
DROP TABLE TNA_t;
