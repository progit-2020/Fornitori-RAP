create or replace function I060F_EMAIL(pAZIENDA IN VARCHAR2, pPROGRESSIVO IN NUMBER) return varchar2 is
  cursor ci060 is
    select email
    from mondoedp.i060_login_dipendente
    where azienda = pAZIENDA
    and matricola = (select matricola from t030_anagrafico where progressivo = pPROGRESSIVO)
    order by nome_utente;
  EMail1 varchar2(200) :='';
  EMail2 varchar2(200) :='';
  result varchar2(200) :='';
begin
  result:='';
  for ri060 in ci060 loop --potrebbero esserci più account per la stessa matricola
    EMail1:=Trim(ri060.email) || ';';
    while Instr(EMail1,';') > 0 loop --potrebbero esserci più email per lo stesso account
      EMail2:=Trim(Substr(EMail1,1,Instr(EMail1,';') - 1));
      if (NVL(EMail2,'#NULL#') <> '#NULL#')
      and (Instr(';' || Result,';' || EMail2 || ';') = 0) then
        Result:=Result || EMail2 || ';';
      end if;
      EMail1:=Substr(EMail1,Instr(EMail1,';') + 1);
    end loop;
  end loop;
  Result:=Replace(Substr(Result,1,Length(Result) - 1),';','; ');
  return(result);
end;
/
