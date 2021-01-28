create or replace procedure M040P_CARICA_MISSIONE_DAITER(pID in integer) as
  wProgressivo m140_richieste_missioni.progressivo%type;
  wMaschera    mondoedp.i005_msginfo.maschera%type;
  wTipo        mondoedp.i006_msgdati.tipo%type;
  wMsg         mondoedp.i006_msgdati.msg%type;
begin
  /* inizializzazioni */
  wMaschera:='M040P_CARICA_MISSIONE_DAITER';
  
  /* fase 1: importazione richiesta */
  begin
    /* estrae dati della richiesta per info log */ 
    begin
      select m140.progressivo
      into   wProgressivo
      from   m140_richieste_missioni m140, 
             t850_iter_richieste t850
      where  m140.id = pID
      and    t850.iter = 'M140'
      and    t850.id = m140.id;
    exception
      when no_data_found then
        wProgressivo:=null;
    end;
    
    if wProgressivo is null then
      /* se il progressivo è null, significa che la richiesta con l'id indicato è inesistente */
      wTipo:='A';
      wMsg:='Importazione impossibile: la richiesta ID = ' || pID || ' non è presente in archivio!';
    else
      /* importazione della trasferta su win */

		  insert into M040_MISSIONI (PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, PROTOCOLLO, TIPOREGISTRAZIONE, DATAA, ORAA,
		                           TOTALEGG, DURATA,
		                           TARIFFAINDINTERA, OREINDINTERA, IMPORTOINDINTERA, TARIFFAINDRIDOTTAH, OREINDRIDOTTAH, IMPORTOINDRIDOTTAH,
		                           TARIFFAINDRIDOTTAG, OREINDRIDOTTAG, IMPORTOINDRIDOTTAG, TARIFFAINDRIDOTTAHG, OREINDRIDOTTAHG, IMPORTOINDRIDOTTAHG,
		                           FLAG_MODIFICATO, PARTENZA, DESTINAZIONE, NOTE_RIMBORSI, COMMESSA, STATO, COD_TARIFFA, COD_RIDUZIONE, ID_MISSIONE)
		  select M140.PROGRESSIVO, trunc(M140.DATAA,'MM'),trunc(M140.DATAA,'MM'), M140.DATADA, M140.ORADA, M140.PROTOCOLLO, M140.TIPOREGISTRAZIONE, M140.DATAA, M140.ORAA,
		         M140.DATAA - M140.DATADA + 1, minutiore(((M140.dataa - M140.datada) * 24 * 60) + (oreminuti(M140.oraa) - oreminuti(M140.orada))),
		         0, 0, 0, 0, 0, 0,
		         0, 0, 0, 0, 0, 0,
		         'N', 
		         M140F_GETPARTENZA(M140.ID),
		         M140F_GETDESTINAZIONE(M140.ID),
		         NULL, NULL, 'S',
		         DECODE(M140.FLAG_DESTINAZIONE,'E','ESTERO',NULL), -- COD_TARIFFA
		         DECODE(M140.FLAG_DESTINAZIONE,'E','ZERO',NULL), -- COD_RIDUZIONE
		         M140.ID
		  from   M140_RICHIESTE_MISSIONI M140, T850_ITER_RICHIESTE T850
		  where  M140.ID = pID
		  and    T850.ITER = 'M140'
		  and    T850.ID = M140.ID;
		  --and    nvl(T850.TIPO_RICHIESTA,'0') <> 'A';

      /* errore se nessuna riga è stata inserita */
      if sql%rowcount = 0 then
        wTipo:='A';
        wMsg:='Importazione fallita: la richiesta ID = ' || pID || ' non è stata importata su IrisWin';
      else
        wTipo:='I';
        wMsg:='Importazione effettuata correttamente: richiesta ID = ' || pID;
      end if;
    end if;
  exception
    when others then
      /* errore in fase di inserimento */
      wTipo:='A';
      /*--NOLOG--*/
      wMsg:='Errore in fase di importazione della richiesta ID = ' || pID || ': ORA-' || sqlcode || ': ' || sqlerrm;
  end;
  
  /* fase 2: log delle operazioni relative all'inserimento missione */
  I005P_REGISTRAMSG(null,null,wMaschera,wTipo,wMsg,wProgressivo);
end;
/