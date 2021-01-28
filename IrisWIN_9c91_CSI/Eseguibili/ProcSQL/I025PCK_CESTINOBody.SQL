create or replace package body I025PCK_CESTINO is
  type TCURSORE is REF CURSOR;
  ValoreNew varchar2(2000);

  function GetID return varchar2 is
  begin
    return ValoreNew;
  end;

  function GetCampoChiave(Tabella varchar2) return varchar2 is
    Campo varchar2(40);
  begin
    if Tabella in ('T910_RIEPILOGO','T911_DATIRIEPILOGO','T912_SORTRIEPILOGO','T913_SERBATOIKEY',
                   'T914_SERBATOIFILTRO','T915_CODICISELEZIONATI') then
      Campo:='CODICE';
    elsif Tabella = 'T002_QUERYPERSONALIZZATE' then
      Campo:='NOME';
    elsif Tabella = 'T275_CAUPRESENZE' then
      Campo:='CODICE';
    end if;
    return Campo;
  end;

  function CheckValore(Tabella varchar2, Valore varchar2) return varchar2 is
    Ret varchar2(1);
  begin
    execute immediate'select decode(count(*),0,''N'',''S'') from '||Tabella||' T where T.'||GetCampoChiave(Tabella)||' = :cod' into Ret using Valore;
    Return Ret;
  end;

  function GeneraCodice(Tabella varchar2) return varchar2 is
    DimCampo integer;
    CKey integer;
    Campo varchar2(40);
    Codice varchar2(2000);
    c TCURSORE;
  begin
    Campo:=GetCampoChiave(Tabella);
    begin
      select VC.DATA_LENGTH into DimCampo
        from COLS VC
       where VC.TABLE_NAME = Tabella
         and VC.COLUMN_NAME = Campo;
    exception
    when NO_DATA_FOUND then
      return('');
    end;

    Codice:='';
    CKey:=0;
    loop
      Codice:='@'||dbms_random.string('P',DimCampo - 2)||chr(39);
      open c for 'select T1.'||Campo||' as ID from '||Tabella||' T1 where T1.'||Campo||' = :cod'||
                 ' union '||
                 'select I025.ID from I025_CESTINO I025 where I025.ID = :cod and I025.TABELLA = :tab' USING codice, codice, Tabella;
      CKey:=CKey + 1;
      fetch c into codice;
      exit when c%notfound or (CKey >= 20);
    end loop;
	if CKey >= 20 then
	  RAISE_APPLICATION_ERROR(-20001, 'Impossibile cancellare, spazio su tabella I025_CESTINO in esaurimento.');
    end if;
    return(Codice);
  end;

  procedure ModificaRapida(Tabella varchar2, ValoreOld varchar2) is
  begin
    execute immediate 'update '||Tabella||' T set T.'||GetCampoChiave(Tabella)||' = :ValoreNew where T.'||GetCampoChiave(Tabella)||' = :ValoreOld' using ValoreNew, ValoreOld;
  end;

  procedure CancRapida(Tabella varchar2, Valore varchar2) is
  begin
    execute immediate 'delete from  '||Tabella||' T where T.'||GetCampoChiave(Tabella)||' = :Valore' using Valore;
  end;

  function CancLogica(Tabella varchar2, ValoreOld varchar2, Operatore varchar2) return varchar2 is
    Esito varchar2(2000);
    Chiave varchar2(40);
    NumRec number(8);
  begin
    Esito:='';
    Chiave:=GetCampoChiave(Tabella);
    begin
      --Operazioni generiche
      --Genero codice univoco(ValoreNew)
      ValoreNew:=GeneraCodice(Tabella);
      --Verifico che il codice da cancellare(ValoreOld) esista, altrimenti non eseguo l'operazione
      execute immediate'select count(*) from '||Tabella||' T where T.'||Chiave||' = :cod' into NumRec using ValoreOld;
      if NumRec > 0 then
        ModificaRapida(Tabella,ValoreOld);
        --Operazioni dedicate
        if Tabella = 'T910_RIEPILOGO' then
          ModificaRapida('T911_DATIRIEPILOGO',ValoreOld);
          ModificaRapida('T912_SORTRIEPILOGO',ValoreOld);
          ModificaRapida('T912_SORTRIEPILOGO',ValoreOld);
          ModificaRapida('T913_SERBATOIKEY',ValoreOld);
          ModificaRapida('T914_SERBATOIFILTRO',ValoreOld);
          ModificaRapida('T915_CODICISELEZIONATI',ValoreOld);
        end if;
        insert into I025_CESTINO I025(TABELLA,CHIAVE,ID,UTENTE,DATA) values(Tabella,ValoreOld,ValoreNew,Operatore,sysdate);
        commit;
      else
        Esito:='Codice '||ValoreOld||' da eliminare non trovato.';
      end if;
    exception
      when others then
        rollback;
        Esito:=SQLERRM;
    end;
    return Esito;
  end;

  function Ripristino(IDRipristino varchar2, Tabella varchar2, MyValore varchar2) return varchar2 is
    Esito varchar2(2000);
    Chiave varchar2(40);
    NumRec number(8);
  begin
    Esito:='';
    begin
      if MyValore is null then
        select I025.CHIAVE into ValoreNew
          from I025_CESTINO I025
         where I025.ID = IDRipristino;
      else
         ValoreNew:=MyValore;
      end if;

      Chiave:=GetCampoChiave(Tabella);
      execute immediate 'select count(*) from '||Tabella||' T where T.'||Chiave||' = :cod' into NumRec using ValoreNew;
      if NumRec = 0 then
        ModificaRapida(Tabella,IDRipristino);
        if Tabella = 'T910_RIEPILOGO' then
          ModificaRapida('T911_DATIRIEPILOGO',IDRipristino);
          ModificaRapida('T912_SORTRIEPILOGO',IDRipristino);
          ModificaRapida('T912_SORTRIEPILOGO',IDRipristino);
          ModificaRapida('T913_SERBATOIKEY',IDRipristino);
          ModificaRapida('T914_SERBATOIFILTRO',IDRipristino);
          ModificaRapida('T915_CODICISELEZIONATI',IDRipristino);
        end if;
        delete from I025_CESTINO I025 where I025.ID = IDRipristino and I025.TABELLA = Tabella;
        commit;
      else
         Esito:='Codice "'||ValoreNew||'" già presente.';
      end if;
    exception
      when others then
        rollback;
        Esito:=SQLERRM;
    end;
    return Esito;
  end;

  function CancFisica(IDRipristino varchar2, Tabella varchar2) return varchar2 is
    Esito varchar2(2000);
  begin
    Esito:='';
    begin
      CancRapida(Tabella,IDRipristino);
      if Tabella = 'T910_RIEPILOGO' then
        CancRapida('T911_DATIRIEPILOGO',IDRipristino);
        CancRapida('T912_SORTRIEPILOGO',IDRipristino);
        CancRapida('T912_SORTRIEPILOGO',IDRipristino);
        CancRapida('T913_SERBATOIKEY',IDRipristino);
        CancRapida('T914_SERBATOIFILTRO',IDRipristino);
        CancRapida('T915_CODICISELEZIONATI',IDRipristino);
      end if;
      delete from I025_CESTINO I025 where I025.ID = IDRipristino and I025.TABELLA = Tabella;
      commit;
    exception
      when others then
        rollback;
        Esito:=SQLERRM;
    end;
    return Esito;
  end;

begin
  -- Initialization
  null;
end I025PCK_CESTINO;
/
