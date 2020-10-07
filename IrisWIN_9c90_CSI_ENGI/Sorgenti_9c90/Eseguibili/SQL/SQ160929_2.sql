insert into mondoedp.i091_datiente (AZIENDA,TIPO,DATO)
select AZIENDA,'C32_GESTMENSILE',decode(CODICE_INTEGRAZIONE,'TO','S','N') from mondoedp.i090_enti;
