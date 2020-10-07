create or replace function RITARDO_ANTICIPO(Timbratureeffettive in varchar2, data_conteggio in date, modello_orario in varchar2) return integer is
cursor c1 is
    select *
    from T021_FASCEORARI t021
    where CODICE = modello_orario and
          tipo_fascia = 'PN' AND
          DECORRENZA = (SELECT MAX(DECORRENZA) FROM T021_FASCEORARI where codice = t021.codice and decorrenza <= data_conteggio);
vis integer;
i integer;
pnE integer;
pnU integer;
e integer;
u integer;
varE integer;
varU integer;
 
begin
  vis:=0;
  varE:=0;
  varU:=1500;
  i:=1;
  e:=2;
  u:=8;
  for t1 in c1 loop
    pnE := oreminuti(getdatoorario(modello_orario,SYSDATE,'PN',i,'ENTRATA'));
    pnU := oreminuti(getdatoorario(modello_orario,SYSDATE,'PN',i,'USCITA'));
    --Scorre le Entrate della prima fascia
  while e < length(Timbratureeffettive) loop
    if OREMINUTI(SUBSTR(Timbratureeffettive,e,2) || '.' || SUBSTR(Timbratureeffettive,e+2,2)) between pne and pnu
       and varE=0
    then
      varE:=OREMINUTI(SUBSTR(Timbratureeffettive,e,2) || '.' || SUBSTR(Timbratureeffettive,e+2,2));
    elsif OREMINUTI(SUBSTR(Timbratureeffettive,e+6,2) || '.' || SUBSTR(Timbratureeffettive,e+9,2)) between pne and pnu
          and varE=0 then
      varE:=OREMINUTI(SUBSTR(Timbratureeffettive,e,2) || '.' || SUBSTR(Timbratureeffettive,e+2,2));
    end if;
    e:=e+12;
  end loop;
  --Scorre le uscite della prima fascia
  while u < length(Timbratureeffettive) loop
    if OREMINUTI(SUBSTR(Timbratureeffettive,u,2) || '.' || SUBSTR(Timbratureeffettive,u+2,2)) between pne and pnu
    then
      varU:=OREMINUTI(SUBSTR(Timbratureeffettive,u,2) || '.' || SUBSTR(Timbratureeffettive,u+2,2));
    elsif OREMINUTI(SUBSTR(Timbratureeffettive,u-6,2) || '.' || SUBSTR(Timbratureeffettive,u-3,2)) between pne and pnu then
        varU:=OREMINUTI(SUBSTR(Timbratureeffettive,u,2) || '.' || SUBSTR(Timbratureeffettive,u+2,2));
    end if;
    u:=u+12;
  end loop;
  if varE - NVL(oreminuti(getdatoorario(modello_orario,SYSDATE,'PN',i,'MMFLEX')),0) > pne or varU < pnu then
    vis:=1;
    return(vis);
  end if;
  i:=i+1;
  e:=2;
  u:=8;
  varE:=0;
  varU:=1500;
  end loop;   
  return(Null);
end RITARDO_ANTICIPO;
/
