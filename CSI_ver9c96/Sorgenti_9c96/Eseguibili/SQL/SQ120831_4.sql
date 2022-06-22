UPDATE t480_comuni t SET T.CITTA='ROCCADARCE' WHERE T.CODCATASTALE='H393';
UPDATE t480_comuni t SET T.CODCATASTALE='M204' WHERE T.CITTA='ZUNGRI';

alter table P440_CEDOLINOSTATO add cedolino_bloccato varchar2(1) default 'N';
comment on column P440_CEDOLINOSTATO.cedolino_bloccato
  is 'Cedolini bloccati: S=Si'' cioe'' non è possibile effettuare Precalcolo/Calcolo/Annulla precalcolo e calcolo, N=No';

UPDATE MONDOEDP.I073_FILTROFUNZIONI
SET INIBIZIONE = 'N'
WHERE TAG = 434 AND AZIENDA = :AZIENDA;

-- Creazione tabella di trascodifica qualifiche DMA
create table P675_QUALIFICADMA
( cod_qualif_minist       VARCHAR2(20) not null,
  cod_posizione_economica VARCHAR2(5) not null,
  decorrenza              DATE not null,
  decorrenza_fine         DATE,
  cod_qualif_dma          VARCHAR2(20) not null,
  descrizione             VARCHAR2(100)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table P675_QUALIFICADMA
  add constraint P675_PK primary key (COD_QUALIF_MINIST, COD_POSIZIONE_ECONOMICA, DECORRENZA)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16021', 'D0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16021', 'COLL.RE PROF.LE SANITARIO - PERS. TEC.- D');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16021', 'D1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16035', 'COLL.RE PROF.LE SANITARIO - PERS. TEC.- D1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16021', 'D2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16036', 'COLL.RE PROF.LE SANITARIO - PERS. TEC.- D2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16021', 'D3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16037', 'COLL.RE PROF.LE SANITARIO - PERS. TEC.- D3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16021', 'D4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16038', 'COLL.RE PROF.LE SANITARIO - PERS. TEC.- D4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16021', 'D5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16039', 'COLL.RE PROF.LE SANITARIO - PERS. TEC.- D5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16021', 'D6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16040', 'COLL.RE PROF.LE SANITARIO - PERS. TEC.- D6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16022', 'D0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16022', 'COLL.RE PROF.LE SANITARIO - PERS. DI VIGIL.ED ISPEZ. - D');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16022', 'D1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16041', 'COLL.RE PROF.LE SANITARIO - PERS. DI VIGIL.ED ISPEZ. - D1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16022', 'D2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16042', 'COLL.RE PROF.LE SANITARIO - PERS. DI VIGIL.ED ISPEZ. - D2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16022', 'D3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16043', 'COLL.RE PROF.LE SANITARIO - PERS. DI VIGIL.ED ISPEZ. - D3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16022', 'D4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16044', 'COLL.RE PROF.LE SANITARIO - PERS. DI VIGIL.ED ISPEZ. - D4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16022', 'D5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16045', 'COLL.RE PROF.LE SANITARIO - PERS. DI VIGIL.ED ISPEZ. - D5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16022', 'D6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16046', 'COLL.RE PROF.LE SANITARIO - PERS. DI VIGIL.ED ISPEZ. - D6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18023', 'Ds0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18023', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. ESPERTO - DS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18023', 'Ds1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18024', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. ESPERTO - DS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18023', 'Ds2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18025', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. ESPERTO - DS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18023', 'Ds3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18026', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. ESPERTO - DS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18023', 'Ds4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18027', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. ESPERTO - DS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18023', 'Ds5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18028', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18023', 'Ds5/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18028', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18023', 'Ds6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18029', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18023', 'Ds6/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18029', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18920', 'Ds0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18920', 'COLL.RE PROF.LE SANITARIO - PERS. TEC. ESPERTO - DS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18920', 'Ds1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18923', 'COLL.RE PROF.LE SANITARIO - PERS. TEC. ESPERTO - DS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18920', 'Ds2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18924', 'COLL.RE PROF.LE SANITARIO - PERS. TEC. ESPERTO - DS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18920', 'Ds3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18925', 'COLL.RE PROF.LE SANITARIO - PERS. TEC. ESPERTO - DS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18920', 'Ds4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18926', 'COLL.RE PROF.LE SANITARIO - PERS. TEC. ESPERTO - DS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18920', 'Ds5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18927', 'COLL.RE PROF.LE SANITARIO - PERS. TEC. ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18920', 'Ds5/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18927', 'COLL.RE PROF.LE SANITARIO - PERS. TEC. ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18920', 'Ds6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18928', 'COLL.RE PROF.LE SANITARIO - PERS. TEC. ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18920', 'Ds6/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18928', 'COLL.RE PROF.LE SANITARIO - PERS. TEC. ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18921', 'Ds0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18921', 'COLL.RE PROF.LE SANITARIO - TECN. DELLA PREV. ESPERTO - DS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18921', 'Ds1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18929', 'COLL.RE PROF.LE SANITARIO - TECN. DELLA PREV. ESPERTO - DS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18921', 'Ds2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18930', 'COLL.RE PROF.LE SANITARIO - TECN. DELLA PREV. ESPERTO - DS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18921', 'Ds3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18931', 'COLL.RE PROF.LE SANITARIO - TECN. DELLA PREV. ESPERTO - DS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18921', 'Ds4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18932', 'COLL.RE PROF.LE SANITARIO - TECN. DELLA PREV. ESPERTO - DS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18921', 'Ds5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18933', 'COLL.RE PROF.LE SANITARIO - TECN. DELLA PREV. ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18921', 'Ds5/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18933', 'COLL.RE PROF.LE SANITARIO - TECN. DELLA PREV. ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18921', 'Ds6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18934', 'COLL.RE PROF.LE SANITARIO - TECN. DELLA PREV. ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18921', 'Ds6/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18934', 'COLL.RE PROF.LE SANITARIO - TECN. DELLA PREV. ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18922', 'Ds0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18922', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. ESPERTO - DS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18922', 'Ds1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18935', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. ESPERTO - DS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18922', 'Ds2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18936', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. ESPERTO - DS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18922', 'Ds3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18937', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. ESPERTO - DS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18922', 'Ds4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18938', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. ESPERTO - DS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18922', 'Ds5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18939', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18922', 'Ds5/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18939', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18922', 'Ds6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18940', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S18922', 'Ds6/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S18940', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T11008', 'A0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T11008', 'AUSILIARIO SPECIALIZZATO - A');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T11008', 'A1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T11009', 'AUSILIARIO SPECIALIZZATO - A1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T11008', 'A2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T11010', 'AUSILIARIO SPECIALIZZATO - A2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T11008', 'A3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T11011', 'AUSILIARIO SPECIALIZZATO - A3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T11008', 'A4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T11012', 'AUSILIARIO SPECIALIZZATO - A4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T11008', 'A5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T11013', 'AUSILIARIO SPECIALIZZATO - A5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12057', 'B0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12057', 'OPERATORE TECNICO - B');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12057', 'B1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12059', 'OPERATORE TECNICO - B1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12057', 'B2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12060', 'OPERATORE TECNICO - B2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12057', 'B3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12061', 'OPERATORE TECNICO - B3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12057', 'B4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12062', 'OPERATORE TECNICO - B4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12057', 'B5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12063', 'OPERATORE TECNICO - B5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12058', 'B0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12058', 'OPERATORE TECNICO ADDETTO ALL''ASSISTENZA - B');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12058', 'B1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12064', 'OPERATORE TECNICO ADDETTO ALL''ASSISTENZA - B1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12058', 'B2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12065', 'OPERATORE TECNICO ADDETTO ALL''ASSISTENZA - B2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12058', 'B3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12066', 'OPERATORE TECNICO ADDETTO ALL''ASSISTENZA - B3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12058', 'B4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12067', 'OPERATORE TECNICO ADDETTO ALL''ASSISTENZA - B4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T12058', 'B5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T12068', 'OPERATORE TECNICO ADDETTO ALL''ASSISTENZA - B5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13059', 'Bs0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13059', 'OPERATORE TECNICO SPECIAL.TO - BS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13059', 'Bs1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13061', 'OPERATORE TECNICO SPECIAL.TO - BS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13059', 'Bs2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13062', 'OPERATORE TECNICO SPECIAL.TO - BS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13059', 'Bs3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13063', 'OPERATORE TECNICO SPECIAL.TO - BS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13059', 'Bs4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13064', 'OPERATORE TECNICO SPECIAL.TO - BS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13059', 'Bs5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13065', 'OPERATORE TECNICO SPECIAL.TO - BS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13660', 'Bs0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13660', 'OPERATORE SOCIO SANITARIO - BS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13660', 'Bs1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13661', 'OPERATORE SOCIO SANITARIO - BS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13660', 'Bs2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13662', 'OPERATORE SOCIO SANITARIO - BS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13660', 'Bs3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13663', 'OPERATORE SOCIO SANITARIO - BS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13660', 'Bs4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13664', 'OPERATORE SOCIO SANITARIO - BS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T13660', 'Bs5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T13665', 'OPERATORE SOCIO SANITARIO - BS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14007', 'C0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14007', 'ASSISTENTE TECNICO - C');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14007', 'C1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14008', 'ASSISTENTE TECNICO - C1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14007', 'C2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14009', 'ASSISTENTE TECNICO - C2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14007', 'C3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14010', 'ASSISTENTE TECNICO - C3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14007', 'C4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14011', 'ASSISTENTE TECNICO - C4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14007', 'C5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14012', 'ASSISTENTE TECNICO - C5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14063', 'C0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14063', 'PROGRAM.RE - C');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14063', 'C1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14064', 'PROGRAM.RE - C1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14063', 'C2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14065', 'PROGRAM.RE - C2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14063', 'C3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14066', 'PROGRAM.RE - C3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14063', 'C4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14067', 'PROGRAM.RE - C4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14063', 'C5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14068', 'PROGRAM.RE - C5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14E59', 'C0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14E59', 'OPERATORE TECNICO SPECIAL.TO ESPERTO - C');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14E59', 'C1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14E60', 'OPERATORE TECNICO SPECIAL.TO ESPERTO - C1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14E59', 'C2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14E61', 'OPERATORE TECNICO SPECIAL.TO ESPERTO - C2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14E59', 'C3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14E62', 'OPERATORE TECNICO SPECIAL.TO ESPERTO - C3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14E59', 'C4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14E63', 'OPERATORE TECNICO SPECIAL.TO ESPERTO - C4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T14E59', 'C5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T14E64', 'OPERATORE TECNICO SPECIAL.TO ESPERTO - C5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16024', 'D0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16024', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE - D');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16024', 'D1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16027', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE - D1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16024', 'D2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16028', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE - D2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16024', 'D3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16029', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE - D3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16024', 'D4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16030', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE - D4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16024', 'D5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16031', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE - D5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16024', 'D6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16032', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE - D6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16026', 'D0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16026', 'COLLAB.RE TEC. - PROF.LE - D');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16026', 'D1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16033', 'COLLAB.RE TEC. - PROF.LE - D1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16026', 'D2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16034', 'COLLAB.RE TEC. - PROF.LE - D2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16026', 'D3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16035', 'COLLAB.RE TEC. - PROF.LE - D3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16026', 'D4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16036', 'COLLAB.RE TEC. - PROF.LE - D4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16026', 'D5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16037', 'COLLAB.RE TEC. - PROF.LE - D5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T16026', 'D6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T16038', 'COLLAB.RE TEC. - PROF.LE - D6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18025', 'Ds0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18025', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE ESPERTO - DS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18025', 'Ds1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18028', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE ESPERTO - DS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18025', 'Ds2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18029', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE ESPERTO - DS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18025', 'Ds3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18030', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE ESPERTO - DS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18025', 'Ds4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18031', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE ESPERTO - DS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18025', 'Ds5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18032', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18025', 'Ds5/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18032', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18025', 'Ds6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18033', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18025', 'Ds6/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18033', 'COLLAB.RE PROF.LE ASSISTENTE SOCIALE ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18027', 'Ds0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18027', 'COLLAB.RE TEC. - PROF.LE ESPERTO - DS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18027', 'Ds1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18034', 'COLLAB.RE TEC. - PROF.LE ESPERTO - DS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18027', 'Ds2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18035', 'COLLAB.RE TEC. - PROF.LE ESPERTO - DS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18027', 'Ds3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18036', 'COLLAB.RE TEC. - PROF.LE ESPERTO - DS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18027', 'Ds4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18037', 'COLLAB.RE TEC. - PROF.LE ESPERTO - DS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18027', 'Ds5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18038', 'COLLAB.RE TEC. - PROF.LE ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18027', 'Ds5/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18038', 'COLLAB.RE TEC. - PROF.LE ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18027', 'Ds6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18039', 'COLLAB.RE TEC. - PROF.LE ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('T18027', 'Ds6/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'T18039', 'COLLAB.RE TEC. - PROF.LE ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A11030', 'A0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A11030', 'COMMESSO - A');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A11030', 'A1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A11031', 'COMMESSO - A1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A11030', 'A2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A11032', 'COMMESSO - A2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A11030', 'A3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A11033', 'COMMESSO - A3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A11030', 'A4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A11034', 'COMMESSO - A4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A11030', 'A5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A11035', 'COMMESSO - A5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A12017', 'B0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A12017', 'COADIUTORE AMM.VO - B');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A12017', 'B1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A12018', 'COADIUTORE AMM.VO - B1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A12017', 'B2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A12019', 'COADIUTORE AMM.VO - B2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A12017', 'B3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A12020', 'COADIUTORE AMM.VO - B3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A12017', 'B4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A12021', 'COADIUTORE AMM.VO - B4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A12017', 'B5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A12022', 'COADIUTORE AMM.VO - B5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A13018', 'Bs0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A13018', 'COADIUTORE AMM.VO ESPERTO - BS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A13018', 'Bs1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A13019', 'COADIUTORE AMM.VO ESPERTO - BS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A13018', 'Bs2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A13020', 'COADIUTORE AMM.VO ESPERTO - BS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A13018', 'Bs3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A13021', 'COADIUTORE AMM.VO ESPERTO - BS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A13018', 'Bs4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A13022', 'COADIUTORE AMM.VO ESPERTO - BS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A13018', 'Bs5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A13023', 'COADIUTORE AMM.VO ESPERTO - BS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A14005', 'C0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A14005', 'ASSISTENTE AMMINISTRATIVO - C');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A14005', 'C1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A14006', 'ASSISTENTE AMMINISTRATIVO - C1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A14005', 'C2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A14007', 'ASSISTENTE AMMINISTRATIVO - C2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A14005', 'C3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A14008', 'ASSISTENTE AMMINISTRATIVO - C3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A14005', 'C4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A14009', 'ASSISTENTE AMMINISTRATIVO - C4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A14005', 'C5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A14010', 'ASSISTENTE AMMINISTRATIVO - C5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A16028', 'D0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A16028', 'COLLABORATORE AMMINISTRATIVO PROF.LE - D');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A16028', 'D1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A16029', 'COLLABORATORE AMMINISTRATIVO PROF.LE - D1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A16028', 'D2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A16030', 'COLLABORATORE AMMINISTRATIVO PROF.LE - D2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A16028', 'D3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A16031', 'COLLABORATORE AMMINISTRATIVO PROF.LE - D3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A16028', 'D4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A16032', 'COLLABORATORE AMMINISTRATIVO PROF.LE - D4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A16028', 'D5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A16033', 'COLLABORATORE AMMINISTRATIVO PROF.LE - D5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A16028', 'D6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A16034', 'COLLABORATORE AMMINISTRATIVO PROF.LE - D6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A18029', 'Ds0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A18029', 'COLLABORATORE AMMINISTRATIVO PROF.LE ESPERTO - DS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A18029', 'Ds1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A18030', 'COLLABORATORE AMMINISTRATIVO PROF.LE ESPERTO - DS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A18029', 'Ds2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A18031', 'COLLABORATORE AMMINISTRATIVO PROF.LE ESPERTO - DS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A18029', 'Ds3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A18032', 'COLLABORATORE AMMINISTRATIVO PROF.LE ESPERTO - DS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A18029', 'Ds4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A18033', 'COLLABORATORE AMMINISTRATIVO PROF.LE ESPERTO - DS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A18029', 'Ds5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A18034', 'COLLABORATORE AMMINISTRATIVO PROF.LE ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A18029', 'Ds5/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A18034', 'COLLABORATORE AMMINISTRATIVO PROF.LE ESPERTO - DS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A18029', 'Ds6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A18035', 'COLLABORATORE AMMINISTRATIVO PROF.LE ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('A18029', 'Ds6/8', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'A18035', 'COLLABORATORE AMMINISTRATIVO PROF.LE ESPERTO - DS6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('P16006', 'D0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'P16006', 'ASSISTENTE RELIGIOSO - D');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('P16006', 'D1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'P16007', 'ASSISTENTE RELIGIOSO - D1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('P16006', 'D2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'P16008', 'ASSISTENTE RELIGIOSO - D2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('P16006', 'D3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'P16009', 'ASSISTENTE RELIGIOSO - D3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('P16006', 'D4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'P16010', 'ASSISTENTE RELIGIOSO - D4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('P16006', 'D5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'P16011', 'ASSISTENTE RELIGIOSO - D5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('P16006', 'D6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'P16012', 'ASSISTENTE RELIGIOSO - D6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13051', 'Bs0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13051', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIABIL. - BS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13051', 'Bs1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13053', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIABIL. - BS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13051', 'Bs2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13054', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIABIL. - BS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13051', 'Bs3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13055', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIABIL. - BS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13051', 'Bs4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13056', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIABIL. - BS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13051', 'Bs5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13057', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIABIL. - BS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13052', 'Bs0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13052', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. BS');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13052', 'Bs1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13058', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. BS1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13052', 'Bs2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13059', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. BS2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13052', 'Bs3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13060', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. BS3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13052', 'Bs4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13061', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. BS4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S13052', 'Bs5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S13062', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. BS5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14056', 'C0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14056', 'OPER.RE PROF.LE SANITARIO PERS. INFERM. - C');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14056', 'C1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14057', 'OPER.RE PROF.LE SANITARIO PERS. INFERM. - C1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14056', 'C2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14058', 'OPER.RE PROF.LE SANITARIO PERS. INFERM. - C2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14056', 'C3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14059', 'OPER.RE PROF.LE SANITARIO PERS. INFERM. - C3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14056', 'C4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14060', 'OPER.RE PROF.LE SANITARIO PERS. INFERM. - C4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14056', 'C5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14061', 'OPER.RE PROF.LE SANITARIO PERS. INFERM. - C5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E51', 'C0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E51', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIAB. ESPERTO- C');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E51', 'C1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E53', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIAB. ESPERTO- C1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E51', 'C2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E54', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIAB. ESPERTO- C2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E51', 'C3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E55', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIAB. ESPERTO- C3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E51', 'C4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E56', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIAB. ESPERTO- C4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E51', 'C5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E57', 'OPER.RE PROF.LE DI II CAT. CON FUNZ. DI RIAB. ESPERTO- C5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E52', 'C0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E52', 'OPER.RE PROF.LE DI II CAT. PERS.INFERM. ESPERTO- C');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E52', 'C1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E58', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. ESPERTO-C1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E52', 'C2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E59', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. ESPERTO-C2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E52', 'C3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E60', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. ESPERTO-C3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E52', 'C4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E61', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. ESPERTO-C4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S14E52', 'C5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S14E62', 'OPER.RE PROF.LE DI II CAT.PERS. INFERM. ESPERTO-C5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16019', 'D0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16019', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. - D');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16019', 'D1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16023', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. - D1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16019', 'D2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16024', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. - D2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16019', 'D3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16025', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. - D3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16019', 'D4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16026', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. - D4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16019', 'D5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16027', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. - D5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16019', 'D6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16028', 'COLL.RE PROF.LE SANITARIO - PERS. DELLA RIABIL. - D6');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16020', 'D0', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16020', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. - D');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16020', 'D1', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16029', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. - D1');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16020', 'D2', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16030', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. - D2');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16020', 'D3', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16031', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. - D3');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16020', 'D4', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16032', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. - D4');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16020', 'D5', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16033', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. - D5');
