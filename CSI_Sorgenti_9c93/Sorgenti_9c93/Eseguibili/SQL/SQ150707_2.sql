alter table CSI010_FESTIVITA_PARTICOLARI add SCELTA_DEFINITIVA varchar2(1);
comment on column CSI010_FESTIVITA_PARTICOLARI.scelta_definitiva
  is 'Scelta derivante dall''applicazione dei comportamenti predefiniti o selezionati dal dipendente';
  
alter table T065_RICHIESTESTRAORDINARI add MESE_RIFERIMENTO date;
comment on column T065_RICHIESTESTRAORDINARI.MESE_RIFERIMENTO is 'Mese in cui si deve verificare la compatibilità tra destinazione e saldo banca ore';

alter table T070_SCHEDARIEPIL add SALDO_COMPLESSIVO varchar2(8);
comment on column T070_SCHEDARIEPIL.SALDO_COMPLESSIVO is 'Saldo orario complessivo da inizio anno';
