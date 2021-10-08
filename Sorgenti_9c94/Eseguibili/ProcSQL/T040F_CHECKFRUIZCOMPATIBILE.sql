create or replace function T040F_CHECKFRUIZCOMPATIBILE
  (P_TABELLA in varchar2, P_PROGRESSIVO in integer, P_DATA in date, P_CAUSALE in varchar2, P_TIPOGIUST in varchar2, P_DAORE in varchar2, P_AORE in varchar2, P_FAMILIARE in date)
  /*
   P_TABELLA = T040 / T050
  */
return varchar2 as

  cursor c1 is
    select T040.CAUSALE,T040.TIPOGIUST
    from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265
    where T040.PROGRESSIVO = P_PROGRESSIVO
    and T040.DATA = P_DATA
    and T040.CAUSALE <> P_CAUSALE
    and T040.CAUSALE = T265.CODICE
    union
    select VT050.CAUSALE,VT050.TIPOGIUST
    from VT050_RICHIESTE_SENZAREVOCA VT050, T265_CAUASSENZE T265
    where VT050.PROGRESSIVO = P_PROGRESSIVO
    and P_DATA between VT050.DAL and VT050.AL
    and nvl(VT050.STATO,'S') <> 'N'    --non negato
    and nvl(VT050.ELABORATO,'N') = 'N' --non elaborato
    and VT050.CAUSALE <> P_CAUSALE
    and VT050.CAUSALE = T265.CODICE;

  result    varchar2(2000);
  result_cm varchar2(2000);

begin
  result:=null;

  for t1 in c1 loop
    if T230F_CHECKCAUSCOMPATIBILI(P_DATA,P_CAUSALE,t1.CAUSALE) = 'N' then
      if result is not null then
        result:=result||',';
      end if;
      result:=result||t1.CAUSALE;
    end if;
  end loop;

  begin
    result_cm:=T040F_CHECKFRUIZCOMPATIB_CM(P_TABELLA,P_PROGRESSIVO,P_DATA,P_CAUSALE,P_TIPOGIUST,P_DAORE,P_AORE,P_FAMILIARE);
    if result_cm is not null then
      if result is not null then
        result:=result||',';
      end if;
      result:=result||result_cm;
    end if;
  exception
    when others then null;
  end;

  return result;
end;
/
