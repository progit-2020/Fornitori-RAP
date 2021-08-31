comment on column T021_FASCEORARI.TIPO_FASCIA is 'PN=Punti Nominali, PMA=Pausa Mensa Automatica, PMT=Pausa Mensa Timbrata, STR=Straordinario, FO=Fascia obbligatoria, MGM=fascia del Mattino, MGP=fascia del Pomeriggio'; 

alter table T265_CAUASSENZE add CSI_MAX_MGMAT number(8);
alter table T265_CAUASSENZE add CSI_MAX_MGPOM number(8);
comment on column T265_CAUASSENZE.CSI_MAX_MGMAT is 'numero max di mezze giornate fruite come mattina';
comment on column T265_CAUASSENZE.CSI_MAX_MGPOM is 'numero max di mezze giornate fruite come pomeriggio';

alter table T040_GIUSTIFICATIVI add CSI_TIPO_MG varchar2(1);
comment on column T040_GIUSTIFICATIVI.CSI_TIPO_MG is 'M=mattino, P=pomeriggio, null=indefinito';

alter table T050_RICHIESTEASSENZA add CSI_TIPO_MG varchar2(1);
comment on column T050_RICHIESTEASSENZA.CSI_TIPO_MG is 'M=mattino, P=pomeriggio, null=indefinito';

create table MONDOEDP.CSI002_SCHEDULAZIONI_B027 (
  DESCRIZIONE varchar2(1000),
  DAL date,
  AL date,
  ORDINE number(3),
  AZIENDA varchar2(30),
  FILEIN varchar2(100),
  FILEOUT varchar2(100),
  FILESEMAFORO varchar2(100),
  ROTTURACHIAVE varchar2(100),
  SALTOPAGINA varchar2(100),
  STRAPPOPAGINA varchar2(100),
  INIZIOPAGINA number(8),
  NUMRIGHE number(3),
  MESIINDIETRO number(2),
  ULTIMOMESE number(2),
  AGGIORNAMENTOSCHEDE varchar2(1),
  ABBATTIMENTOBANCAORE varchar2(1),
  SOLOAGGIORNAMENTO varchar2(1),
  AUTOGIUSTIFICAZIONE varchar2(1),
  IGNORAANOMALIE varchar2(1),
  PARCARTELLINO varchar2(5),
  SELEZIONEANAGRAFICA varchar2(100),
  CARATTEREFOB number(3),
  MAILSERVER varchar2(100),
  MAILUSER varchar2(100),
  MAILPASSWORD varchar2(100),
  MailFromAddress varchar2(100),
  MailToAddress varchar2(100),
  MAILOGGETTO varchar2(100),
  MailTestoInizio varchar2(100),
  MailTestoFine varchar2(100)
) tablespace LAVORO;
