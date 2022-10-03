inherited A124FPermessiSindacaliMW: TA124FPermessiSindacaliMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 194
  Width = 542
  object Q040: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'T040.*,T040.ROWID FROM T040_GIUSTIFICATIVI T040'
      'WHERE PROGRESSIVO = :Progressivo AND'
      '               DATA BETWEEN :DataInizio and :DataFine'
      'ORDER BY DATA, CAUSALE, PROGRCAUSALE')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 384
    Top = 124
  end
  object Q100: TOracleDataSet
    SQL.Strings = (
      'SELECT T100.*,T100.ROWID FROM T100_TIMBRATURE T100'
      'WHERE PROGRESSIVO = :Progressivo and '
      '           DATA BETWEEN :DataInizio AND :DataFine'
      '           AND FLAG IN ('#39'O'#39','#39'I'#39')'
      'ORDER BY DATA,ORA,VERSO,FLAG')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 420
    Top = 124
    object Q100PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object Q100DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object Q100ORA: TDateTimeField
      FieldName = 'ORA'
      DisplayFormat = 't'
      EditMask = '!90:00;1;_'
    end
    object Q100VERSO: TStringField
      FieldName = 'VERSO'
      Size = 1
    end
    object Q100FLAG: TStringField
      FieldName = 'FLAG'
      Size = 1
    end
    object Q100RILEVATORE: TStringField
      FieldName = 'RILEVATORE'
      Size = 2
    end
    object Q100CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE ORDER BY CODICE')
    Optimize = False
    Left = 457
    Top = 124
  end
  object Q305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T305_CAUGIUSTIF ORDER BY CODICE')
    Optimize = False
    Left = 492
    Top = 124
  end
  object selAssenza: TOracleQuery
    SQL.Strings = (
      
        'select decode(:tipo,'#39'S'#39',T240.causale_competenze,'#39'N'#39',nvl(T240.cau' +
        'sale_competenze_no,T240.causale_competenze)) CAUSALE'
      '  from t240_organizzazionisindacali T240'
      ' where T240.codice = :sindacato'
      '   and T240.decorrenza = (select max(decorrenza)'
      '                            from t240_organizzazionisindacali'
      '                           where codice = T240.codice '
      '                             and decorrenza <= :data)')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0005000000000000000000
      0000140000003A00530049004E00440041004300410054004F00050000000000
      0000000000000A0000003A0044004100540041000C0000000000000000000000}
    Left = 146
    Top = 116
  end
  object selPermessi: TOracleDataSet
    SQL.Strings = (
      'select TIPO_PERMESSO, DALLE, ALLE, prog_permesso'
      '  from t248_permessisindacali'
      ' where progressivo = :PROG'
      '   and data = :DATA'
      '   and abbatte_competenze = :ABBATTE'
      '   and cod_sindacato = :SINDACATO'
      '   and cod_organismo = :ORGANISMO'
      '   and stato = :STATO'
      'order by prog_permesso')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C000000000000000000000010000000
      3A00410042004200410054005400450005000000000000000000000014000000
      3A00530049004E00440041004300410054004F00050000000000000000000000
      140000003A004F005200470041004E00490053004D004F000500000000000000
      000000000C0000003A0053005400410054004F00050000000000000000000000}
    Left = 218
    Top = 116
  end
  object insT040: TOracleQuery
    SQL.Strings = (
      'declare'
      '  p integer;'
      '  aore date;'
      '  giustif varchar2(5);'
      '  giustif_old varchar2(5);'
      'begin'
      '  giustif:=null;'
      '  giustif_old:=null;'
      '  --Lettura causale di assenza da cancellare'
      '  begin'
      
        '    select decode(:tipo_old,'#39'S'#39',T240.causale_competenze,'#39'N'#39',nvl(' +
        'T240.causale_competenze_no,T240.causale_competenze)) '
      '      into giustif_old'
      '      from t240_organizzazionisindacali T240'
      '      where T240.codice = :sindacato_old'
      '      and T240.decorrenza = (select max(decorrenza)'
      '                             from t240_organizzazionisindacali'
      '                             where codice = T240.codice '
      '                             and decorrenza <= :data_old);'
      '  exception'
      '    when no_data_found then'
      '      giustif_old:=null;'
      '  end;'
      '  --Lettura causale di assenza da inserire'
      '  begin'
      
        '    select decode(:tipo,'#39'S'#39',T240.causale_competenze,'#39'N'#39',nvl(T240' +
        '.causale_competenze_no,T240.causale_competenze)) '
      '      into giustif'
      '      from t240_organizzazionisindacali T240'
      '      where T240.codice = :sindacato'
      '      and T240.decorrenza = (select max(decorrenza)'
      '                             from t240_organizzazionisindacali'
      '                             where codice = T240.codice '
      '                             and decorrenza <= :data);'
      '  exception'
      '    when no_data_found then'
      '      giustif:=null;'
      '  end;'
      '  --Cancellazione vecchio giustificativo'
      '  if (:stato <> '#39'I'#39') and (giustif_old is not null) then'
      '    :sindacato_old:=null;'
      '    delete from t040_giustificativi where '
      '      progressivo = :progressivo and'
      '      data = :data_old and'
      '      causale = giustif_old and'
      '      tipogiust = :tipogiust_old and'
      '      daore = to_date('#39'30121899'#39'||:daore_old,'#39'ddmmyyyysssss'#39')'
      '      and rownum = 1;'
      '  end if;'
      '  --Inserimento nuovo giustificativo'
      '  if (:stato <> '#39'C'#39') and (giustif is not null) then'
      '    :sindacato:=null;'
      '    p:=0;'
      '    while p >= 0 loop'
      '      begin'
      '      if :tipogiust = '#39'D'#39' then'
      '        aore:=to_date('#39'30121899'#39'||:aore,'#39'ddmmyyyysssss'#39');'
      '      else'
      '        aore:=null;'
      '      end if;'
      '      insert into t040_giustificativi '
      
        '        (progressivo,causale,data,daore,aore,progrcausale,tipogi' +
        'ust)'
      '      values'
      
        '        (:progressivo,giustif,:data,to_date('#39'30121899'#39'||:daore,'#39 +
        'ddmmyyyysssss'#39'),aore,p,:tipogiust);'
      '      p:=-1;'
      '      exception'
      '        when dup_val_on_index then'
      '          p:=p + 1;'
      '      end;'
      '    end loop;'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      040000000D0000000C0000003A0053005400410054004F000500000000000000
      00000000180000003A00500052004F0047005200450053005300490056004F00
      030000000000000000000000120000003A0044004100540041005F004F004C00
      44000C00000000000000000000001C0000003A005400490050004F0047004900
      5500530054005F004F004C0044000500000000000000000000000C0000003A00
      440041004F00520045000300000000000000000000000A0000003A0044004100
      540041000C00000000000000000000000A0000003A0041004F00520045000300
      00000000000000000000140000003A005400490050004F004700490055005300
      5400050000000000000000000000140000003A00440041004F00520045005F00
      4F004C0044000300000000000000000000000A0000003A005400490050004F00
      0500000000000000000000001C0000003A00530049004E004400410043004100
      54004F005F004F004C004400050000000000000000000000140000003A005300
      49004E00440041004300410054004F0005000000000000000000000012000000
      3A005400490050004F005F004F004C004400050000000000000000000000}
    Left = 90
    Top = 116
  end
  object selT240Filtro: TOracleDataSet
    SQL.Strings = (
      
        'SELECT :SINDACATO SINDACATO FROM T030_ANAGRAFICO T030, T430_STOR' +
        'ICO T430, P430_ANAGRAFICO P430'
      'WHERE'
      '  T030.PROGRESSIVO = T430.PROGRESSIVO AND'
      '  :PROGRESSIVO = T030.PROGRESSIVO AND'
      '  :DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE ')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 332
    Top = 16
  end
  object selV010: TOracleDataSet
    SQL.Strings = (
      'select V010.data'
      '  from V010_calendari V010'
      ' where V010.lavorativo = '#39'S'#39
      '   and V010.data > :DATA'
      '   and V010.progressivo = :PROGRESSIVO'
      'order by data')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 272
    Top = 16
  end
  object cdsT248: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'DATA'
        DataType = ftDate
      end
      item
        Name = 'NUMERO_PROT'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DATA_PROT'
        DataType = ftDate
      end
      item
        Name = 'DALLE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ALLE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ORE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ABBATTE_COMPETENZE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'COD_SINDACATO'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'COD_ORGANISMO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'STATO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PROT_MODIFICA'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'DATA_MODIFICA'
        DataType = ftDate
      end
      item
        Name = 'RSU'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'RAGGRUPPAMENTO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'SINDACATI_RAGGRUPPATI'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'TIPO_PERMESSO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PROG_PERMESSO'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterScroll = cdsT248AfterScroll
    OnNewRecord = cdsT248NewRecord
    Left = 480
    Top = 16
    object cdsT248PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object cdsT248DATA: TDateField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object cdsT248NUMERO_PROT: TStringField
      DisplayLabel = 'N.Prot.'
      DisplayWidth = 5
      FieldName = 'NUMERO_PROT'
      Size = 10
    end
    object cdsT248DATA_PROT: TDateField
      DisplayLabel = 'Data Prot.'
      FieldName = 'DATA_PROT'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object cdsT248DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object cdsT248ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object cdsT248ORE: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object cdsT248ABBATTE_COMPETENZE: TStringField
      DisplayLabel = 'Abbat.'
      FieldName = 'ABBATTE_COMPETENZE'
      Size = 1
    end
    object cdsT248COD_SINDACATO: TStringField
      DisplayLabel = 'Sindacato'
      FieldName = 'COD_SINDACATO'
      Size = 10
    end
    object cdsT248COD_ORGANISMO: TStringField
      DisplayLabel = 'Organismo'
      FieldName = 'COD_ORGANISMO'
      Size = 5
    end
    object cdsT248STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Size = 1
    end
    object cdsT248PROT_MODIFICA: TStringField
      DisplayLabel = 'Prot.Mod.'
      DisplayWidth = 5
      FieldName = 'PROT_MODIFICA'
      Size = 10
    end
    object cdsT248DATA_MODIFICA: TDateField
      DisplayLabel = 'Data Mod.'
      FieldName = 'DATA_MODIFICA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object cdsT248RSU: TStringField
      FieldName = 'RSU'
      Visible = False
      Size = 1
    end
    object cdsT248RAGGRUPPAMENTO: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Visible = False
      Size = 1
    end
    object cdsT248SINDACATI_RAGGRUPPATI: TStringField
      FieldName = 'SINDACATI_RAGGRUPPATI'
      Visible = False
      Size = 200
    end
    object cdsT248TIPO_PERMESSO: TStringField
      FieldName = 'TIPO_PERMESSO'
      Size = 1
    end
    object cdsT248PROG_PERMESSO: TIntegerField
      FieldName = 'PROG_PERMESSO'
      Visible = False
    end
  end
  object dsrT240C: TDataSource
    AutoEdit = False
    DataSet = selT240C
    Left = 408
    Top = 64
  end
  object selT240C: TOracleDataSet
    SQL.Strings = (
      
        'select distinct T240.codice, T240.descrizione, T240.rsu, t240.ra' +
        'ggruppamento, T240.sindacati_raggruppati, t240.filtro'
      
        'from t240_organizzazionisindacali T240, t242_competenzesindacati' +
        ' T242'
      'where '
      
        '  T240.decorrenza = (select max(decorrenza) from t240_organizzaz' +
        'ionisindacali where codice = T240.CODICE and decorrenza < :DATA)' +
        ' '
      'and '
      '  (:COMPETENZE = '#39'N'#39' OR'
      '   :COMPETENZE = '#39'S'#39' and'
      '   T242.Codice = T240.Codice and'
      
        '   :data between t242.decorrenza and nvl(t242.scadenza,to_date('#39 +
        '31123999'#39','#39'ddmmyyyy'#39')) )'
      'order by codice,descrizione')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000160000003A0043004F004D0050004500540045004E005A00450005000000
      0000000000000000}
    Left = 408
    Top = 16
  end
  object selCompetenze: TOracleDataSet
    SQL.Strings = (
      'select'
      
        'selA.area_sindacale, selA.tipo, selA.competenza, selA.decorrenza' +
        ', selA.scadenza,'
      
        'minutiore(sum(decode(t430.progressivo,null,0,oreminuti(selA.ore)' +
        '))) fruito, '
      
        'minutiore(oreminuti(selA.competenza) - sum(decode(t430.progressi' +
        'vo,null,0,oreminuti(selA.ore)))) residuo'
      'from '
      '('
      
        'select * from  t242_competenzesindacati t242, t248_permessisinda' +
        'cali T248'
      'where t242.codice = :CODICE'
      '  and t242.area_sindacale = (select contratto'
      '                               from T430_Storico'
      '                              where progressivo = :PROGRESSIVO'
      
        '                                and :DATA between datadecorrenza' +
        ' and datafine and rownum = 1)'
      
        '  and :DATA between t242.decorrenza and nvl(t242.scadenza,to_dat' +
        'e('#39'31123999'#39','#39'ddmmyyyy'#39'))'
      ''
      
        '  and T248.data(+) between T242.DECORRENZA and nvl(t242.scadenza' +
        ',to_date('#39'31123999'#39','#39'ddmmyyyy'#39'))'
      '  and T248.abbatte_competenze (+) = '#39'S'#39
      '  and nvl(T248.stato,'#39'O'#39') in ('#39'O'#39','#39'M'#39')'
      '  and T248.cod_sindacato (+) = :CODICE'
      '  :NUMRIGA'
      ')'
      'selA, t430_storico t430  '
      'where'
      '  selA.progressivo = t430.progressivo(+) '
      
        '  and selA.data between t430.datadecorrenza(+) and t430.datafine' +
        '(+)'
      '  and selA.area_sindacale = t430.contratto(+)'
      
        '  and ((selA.tipo = '#39'I'#39' and nvl(T430.progressivo,:PROGRESSIVO) =' +
        ' :PROGRESSIVO)'
      '       or (selA.tipo = '#39'C'#39'))'
      
        'group by selA.area_sindacale, selA.tipo, selA.competenza, selA.d' +
        'ecorrenza, selA.scadenza')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0043004F004400490043004500050000000000
      0000000000000A0000003A0044004100540041000C0000000000000000000000
      180000003A00500052004F0047005200450053005300490056004F0003000000
      0000000000000000100000003A004E0055004D00520049004700410001000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000001400000043004F004D0050004500540045004E005A004100
      0100000000000C000000460052005500490054004F000100000000000E000000
      5200450053004900440055004F000100000000001C0000004100520045004100
      5F00530049004E0044004100430041004C004500010000000000140000004400
      450043004F005200520045004E005A0041000100000000001000000053004300
      4100440045004E005A004100010000000000080000005400490050004F000100
      00000000}
    Left = 200
    Top = 16
    object selCompetenzeAREA_SINDACALE: TStringField
      DisplayLabel = 'Contr.'
      DisplayWidth = 5
      FieldName = 'AREA_SINDACALE'
      Required = True
    end
    object selCompetenzeTIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 1
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
    object selCompetenzeDECORRENZA: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selCompetenzeSCADENZA: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'SCADENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selCompetenzeCOMPETENZA: TStringField
      DisplayLabel = 'Competenze'
      DisplayWidth = 10
      FieldName = 'COMPETENZA'
      Size = 7
    end
    object selCompetenzeFRUITO: TStringField
      DisplayLabel = 'Fruito'
      DisplayWidth = 10
      FieldName = 'FRUITO'
      Size = 4000
    end
    object selCompetenzeRESIDUO: TStringField
      DisplayLabel = 'Residuo'
      DisplayWidth = 10
      FieldName = 'RESIDUO'
      Size = 4000
    end
  end
  object dsrCompetenze: TDataSource
    DataSet = selCompetenze
    Left = 200
    Top = 61
  end
  object selT245: TOracleDataSet
    SQL.Strings = (
      'select codice, descrizione '
      '  from t245_organismisindacali T245'
      'order by codice, descrizione')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 124
    Top = 16
  end
  object dsrT245: TDataSource
    AutoEdit = False
    DataSet = selT245
    Left = 124
    Top = 62
  end
  object selT240: TOracleDataSet
    SQL.Strings = (
      
        'select distinct T240.codice, T240.descrizione, T240.rsu, t240.ra' +
        'ggruppamento, T240.sindacati_raggruppati, t240.filtro, :progress' +
        'ivo progressivo'
      
        'from t240_organizzazionisindacali T240, T247_partecipazionisinda' +
        'cati T247, t242_competenzesindacati T242, t430_storico t430'
      'where '
      
        '  T240.decorrenza = (select max(decorrenza) from t240_organizzaz' +
        'ionisindacali where codice = T240.CODICE and decorrenza < :DATA)' +
        ' and'
      
        '  ((T240.raggruppamento = '#39'N'#39' and T240.codice = T247.COD_SINDACA' +
        'TO) or'
      
        '   (T240.raggruppamento = '#39'S'#39'  and '#39','#39' || T240.sindacati_raggrup' +
        'pati || '#39','#39' like '#39'%,'#39' || T247.cod_sindacato || '#39'%,'#39')) and'
      '  T247.progressivo = :PROGRESSIVO and'
      
        '  :data between T247.dadata and nvl(T247.adata,to_date('#39'31123999' +
        #39','#39'ddmmyyyy'#39')) and '
      '  t430.progressivo = :progressivo and'
      '  :data between t430.datadecorrenza and t430.datafine and '
      '  (:COMPETENZE = '#39'N'#39' OR'
      '   :COMPETENZE = '#39'S'#39' and'
      '   T242.Codice = T240.Codice and'
      
        '   :data between t242.decorrenza and nvl(t242.scadenza,to_date('#39 +
        '31123999'#39','#39'ddmmyyyy'#39')) and'
      '   t242.area_sindacale = T430.CONTRATTO)'
      'order by codice,descrizione')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000160000003A0043004F004D0050004500540045004E00
      5A004500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000000600
      00005200530055000100000000001C0000005200410047004700520055005000
      500041004D0045004E0054004F000100000000002A000000530049004E004400
      410043004100540049005F005200410047004700520055005000500041005400
      4900010000000000}
    AfterOpen = selT240AfterOpen
    OnFilterRecord = selT240FilterRecord
    Left = 75
    Top = 16
  end
  object dsrT240: TDataSource
    AutoEdit = False
    DataSet = selT240
    Left = 75
    Top = 61
  end
  object selT248Canc: TOracleDataSet
    SQL.Strings = (
      'select T248.*, T248.ROWID '
      'from T248_PERMESSISINDACALI T248'
      'where DATA = :DATA'
      '  and NVL(DALLE,'#39'X'#39') = NVL(:DALLE,'#39'X'#39')'
      '  and NVL(ALLE,'#39'X'#39') = NVL(:ALLE,'#39'X'#39')'
      '  and NVL(ORE,'#39'X'#39') = NVL(:ORE,'#39'X'#39')'
      '  and ABBATTE_COMPETENZE = :ABBATTE'
      '  and COD_SINDACATO = :COD_SINDACATO'
      '  and COD_ORGANISMO = :COD_ORGANISMO'
      '  and NVL(NUMERO_PROT,'#39'X'#39') = NVL(:NUMERO_PROT,'#39'X'#39')'
      '  and DATA_PROT = :DATA_PROT'
      '  and ((:TIPO = '#39'C'#39') or '
      
        '       (:TIPO = '#39'E'#39' and NVL(PROT_MODIFICA,'#39'X'#39') = NVL(:PROT_MODIF' +
        'ICA,'#39'X'#39') and DATA_MODIFICA = :DATA_MODIFICA))'
      '  and PROGRESSIVO in :SELC700'
      'order by PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      040000000D0000000A0000003A0044004100540041000C000000000000000000
      00000C0000003A00440041004C004C0045000500000000000000000000000A00
      00003A0041004C004C004500050000000000000000000000080000003A004F00
      52004500050000000000000000000000100000003A0041004200420041005400
      540045000500000000000000000000001C0000003A0043004F0044005F005300
      49004E00440041004300410054004F000500000000000000000000001C000000
      3A0043004F0044005F004F005200470041004E00490053004D004F0005000000
      0000000000000000180000003A004E0055004D00450052004F005F0050005200
      4F005400050000000000000000000000140000003A0044004100540041005F00
      500052004F0054000C0000000000000000000000100000003A00530045004C00
      43003700300030000100000000000000000000000A0000003A00540049005000
      4F000500000000000000000000001C0000003A00500052004F0054005F004D00
      4F004400490046004900430041000500000000000000000000001C0000003A00
      44004100540041005F004D004F004400490046004900430041000C0000000000
      000000000000}
    Left = 20
    Top = 58
  end
  object selT247InsColl: TOracleDataSet
    SQL.Strings = (
      'SELECT T030.PROGRESSIVO'
      'FROM T030_ANAGRAFICO T030, V430_STORICO V430'
      'WHERE T030.PROGRESSIVO = V430.T430PROGRESSIVO'
      
        'AND :DATALAVORO BETWEEN V430.T430DATADECORRENZA AND V430.T430DAT' +
        'AFINE'
      ':FILTRO_T240'
      'AND T030.PROGRESSIVO IN '
      '(SELECT DISTINCT T247.PROGRESSIVO'
      
        ' FROM t240_organizzazionisindacali T240, T247_partecipazionisind' +
        'acati T247, t242_competenzesindacati T242, t430_storico t430'
      
        ' WHERE T240.decorrenza = (select max(decorrenza) from t240_organ' +
        'izzazionisindacali'
      
        '                          where codice = T240.CODICE and decorre' +
        'nza < :DATALAVORO)'
      
        ' AND (   (T240.raggruppamento = '#39'N'#39' and T240.codice = T247.COD_S' +
        'INDACATO) '
      
        '      OR (T240.raggruppamento = '#39'S'#39' and '#39','#39' || T240.sindacati_ra' +
        'ggruppati || '#39','#39' like '#39'%,'#39' || T247.cod_sindacato || '#39'%,'#39'))'
      ' AND T247.COD_SINDACATO = :COD_SINDACATO'
      
        ' AND :datalavoro between T247.dadata and nvl(T247.adata,to_date(' +
        #39'31123999'#39','#39'ddmmyyyy'#39'))'
      ' AND T247.PROGRESSIVO = T430.PROGRESSIVO'
      ' AND :datalavoro between t430.datadecorrenza and t430.datafine'
      ' AND (   :ABBATTE_COMPETENZE <> '#39'S'#39' '
      '      OR (    T242.Codice = T247.COD_SINDACATO '
      
        '          and :datalavoro between t242.decorrenza and nvl(t242.s' +
        'cadenza,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')) '
      '          and t242.area_sindacale = T430.CONTRATTO)))')
    Optimize = False
    Variables.Data = {
      0400000004000000160000003A0044004100540041004C00410056004F005200
      4F000C0000000000000000000000180000003A00460049004C00540052004F00
      5F0054003200340030000100000000000000000000001C0000003A0043004F00
      44005F00530049004E00440041004300410054004F0005000000000000000000
      0000260000003A0041004200420041005400540045005F0043004F004D005000
      4500540045004E005A004500050000000000000000000000}
    Left = 296
    Top = 120
  end
end
