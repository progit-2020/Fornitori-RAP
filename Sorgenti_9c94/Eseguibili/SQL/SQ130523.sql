update MONDOEDP.I090_ENTI set VERSIONEDB = '9.0',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T100_TIMBRATURE add ID_RICHIESTA number(38);
comment on column T100_TIMBRATURE.ID_RICHIESTA is 'T105.ID della richiesta di modifica della timbratura';

alter table MONDOEDP.I090_ENTI add gruppo_badge VARCHAR2(1);
comment on column MONDOEDP.I090_ENTI.gruppo_badge
  is 'Valore del raggruppamento di piu'''' aziende che condividono la numerazione dei badge';

insert into MONDOEDP.I091_DATIENTE (AZIENDA, TIPO, DATO) values (:AZIENDA, 'C90_W026ECCEDGG_TUTTA', 'S');
insert into MONDOEDP.I091_DATIENTE (AZIENDA, TIPO, DATO) values (:AZIENDA, 'C90_W026CHECKSALDODISPONIBILE', 'N');

create table T082_PAR_PIANIFORARI
(
  codice           varchar2(5) not null,
  descrizione      varchar2(1000),
  titolo           varchar2(1000) default 'Tabellone turni',
  note_stampa      varchar2(2000) default 'NOTA: Ogni richiesta di variazione dovra essere trasmessa a questo ufficio',
  descrizione1     varchar2(1000) default 'L''UFFICIO DEL PERSONALE',
  descrizione2     varchar2(1000) default 'IL DIRETTORE SANITARIO',
  dett_stampa      varchar2(1) default 'S',
  righe_dip        varchar2(1) default '4',
  ord_stampa       varchar2(1) default 'C',
  tipo_stampa      varchar2(1) default 'P',
  tot_turno        varchar2(1) default 'N',
  tot_ope_turno    varchar2(1) default 'N',
  tot_liquidabile  varchar2(1) default 'N',
  dett_orari       varchar2(1) default 'N',
  tot_turni_mese   varchar2(1) default 'N',
  tot_generali     varchar2(1) default 'N',
  assenze          varchar2(1) default 'N',
  saldi_ore        varchar2(1) default 'N',
  margine_sx       number(2,0) default 5,
  dimensione_font  number(2,0) default 7,
  gg_pagina        number(2,0) default 31,
  separatore_col   varchar2(1) default 'N',
  separatore_righe varchar2(1) default 'N',
  orientamento_pag varchar2(1) default 'A',
  modalita_lavoro  varchar2(1) default 'N',
  ord_vis          varchar2(1) default 'N',
  pianif_gg_fest   varchar2(1) default 'S',
  pianif_solo_turn varchar2(1) default 'N',
  pianif_gg_ass    varchar2(1) default 'N',
  caus_ecluditurno varchar2(2000),
  righe_nome varchar2(1) default 'N',
  orario_sintetico varchar2(1) default 'N',
  dato_anagrafico varchar2(40))
tablespace LAVORO
 storage (initial 256K next 256K pctincrease 0);
comment on column T082_PAR_PIANIFORARI.dett_stampa
  is 'S=Sintetica, D=Dettagliata';
comment on column T082_PAR_PIANIFORARI.ord_stampa
  is 'C=Cognome, S=Squadra/Operatore, T=Turno di partenza, P=Turno pianificato';
comment on column T082_PAR_PIANIFORARI.tipo_stampa
  is 'P=Stampa preventiva, C=Stampa consuntiva';
comment on column T082_PAR_PIANIFORARI.orientamento_pag
  is 'A=Automatico, O=Orizzontale, V=Verticale';
comment on column T082_PAR_PIANIFORARI.modalita_lavoro
  is 'O=Operativa, N=Non operativa';
comment on column T082_PAR_PIANIFORARI.ord_vis
  is 'N=Nominativo, S=Squadra/Operatore, T=Turno di partenza, P=Turno pianificato'; 
comment on column T082_PAR_PIANIFORARI.righe_nome
  is 'S = 2 righe, N = 1 riga';
comment on column T082_PAR_PIANIFORARI.orario_sintetico
  is 'S = Visualizzo primi due caratteri orario nel campo turno, N = Il simbolo di modello orario non a turni';  
alter table T082_PAR_PIANIFORARI
  add constraint PK_T082 primary key (CODICE);  

declare
  cursor C1 is
    select distinct T001.UTENTE
      from T001_PARAMETRIFUNZIONI T001
     where T001.PROG like 'A058%'
       and T001.UTENTE is not null;
  cursor C2(MyUser string) is
    select T001.*
      from T001_PARAMETRIFUNZIONI T001
     where T001.UTENTE = MyUser
       and T001.PROG like 'A058%';
  codProfilo integer;  
  TempSTR varchar2(2000);
begin
  codProfilo:=0;  
  for T1 in C1 loop
    insert into T001_PARAMETRIFUNZIONI(PROG,NOME,VALORE,UTENTE) values('A058','CODPROFILO',lpad(to_char(codProfilo),2,'0'),T1.UTENTE);
    insert into T082_PAR_PIANIFORARI(CODICE,DESCRIZIONE) values(lpad(to_char(codProfilo),2,'0'),'Profilo '||T1.UTENTE);    
    for T2 in C2(T1.UTENTE) loop
      if T2.NOME = 'TITOLO' then
        update T082_PAR_PIANIFORARI T082
           set T082.TITOLO = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');
      elsif T2.NOME = 'NOTA' then
        update T082_PAR_PIANIFORARI T082
           set T082.NOTE_STAMPA = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');      
      elsif T2.NOME = 'DESCRIZIONE1' then
        update T082_PAR_PIANIFORARI T082
           set T082.DESCRIZIONE1 = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');               
      elsif T2.NOME = 'DESCRIZIONE2' then
        update T082_PAR_PIANIFORARI T082
           set T082.DESCRIZIONE2 = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                        
      elsif T2.NOME = 'TIPOSTAMPA' then             
        TempSTR:='S';        
        if T2.VALORE = '1' then
          TempSTR:='D';
        end if;
        update T082_PAR_PIANIFORARI T082
           set T082.DETT_STAMPA = TempSTR
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                        
      elsif T2.NOME = 'RGPRIGHEDIP' then
        TempSTR:='4';
        if T2.VALORE = '0' then
          TempSTR:='2';
        elsif T2.VALORE = '1' then
          TempSTR:='3';          
        end if;
        update T082_PAR_PIANIFORARI T082
           set T082.RIGHE_DIP = TempSTR
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');
      elsif (T2.NOME = 'ORDINAMENTO') and (T2.PROG = 'A058B') then
        TempSTR:='C';
        if T2.VALORE = '1' then
          TempSTR:='S';
        elsif T2.VALORE = '2' then
          TempSTR:='T';          
        elsif T2.VALORE = '3' then
          TempSTR:='P';                    
        end if;
        update T082_PAR_PIANIFORARI T082
           set T082.ORD_STAMPA = TempSTR
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');
      elsif T2.NOME = 'PREVENTIVACONSUNTIVA' then             
        TempSTR:='P';        
        if T2.VALORE = '1' then
          TempSTR:='C';
        end if;
        update T082_PAR_PIANIFORARI T082
           set T082.TIPO_STAMPA = TempSTR
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                 
      elsif T2.NOME = 'TOTTURNO' then             
        update T082_PAR_PIANIFORARI T082
           set T082.TOT_TURNO = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                          
      elsif T2.NOME = 'CHKTOTOPER' then             
        update T082_PAR_PIANIFORARI T082
           set T082.TOT_OPE_TURNO = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                   
      elsif T2.NOME = 'CHKLIQUID' then             
        update T082_PAR_PIANIFORARI T082
           set T082.TOT_LIQUIDABILE = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                            
      elsif T2.NOME = 'DETTORARI' then             
        update T082_PAR_PIANIFORARI T082
           set T082.DETT_ORARI = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                                     
      elsif T2.NOME = 'TOTALE_TURNI_MESE' then             
        update T082_PAR_PIANIFORARI T082
           set T082.TOT_TURNI_MESE = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                                              
      elsif T2.NOME = 'CHKTOTGENTURNI' then             
        update T082_PAR_PIANIFORARI T082
           set T082.TOT_GENERALI = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                                                       
      elsif (T2.NOME = 'ASSENZE') and (T2.PROG = 'A058B') then             
        update T082_PAR_PIANIFORARI T082
           set T082.ASSENZE = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                                                                
      elsif T2.NOME = 'SALDI' then             
        update T082_PAR_PIANIFORARI T082
           set T082.SALDI_ORE = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                                                                
      elsif T2.NOME = 'EDTMARGINESX' then             
        update T082_PAR_PIANIFORARI T082
           set T082.MARGINE_SX = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                                                                         
      elsif T2.NOME = 'SEDTFONTSIZE' then             
        update T082_PAR_PIANIFORARI T082
           set T082.DIMENSIONE_FONT = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');          
      elsif T2.NOME = 'NUMERO_GIORNI' then             
        update T082_PAR_PIANIFORARI T082
           set T082.GG_PAGINA = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                   
      elsif T2.NOME = 'SEPARATORE_COLONNE' then             
        update T082_PAR_PIANIFORARI T082
           set T082.SEPARATORE_COL = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                   
      elsif T2.NOME = 'SEPARATORE_RIGHE' then             
        update T082_PAR_PIANIFORARI T082
           set T082.SEPARATORE_RIGHE = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                     
      elsif T2.NOME = 'CMBORIPAGINA' then             
        TempStr:='A';
        if T2.VALORE = '1' then
          TempStr:='V';          
        elsif T2.VALORE = '2' then
          TempStr:='O';                    
        end if;
        update T082_PAR_PIANIFORARI T082
           set T082.ORIENTAMENTO_PAG = TempStr
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                              
      elsif T2.NOME = 'MODALITALAVORO' then             
        TempSTR:='O';
        if T2.VALORE = '1' then
          TempSTR:='N';
        end if;
        update T082_PAR_PIANIFORARI T082
           set T082.MODALITA_LAVORO = TempSTR
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                              
      elsif (T2.NOME = 'ORDINAMENTO') and (T2.PROG = 'A058A')  then             
        TempSTR:='N';
        if T2.VALORE = '1' then
          TempSTR:='S';
        elsif T2.VALORE = '2' then
          TempSTR:='T';          
        elsif T2.VALORE = '3' then
          TempSTR:='P';                    
        end if;
        update T082_PAR_PIANIFORARI T082
           set T082.ORD_VIS = TempSTR
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                       
      elsif T2.NOME = 'GIORNIFESTIVI' then             
        update T082_PAR_PIANIFORARI T082
           set T082.PIANIF_GG_FEST = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                              
      elsif T2.NOME = 'GESTIONE_TURNISTA' then             
        update T082_PAR_PIANIFORARI T082
           set T082.PIANIF_SOLO_TURN = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                       
      elsif T2.NOME = 'ORARIOGGASSENZA' then             
        update T082_PAR_PIANIFORARI T082
           set T082.PIANIF_GG_ASS = T2.VALORE
         where T082.CODICE = lpad(to_char(codProfilo),2,'0');                                                                
      end if;           
    end loop;    
    codProfilo:=codProfilo + 1;
    commit;    
  end loop;
  update T001_PARAMETRIFUNZIONI T001
     set T001.PROG = 'A058'
   where T001.PROG = 'A058A'
     and T001.UTENTE is not null;  
  commit;
end;
/

create table T721_EVENTI_STR (
  CODICE varchar2(10),
  DESCRIZIONE varchar2(50)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T721_EVENTI_STR add constraint T721_PK primary key (CODICE) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T724_EVENTI_STR_INDIVIDUALI drop constraint T724_FK_T722/*--NOLOG--*/;
drop table T722_PERIODI_EVENTI_STR/*--NOLOG--*/;

create table T722_PERIODI_EVENTI_STR (
  CODICE varchar2(10),
  DECORRENZA date,
  DECORRENZA_FINE date,
  DESCRIZIONE varchar2(80),
  ID number(8),
  ORE_TOTALI varchar2(7),
  ORE_INDIV  varchar2(7),
  CAUSALE_STR varchar2(5), 
  CAUSALE_STR_DOM varchar2(5), 
  STATO varchar2(1)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T722_PERIODI_EVENTI_STR modify STATO default 'A';
alter table T722_PERIODI_EVENTI_STR add constraint T722_PK primary key (CODICE,DECORRENZA) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T722_PERIODI_EVENTI_STR add constraint T722_ID unique (ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column T722_PERIODI_EVENTI_STR.ORE_TOTALI is 'ore totali disponibili per l''evento - inutilizzato';
comment on column T722_PERIODI_EVENTI_STR.ORE_INDIV is 'ore disponibili individualmente';
comment on column T722_PERIODI_EVENTI_STR.CAUSALE_STR is 'causale di presenza con cui causalizzare la prestazione nei giorni lu..sa';
comment on column T722_PERIODI_EVENTI_STR.CAUSALE_STR_DOM is 'causale di presenza con cui causalizzare la prestazione nella domenica';
comment on column T722_PERIODI_EVENTI_STR.STATO is 'A=aperto, C=chiuso';

create table T723_BUDGET_EVENTI_STR
(
  id              NUMBER(8),
  codgruppo       VARCHAR2(10) not null,
  filtro_anagrafe VARCHAR2(4000) not null,
  tipo            VARCHAR2(5) not null,
  descrizione     VARCHAR2(100),
  ore             VARCHAR2(10),
  importo         NUMBER
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T723_BUDGET_EVENTI_STR add constraint T723_PK primary key (ID, CODGRUPPO, TIPO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column T723_BUDGET_EVENTI_STR.ID is 'id dell''evento straordinario: T722.ID';
comment on column T723_BUDGET_EVENTI_STR.CODGRUPPO is 'Codice identificativo del gruppo di appartenenza';
comment on column T723_BUDGET_EVENTI_STR.FILTRO_ANAGRAFE is 'Filtro anagrafico che identifica i dipendenti del gruppo';
comment on column T723_BUDGET_EVENTI_STR.TIPO is '#B.O#=Banca Ore, #LIQ#=Liquidabile, altro=causale di presenza - inutilizzato';
comment on column T723_BUDGET_EVENTI_STR.ORE is 'Ore annue di budget straordinario';
comment on column T723_BUDGET_EVENTI_STR.IMPORTO is 'Importo annuo di budget straordinario - inutilizzato';

create table T724_EVENTI_STR_INDIVIDUALI (
  PROGRESSIVO number(8),
  ID number(8),
  DAL date,
  AL date,
  SERVIZI varchar2(200),
  DELEGATO varchar2(1),
  TIPO_LAVORO varchar2(5),
  ORE_INDIV varchar2(7)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T724_EVENTI_STR_INDIVIDUALI add constraint T724_PK primary key (PROGRESSIVO,ID,DAL) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T724_EVENTI_STR_INDIVIDUALI add constraint T724_FK_T722 foreign key (ID) references T722_PERIODI_EVENTI_STR (ID);

comment on column T724_EVENTI_STR_INDIVIDUALI.ID is 'T722.ID';
comment on column T724_EVENTI_STR_INDIVIDUALI.DAL is '>= T722.DAL';
comment on column T724_EVENTI_STR_INDIVIDUALI.AL is '<= T722.AL';
comment on column T724_EVENTI_STR_INDIVIDUALI.SERVIZI is 'Elenco servizi esterni a cui è possibile imputare la prestazione';
comment on column T724_EVENTI_STR_INDIVIDUALI.TIPO_LAVORO is 'Tipologia del servizio';
comment on column T724_EVENTI_STR_INDIVIDUALI.ORE_INDIV is 'Ridefinizione ore individuali per personale part-time';

alter table T320_PIANLIBPROFESSIONE add ID_EVENTO_STR number(8);
comment on column T320_PIANLIBPROFESSIONE.ID_EVENTO_STR is 'relazione a T722.ID'; 

alter table T320_PIANLIBPROFESSIONE add SERVIZIO varchar2(20);
comment on column T320_PIANLIBPROFESSIONE.SERVIZIO is 'dato anagrafico che identifica il servizio per cui si effettua la prestazione'; 

create sequence T722_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

alter table T025_CONTMENSILI add ITER_ECCGG_CHECKSALDO varchar2(1) default 'N';
comment on column T025_CONTMENSILI.ITER_ECCGG_CHECKSALDO is 'S=l''iter delle eccedenze giornaliere verifica la disponibilità nel saldo complessivo, N=l''iter delle eccedenze giornaliere non considera il saldo complessivo';

alter table T220_PROFILIORARI add PRIORITA_DOM_NONLAV varchar2(1) default 'N';
comment on column T220_PROFILIORARI.PRIORITA_DOM_NONLAV is 
  'S=nelle Domeniche viene scelto l''orario della Domenica invece che il Non Lavorativo';
update T220_PROFILIORARI set PRIORITA_DOM_NONLAV = 'S';

alter table T265_CAUASSENZE add ARROT_COMPETENZE varchar2(1) default 'N';
comment on column T265_CAUASSENZE.ARROT_COMPETENZE is 
  'S=richiama la prcoedura T265P_ARROTCOMPETENZE arrotondando i valori delle competenze in fasce calcolate dai conteggi, dopo i vari riproporzionameti';

alter table I200_PUBBL_DOC add ROOT varchar2(200);
comment on column I200_PUBBL_DOC.ROOT is 'percorso principale in cui sono posizionati i documenti da pubblicare: se nullo viene considerato di default Archivi\usr_files';

update MONDOEDP.I074_FILTRODIZIONARIO Set TABELLA = 'TIPOLOGIA TRASFERTA' where TABELLA = 'TIPI MISSIONE';