insert into P675_QUALIFICADMA (cod_qualif_minist, cod_posizione_economica, decorrenza, decorrenza_fine, cod_qualif_dma, descrizione)
values ('S16020', 'D6', to_date('01-01-1900', 'dd-mm-yyyy'), to_date('31-12-3999', 'dd-mm-yyyy'), 'S16034', 'COLL.RE PROF.LE SANITARIO - PERS. INFER. - D6');

-- Aggiunta colonna PROTETTO all'accorpamento voci
alter table P214_TIPOACCORPAMENTOVOCI add protetto varchar2(1) default 'N';
comment on column P214_TIPOACCORPAMENTOVOCI.protetto is 'Bloccata per l''operatore (S/N)';

UPDATE P214_TIPOACCORPAMENTOVOCI t SET T.PROTETTO='S'
WHERE T.COD_TIPOACCORPAMENTOVOCI IN ('CU770','INAPT','DMA','DMAF1','UNIEM','FOPAD');

-- Inizio creazione interrogazione di servizio PA_Flusso_Perseo_Dettaglio
declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO where exists
    (select 'x' from P214_TIPOACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='FOPAD');
  if i > 0 then
    select COUNT(*) into i from t002_querypersonalizzate t where t.nome = 'PA_Flusso_Perseo_Dettaglio';
    if i = 0 then
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', -4, 'CHKINTESTAZIONE(N)CHKNORITORNOACAPO(N)', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', -2, 'Data', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', -1, '"31/01/2013"', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 0, 'SELECT ''D'' TIPO_RECORD, ''CT'' TIPO_OPERAZIONE, ', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 1, '       UPPER(T030.COGNOME) COGNOME, UPPER(T030.NOME) NOME, UPPER(T030.CODFISCALE) COD_FISCALE,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 2, '       T030.SESSO TIPO_SESSO, TO_CHAR(DATANAS,''YYYYMMDD'') DATA_NASCITA, ', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 3, '       TO_CHAR(TRUNC(:DataCedolino,''MM''),''YYYYMMDD'') DATA_INIZIO,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 4, '       TO_CHAR(LAST_DAY(:DataCedolino),''YYYYMMDD'') DATA_FINE,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 5, '-- Subquery per contributo aderente', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 6, '       (SELECT SUM(P442.IMPORTO)', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 7, '        FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 8, '        WHERE P441.PROGRESSIVO=Q.PROGRESSIVO AND P441.DATA_CEDOLINO=:DataCedolino AND P441.CHIUSO=''S''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 9, '        AND P442.ID_CEDOLINO=P441.ID_CEDOLINO AND P442.TIPO_RECORD=''M'' AND P442.COD_CONTRATTO=''EDP''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 10, '        AND P442.COD_VOCE=''11080''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 11, '       ) CONTRIBUTO_ADERENTE,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 12, '-- Subquery per contributo azienda', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 13, '       (SELECT SUM(P442.IMPORTO)', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 14, '        FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 15, '        WHERE P441.PROGRESSIVO=Q.PROGRESSIVO AND P441.DATA_CEDOLINO=:DataCedolino AND P441.CHIUSO=''S''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 16, '        AND P442.ID_CEDOLINO=P441.ID_CEDOLINO AND P442.TIPO_RECORD=''M'' AND P442.COD_CONTRATTO=''EDP''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 17, '        AND P442.COD_VOCE=''11085''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 18, '       ) CONTRIBUTO_AZIENDA,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 19, '       '''' CONTRIBUTO_TFR, '''' CONTRIBUTO_VOLONT,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 20, '-- Subquery per quota iscrizione aderente', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 21, '       (SELECT SUM(P442.IMPORTO)', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 22, '        FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 23, '        WHERE P441.PROGRESSIVO=Q.PROGRESSIVO AND P441.DATA_CEDOLINO=:DataCedolino AND P441.CHIUSO=''S''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 24, '        AND P442.ID_CEDOLINO=P441.ID_CEDOLINO AND P442.TIPO_RECORD=''M'' AND P442.COD_CONTRATTO=''EDP''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 25, '        AND P442.COD_VOCE=''11082''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 26, '       ) QUOTA_ISC_ADERENTE,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 27, '-- Subquery per quota iscrizione azienda', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 28, '       (SELECT SUM(P442.IMPORTO)', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 29, '        FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 30, '        WHERE P441.PROGRESSIVO=Q.PROGRESSIVO AND P441.DATA_CEDOLINO=:DataCedolino AND P441.CHIUSO=''S''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 31, '        AND P442.ID_CEDOLINO=P441.ID_CEDOLINO AND P442.TIPO_RECORD=''M'' AND P442.COD_CONTRATTO=''EDP''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 32, '        AND P442.COD_VOCE=''11087''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 33, '       ) QUOTA_ISC_AZIENDA,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 34, '       '''' QUOTA_ASSOC_ADERENTE, '''' QUOTA_ASSOC_AZIENDA, ', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 35, '       CONTRIBUTO_TOT,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 36, '       ''EUR'' DIVISA, P430.PERC_TOT_DIP_FPC ALIQUOTA_ISCRITTO, P026.PERC_ENTE ALIQUOTA_AZIENDA,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 37, '       '''' ALIQUOTA_TFR, '''' COD_DESTINAZIONE, '''' COD_OPERAZIONE, '''' IMP_IMPONIBILE,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 38, '       DECODE(P430.COD_INPDAPTIPOCESS_FPC, '''', '''',', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 39, '         DECODE(LEAST(P430.DATA_SOSP_CESS_FPC, :DataCedolino), P430.DATA_SOSP_CESS_FPC, TO_CHAR(P430.DATA_SOSP_CESS_FPC,''YYYYMMDD''), '''')) DATA_CESSAZ,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 40, '-- Subquery per motivo cessazione', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 41, '       (SELECT P004.DESCRIZIONE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 42, '        FROM P430_ANAGRAFICO P430, P004_CODICITABANNUALI P004', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 43, '        WHERE P430.PROGRESSIVO=Q.PROGRESSIVO AND :DataCedolino BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 44, '        AND P430.DATA_SOSP_CESS_FPC<=:DataCedolino', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 45, '        AND P004.COD_TABANNUALE=''IPCCESSFPC'' AND P004.COD_CODICITABANNUALI=P430.COD_INPDAPTIPOCESS_FPC', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 46, '        AND P004.ANNO=', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 47, '          (SELECT MAX(P004A.ANNO) FROM P004_CODICITABANNUALI P004A', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 48, '           WHERE P004A.COD_TABANNUALE=P004.COD_TABANNUALE AND P004A.COD_CODICITABANNUALI=P004.COD_CODICITABANNUALI', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 49, '           AND P004A.ANNO<=TO_CHAR(:DataCedolino,''YYYY''))', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 50, '       ) MOTIVO_CESSAZ', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 51, '-- Corpo principale per calcolo totale contribuzioni al Fondo Previdenza Complementare', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 52, 'FROM T030_ANAGRAFICO T030, P430_ANAGRAFICO P430, P026_FONDIPREVCOMPL P026,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 53, '  (', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 54, '  SELECT P441.PROGRESSIVO, SUM(P442.IMPORTO) CONTRIBUTO_TOT', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 55, '  FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 56, '  WHERE P441.DATA_CEDOLINO=:DataCedolino AND P441.CHIUSO=''S''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 57, '  AND P442.ID_CEDOLINO=P441.ID_CEDOLINO AND P442.TIPO_RECORD=''M'' AND P442.COD_CONTRATTO=''EDP''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 58, '  AND P442.COD_VOCE IN (''11080'',''11082'',''11085'',''11087'')', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 59, '  GROUP BY P441.PROGRESSIVO', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 60, '  ) Q', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 61, 'WHERE T030.PROGRESSIVO=Q.PROGRESSIVO', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 62, 'AND P430.PROGRESSIVO=T030.PROGRESSIVO AND :DataCedolino BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 63, 'AND P430.COD_FPC=P026.COD_FPC(+)', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 64, 'AND :DataCedolino BETWEEN P026.DECORRENZA(+) AND P026.DECORRENZA_FINE(+) ', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 65, null, 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
      values ('PA_Flusso_Perseo_Dettaglio', 66, 'ORDER BY T030.COGNOME, T030.NOME, T030.CODFISCALE', 'PAGHE');
    end if;
  end if;
end;
/
-- Fine creazione interrogazione di servizio PA_Flusso_Perseo_Dettaglio

-- Inizio creazione stampa Perseo.Det
declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO where exists
    (select 'x' from P214_TIPOACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='FOPAD');
  if i > 0 then
    select COUNT(*) into i from t910_riepilogo t where t.codice = 'Perseo.Det';
    if i = 0 then
      INSERT INTO T910_RIEPILOGO
      (CODICE,TITOLO,APPLICAZIONE,TIPO,SEPARAH,SEPARAV,FONTNAME,FONTSIZE,SALTOPAGINA,TOTALI,TOTPARZIALI,TOTGENERALI,CONTEGGIGIORNALIERI,FILTROESCLUSIVO,VALORENULLO,IMPOSTAZIONI,STAMPA_TITOLO,STAMPA_AZIENDA,STAMPA_PERIODO,STAMPA_NUMPAG,STAMPA_DATA,FORMATO_PAGINA,ORIENTAMENTO_PAGINA,TABELLA_GENERATA,TOTRIEPILOGO,CDC_PERCENTUALIZZATI,INTESTAZIONE_COLONNE,FILTRO_INSERVIZIO,SALTOPAGINA_TOTALI,TABELLA_GENERATA_DROP,TABELLA_GENERATA_KEY,TABELLA_GENERATA_DELETE,STAMPA_BLOCCATA,DATA_ACCESSO,UTENTE_ACCESSO,QUERY_INTESTAZIONE,QUERY_FINESTAMPA)
      VALUES
      ('Perseo.Det','Fondo di previdenza complementare Perseo','PAGHE','C','N','N','Courier New',8,'N','S','S','S','N','S','S','TIPO_VOCE=0,CEDOLINI_CHIUSI=N,TIPO_DATIMENSILI=0,ACCORPAMENTO_VOCI=FOPAD,VOCI_CUMULO_STAMPA=S,PARCHEGGIO_VOCI=,CONTRATTO_VOCI=EDP,CONVERTI_VALUTA=','S','S','S','S','S','','O','','N','N','N','T','N','S','','','N',TO_DATE('28/02/2013 13.48.12','DD/MM/YYYY HH24.MI.SS'),'DARIO','','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','AV_COLONNA_01','Imponibile','D','S',0,588,110,16,'M=S,D=2,0=N','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','AV_COLONNA_02','Quota dip.','D','S',0,700,75,16,'M=S,D=2,0=N','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','AV_COLONNA_03','Quota ente','D','S',0,780,75,16,'M=S,D=2,0=N','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','AV_COLONNA_04','Iscriz.dip.','D','S',0,860,80,16,'M=S,D=2,0=N','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','AV_COLONNA_05','Iscriz.ente','D','S',0,948,80,16,'M=S,D=2,0=N','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','CODFISCALE','Cod.Fiscale','D','S',0,48,80,16,'','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','COGNOME','Cognome','D','S',0,136,120,16,'','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','CVX_AL','DATA_AL','D','N',0,1196,80,16,'','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','DATANAS','Data nasc.','D','S',0,380,75,16,'','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','MATRICOLA','Matr.','D','S',0,4,40,16,'','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','NOME','Nome','D','S',0,264,110,16,'','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','SESSO','Sesso','D','S',0,460,40,16,'','N','N','N','');
      INSERT INTO T911_DATIRIEPILOGO (CODICE,NOME,CAPTION,BANDA,TOTALE,POST,POSL,LUNG,ALT,FORMATO,CONTATORE,CDC_PERCENTUALIZZATI,CONV_VALUTA,RIPETUTO) VALUES
      ('Perseo.Det','T430FINE','Data cess.','D','S',0,508,75,16,'','N','N','N','');
      INSERT INTO T912_SORTRIEPILOGO (CODICE,POS,NOME,TIPO,ROTTKEY) VALUES
      ('Perseo.Det',0,'COGNOME','C','N');
      INSERT INTO T912_SORTRIEPILOGO (CODICE,POS,NOME,TIPO,ROTTKEY) VALUES
      ('Perseo.Det',1,'NOME','C','N');
      INSERT INTO T912_SORTRIEPILOGO (CODICE,POS,NOME,TIPO,ROTTKEY) VALUES
      ('Perseo.Det',2,'CODFISCALE','C','N');
      INSERT INTO T912_SORTRIEPILOGO (CODICE,POS,NOME,TIPO,ROTTKEY) VALUES
      ('Perseo.Det',3,'MATRICOLA','C','S');
      INSERT INTO T913_SERBATOIKEY (CODICE,ID_SERBATOIO,POS,DATO,TOTALE) VALUES
      ('Perseo.Det',5,'0','CV_DATA_CEDOLINO','N');
      INSERT INTO T914_SERBATOIFILTRO (CODICE,ID_SERBATOIO,ESCLUSIVO,FILTRO, DATO_DALAL) VALUES
      ('Perseo.Det',5,'N','AV_COLONNA_01 <> 0 OR AV_COLONNA_02 <> 0 OR AV_COLONNA_03 <> 0 OR AV_COLONNA_04 <> 0 OR AV_COLONNA_05 <> 0','');
      DELETE FROM T909_DATICALCOLATI WHERE APPLICAZIONE = 'PAGHE' AND NOME = 'CVX_AL';
      INSERT INTO T909_DATICALCOLATI (APPLICAZIONE,NOME,ID_SERBATOIO,TIPO,ESPRESSIONE,CODICE_STAMPA) VALUES
      ('PAGHE','CVX_AL',5,'3',':AL','');
    end if;
  end if;
end;
/
-- Fine creazione stampa Perseo.Det

