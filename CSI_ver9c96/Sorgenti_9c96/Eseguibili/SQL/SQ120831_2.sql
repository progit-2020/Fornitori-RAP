insert into p206_assenzeinpdap
select cod_contratto, cod_voce, cod_voce_speciale, to_date('01022013','ddmmyyyy'), 'S', abbatte_ggutili, '', cod_gestassic_noncoperte, cod_causasospensione, perc_asp_sindacale, perc_retribuzione, note, decorrenza_fine
from p206_assenzeinpdap t where t.cod_contratto='EDP' and t.cod_voce='15060'
and t.cod_voce_speciale='BASE' and t.decorrenza=to_date('01102012','ddmmyyyy')
and not exists
(select 'x' from p206_assenzeinpdap v where v.cod_contratto=t.cod_contratto and v.cod_voce=t.cod_voce
and v.cod_voce_speciale=t.cod_voce_speciale and v.decorrenza=to_date('01022013','ddmmyyyy'));

update p206_assenzeinpdap t set t.decorrenza_fine=to_date('01022013','ddmmyyyy')-1
where t.cod_contratto='EDP' and t.cod_voce='15060'
and t.cod_voce_speciale='BASE' and t.decorrenza=to_date('01102012','ddmmyyyy');

update p206_assenzeinpdap t set t.cod_causasospensione='38'
where t.cod_contratto='EDP' and t.cod_voce='15060'
and t.cod_voce_speciale='BASE' and t.decorrenza=to_date('01022013','ddmmyyyy');

declare
  i integer;
begin
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      update i501incarico t
      set t.descrizione=replace(t.descrizione,'dec. 2010-2012','dec. 2010-2014')
      where t.descrizione like '%dec. 2010-2012%';

      update p252_vociaggiuntiveimporti t
      set t.descrizione=replace(t.descrizione,'dec. 2010-2012','dec. 2010-2014')
      where t.cod_contratto='EDP' and t.nome_voceaggiuntiva='INCARICO'
      and t.descrizione like '%dec. 2010-2012%';

    end if;
end;
/


