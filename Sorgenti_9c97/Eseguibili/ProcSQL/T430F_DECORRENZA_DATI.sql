create or replace function T430F_DECORRENZA_DATI(P_PROGRESSIVO in integer, P_DATA in date, P_DATI in varchar2, P_LIMITE_INIZIO in varchar2 := 'S', P_SCADENZA in varchar2 := 'N') return date as
/*resituisce la minima decorrenza per il gruppo di dati specificato in P_DATI, a partire dalla data P_DATA
  P_PROGRESSIVO_ progressivo dell'anagrafico
  P_DATA: data a cui leggere i dati da T430_STORICO
  P_DATI: elenco dei dati della T430_STORICO da leggere a P_DATA. Per es: DIPARTIMENTO,REPARTO,PRESIDIO
  P_LIMITE_INIZIO: S=la decorrenza letta in T430.DECORRENZA viene limitata alla data di assunzione T430.INIZIO; N=la decorrenza è quella letta da T430.DECORRENZA
*/
  result date;
  wNvl varchar2(100) := '''(nullo)''';
  wColDataDecorrenza varchar2(100);
  wColDataScadenza   varchar2(100);
  wInizio date;
  wFine   date;
  wDatiStat varchar2(4000);
  wDatiName varchar2(4000);
  wDatiValue varchar2(32767);

  wCursore PCK_CONST.REF_CURSOR;
  fDataDecorrenza date;
  fDataScadenza date;

  procedure dyn_sel (
          P_PROGRESSIVO in integer,
          P_DATA in date,
          field_name in varchar2,
          val        in varchar2,
          crs        in out PCK_CONST.REF_CURSOR)
  is
    stmt varchar2(4000);
  begin
    stmt:=
    'select '||wColDataDecorrenza||','||wColDataScadenza;
    if P_SCADENZA = 'N' then
      stmt:=stmt||' from T430_STORICO where PROGRESSIVO = :PROGRESSIVO and DATADECORRENZA < :DATA';
    else  
      stmt:=stmt||' from T430_STORICO where PROGRESSIVO = :PROGRESSIVO and DATADECORRENZA > :DATA';
    end if;  
    stmt:=stmt||  
    ' and '||field_name||' = '''||val||''''||
    ' order by DATADECORRENZA';
    if P_SCADENZA = 'N' then
      stmt:=stmt||' desc';
    end if;
     --dbms_output.put_line(stmt);

    open crs for stmt using P_PROGRESSIVO,P_DATA;
  end dyn_sel;

begin
  if P_SCADENZA = 'S' then
    result:=PCK_CONST.DATA_INF;
  else  
    result:=to_date('01011900','ddmmyyyy');
  end if;  

  if P_LIMITE_INIZIO = 'S' then
    wColDataDecorrenza:='greatest(DATADECORRENZA,nvl(INIZIO,DATADECORRENZA))';
    wColDataScadenza:='least(DATAFINE,nvl(FINE,DATAFINE))';
    begin
      select INIZIO,FINE
      into wInizio,wFine
      from T430_STORICO
      where PROGRESSIVO = P_PROGRESSIVO
      and P_DATA between DATADECORRENZA and DATAFINE;
    exception
      when no_data_found then null;
    end;
  else
    wColDataDecorrenza:='DATADECORRENZA';
    wColDataScadenza:='DATAFINE';
    wInizio:=null;
    wFine:=null;
  end if;

  wDatiName:=replace(P_DATI, ',', ','||wNvl||')'||'||nvl(');
  wDatiName:='nvl('||wDatiName||','||wNvl||')';
  --dbms_output.put_line(wDatiName);

  if P_SCADENZA = 'S' then
    wDatiStat:='select '||wColDataScadenza;
  else
    wDatiStat:='select '||wColDataDecorrenza;
  end if;
  wDatiStat:=wDatiStat||','||wDatiName||' from T430_STORICO where PROGRESSIVO = :PROGRESSIVO and :DATA between DATADECORRENZA and DATAFINE';
  --dbms_output.put_line(wDatiStat);
  begin
    execute immediate wDatiStat into result,wDatiValue using in P_PROGRESSIVO,in P_DATA;
  exception
    when no_data_found then
      result:=null;
  end;

  dyn_sel(P_PROGRESSIVO,result,wDatiName,wDatiValue,wCursore);
  loop
    fetch wCursore into fDataDecorrenza,fDataScadenza;
    exit when wCursore%notfound;
    if P_SCADENZA = 'S' then
      if fDataDecorrenza = result + 1 then
        result:=fDataScadenza;
      else
        exit;
      end if;
    else  
      if fDataScadenza = result - 1 then
        result:=fDataDecorrenza;
      else
        exit;
      end if;
    end if;  
  end loop;

  if P_SCADENZA = 'S' then
    return least(result,nvl(wFine,result));
  else  
    return greatest(result,nvl(wInizio,result));
  end if;  
end;
/