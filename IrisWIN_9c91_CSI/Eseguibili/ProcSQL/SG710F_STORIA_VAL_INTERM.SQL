CREATE OR REPLACE FUNCTION SG710F_STORIA_VAL_INTERM(data in date, progressivo in number, tipo in varchar2, stato in number) return varchar2 is
  CURSOR c1(p_data in date, p_progressivo in number, p_tipo in varchar2, p_stato in number) is
    SELECT SG746.descrizione desc_stato,
           decode(SG710.esito_valutazione_intermedia,'P','Positiva','N','Negativa') esito,
           trim(SG710.valutazione_intermedia) testo,
           to_char(SG710.data_compilazione,'dd/mm/yyyy') data
    FROM SG710_TESTATA_VALUTAZIONI SG710,
         SG746_STATI_AVANZAMENTO SG746,
         T430_STORICO T430
    WHERE SG710.esito_valutazione_intermedia IS NOT NULL
    AND SG710.data = p_data
    AND SG710.progressivo = p_progressivo
    AND SG710.tipo_valutazione = p_tipo
    AND SG710.stato_avanzamento < p_stato
    AND SG710.PROGRESSIVO = T430.PROGRESSIVO
    AND SG710.DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE
    AND LEAST(NVL(T430.FINE,SG710.DATA),SG710.DATA) BETWEEN SG746.DECORRENZA AND SG746.DECORRENZA_FINE
    AND SG710.CODREGOLA = SG746.CODREGOLA
    AND SG710.STATO_AVANZAMENTO = SG746.CODICE
    ORDER BY stato_avanzamento;
  Result varchar2(4000) := '';
BEGIN
  Result:=null;
  FOR R1 in C1(data, progressivo, tipo, stato) LOOP
    IF Result IS NOT NULL THEN
      Result:=Result || chr(13) || chr(10);
    END IF;
    Result:=Result || '(' || r1.data ||') ' || r1.desc_stato || ': ' || r1.esito || '.';
    IF r1.testo IS NOT NULL THEN
      Result:=Result || ' ' || r1.testo;
    END IF;
  END LOOP;
  Result:=Trim(Result);
  return(Result);
END;
/
