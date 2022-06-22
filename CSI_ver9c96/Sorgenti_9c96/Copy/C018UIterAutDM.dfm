inherited C018FIterAutDM: TC018FIterAutDM
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 515
  Width = 894
  object insT850: TOracleQuery
    SQL.Strings = (
      'begin'
      '  if :ID is null then'
      '    --inserimento nuova richiesta'
      '    select T850_ID.nextval into :ID from dual;'
      ''
      '    insert into T850_ITER_RICHIESTE'
      
        '      (ITER,COD_ITER,ID,DATA,NOTE,STATO,TIPO_RICHIESTA,RICHIEDEN' +
        'TE,AUTORIZZ_AUTOMATICA,ID_REVOCA,ID_REVOCATO,CONDIZ_ALLEGATI)'
      '    values '
      
        '      (:ITER,:COD_ITER,:ID,:DATA,:NOTE,:STATO,:TIPO_RICHIESTA,:R' +
        'ICHIEDENTE,:AUTORIZZ_AUTOMATICA,:ID_REVOCA,:ID_REVOCATO,nvl(:CON' +
        'DIZ_ALLEGATI,'#39'N'#39'));'
      '  else'
      
        '    --modifica COD_ITER a richiesta esistente, solo se COD_ITER ' +
        #232' cambiato'
      '    update T850_ITER_RICHIESTE set'
      '      COD_ITER = :COD_ITER,'
      '      DATA = :DATA,'
      '      RICHIEDENTE = :RICHIEDENTE,'
      '      CONDIZ_ALLEGATI = nvl(:CONDIZ_ALLEGATI,'#39'N'#39')'
      '    where ITER = :ITER '
      '    and ID = :ID'
      '    and COD_ITER <> :COD_ITER;'
      
        '    --se COD_ITER '#232' cambiato, si annullano eventuali autorizzazi' +
        'oni successive perch'#232' la struttura pu'#242' essere diversa'
      '    if sql%rowcount > 0 then'
      '      delete from T851_ITER_AUTORIZZAZIONI'
      '      where ID = :ID;'
      '    end if;'
      '  end if;'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      040000000C0000000A0000003A00490054004500520005000000000000000000
      0000120000003A0043004F0044005F0049005400450052000500000000000000
      00000000060000003A00490044000300000000000000000000000A0000003A00
      4E004F00540045000500000000000000000000000C0000003A00530054004100
      54004F000500000000000000000000001E0000003A005400490050004F005F00
      5200490043004800490045005300540041000500000000000000000000002800
      00003A004100550054004F00520049005A005A005F004100550054004F004D00
      41005400490043004100050000000000000000000000140000003A0049004400
      5F005200450056004F0043004100030000000000000000000000180000003A00
      490044005F005200450056004F004300410054004F0003000000000000000000
      00000A0000003A0044004100540041000C000000000000000000000018000000
      3A00520049004300480049004500440045004E00540045000500000000000000
      00000000200000003A0043004F004E00440049005A005F0041004C004C004500
      4700410054004900050000000000000000000000}
    Left = 144
    Top = 16
  end
  object updT850IdRevoca: TOracleQuery
    SQL.Strings = (
      'update T850_ITER_RICHIESTE'
      'set ID_REVOCA = :ID_REVOCA '
      'where ITER = :ITER '
      'and ID = :ID '
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00490054004500520005000000000000000000
      0000060000003A0049004400030000000000000000000000140000003A004900
      44005F005200450056004F0043004100030000000000000000000000}
    Left = 331
    Top = 208
  end
  object updT850Note: TOracleQuery
    SQL.Strings = (
      'update T850_ITER_RICHIESTE'
      'set NOTE = :NOTE '
      'where ITER = :ITER '
      'and ID = :ID ')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00490054004500520005000000000000000000
      0000060000003A00490044000300000000000000000000000A0000003A004E00
      4F0054004500050000000000000000000000}
    Left = 331
    Top = 16
  end
  object updT850Stato: TOracleQuery
    SQL.Strings = (
      'update T850_ITER_RICHIESTE'
      'set STATO = :STATO '
      'where ITER = :ITER '
      'and ID = :ID ')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00490054004500520005000000000000000000
      0000060000003A00490044000300000000000000000000000C0000003A005300
      5400410054004F00050000000000000000000000}
    Left = 331
    Top = 64
  end
  object selI096: TOracleDataSet
    SQL.Strings = (
      'select * from MONDOEDP.I096_LIVELLI_ITER_AUT '
      'where AZIENDA = :AZIENDA '
      'and ITER = :ITER'
      'order by COD_ITER,LIVELLO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    Left = 48
    Top = 160
  end
  object delIterRichiesta: TOracleQuery
    SQL.Strings = (
      'declare'
      '  w_ID_REVOCATO    integer;'
      '  w_TIPO_RICHIESTA varchar2(1);'
      '  wContaCan        integer;'
      'begin'
      
        '  /* se si cancella una richiesta di revoca o cancellazione (ID_' +
        'REVOCATO not null), '
      '     si annulla se necessario il riferimento alla revoca stessa'
      '  */'
      '  begin'
      '    select ID_REVOCATO, TIPO_RICHIESTA '
      '    into   w_ID_REVOCATO, w_TIPO_RICHIESTA '
      '    from   T850_ITER_RICHIESTE '
      '    where  ITER = :ITER '
      '    and    ID = :ID;'
      '  exception'
      '    when no_data_found then'
      '      w_ID_REVOCATO:=null;'
      '      w_TIPO_RICHIESTA:=null;'
      '  end;'
      '  '
      '  if w_ID_REVOCATO is not null then'
      '    /* '
      
        '      se si tratta di cancellazione, prima di procedere con la u' +
        'pdate'
      '      verifica che non ci siano altre cancellazioni '
      '    */'
      '    wContaCan:=0;'
      '    if w_TIPO_RICHIESTA = '#39'C'#39' then'
      '      select count(*)'
      '      into   wContaCan'
      '      from   T850_ITER_RICHIESTE'
      '      where  ITER = :ITER '
      '      and    ID_REVOCATO = w_ID_REVOCATO'
      '      and    ID <> :ID;'
      '    end if;'
      '    '
      '    if wContaCan = 0 then'
      '      update T850_ITER_RICHIESTE'
      '      set ID_REVOCA = null '
      '      where ITER = :ITER'
      '      and ID = w_ID_REVOCATO;'
      '    end if;  '
      '  end if;'
      ''
      
        '  /* per l'#39'iter delle eccedenze giornaliere effettua operazioni ' +
        'particolari */'
      '  if :ITER = '#39'T325'#39' then'
      '    delete from T325_RICHIESTESTR_GG '
      '    where  ID in (select ID '
      '                  from T326_RICHIESTESTR_SPEZ '
      '                  where ID_T850 = :ID);'
      '  else'
      '    delete from :TABELLA where ID = :ID;'
      '  end if;'
      ''
      
        '  delete from T850_ITER_RICHIESTE where ITER = :ITER and ID = :I' +
        'D;'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00490054004500520005000000000000000000
      0000060000003A0049004400030000000000000000000000100000003A005400
      4100420045004C004C004100010000000000000000000000}
    Left = 144
    Top = 64
  end
  object selI095: TOracleDataSet
    SQL.Strings = (
      'select * from MONDOEDP.I095_ITER_AUT'
      'where AZIENDA = :AZIENDA '
      'and ITER = :ITER'
      'order by nvl(FILTRO_RICHIESTA,'#39'zzz'#39'),COD_ITER')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    Left = 48
    Top = 112
  end
  object updT850TipoRichiesta: TOracleQuery
    SQL.Strings = (
      'update T850_ITER_RICHIESTE'
      'set TIPO_RICHIESTA = :TIPO_RICHIESTA'
      'where ITER = :ITER '
      'and ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00490054004500520005000000000000000000
      0000060000003A00490044000300000000000000000000001E0000003A005400
      490050004F005F00520049004300480049004500530054004100050000000000
      000000000000}
    Left = 331
    Top = 256
  end
  object updT850AutorizzAutomatica: TOracleQuery
    SQL.Strings = (
      'update T850_ITER_RICHIESTE'
      'set AUTORIZZ_AUTOMATICA = :AUTORIZZ_AUTOMATICA '
      'where ITER = :ITER '
      'and ID = :ID ')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00490054004500520005000000000000000000
      0000060000003A0049004400030000000000000000000000280000003A004100
      550054004F00520049005A005A005F004100550054004F004D00410054004900
      43004100050000000000000000000000}
    Left = 331
    Top = 112
  end
  object updT851: TOracleQuery
    SQL.Strings = (
      'update T851_ITER_AUTORIZZAZIONI '
      'set STATO = :STATO,'
      '    RESPONSABILE = :RESPONSABILE,'
      '    DATA = :DATA'
      'where ID = :ID'
      'and LIVELLO = :LIVELLO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000050000000C0000003A0053005400410054004F000500000000000000
      000000001A0000003A0052004500530050004F004E0053004100420049004C00
      45000500000000000000000000000A0000003A0044004100540041000C000000
      0000000000000000060000003A00490044000300000000000000000000001000
      00003A004C004900560045004C004C004F00030000000000000000000000}
    Left = 216
    Top = 64
  end
  object selMaxLivelloAut: TOracleQuery
    SQL.Strings = (
      'select nvl(max(T851.LIVELLO),0) LIVELLO_MAX'
      
        'from T850_ITER_RICHIESTE T850, T851_ITER_AUTORIZZAZIONI T851, MO' +
        'NDOEDP.I096_LIVELLI_ITER_AUT I096'
      'where T850.ITER = :ITER'
      'and T850.ID = :ID'
      'and T851.ID = T850.ID_REVOCATO'
      
        'and nvl(T851.STATO,'#39'nullo'#39') in ('#39'S'#39',nvl(I096.AUTORIZZ_INTERMEDIA' +
        ','#39'vuoto'#39'))'
      'and I096.AZIENDA = :AZIENDA'
      'and I096.ITER = :ITER'
      'and I096.COD_ITER = T850.COD_ITER'
      'and I096.OBBLIGATORIO = '#39'S'#39
      'and I096.LIVELLO = T851.LIVELLO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00490054004500520005000000000000000000
      0000060000003A0049004400030000000000000000000000100000003A004100
      5A00490045004E0044004100050000000000000000000000}
    Left = 48
    Top = 264
  end
  object insT851: TOracleQuery
    SQL.Strings = (
      'insert into T851_ITER_AUTORIZZAZIONI '
      '  (ID,LIVELLO,DATA,RESPONSABILE,NOTE,STATO,AUTORIZZ_AUTOMATICA)'
      'values '
      
        '  (:ID,:LIVELLO,:DATA,:RESPONSABILE,:NOTE,:STATO,:AUTORIZZ_AUTOM' +
        'ATICA)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000007000000060000003A00490044000300000000000000000000001A00
      00003A0052004500530050004F004E0053004100420049004C00450005000000
      00000000000000000A0000003A004E004F005400450005000000000000000000
      00000C0000003A0053005400410054004F000500000000000000000000002800
      00003A004100550054004F00520049005A005A005F004100550054004F004D00
      41005400490043004100050000000000000000000000100000003A004C004900
      560045004C004C004F000300000000000000000000000A0000003A0044004100
      540041000C0000000000000000000000}
    Left = 216
    Top = 16
  end
  object updT851Note: TOracleQuery
    SQL.Strings = (
      'update T851_ITER_AUTORIZZAZIONI '
      'set NOTE = :NOTE '
      'where ID = :ID '
      'and LIVELLO = :LIVELLO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000000A00
      00003A004E004F0054004500050000000000000000000000100000003A004C00
      4900560045004C004C004F00030000000000000000000000}
    Left = 475
    Top = 16
  end
  object updT851Stato: TOracleQuery
    SQL.Strings = (
      'update T851_ITER_AUTORIZZAZIONI '
      'set STATO = :STATO '
      'where ID = :ID '
      'and LIVELLO = :LIVELLO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001000
      00003A004C004900560045004C004C004F000300000000000000000000000C00
      00003A0053005400410054004F00050000000000000000000000}
    Left = 475
    Top = 64
  end
  object updT851AutorizzAutomatica: TOracleQuery
    SQL.Strings = (
      'update T851_ITER_AUTORIZZAZIONI '
      'set AUTORIZZ_AUTOMATICA = :AUTORIZZ_AUTOMATICA '
      'where ID = :ID '
      'and LIVELLO = :LIVELLO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001000
      00003A004C004900560045004C004C004F000300000000000000000000002800
      00003A004100550054004F00520049005A005A005F004100550054004F004D00
      41005400490043004100050000000000000000000000}
    Left = 475
    Top = 112
  end
  object selDualExprRichiesta: TOracleQuery
    SQL.Strings = (
      'select count(*) tot from DUAL '
      'where :FILTRO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    Left = 48
    Top = 312
  end
  object selMailPerAutorizzatore: TOracleQuery
    SQL.Strings = (
      'select '
      '  :OGGETTO MAIL_OGGETTO,'
      '  :CORPO MAIL_CORPO'
      'from '
      
        '  T030_ANAGRAFICO T030, T850_ITER_RICHIESTE T850, T850_ITER_RICH' +
        'IESTE T850R, :TABELLA T_ITER'
      'where T030.PROGRESSIVO =:PROGRESSIVO'
      'and T850.ITER = :ITER'
      'and T850.ID = :ID'
      'and T_ITER.ID = :ID'
      'and T850R.ITER(+) = :ITER'
      'and T850R.ID(+) = T850.ID_REVOCATO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000007000000100000003A004F00470047004500540054004F0001000000
      00000000000000000C0000003A0043004F00520050004F000100000000000000
      00000000100000003A0054004100420045004C004C0041000100000000000000
      00000000180000003A00500052004F0047005200450053005300490056004F00
      0300000000000000000000000A0000003A004900540045005200050000000000
      000000000000060000003A004900440003000000000000000000000016000000
      3A004F0050004500520041005A0049004F004E00450005000000000000000000
      0000}
    Left = 48
    Top = 360
  end
  object selMailPerRichiedente: TOracleQuery
    SQL.Strings = (
      'select'
      '  :OGGETTO MAIL_OGGETTO,'
      '  :CORPO MAIL_CORPO'
      'from'
      '  T030_ANAGRAFICO T030, T850_ITER_RICHIESTE T850, '
      '  T850_ITER_RICHIESTE T850R, '
      '  T851_ITER_AUTORIZZAZIONI T851, :TABELLA T_ITER'
      'where T030.PROGRESSIVO =:PROGRESSIVO'
      'and T_ITER.ID = :ID'
      'and T850.ITER = :ITER'
      'and T850.ID = :ID'
      'and T850R.ITER(+) = :ITER'
      'and T850R.ID(+) = T850.ID_REVOCATO'
      'and T851.ID = :ID'
      'and T851.LIVELLO = :LIVELLO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000007000000100000003A0054004100420045004C004C00410001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0049005400450052000500
      00000000000000000000060000003A0049004400030000000000000000000000
      100000003A004F00470047004500540054004F00010000000000000000000000
      0C0000003A0043004F00520050004F0001000000000000000000000010000000
      3A004C004900560045004C004C004F00050000000000000000000000}
    Left = 48
    Top = 408
  end
  object selT851: TOracleDataSet
    SQL.Strings = (
      'select '
      '  0 LIVELLO, '
      '  null DESC_LIVELLO, '
      '  '#39'Richiesta'#39' TITOLO_LIVELLO, '
      '  '#39'Richiesta'#39' TIPO_LIVELLO, '
      '  null OBBLIGATORIO,'
      '  null AVVISO,'
      '  null STATO, '
      '  null AUTORIZZ_AUTOMATICA, '
      
        '  decode(T850.RICHIEDENTE,null,T030.COGNOME||'#39' '#39'||T030.NOME,I060' +
        'F_NOMINATIVO(:AZIENDA,T850.RICHIEDENTE)) NOMINATIVO, '
      '  T850.DATA, '
      '  T850.NOTE'
      'from '
      
        '  T850_ITER_RICHIESTE T850, :TABELLA T_ITER, T030_ANAGRAFICO T03' +
        '0'
      'where T850.ITER = :ITER'
      'and T850.ID = :ID'
      'and T_ITER.ID = T850.ID'
      'and T_ITER.PROGRESSIVO = T030.PROGRESSIVO'
      'union all'
      'select '
      '  I096.LIVELLO,'
      '  I096.DESC_LIVELLO, '
      
        '  I096.LIVELLO||'#39' - '#39'||nvl(I096.DESC_LIVELLO,decode(I096.OBBLIGA' +
        'TORIO,'#39'S'#39','#39'Autorizzazione'#39','#39'Visto'#39')) TITOLO_LIVELLO, '
      
        '  decode(I096.OBBLIGATORIO,'#39'S'#39','#39'Autorizzazione'#39','#39'Visto'#39') TIPO_LI' +
        'VELLO, '
      '  I096.OBBLIGATORIO,'
      '  I096.AVVISO,'
      '  decode(T851.STATO,null,null,'#39'N'#39','#39'No'#39','#39'Si'#39') STATO, '
      '  T851.AUTORIZZ_AUTOMATICA,'
      '  I060F_NOMINATIVO(:AZIENDA,T851.RESPONSABILE) NOMINATIVO, '
      '  T851.DATA, '
      '  T851.NOTE'
      'from '
      
        '  MONDOEDP.I096_LIVELLI_ITER_AUT I096, T851_ITER_AUTORIZZAZIONI ' +
        'T851'
      'where I096.AZIENDA = :AZIENDA'
      'and I096.ITER = :ITER'
      'and I096.COD_ITER = :COD_ITER'
      'and T851.ID(+) = :ID'
      'and T851.LIVELLO(+) = I096.LIVELLO'
      'order by LIVELLO')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000005000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000120000003A0043004F0044005F0049005400450052000500000000000000
      00000000060000003A0049004400030000000000000000000000100000003A00
      54004100420045004C004C004100010000000000000000000000}
    OnCalcFields = selT851CalcFields
    Left = 608
    Top = 16
    object selT851LIVELLO: TFloatField
      FieldName = 'LIVELLO'
    end
    object selT851DESC_LIVELLO: TStringField
      FieldName = 'DESC_LIVELLO'
      Size = 40
    end
    object selT851TITOLO_LIVELLO: TStringField
      FieldName = 'TITOLO_LIVELLO'
      Visible = False
      Size = 50
    end
    object selT851C_TITOLO_LIVELLO: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_TITOLO_LIVELLO'
      Size = 50
      Calculated = True
    end
    object selT851TIPO_LIVELLO: TStringField
      FieldName = 'TIPO_LIVELLO'
      Size = 50
    end
    object selT851OBBLIGATORIO: TStringField
      FieldName = 'OBBLIGATORIO'
      Size = 1
    end
    object selT851AVVISO: TStringField
      FieldName = 'AVVISO'
      Size = 1
    end
    object selT851STATO: TStringField
      FieldName = 'STATO'
      Visible = False
      Size = 2
    end
    object selT851C_STATO: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_STATO'
      Size = 5
      Calculated = True
    end
    object selT851AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selT851NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 80
    end
    object selT851DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object selT851NOTE: TStringField
      FieldName = 'NOTE'
      Size = 2000
    end
  end
  object selI093: TOracleDataSet
    SQL.Strings = (
      'select * from MONDOEDP.I093_BASE_ITER_AUT '
      'where AZIENDA = :AZIENDA '
      'and ITER = :ITER')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    Left = 48
    Top = 16
  end
  object selI094: TOracleDataSet
    SQL.Strings = (
      'select * from MONDOEDP.I094_CHKDATI_ITER_AUT '
      'where AZIENDA = :AZIENDA '
      'and ITER = :ITER'
      'order by RIEPILOGO,STATO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    Left = 48
    Top = 64
  end
  object selI097: TOracleDataSet
    SQL.Strings = (
      'select * from MONDOEDP.I097_VALIDITA_ITER_AUT '
      'where AZIENDA = :AZIENDA '
      'and ITER = :ITER'
      'and ltrim(rtrim(CONDIZ_VALIDITA)) is not null'
      'order by COD_ITER,decode(BLOCCANTE,'#39'S'#39',0,1),NUM_CONDIZ')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000}
    Left = 48
    Top = 208
  end
  object insupdT852: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  insert into T851_ITER_AUTORIZZAZIONI (ID,LIVELLO,DATA,RESPONSA' +
        'BILE)'
      '  select :ID,:LIVELLO,sysdate,:RESPONSABILE'
      '  from dual'
      
        '  where not exists (select '#39'x'#39' from T851_ITER_AUTORIZZAZIONI whe' +
        're ID = :ID);'
      ''
      '  update T852_ITER_DATI_AUTORIZZATORI'
      '  set VALORE = :VALORE,'
      '      DATA = sysdate'
      '  where ID = :ID '
      '  and LIVELLO = :LIVELLO'
      '  and DATO = :DATO;'
      '  if sql%rowcount = 0 then'
      
        '    insert into T852_ITER_DATI_AUTORIZZATORI (ID,LIVELLO,DATA,DA' +
        'TO,VALORE)'
      '    values (:ID,:LIVELLO,sysdate,:DATO,:VALORE);'
      '  end if;'
      'end;'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000005000000060000003A00490044000300000000000000000000001000
      00003A004C004900560045004C004C004F000300000000000000000000000E00
      00003A00560041004C004F00520045000500000000000000000000000A000000
      3A004400410054004F000500000000000000000000001A0000003A0052004500
      530050004F004E0053004100420049004C004500050000000000000000000000}
    Left = 705
    Top = 64
  end
  object selT852: TOracleDataSet
    SQL.Strings = (
      'select LIVELLO,DATO,VALORE'
      'from   T852_ITER_DATI_AUTORIZZATORI T852'
      'where  ID = :ID'
      'and    LIVELLO = :LIVELLO')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001000
      00003A004C004900560045004C004C004F00010000000000000000000000}
    Left = 702
    Top = 16
  end
  object T851F_FASE_CORRENTE: TOracleQuery
    SQL.Strings = (
      'begin'
      '  :FASE:=T851F_FASE_CORRENTE(:AZIENDA,:ITER,:COD_ITER,:ID);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A00490054004500520005000000000000000000
      0000060000003A00490044000300000000000000000000000A0000003A004600
      410053004500030000000000000000000000100000003A0041005A0049004500
      4E0044004100050000000000000000000000120000003A0043004F0044005F00
      4900540045005200050000000000000000000000}
    Left = 608
    Top = 112
  end
  object selT851RespFasi: TOracleDataSet
    SQL.Strings = (
      
        'select I096.FASE,T851.STATO,T851.DATA,I060F_NOMINATIVO(:AZIENDA,' +
        'T851.RESPONSABILE) NOMINATIVO_RESP '
      'from '
      '  ('
      '  select FASE,max(LIVELLO) LIVELLO'
      '  from MONDOEDP.I096_LIVELLI_ITER_AUT I096'
      '  where AZIENDA = :AZIENDA'
      '  and ITER =:ITER'
      '  and COD_ITER = :COD_ITER'
      '  and OBBLIGATORIO = '#39'S'#39
      '  group by FASE'
      '  ) I096,'
      '  ('
      
        '  select STATO,RESPONSABILE,DATA,LIVELLO FROM T851_ITER_AUTORIZZ' +
        'AZIONI T851'
      '  where ID = :ID'
      '  ) T851'
      'where T851.LIVELLO = I096.LIVELLO'
      'order by FASE')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000120000003A0043004F0044005F0049005400450052000500000000000000
      00000000060000003A0049004400030000000000000000000000}
    Left = 608
    Top = 64
  end
  object updT850CodIter: TOracleQuery
    SQL.Strings = (
      'update T850_ITER_RICHIESTE'
      'set COD_ITER = :COD_ITER'
      'where ITER = :ITER '
      'and ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00490054004500520005000000000000000000
      0000060000003A0049004400030000000000000000000000120000003A004300
      4F0044005F004900540045005200050000000000000000000000}
    Left = 331
    Top = 160
  end
  object selT851StatoLivelli: TOracleDataSet
    SQL.Strings = (
      'select LIVELLO, STATO'
      'from   T851_ITER_AUTORIZZAZIONI'
      'where  ID = :ID'
      'order by LIVELLO desc')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 608
    Top = 176
  end
  object updT850Data: TOracleQuery
    SQL.Strings = (
      'update T850_ITER_RICHIESTE'
      'set DATA = nvl(:DATA, sysdate)'
      'where ITER = :ITER '
      'and ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00490054004500520005000000000000000000
      0000060000003A00490044000300000000000000000000000A0000003A004400
      4100540041000C0000000000000000000000}
    Left = 331
    Top = 304
  end
  object scrT851: TOracleQuery
    ReadBuffer = 2
    Optimize = False
    Left = 216
    Top = 112
  end
  object selI075: TOracleDataSet
    SQL.Strings = (
      
        'select I096.COD_ITER, I096.LIVELLO, I096.OBBLIGATORIO, I096.AVVI' +
        'SO, nvl(I075.ACCESSO,'#39'N'#39') as ACCESSO'
      'from   MONDOEDP.I075_ITER_AUTORIZZATIVI I075, '
      '       MONDOEDP.I096_LIVELLI_ITER_AUT I096'
      'where  I096.AZIENDA = :AZIENDA'
      'and    I096.ITER = :ITER'
      'and    I075.AZIENDA(+) = I096.AZIENDA'
      'and    I075.PROFILO(+) = :PROFILO'
      'and    I075.ITER(+) = I096.ITER'
      'and    I075.COD_ITER(+) = I096.COD_ITER'
      'and    I075.LIVELLO(+) = I096.LIVELLO'
      'order by I096.COD_ITER, I096.LIVELLO')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000A0000003A00490054004500520005000000000000000000
      0000100000003A00500052004F00460049004C004F0005000000000000000000
      0000}
    Left = 841
    Top = 16
  end
  object selT002_Richiesta: TOracleDataSet
    SQL.Strings = (
      'select RIGA from '
      'T002_QUERYPERSONALIZZATE'
      'where NOME = '#39'#MEDP_C018_RICHIESTA#'#39' '
      'and APPLICAZIONE = '#39'MEDP'#39
      'and POSIZ >= 0'
      'order by POSIZ')
    ReadBuffer = 40
    Optimize = False
    Left = 48
    Top = 456
  end
  object selT002_Autorizzazione: TOracleDataSet
    SQL.Strings = (
      'select RIGA from '
      'T002_QUERYPERSONALIZZATE'
      'where NOME = '#39'#MEDP_C018_AUTORIZZAZIONE#'#39' '
      'and APPLICAZIONE = '#39'MEDP'#39
      'and POSIZ >= 0'
      'order by POSIZ')
    ReadBuffer = 40
    Optimize = False
    Left = 175
    Top = 456
  end
  object delT852: TOracleQuery
    SQL.Strings = (
      'delete from T852_ITER_DATI_AUTORIZZATORI'
      'where ID = :ID '
      'and LIVELLO = :LIVELLO'
      'and DATO = :DATO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001000
      00003A004C004900560045004C004C004F000300000000000000000000000A00
      00003A004400410054004F00050000000000000000000000}
    Left = 705
    Top = 120
  end
  object selT853_T960: TOracleDataSet
    SQL.Strings = (
      'select T853.ID, T853.ID_T960,'
      '       T960.NOME_FILE, T960.EXT_FILE, T960.DIMENSIONE, T960.NOTE'
      'from   T853_DOC_ALLEGATI T853,'
      '       T960_DOCUMENTI_INFO T960'
      'where  T853.ID = :ID'
      'and    T960.ID = T853.ID_T960'
      '')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    ReadOnly = True
    Left = 774
    Top = 64
  end
  object insT853: TOracleQuery
    SQL.Strings = (
      'insert into T853_DOC_ALLEGATI (ID, ID_T960)'
      'values (:ID, :ID_T960)'
      ''
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001000
      00003A00490044005F005400390036003000030000000000000000000000}
    Left = 775
    Top = 120
  end
  object delT853: TOracleQuery
    SQL.Strings = (
      'delete from T853_DOC_ALLEGATI'
      'where  ID = :ID'
      'and    ID_T960 = :ID_T960'
      ''
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001000
      00003A00490044005F005400390036003000030000000000000000000000}
    Left = 775
    Top = 168
  end
  object selT853Count: TOracleQuery
    SQL.Strings = (
      'select count(ID)'
      'from   T853_DOC_ALLEGATI'
      'where  ID = :ID'
      ''
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 775
    Top = 16
  end
  object selT850: TOracleQuery
    SQL.Strings = (
      'select T850.COD_ITER'
      'from   T850_ITER_RICHIESTE T850'
      'where  T850.ID = :ID')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 144
    Top = 112
  end
  object delT851: TOracleQuery
    SQL.Strings = (
      'delete'
      '  from T851_ITER_AUTORIZZAZIONI T851'
      ' where T851.ID = :ID'
      '   and T851.LIVELLO >= :LIVELLO')
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001000
      00003A004C004900560045004C004C004F00030000000000000000000000}
    Left = 760
    Top = 352
  end
  object delDBDato: TOracleQuery
    SQL.Strings = (
      'delete'
      '  from :TABELLA_ITER T'
      ' where T.:NOME_DATO = :ID')
    Optimize = False
    Variables.Data = {
      04000000030000001A0000003A0054004100420045004C004C0041005F004900
      540045005200010000000000000000000000140000003A004E004F004D004500
      5F004400410054004F00010000000000000000000000060000003A0049004400
      030000000000000000000000}
    Left = 808
    Top = 352
  end
  object updElaborato: TOracleQuery
    SQL.Strings = (
      'update :TABELLA_ITER T'
      '   set T.ELABORATO = :ELABORATO'
      ' where T.ID = :ID')
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001400
      00003A0045004C00410042004F005200410054004F0005000000000000000000
      00001A0000003A0054004100420045004C004C0041005F004900540045005200
      010000000000000000000000}
    Left = 808
    Top = 408
  end
  object delTabRichieste: TOracleQuery
    SQL.Strings = (
      'delete'
      '  from :TABELLA_ITER T'
      ' where T.:COLONNA_ID = :ID')
    Optimize = False
    Variables.Data = {
      04000000030000001A0000003A0054004100420045004C004C0041005F004900
      540045005200010000000000000000000000060000003A004900440003000000
      0000000000000000160000003A0043004F004C004F004E004E0041005F004900
      4400010000000000000000000000}
    Left = 808
    Top = 456
  end
  object selSG101: TOracleDataSet
    SQL.Strings = (
      'select SG101.CODFISCALE'
      'from   SG101_FAMILIARI SG101'
      'where  SG101.PROGRESSIVO = :PROGRESSIVO'
      'and    SG101.DATANAS = :DATANAS')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004E00
      410053000C0000000000000000000000}
    ReadOnly = True
    Left = 470
    Top = 184
  end
  object selT230: TOracleDataSet
    SQL.Strings = (
      
        'select t230f_getvalue(:CODICE, '#39'CONDIZIONE_ALLEGATI'#39', :DATA) CON' +
        'DIZIONE_ALLEGATI from dual')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000000A0000003A0044004100540041000C0000000000000000000000}
    Left = 328
    Top = 456
  end
  object updT960Note: TOracleQuery
    SQL.Strings = (
      'update T960_DOCUMENTI_INFO'
      'set NOTE = :NOTE'
      'where ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A004E004F005400450005000000000000000000
      0000060000003A0049004400030000000000000000000000}
    Left = 504
    Top = 304
  end
  object selT230Count: TOracleDataSet
    SQL.Strings = (
      
        'select count(*) from T230_CAUASSENZE_PARSTO where CONDIZIONE_ALL' +
        'EGATI in ('#39'O'#39','#39'F'#39')')
    ReadBuffer = 2
    Optimize = False
    Left = 328
    Top = 408
  end
end
