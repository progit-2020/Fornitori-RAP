alter table T670_REGOLEBUONI add ORARI_INIBITI varchar2(2000);
comment on column T670_REGOLEBUONI.ORARI_INIBITI is 'Orari che inibiscono la maturazione e l''acquisto nei giorni in cui l''orario è in uso';

