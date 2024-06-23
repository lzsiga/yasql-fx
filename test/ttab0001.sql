-- test table used by test0010.sh (maybe others in the future)
-- usage: @ttab0001.sql

DROP TABLE yasql_ttab_0001;

CREATE TABLE yasql_ttab_0001 (
    c12c   CHAR (12 CHAR),
    c12b   CHAR (12 BYTE),
    nc12   NCHAR (12),      -- implicit 'char'
    vc12c  VARCHAR2 (12 CHAR),
    vc12b  VARCHAR2 (12 BYTE),

    nvc12  NVARCHAR2 (12),  -- implicit 'char'
    raw12  RAW(12),         -- implicit 'byte'
    int1   INTEGER,
    int2   INT,
    int3   SMALLINT,

    num12  NUMBER(12),
    num20  NUMBER(20),
    num84  NUMBER(8,4),
    num93  NUMBER(9,3),
    f1     FLOAT,

    f2     DOUBLE PRECISION,
    f3     REAL
);

INSERT INTO yasql_ttab_0001
 (c12c,  c12b,  nc12,  vc12c, vc12b,
  nvc12, raw12, int1,  int2,  int3,
  num12, num20, num84, num93, f1,
  f2,    f3)
VALUES
 ('char12c',     'char12',     N'nchar12',  'varchar12c', 'varchar12b',
  N'nvarchar12', '7261773132', 1230000001,  1230000002,   1230000003,
  1230000004,    1230000005,   1230.0006 ,  123000.007,  3.1415926535,
  2.7182818284,  1.6180339887);
COMMIT;
