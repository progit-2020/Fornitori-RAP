update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.9',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

comment on column M150_RICHIESTE_RIMBORSI.STATO is 'null=Non autorizzato, A=Autorizzato, C=proveniente da agenzia Cisalpina, S=Pronto per l''importazione sulla M050, I=Importato sulla M050';

create function USR_T100T040F_GGLAVSEDE(P_PROGRESSIVO in integer, P_MESE in date, P_RILEVATORI in varchar2, P_CAUSALI in varchar2, P_GIUSTIF_PRES in varchar2, P_VERSO in varchar2 := 'E') return integer as
  result integer;
begin
  select count(*)
  into result
  from
   (select T100.DATA from VT100_TIMB_DATAORA T100
    where T100.PROGRESSIVO = P_PROGRESSIVO and T100.DATA between trunc(P_MESE,'mm') and last_day(P_MESE)
    and T100.VERSO = decode(P_VERSO,'EU',T100.VERSO,P_VERSO)
    and intersez_liste(nvl(T100.RILEVATORE,'null'),P_RILEVATORI) is null
    and intersez_liste(nvl(T100.CAUSALE,'xY'),P_CAUSALI) is null
    union
    select T040.DATA from T040_GIUSTIFICATIVI T040
    where T040.PROGRESSIVO = P_PROGRESSIVO and T040.DATA between trunc(P_MESE,'mm') and last_day(P_MESE)
    and INTERSEZ_LISTE(T040.CAUSALE,P_GIUSTIF_PRES) is not null
    );
  return result;
end/*--NOLOG--*/;
/

declare
  wNumero integer;
begin
  select count(*) into wNumero from T003_SELEZIONIANAGRAFE where nome = 'COVID_PTV';
  if wNumero = 0 then
	insert into T003_SELEZIONIANAGRAFE (nome, posizione, riga)
	values ('COVID_PTV', 0, 'T030.PROGRESSIVO in (');
	insert into T003_SELEZIONIANAGRAFE (nome, posizione, riga)
	values ('COVID_PTV', 1, 'select T430.PROGRESSIVO');
	insert into T003_SELEZIONIANAGRAFE (nome, posizione, riga)
	values ('COVID_PTV', 2, 'from T430_STORICO T430, T460_PARTTIME T460');
	insert into T003_SELEZIONIANAGRAFE (nome, posizione, riga)
	values ('COVID_PTV', 3, 'WHERE TRUNC(SYSDATE) BETWEEN DATADECORRENZA AND DATAFINE');
	insert into T003_SELEZIONIANAGRAFE (nome, posizione, riga)
	values ('COVID_PTV', 4, 'AND TRUNC(SYSDATE) BETWEEN INIZIO AND NVL(FINE,SYSDATE)');
	insert into T003_SELEZIONIANAGRAFE (nome, posizione, riga)
	values ('COVID_PTV', 5, 'AND T430.PARTTIME = T460.CODICE');
	insert into T003_SELEZIONIANAGRAFE (nome, posizione, riga)
	values ('COVID_PTV', 6, 'AND T460.TIPO = ''V''');
	insert into T003_SELEZIONIANAGRAFE (nome, posizione, riga)
	values ('COVID_PTV', 7, 'AND T460.PIANTA > 0 AND T460.PIANTA < 100');
	insert into T003_SELEZIONIANAGRAFE (nome, posizione, riga)
	values ('COVID_PTV', 8, ')');
	insert into T003_SELEZIONIANAGRAFE (nome, posizione, riga)
	values ('COVID_PTV', 9, 'ORDER BY T030.COGNOME, T030.NOME');
  end if;	
end;
/

declare
  wNumero integer;
