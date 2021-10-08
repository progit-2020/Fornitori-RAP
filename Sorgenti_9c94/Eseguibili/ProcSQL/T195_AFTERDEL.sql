create or replace trigger T195_AFTERDEL
  after delete on T195_VOCIVARIABILI  
  for each row
declare
begin
  /* traccia ogni cancellazione sulla tabella T195 al fine di aiutare 
     il recupero di eventuali disallineamenti con i dati passati alle paghe */
  insert into T195_VOCIVARIABILIELIMINATE
    (DATA_OPERAZIONE,PROGRESSIVO,DATARIF,VOCEPAGHE,VALORE,UM,DAL,OPERAZIONE,COD_INTERNO,DATA_CASSA,IMPORTO)
  values
    (sysdate, :OLD.PROGRESSIVO,:OLD.DATARIF,:OLD.VOCEPAGHE,:OLD.VALORE,:OLD.UM,
     :OLD.DAL,:OLD.OPERAZIONE,:OLD.COD_INTERNO,:OLD.DATA_CASSA,:OLD.IMPORTO);
end T195_AFTERDEL;
/
