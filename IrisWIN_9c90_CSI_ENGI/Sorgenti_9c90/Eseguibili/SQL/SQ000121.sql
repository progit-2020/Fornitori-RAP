ALTER TABLE T190_INTPAGHE ADD F210 VARCHAR2(1);
ALTER TABLE T190_INTPAGHE ADD F220 VARCHAR2(1);
ALTER TABLE T190_INTPAGHE ADD P210 VARCHAR2(6);
ALTER TABLE T190_INTPAGHE ADD P220 VARCHAR2(6);
UPDATE T190_INTPAGHE SET F210 = 'N';
UPDATE T190_INTPAGHE SET F220 = 'N';