begin
  select count(*) into wNumero from T002_QUERYPERSONALIZZATE where nome like 'RP_Covid%';
  if wNumero = 0 then
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', -9, 'N', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', -4, 'CHKINTESTAZIONE(N)CHKNORITORNOACAPO(N)', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', -2, 'Sostituzione,Stringa,Stringa,Data,Numero,Stringa,Data,Stringa,Stringa,Stringa', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', -1, '*,*,"","01/05/2020","22","","01/03/2020",*,"","834"', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 0, '------------------------', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 1, '-- Significato parametri: ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 2, '-- CAUSALI_SMW: elenco causali sulle timbrature da escludere.', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 3, '-- COD_ENTE:    cod. ente da trasmettere alle paghe', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 4, '-- DATA_CASSA:  data del cedolino', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 5, '-- GG_LAVORATIVI_MESE: gg lavorativi lavorabili di default riconosciuti se dato non reperibile da cartellino', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 6, '-- GIUSTIF_PRES: elenco causali di presenza da considerare come se fosse timbrato', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 7, '-- MESE_ELAB:    mese di riferimento su cui riconoscere il premio', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 8, '-- RILEVATORI_SMW: elenco rilevatori da escludere. (Per es. BV)', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 9, '-- TIMBR_ENTRATA: S = considera solo le timbrature in Entrata / N =) considera tutte le timbrature', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 10, '-- VOCE_PAGHE:    761 = gg lavorabili /834 = gg lavorati', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 11, '------------------------', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 12, 'select ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 13, ' :COD_ENTE||', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 14, ' ''0000''||', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 15, '  lpad(MATRICOLA,7,''0'')||', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 16, '  to_char(:DATA_CASSA,''yyyymm'')||', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 17, '  lpad(:VOCE_PAGHE,4,''0'')||', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 18, '  lpad(decode(lpad(:VOCE_PAGHE,4,''0''),''0834'',GG_TIMBRATI_SEDE,''0761'',GG_PRESENZA_TEORICI,0),11,''0'')||', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 19, '  ''00000000000''||', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 20, '  to_char(:MESE_ELAB,''yyyymm'')', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 21, '  /*', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 22, '  MATRICOLA, COGNOME, NOME, PROGRESSIVO, ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 23, '  trim(INIZIO) ASSUNZIONE, trim(FINE) CESSAZIONE,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 24, '  TURNISTA, TIPO_PT, substr(PERC_PT,1,6) PERC_PT,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 25, '  GG_CALENDARIO,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 26, '  GG_TIMBRATI_SEDE, ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 27, '  GG_PRESENZA_TEORICI,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 28, '  decode(GG_PRESENZA_TEORICI,0,0,least(1,GG_TIMBRATI_SEDE / GG_PRESENZA_TEORICI)) COEFFICIENTE_PREMIO,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 29, '  GG_SERVIZIO_MESE ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 30, '  --decode(GG_PRESENZA_TEORICI,0,0,least(round(GG_TIMBRATI_SEDE/GG_PRESENZA_TEORICI*to_number(:GG_NORMALIZZA),0),to_number(:GG_NORMALIZZA))) GG_NORMALIZZATI,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 31, '  */', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 32, 'from', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 33, '(', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 34, '  select ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 35, '    T030.PROGRESSIVO, T030.MATRICOLA, T030.COGNOME, T030.NOME, ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 36, '    T430.INIZIO, T430.FINE,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 37, '    decode(T460.PIANTA,100,'''',decode(T460.TIPO,''O'',''Orizz'',''V'',''Vert'',''C'',''Ciclico'','''')) TIPO_PT,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 38, '    decode(T460.PIANTA,100,'''',T460.PIANTA) PERC_PT,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 39, '    decode(T430.TGESTIONE,''1'',''Si'',''No'') TURNISTA,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 40, '    V010.NUMGIORNI GG_CALENDARIO,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 41, '    -- Giorni di servizio nel mese', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 42, '    T430F_GIORNISERVIZIO(T030.PROGRESSIVO,trunc(:MESE_ELAB,''mm''),last_day(:MESE_ELAB),''S'') GG_SERVIZIO_MESE,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 43, '    -- Giorni timbrati in sede', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 44, '    USR_T100T040F_GGLAVSEDE(T030.PROGRESSIVO, trunc(:MESE_ELAB,''mm''), :RILEVATORI_SMW, :CAUSALI_SMW, :GIUSTIF_PRES, decode(nvl(:TIMBR_ENTRATA,''N''),''S'',''E'',''EU'')) GG_TIMBRATI_SEDE,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 45, '    -- Giorni presenza teorici ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 46, '    V010F_GGLAV_MESE(T030.PROGRESSIVO, :MESE_ELAB, :GG_LAVORATIVI_MESE) GG_PRESENZA_TEORICI', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 47, '  from T030_ANAGRAFICO T030, T430_STORICO T430, T460_PARTTIME T460, V010_CALENDARI V010', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 48, '  where T430.PROGRESSIVO=T030.PROGRESSIVO ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 49, '  and last_day(:MESE_ELAB) between T430.DATADECORRENZA and T430.DATAFINE', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 50, '  and T430.INIZIO <= last_day(:MESE_ELAB) ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 51, '  and trunc(:MESE_ELAB,''MM'') <= nvl(T430.FINE,:MESE_ELAB)', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 52, '  and T460.CODICE(+) = T430.PARTTIME', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 53, '  and T030.PROGRESSIVO in (select PROGRESSIVO from :C700SelAnagrafe)', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 54, '  and V010.PROGRESSIVO(+) = T030.PROGRESSIVO', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 55, '  and V010.DATA(+) = last_day(:MESE_ELAB)', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 56, ')', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 57, 'where GG_SERVIZIO_MESE > 0 and GG_TIMBRATI_SEDE > 0', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_File_Paghe', 58, 'order by COGNOME, NOME', 'RILPRE');

	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', -9, 'N', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', -4, 'CHKINTESTAZIONE(N)CHKNORITORNOACAPO(N)', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', -2, 'Sostituzione,Stringa,Numero,Stringa,Data,Stringa,Stringa', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', -1, '*,*,"22","","01/03/2020",*,""', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 0, '------------------------', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 1, '-- Significato parametri: ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 2, '-- CAUSALI_SMW: elenco causali sulle timbrature da escludere.', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 3, '-- GG_LAVORATIVI_MESE: gg lavorativi lavorabili di default riconosciuti se dato non reperibile da cartellino', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 4, '-- GIUSTIF_PRES: elenco causali di presenza da considerare come se fosse timbrato', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 5, '-- MESE_ELAB:    mese di riferimento su cui riconoscere il premio', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 6, '-- RILEVATORI_SMW: elenco rilevatori da escludere. (Per es. BV)', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 7, '-- TIMBR_ENTRATA: S = considera solo le timbrature in Entrata / N =) considera tutte le timbrature', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 8, '------------------------', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 9, 'select MATRICOLA, COGNOME, NOME, PROGRESSIVO, ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 10, '       TURNISTA,TIPO_PT, substr(PERC_PT,1,6) PERC_PT,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 11, '       GG_CALENDARIO,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 12, '       GG_TIMBRATI_SEDE, ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 13, '       GG_PRESENZA_TEORICI,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 14, '       decode(GG_PRESENZA_TEORICI,0,0,least(1,GG_TIMBRATI_SEDE / GG_PRESENZA_TEORICI)) COEFFICIENTE_PREMIO,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 15, '       GG_SERVIZIO_MESE ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 16, '       --decode(GG_PRESENZA_TEORICI,0,0,least(round(GG_TIMBRATI_SEDE/GG_PRESENZA_TEORICI*to_number(:GG_NORMALIZZA),0),to_number(:GG_NORMALIZZA))) GG_NORMALIZZATI,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 17, 'from', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 18, '(', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 19, 'select T030.PROGRESSIVO, T030.MATRICOLA, T030.COGNOME, T030.NOME, ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 20, '       decode(T460.PIANTA,100,'''',decode(T460.TIPO,''O'',''Orizz'',''V'',''Vert'',''C'',''Ciclico'','''')) TIPO_PT,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 21, '       decode(T460.PIANTA,100,'''',T460.PIANTA) PERC_PT,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 22, '       decode(T430.TGESTIONE,''1'',''Si'',''No'') TURNISTA,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 23, '       V010.NUMGIORNI GG_CALENDARIO,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 24, '       -- Giorni di servizio nel mese', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 25, '       T430F_GIORNISERVIZIO(T030.PROGRESSIVO,trunc(:MESE_ELAB,''mm''),last_day(:MESE_ELAB),''S'') GG_SERVIZIO_MESE,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 26, '       -- Giorni timbrati in sede', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 27, '       USR_T100T040F_GGLAVSEDE(T030.PROGRESSIVO, trunc(:MESE_ELAB,''mm''), :RILEVATORI_SMW, :CAUSALI_SMW, :GIUSTIF_PRES, decode(nvl(:TIMBR_ENTRATA,''N''),''S'',''E'',''EU'')) GG_TIMBRATI_SEDE,', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 28, '       -- Giorni presenza teorici ', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 29, '       V010F_GGLAV_MESE(T030.PROGRESSIVO, :MESE_ELAB, :GG_LAVORATIVI_MESE) GG_PRESENZA_TEORICI', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 30, 'from T030_ANAGRAFICO T030, T430_STORICO T430, T460_PARTTIME T460, V010_CALENDARI V010', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 31, 'where T430.PROGRESSIVO=T030.PROGRESSIVO and last_day(:MESE_ELAB) between T430.DATADECORRENZA and T430.DATAFINE', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 32, 'and T460.CODICE(+)=T430.PARTTIME', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 33, 'and T430.PROGRESSIVO=T030.PROGRESSIVO and last_day(:MESE_ELAB) between T430.DATADECORRENZA and T430.DATAFINE', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 34, 'and T030.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 35, 'and V010.PROGRESSIVO(+) = T030.PROGRESSIVO', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 36, 'and V010.DATA(+) = last_day(:MESE_ELAB)', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 37, ')', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 38, 'where GG_SERVIZIO_MESE > 0 and GG_TIMBRATI_SEDE > 0', 'RILPRE');
	insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
	values ('RP_Covid_Premio_Lav_Dip', 39, 'order by COGNOME, NOME', 'RILPRE');
  end if;	
end;
/
