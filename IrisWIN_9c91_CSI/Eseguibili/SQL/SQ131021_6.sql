-- Tolto il valore di default dal campo valore dei dati mensili
alter table P450_DATIMENSILI modify valore default null;

-- Previsto nuovo dato mensile
INSERT INTO P452_DATIMENSILIDESC
SELECT 'BORCF', 'Bonus riduzione cuneo fiscale anno 2014', 'T', 0, 'N,NOCONG', 'A' FROM DUAL
WHERE NOT EXISTS 
  (SELECT 'X' FROM P452_DATIMENSILIDESC T WHERE T.COD_CAMPO='BORCF');

UPDATE P200_VOCI t SET T.STAMPA_CEDOLINO='D'
where t.cod_voce='13162' and t.cod_voce_speciale='CONG';

-- Previsto nuovo dato su cedolini RP
alter table P268_RAPPORTIPRECEDENTI add BONUS_RID_CUNEO_FISC number default 0 not null;
comment on column P268_RAPPORTIPRECEDENTI.BONUS_RID_CUNEO_FISC is 'Bonus riduzione cuneo fiscale';

-- Inserimento anni mancanti sulla tabella di base per codice ISFORASSIC
declare
  i integer;
  j integer;

begin

i:=2001;

while i <= 2014 loop 

  select COUNT(*) into j from p004_codicitabannuali t
  where t.cod_tabannuale='ISFORASSIC' and t.anno>= i;

  if j = 0 then
    insert into p004_codicitabannuali
    select cod_tabannuale, cod_codicitabannuali, i, descrizione from p004_codicitabannuali T
    where t.cod_tabannuale='ISFORASSIC'
    and t.anno=
      (select max(anno) from p004_codicitabannuali where cod_tabannuale='ISFORASSIC');
  end if;

  i:=i + 1;
end loop;

end;
/
