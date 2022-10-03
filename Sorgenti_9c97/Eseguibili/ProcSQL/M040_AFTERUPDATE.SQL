CREATE OR REPLACE TRIGGER M040_AFTERUPDATE
  AFTER UPDATE ON M040_MISSIONI
  FOR EACH ROW
BEGIN
  -- mantiene coerenza delle sottotabelle con la chiave di M040
  if :old.MESESCARICO <> :new.MESESCARICO or
     :old.MESECOMPETENZA <> :new.MESECOMPETENZA or
     :old.DATADA <> :new.DATADA or
     :old.ORADA <> :new.ORADA then
    
    /*gestione foreign key tra M050 e M051*/
    delete from M051_APPOGGIO;
    insert into M051_APPOGGIO
      select * from M051_DETTAGLIORIMBORSO
      where
      PROGRESSIVO = :old.PROGRESSIVO and
      MESESCARICO = :old.MESESCARICO and
      MESECOMPETENZA = :old.MESECOMPETENZA and
      DATADA = :old.DATADA and
      ORADA = :old.ORADA;
    delete from M051_DETTAGLIORIMBORSO
      where
        PROGRESSIVO = :old.PROGRESSIVO and
        MESESCARICO = :old.MESESCARICO and
        MESECOMPETENZA = :old.MESECOMPETENZA and
        DATADA = :old.DATADA and
        ORADA = :old.ORADA;
    update M051_APPOGGIO
      set
        MESESCARICO = :new.MESESCARICO,
        MESECOMPETENZA = :new.MESECOMPETENZA,
        DATADA = :new.DATADA,
        ORADA = :new.ORADA
      where
        PROGRESSIVO = :old.PROGRESSIVO and
        MESESCARICO = :old.MESESCARICO and
        MESECOMPETENZA = :old.MESECOMPETENZA and
        DATADA = :old.DATADA and
        ORADA = :old.ORADA;
    update M050_RIMBORSI
      set
        MESESCARICO = :new.MESESCARICO,
        MESECOMPETENZA = :new.MESECOMPETENZA,
        DATADA = :new.DATADA,
        ORADA = :new.ORADA
      where
        PROGRESSIVO = :old.PROGRESSIVO and
        MESESCARICO = :old.MESESCARICO and
        MESECOMPETENZA = :old.MESECOMPETENZA and
        DATADA = :old.DATADA and
        ORADA = :old.ORADA;
    insert into M051_DETTAGLIORIMBORSO
      select * from M051_APPOGGIO
      where
      PROGRESSIVO = :new.PROGRESSIVO and
      MESESCARICO = :new.MESESCARICO and
      MESECOMPETENZA = :new.MESECOMPETENZA and
      DATADA = :new.DATADA and
      ORADA = :new.ORADA;
    delete from M051_APPOGGIO;
    update M052_INDENNITAKM
      set
        MESESCARICO = :new.MESESCARICO,
        MESECOMPETENZA = :new.MESECOMPETENZA,
        DATADA = :new.DATADA,
        ORADA = :new.ORADA
      where
        PROGRESSIVO = :old.PROGRESSIVO and
        MESESCARICO = :old.MESESCARICO and
        MESECOMPETENZA = :old.MESECOMPETENZA and
        DATADA = :old.DATADA and
        ORADA = :old.ORADA;
  end if;
END;
/