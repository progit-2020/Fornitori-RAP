create or replace trigger T235_AFTERUPDINS
  after insert or update of 
    CAUSCOMP_DEBITOGG,
    ARROT_RIEPGG,
    ARROT_RIEPGG_FASCE,
    ARROT_RIEPGG_ORENORM
  on T235_CAUPRESENZE_PARSTO
  for each row
begin
  --mantiene allineati i dati sulla T275 con l'ultima decorrenza di T235
  if :NEW.DECORRENZA_FINE = to_date('31/12/3999','dd/mm/yyyy') then
    null;
    update T275_CAUPRESENZE set
      CAUSCOMP_DEBITOGG = :NEW.CAUSCOMP_DEBITOGG,
      ARROT_RIEPGG = :NEW.ARROT_RIEPGG,
      ARROT_RIEPGG_FASCE = :NEW.ARROT_RIEPGG_FASCE,
      ARROT_RIEPGG_ORENORM = :NEW.ARROT_RIEPGG_ORENORM
      /*,parametro2 = :NEW.parametro2*/
    where ID = :new.ID;
  end if;
exception
  when others then null;
end T235_AFTERUPDINS;
/
