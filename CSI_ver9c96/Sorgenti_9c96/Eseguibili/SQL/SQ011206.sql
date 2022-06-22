ALTER TABLE T042_PERIODIASSENZA ADD ID NUMBER;

create sequence T042_ID minvalue 0 start with 0 increment by 1;

CREATE OR REPLACE VIEW V042_PERIODIASSENZA AS
SELECT 
  T030.MATRICOLA,
  T042.CAUSALE,T042.DAL,T042.AL,T042.TIPOGIUST,T042.DAORE,T042.AORE,T042.OPERAZIONE,T042.DATA_AGG,T042.ID,
  T265.VOCEPAGHE
  FROM T030_ANAGRAFICO T030, T042_PERIODIASSENZA T042, T265_CAUASSENZE T265
  WHERE 
  T030.PROGRESSIVO = T042.PROGRESSIVO AND
  T042.CAUSALE = T265.CODICE AND
  T265.VOCEPAGHE IS NOT NULL;

