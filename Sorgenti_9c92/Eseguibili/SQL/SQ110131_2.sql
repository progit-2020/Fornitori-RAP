alter table M010_PARAMETRICONTEGGIO add CAUSALE_MISSIONE varchar2(5);
comment on column M010_PARAMETRICONTEGGIO.CAUSALE_MISSIONE is 'causale per l''inserimento della missione nei giustificativi';

alter table T105_RICHIESTETIMBRATURE add RILEVATORE_RICH varchar2(2);
comment on column T105_RICHIESTETIMBRATURE.RILEVATORE_RICH
  is 'Rilevatore indicato dal dipendente solo in fase di inserimento di timbratura mancante';
  
update t002_querypersonalizzate t set t.nome='PA_Ind_Art_42_Con_Tred' where t.applicazione='PAGHE' and t.nome='PA_Ind_Art_42';

-- Creazione interrogazione di servizio PA_Ind_Art_42_Senza_Tred
declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from t002_querypersonalizzate t where t.nome = 'PA_Ind_Art_42_Senza_Tred';
    if i = 0 then
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', -2, 'Data,Numero,Stringa', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', -1, '"31/01/2011","44276,33",*', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 0, 'SELECT T030.MATRICOLA,T030.COGNOME,T030.NOME,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 1, '       ROUND(LEAST(SUM(P272.IMPORTO),:MassimaleAnnuo/1.238/12)/30,5) IMPORTO_GG_IND_ART_42', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 2, 'FROM T030_ANAGRAFICO T030, P430_ANAGRAFICO P430, P272_RETRIBUZIONE_CONTRATTUALE P272,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 3, '     P205_QUOTE P205, P200_VOCI P200', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 4, 'WHERE T030.MATRICOLA=:Matricola', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 5, 'AND P430.PROGRESSIVO=T030.PROGRESSIVO AND :DataCompetenza BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 6, 'AND P272.PROGRESSIVO=T030.PROGRESSIVO AND P272.COD_CONTRATTO=P430.COD_CONTRATTO', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 7, 'AND :DataCompetenza BETWEEN P272.DECORRENZA_INIZIO AND P272.DECORRENZA_FINE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 8, 'AND P205.COD_CONTRATTO=P272.COD_CONTRATTO AND P205.COD_VOCE_DA_QUOTARE=''15034''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 9, 'AND P205.COD_VOCE_SPECIALE_DA_QUOTARE=''BASE'' AND P205.COD_VOCE_IN_QUOTA=P272.COD_VOCE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 10, 'AND P205.COD_VOCE_SPECIALE_IN_QUOTA=P272.COD_VOCE_SPECIALE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 11, 'AND P200.COD_CONTRATTO=P205.COD_CONTRATTO AND P200.COD_VOCE=P205.COD_VOCE_IN_QUOTA', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 12, 'AND P200.COD_VOCE_SPECIALE=P205.COD_VOCE_SPECIALE_IN_QUOTA', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 13, 'AND :DataCompetenza BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42_Senza_Tred', 14, 'GROUP BY T030.MATRICOLA,T030.COGNOME,T030.NOME', 'PAGHE');
    end if;
  end if;
end;
/

alter table T265_CAUASSENZE add ALLARME_FRUIZIONE_CONTINUATIVA number(4);
comment on column T265_CAUASSENZE.ALLARME_FRUIZIONE_CONTINUATIVA is 'numero di giorni continuativi al raggiungimento dei quali viene data segnalazione all''operatore';
