CREATE OR REPLACE FUNCTION OREMINUTI (ORE IN VARCHAR2) RETURN INTEGER AS
  H INTEGER;
  M INTEGER;
  S INTEGER;
BEGIN
  S:=0;
  H:=0;
  M:=0;
  IF (ORE IS NULL) OR (LTRIM(RTRIM(ORE)) IN (',','.',':')) THEN
    RETURN 0;
  ELSE
    S:=INSTR(ORE,'.');
    IF S = 0 THEN
      S:=INSTR(ORE,',');
    END IF;
    IF S = 0 THEN
      S:=INSTR(ORE,':');
    END IF;
    IF S = 0 THEN
      H:=ORE;
    ELSE
      H:=NVL(LTRIM(RTRIM(SUBSTR(ORE,1,S - 1))),'0');
      M:=NVL(LTRIM(RTRIM(SUBSTR(ORE,S + 1,LENGTH(ORE)))),'0');
    END IF;
    H:=ABS(H)*60 + M;
    IF INSTR(ORE,'-') > 0 THEN
      H:=-H;
    END IF;
    RETURN H;
  END IF;
END;
/
