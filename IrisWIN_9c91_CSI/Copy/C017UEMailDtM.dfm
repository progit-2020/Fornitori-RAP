object C017FEMailDtM: TC017FEMailDtM
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 137
  Width = 412
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 43
    Top = 76
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CharSet = 'ISO-8859-15'
    CCList = <>
    ContentType = 'text/plain'
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 119
    Top = 76
  end
  object scrEMailResponsabile: TOracleQuery
    SQL.Strings = (
      'declare '
      '  -- cursore per reperire gli indirizzi email dei responsabili'
      '  -- i responsabili sono cos'#236' individuati:'
      '  --   utenti con filtro anagrafe impostato, '
      '  --   indirizzo email impostato,'
      '  --   tag abilitato nel filtro permessi,'
      
        '  --   accesso abilitato ad uno dei livelli dell'#39'iter + cod_iter' +
        ' indicato'
      ''
      '  cursor c1(p_azienda varchar2) is '
      
        '    select distinct i060.email,i060.nome_utente,i061.nome_profil' +
        'o,i061.delegato_da,i061.filtro_anagrafe'
      '    from   mondoedp.i060_login_dipendente i060, '
      '           mondoedp.i061_profili_dipendente i061,'
      '           mondoedp.i073_filtrofunzioni i073,'
      '           mondoedp.i075_iter_autorizzativi i075'
      '    where  i060.azienda = :AZIENDA'
      '    and    i060.email is not null'
      '    and    i061.azienda = i060.azienda '
      '    and    i061.nome_utente = i060.nome_utente '
      
        '    and    trunc(sysdate) between i061.inizio_validita and nvl(i' +
        '061.fine_validita,sysdate + 1) '
      '    and    i061.ricezione_mail = '#39'S'#39
      '    and    i061.filtro_anagrafe is not null '
      '    and    i073.azienda = i060.azienda '
      '    and    i073.profilo = i061.filtro_funzioni '
      '    and    i073.applicazione = '#39'RILPRE'#39' '
      
        '    and    i073.tag = nvl(:tag,100)                             ' +
        '    -- 100 '#232' un tag sicuramente esistente'
      
        '    and    i073.inibizione = decode(:tag,NULL,i073.inibizione,'#39'S' +
        #39')  -- inibizione non pu'#242' valere null'
      '    and    i075.azienda = i061.azienda'
      '    and    i075.profilo = i061.iter_autorizzativi'
      '    and    i075.iter = :iter'
      '    and    i075.cod_iter = :cod_iter'
      '    and    i075.livello in (:elenco_livelli)'
      '    and    i075.accesso = '#39'F'#39';'
      ''
      '  -- cursore per costruire il filtro anagrafe dell'#39'utente'
      
        '  cursor c2(p_azienda varchar2, p_utente varchar2, p_profilo var' +
        'char2) is'
      '    select progressivo,'
      
        '           replace(replace(replace(replace(filtro,'#39':nome_utente'#39 +
        ','#39#39#39#39'|| p_utente ||'#39#39#39#39'),'#39':NOME_UTENTE'#39','#39#39#39#39'|| p_utente||'#39#39#39#39'),'#39 +
        ':datalavoro'#39','#39'to_date('#39#39#39' || to_char(sysdate,'#39'dd/mm/yyyy'#39') || '#39#39 +
        #39','#39#39'dd/mm/yyyy'#39#39')'#39'),'#39':DATALAVORO'#39','#39'to_date('#39#39#39' || to_char(sysdat' +
        'e,'#39'dd/mm/yyyy'#39') || '#39#39#39','#39#39'dd/mm/yyyy'#39#39')'#39') filtro'
      '    from   mondoedp.i072_filtroanagrafe '
      '    where  azienda = p_azienda '
      '    and    profilo = p_profilo'
      '    order by progressivo;'
      ''
      
        '  espr_norm    varchar2(300);  -- query sql normale per test fil' +
        'tro anagrafe'
      
        '  espr_fast    varchar2(300);  -- query sql veloce per test filt' +
        'ro anagrafe (esclude v430_storico)'
      
        '  espressione  varchar2(4000); -- query sql principale per test ' +
        'filtro anagrafe'
      '  filtro       varchar2(4000); -- filtro anagrafe'
      '  p_email      varchar2(4000); -- elenco indirizzi email'
      
        '  p_filtroagg  varchar2(4000); -- stringa per update data invio ' +
        'mail'
      '  x            varchar2(1);'
      '  TYPE cur_typ IS REF CURSOR;'
      '  c cur_typ;'
      'begin'
      '  p_email:=null;'
      '  p_filtroagg:=null;'
      
        '  espr_norm:='#39'select '#39'||:hintT030V430||'#39' '#39#39'X'#39#39' from T030_ANAGRAF' +
        'ICO T030, V430_STORICO V430 '#39' ||'
      '             '#39'where T030.PROGRESSIVO = :PROGRESSIVO '#39' ||'
      '             '#39'and   T030.PROGRESSIVO = T430PROGRESSIVO '#39' ||'
      
        '             '#39'and   trunc(sysdate) between T430DATADECORRENZA an' +
        'd T430DATAFINE '#39' ||'
      
        '             '#39'and   trunc(sysdate) between T430INIZIO and nvl(T4' +
        '30FINE,sysdate + 1)'#39';'
      
        '  espr_fast:='#39'select '#39#39'X'#39#39' from T030_ANAGRAFICO T030, T430_STORI' +
        'CO T430 '#39' ||'
      '             '#39'where T030.PROGRESSIVO = :PROGRESSIVO '#39' ||'
      '             '#39'and   T030.PROGRESSIVO = T430.PROGRESSIVO '#39' ||'
      
        '             '#39'and   trunc(sysdate) between T430.DATADECORRENZA a' +
        'nd T430.DATAFINE '#39' ||'
      
        '             '#39'and   trunc(sysdate) between T430.INIZIO and nvl(T' +
        '430.FINE,sysdate + 1)'#39';'
      ''
      '  for t1 in c1(:azienda) loop'
      '    -- costruisce il filtro anagrafe dell'#39'utente'
      '    filtro:=null;'
      
        '    for t2 in c2(:azienda,nvl(t1.delegato_da,t1.nome_utente),t1.' +
        'filtro_anagrafe) loop'
      '      if filtro is null then'
      '        filtro:=t2.filtro || '#39' '#39';'
      '      else'
      '        filtro:=filtro || t2.filtro || '#39' '#39';'
      '      end if;'
      '    end loop;'
      '    if filtro is not null then'
      '      filtro:='#39' and ('#39' || filtro || '#39')'#39';'
      '    end if;    '
      ''
      '    -- ottimizzazione query se il db ha la parte stipendiale'
      '    if :V430 = '#39'P430'#39' then'
      '      -- ottimizzazione attiva se:'
      
        '      -- 1. non viene usato "P430"   (tabella anagrafico stipend' +
        'i) e'
      
        '      -- 2. non viene usato "T430D_" (descrizione dei dati liber' +
        'i)'
      
        '      if (instr(upper(filtro),'#39'P430'#39') > 0) or (instr(upper(filtr' +
        'o),'#39'T430D_'#39') > 0) then'
      '        espressione:=espr_norm;'
      '      else'
      '        espressione:=espr_fast;'
      '        filtro:=replace(replace(filtro,'#39'V430.'#39','#39#39'),'#39'v430.'#39','#39#39');'
      
        '        filtro:=replace(replace(filtro,'#39'T430'#39','#39'T430.'#39'),'#39't430'#39','#39'T' +
        '430.'#39');'
      '      end if;'
      '    else'
      '      espressione:=espr_norm;'
      '    end if;'
      '   '
      
        '    -- se l'#39'utente '#232' responsabile del dipendente indicato dal pr' +
        'ogressivo'
      '    -- allora l'#39'indirizzo e-mail viene aggiunto'
      '    begin'
      '      open c for espressione || filtro using :progressivo;'
      '      loop'
      '        fetch c into x;'
      '        exit when c%notfound;'
      '        '
      '        if instr('#39';'#39'||p_email||'#39';'#39', '#39';'#39'||t1.email||'#39';'#39') = 0 then'
      '          p_email:=p_email || '#39';'#39' || t1.email;'
      '        end if;'
      
        '        p_filtroagg:=p_filtroagg || '#39';<U>'#39' || t1.nome_utente || ' +
        #39'<P>'#39' || t1.nome_profilo;'
      '      end loop;'
      '      close c;'
      '    exception'
      '      when others then'
      '        close c;'
      '    end;'
      '  end loop;'
      '  '
      '  if p_email is not null then'
      '    p_email:=substr(p_email,2,length(p_email));'
      '  end if;'
      '  if p_filtroagg is not null then'
      '    p_filtroagg:=substr(p_filtroagg,2,length(p_filtroagg));'
      '  end if;'
      ''
      '  :email:=p_email;'
      '  :filtro_agg:=p_filtroagg;'
      'end;')
    Optimize = False
    Variables.Data = {
      040000000A000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0045004D00410049004C00
      050000000000000000000000080000003A005400410047000300000000000000
      00000000160000003A00460049004C00540052004F005F004100470047000500
      000000000000000000000A0000003A0056003400330030000500000000000000
      000000000A0000003A0049005400450052000500000000000000000000001200
      00003A0043004F0044005F004900540045005200050000000000000000000000
      1E0000003A0045004C0045004E0043004F005F004C004900560045004C004C00
      49000100000000000000000000001A0000003A00480049004E00540054003000
      330030005600340033003000050000000000000000000000}
    Left = 147
    Top = 12
  end
  object scrEMailDipendente: TOracleQuery
    SQL.Strings = (
      'declare'
      'begin'
      '  select max(i060.email) into :email'
      '  from   mondoedp.i060_login_dipendente i060, '
      '         t030_anagrafico t030'
      '  where  i060.matricola = t030.matricola '
      '  and    i060.azienda = :azienda '
      '  and    t030.progressivo = :progressivo '
      '  and    email is not null'
      '  and    ((:tag is null) or'
      '          (exists ('
      '             select '#39'X'#39' || i061.nome_profilo'
      
        '             from   mondoedp.i061_profili_dipendente i061, mondo' +
        'edp.i073_filtrofunzioni i073'
      '             where  i061.azienda = i060.azienda'
      '             and    i061.nome_utente = i060.nome_utente'
      
        '             and    trunc(sysdate) between i061.inizio_validita ' +
        'and nvl(i061.fine_validita,sysdate + 1) '
      '             and    i061.ricezione_mail = '#39'S'#39
      '             and    i073.azienda = i060.azienda '
      '             and    i073.profilo = i061.filtro_funzioni'
      '             and    i073.applicazione = '#39'RILPRE'#39
      '             and    i073.tag = :tag'
      '             and    i073.inibizione = '#39'S'#39')));'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0041005A00490045004E004400410005000000
      00000000000000000C0000003A0045004D00410049004C000500000000000000
      00000000180000003A00500052004F0047005200450053005300490056004F00
      030000000000000000000000080000003A005400410047000300000000000000
      00000000}
    Left = 40
    Top = 12
  end
  object selI060MailResp: TOracleDataSet
    SQL.Strings = (
      'select distinct I060.EMAIL'
      
        'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060, MONDOEDP.I061_PROFIL' +
        'I_DIPENDENTE I061'
      'where  I060.AZIENDA = :AZIENDA'
      'and    I060.AZIENDA = I061.AZIENDA'
      'and    I060.NOME_UTENTE = I061.NOME_UTENTE'
      
        'and    trunc(sysdate) between I061.INIZIO_VALIDITA and I061.FINE' +
        '_VALIDITA'
      'and    (I061.ULTIMO_ACCESSO is null or'
      '        I061.ULTIMO_INVIO_MAIL is null or'
      '        I061.ULTIMO_ACCESSO > I061.ULTIMO_INVIO_MAIL or'
      
        '        (:GG_REINVIO_MAIL <> 0 and sysdate > (I061.ULTIMO_INVIO_' +
        'MAIL + :GG_REINVIO_MAIL)))'
      ':FILTRO_AGG')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      0000000000000000160000003A00460049004C00540052004F005F0041004700
      4700010000000000000000000000200000003A00470047005F00520045004900
      4E00560049004F005F004D00410049004C00040000000000000000000000}
    Left = 242
    Top = 12
  end
  object updI061UltimoInvio: TOracleQuery
    SQL.Strings = (
      'declare'
      '  pragma autonomous_transaction;'
      'begin'
      '  update MONDOEDP.I061_PROFILI_DIPENDENTE I061'
      '  set    I061.ULTIMO_INVIO_MAIL = sysdate'
      '  where  I061.AZIENDA = :AZIENDA'
      
        '  and    trunc(sysdate) between I061.INIZIO_VALIDITA AND I061.FI' +
        'NE_VALIDITA'
      '  and    (I061.ULTIMO_ACCESSO is null or'
      '          I061.ULTIMO_INVIO_MAIL is null or'
      '          I061.ULTIMO_ACCESSO > I061.ULTIMO_INVIO_MAIL or'
      
        '          (:GG_REINVIO_MAIL <> 0 and sysdate > (I061.ULTIMO_INVI' +
        'O_MAIL + :GG_REINVIO_MAIL)))'
      '  :FILTRO_AGG'
      '  ;'
      ''
      '  commit;'
      'end;'
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      ''
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      0000000000000000160000003A00460049004C00540052004F005F0041004700
      4700010000000000000000000000200000003A00470047005F00520045004900
      4E00560049004F005F004D00410049004C00040000000000000000000000}
    Left = 240
    Top = 76
  end
  object selI060NomiResp: TOracleDataSet
    SQL.Strings = (
      
        'select distinct I060F_NOMINATIVO(:AZIENDA,I060.NOME_UTENTE) NOMI' +
        'NATIVO'
      
        'from   MONDOEDP.I060_LOGIN_DIPENDENTE I060, MONDOEDP.I061_PROFIL' +
        'I_DIPENDENTE I061'
      'where  I060.AZIENDA = :AZIENDA'
      'and    I061.AZIENDA = I060.AZIENDA'
      'and    I061.NOME_UTENTE = I060.NOME_UTENTE'
      
        'and    trunc(sysdate) between I061.INIZIO_VALIDITA and I061.FINE' +
        '_VALIDITA'
      ':FILTRO_AGG')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000160000003A00460049004C00540052004F005F0041004700
      4700010000000000000000000000}
    Left = 330
    Top = 12
  end
  object selI091: TOracleDataSet
    SQL.Strings = (
      'select DATO from MONDOEDP.I091_DATIENTE'
      'where AZIENDA = :AZIENDA'
      'and TIPO = '#39'C90_EMAIL_RESP_OTTIMIZZATA'#39
      'and DATO = '#39'S'#39
      '  ')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 328
    Top = 76
  end
end
