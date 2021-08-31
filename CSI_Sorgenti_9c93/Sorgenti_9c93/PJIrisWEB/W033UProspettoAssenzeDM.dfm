object W033FProspettoAssenzeDM: TW033FProspettoAssenzeDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 171
  Width = 542
  object selT050: TOracleDataSet
    SQL.Strings = (
      
        'SELECT VT050.PROGRESSIVO, VT050.CAUSALE, VT050.TIPOGIUST, VT050.' +
        'CSI_TIPO_MG, DECODE(VT050.TIPOGIUST,'#39'I'#39',1,'#39'M'#39',2,'#39'N'#39',3,'#39'D'#39',4) SOR' +
        'T_TIPOGIUST, V010.DATA, VT050.TIPO_RICHIESTA, VT050.STATO, VT050' +
        '.NUMEROORE DAORE, VT050.AORE, VT050.ID'
      'FROM VT050_RICHIESTE_SENZAREVOCA VT050, V010_CALENDARI V010'
      'WHERE VT050.PROGRESSIVO :filtro_dip'
      'AND VT050.DAL <= :AL AND VT050.AL >= :DAL'
      'AND VT050.ELABORATO = '#39'N'#39
      'AND NVL(VT050.STATO,'#39'S'#39') = '#39'S'#39
      
        'AND (   EXISTS (SELECT 1 FROM T265_CAUASSENZE T265 WHERE T265.CO' +
        'DICE = VT050.CAUSALE)'
      '     OR (    :PRESENZE = '#39'S'#39' '
      
        '         AND EXISTS (SELECT 1 FROM T275_CAUPRESENZE T275 WHERE T' +
        '275.CODICE = VT050.CAUSALE)))'
      
        'AND not exists (select '#39'X'#39' from VT050_RICHIESTEASSENZA where TIP' +
        'O_RICHIESTA = '#39'C'#39' and nvl(STATO,'#39'S'#39') = '#39'S'#39' and ID_REVOCATO = VT0' +
        '50.ID and V010.DATA between DAL and AL)'
      'AND V010.PROGRESSIVO = VT050.PROGRESSIVO'
      'AND V010.DATA BETWEEN VT050.DAL AND VT050.AL'
      'UNION ALL'
      
        'SELECT VT050.PROGRESSIVO, VT050.CAUSALE, VT050.TIPOGIUST, VT050.' +
        'CSI_TIPO_MG, DECODE(VT050.TIPOGIUST,'#39'I'#39',1,'#39'M'#39',2,'#39'N'#39',3,'#39'D'#39',4) SOR' +
        'T_TIPOGIUST, V010.DATA, VT050.TIPO_RICHIESTA, VT050.STATO, VT050' +
        '.NUMEROORE DAORE, VT050.AORE, VT050.ID'
      'FROM VT050_RICHIESTEASSENZA VT050, V010_CALENDARI V010'
      'WHERE VT050.PROGRESSIVO :filtro_dip'
      'AND VT050.DAL <= :AL AND VT050.AL >= :DAL'
      'AND VT050.ELABORATO = '#39'N'#39
      'AND VT050.TIPO_RICHIESTA = '#39'C'#39
      'AND VT050.STATO is null'
      
        'AND (   EXISTS (SELECT 1 FROM T265_CAUASSENZE T265 WHERE T265.CO' +
        'DICE = VT050.CAUSALE)'
      '     OR (    :PRESENZE = '#39'S'#39' '
      
        '         AND EXISTS (SELECT 1 FROM T275_CAUPRESENZE T275 WHERE T' +
        '275.CODICE = VT050.CAUSALE)))'
      'AND V010.PROGRESSIVO = VT050.PROGRESSIVO'
      'AND V010.DATA BETWEEN VT050.DAL AND VT050.AL'
      'ORDER BY PROGRESSIVO, DATA, SORT_TIPOGIUST, DAORE, AORE, CAUSALE'
      '')
    ReadBuffer = 10
    Optimize = False
    Variables.Data = {
      0400000004000000060000003A0041004C000C00000000000000000000000800
      00003A00440041004C000C0000000000000000000000160000003A0046004900
      4C00540052004F005F0044004900500001000000000000000000000012000000
      3A00500052004500530045004E005A004500050000000000000000000000}
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T050_ID'
    SequenceField.ApplyMoment = amOnNewRecord
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Filtered = True
    Left = 61
    Top = 8
  end
  object selT100: TOracleDataSet
    SQL.Strings = (
      'SELECT T100.PROGRESSIVO,T100.DATA,COUNT(*) N_TIMB'
      'FROM T100_TIMBRATURE T100,'
      '    (SELECT PROGRESSIVO,DATA,COUNT(*) N_TIMB'
      '    FROM T100_TIMBRATURE '
      '    WHERE PROGRESSIVO :filtro_dip  '
      '    AND DATA BETWEEN :DAL AND :AL '
      '    AND FLAG IN ('#39'O'#39','#39'I'#39')'
      '    GROUP BY PROGRESSIVO,DATA) A'
      'WHERE T100.PROGRESSIVO = A.PROGRESSIVO'
      'AND T100.DATA = A.DATA'
      'AND T100.FLAG IN ('#39'O'#39','#39'I'#39')'
      'AND (A.N_TIMB > 1 '
      '     OR T100.VERSO = '#39'E'#39
      '     OR NOT EXISTS (SELECT 1 FROM T100_TIMBRATURE B'
      '                    WHERE B.PROGRESSIVO = T100.PROGRESSIVO'
      '                    AND B.DATA = T100.DATA - 1'
      '                    AND B.FLAG IN ('#39'O'#39','#39'I'#39')'
      '                    AND B.ORA = (SELECT MAX(ORA)'
      '                                 FROM T100_TIMBRATURE C'
      
        '                                 WHERE C.PROGRESSIVO = B.PROGRES' +
        'SIVO'
      '                                 AND C.DATA = B.DATA'
      '                                 AND C.FLAG IN ('#39'O'#39','#39'I'#39'))'
      '                    AND B.VERSO = '#39'E'#39'))'
      'GROUP BY T100.PROGRESSIVO,T100.DATA'
      'ORDER BY T100.PROGRESSIVO,T100.DATA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000003000000080000003A00440041004C000C0000000000000000000000
      060000003A0041004C000C0000000000000000000000160000003A0046004900
      4C00540052004F005F00440049005000010000000000000000000000}
    Left = 110
    Top = 8
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      
        'SELECT PROGRESSIVO, DATA, CAUSALE, TIPOGIUST, CSI_TIPO_MG, TO_CH' +
        'AR(DAORE,'#39'HH24.MI'#39') DAORE, TO_CHAR(AORE,'#39'HH24.MI'#39') AORE, ID_RICH' +
        'IESTA'
      'FROM T040_GIUSTIFICATIVI T040'
      'WHERE PROGRESSIVO :filtro_dip'
      'AND DATA BETWEEN :DAL AND :AL'
      
        'AND (   EXISTS (SELECT 1 FROM T265_CAUASSENZE T265 WHERE T265.CO' +
        'DICE = T040.CAUSALE)'
      '     OR (    :PRESENZE = '#39'S'#39' '
      
        '         AND EXISTS (SELECT 1 FROM T275_CAUPRESENZE T275 WHERE T' +
        '275.CODICE = T040.CAUSALE)))'
      
        'AND exists (select '#39'X'#39' from dual where T050F_CANCELLATA(T040.ID_' +
        'RICHIESTA,T040.DATA) = '#39'N'#39')'
      
        'ORDER BY PROGRESSIVO, DATA, DECODE(TIPOGIUST,'#39'I'#39',1,'#39'M'#39',2,'#39'N'#39',3,'#39 +
        'D'#39',4), DAORE, AORE, CAUSALE')
    ReadBuffer = 33
    Optimize = False
    Variables.Data = {
      0400000004000000080000003A00440041004C000C0000000000000000000000
      060000003A0041004C000C0000000000000000000000160000003A0046004900
      4C00540052004F005F0044004900500001000000000000000000000012000000
      3A00500052004500530045004E005A004500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000B00000016000000500052004F004700520045005300530049005600
      4F000100000000000800000044004100540041000100000000000E0000004300
      41005500530041004C00450001000000000018000000500052004F0047005200
      430041005500530041004C004500010000000000120000005400490050004F00
      470049005500530054000100000000000A000000440041004F00520045000100
      000000000800000041004F00520045000100000000000C000000530043004800
      4500440041000100000000000C0000005300540041004D005000410001000000
      00000E00000044004100540041004E0041005300010000000000160000004400
      450053004300520049005A0049004F004E004500010000000000}
    Left = 12
    Top = 8
  end
  object cdsListaTimb: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 288
    Top = 8
  end
  object cdsLista: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 167
    Top = 8
  end
  object cdsListaPag: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 222
    Top = 8
  end
  object cdsListaAss: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 352
    Top = 8
  end
  object T010F_GGLAVORATIVO: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  :LAVORATIVO:=T010F_GGLAVORATIVO(:PROGRESSIVO,:DATA);'
      'END;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000160000003A004C00410056004F005200410054004900
      56004F00050000000000000000000000}
    Left = 450
    Top = 8
  end
  object selaT050: TOracleDataSet
    SQL.Strings = (
      'select  '
      '        T050.ROWID,'
      
        '        T050.ID,T050.PROGRESSIVO,T050.CAUSALE,T050.TIPOGIUST,T05' +
        '0.CSI_TIPO_MG,T050.DAL,T050.AL,T050.NUMEROORE,T050.DATANAS,T050.' +
        'AORE,T050.ELABORATO,T050.NUMEROORE_PREV,T050.AORE_PREV,'
      
        '        T850.STATO AUTORIZZAZIONE,T850.NOTE NOTE1,T850.DATA DATA' +
        '_RICHIESTA,T850.TIPO_RICHIESTA,T850.ID_REVOCA,T850.ID_REVOCATO,T' +
        '850.AUTORIZZ_AUTOMATICA,T850.COD_ITER,'
      
        '        T030A.MATRICOLA, T030A.COGNOME || '#39' '#39' || T030A.NOME NOMI' +
        'NATIVO, T030A.SESSO,'
      
        '        decode(T850.TIPO_RICHIESTA,'#39'P'#39',decode(T851P.STATO,null,n' +
        'ull,'#39'N'#39','#39'N'#39','#39'S'#39'),T850.STATO) AUTORIZZ_UTILE,'
      
        '        I060F_NOMINATIVO(:AZIENDA, T851A.RESPONSABILE) NOMINATIV' +
        'O_RESP,'
      '        T851A.RESPONSABILE RESPONSABILE,'
      '        T851A.NOTE NOTE2,'
      '        T851A.DATA DATA_AUTORIZZAZIONE,'
      '        decode(T851P.STATO,null,null,'#39'N'#39','#39'N'#39','#39'S'#39') AUTORIZZ_PREV,'
      '        T851P.DATA DATA_AUTORIZZ_PREV,'
      '        T851P.AUTORIZZ_AUTOMATICA AUTORIZZ_AUTOM_PREV, '
      '        T851P.RESPONSABILE RESPONSABILE_PREV,'
      '        T850R.STATO AUTORIZZ_REVOCA,'
      
        '        T851F_REVOCABILE(:AZIENDA, :ITER, T850.COD_ITER , T850.I' +
        'D) REVOCABILE'
      'from    T050_RICHIESTEASSENZA T050,  '
      '        T850_ITER_RICHIESTE T850,'
      '        T850_ITER_RICHIESTE T850R,'
      '        T851_ITER_AUTORIZZAZIONI T851P,'
      '        T851_ITER_AUTORIZZAZIONI T851A,'
      '        T030_ANAGRAFICO T030A'
      'where   exists (select PROGRESSIVO from '
      '                :QVISTAORACLE'
      '                :FILTRO_ANAG  '
      '                and T030A.PROGRESSIVO = T030.PROGRESSIVO'
      '                )'
      'and     T050.PROGRESSIVO = T030A.PROGRESSIVO'
      '/*C018*/and T850.ITER = :ITER and T850.ID = T050.ID '
      
        '/*C018*/and T850R.ITER(+) = :ITER and T850R.ID(+) = T850.ID_REVO' +
        'CA '
      
        '/*C018*/and T851P.ID(+) = T850.ID and T851P.LIVELLO(+) = :LIVELL' +
        'O_INTERMEDIO'
      
        '/*C018*/and T851A.ID(+) = T850.ID and T851A.LIVELLO(+) = :LIVELL' +
        'O_AUTORIZZAZIONE'
      '        :FILTRO_VISUALIZZAZIONE'
      '        :FILTRO_PERIODO'
      
        'order by NOMINATIVO, T030A.MATRICOLA, T050.DAL DESC, T050.TIPOGI' +
        'UST, T050.NUMEROORE, T050.CAUSALE, T850.DATA DESC')
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00460049004C00540052004F005F0041004E00
      41004700010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C00000000000000000000001A0000003A0051005600
      49005300540041004F005200410043004C004500010000000000000000000000
      1E0000003A00460049004C00540052004F005F0050004500520049004F004400
      4F000100000000000000000000002E0000003A00460049004C00540052004F00
      5F00560049005300550041004C0049005A005A0041005A0049004F004E004500
      0100000000000000000000000A0000003A004900540045005200050000000000
      000000000000260000003A004C004900560045004C004C004F005F0049004E00
      5400450052004D004500440049004F0001000000000000000000000010000000
      3A0041005A00490045004E00440041000500000000000000000000002E000000
      3A004C004900560045004C004C004F005F004100550054004F00520049005A00
      5A0041005A0049004F004E004500010000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    UpdatingTable = 'T050_RICHIESTEASSENZA'
    CommitOnPost = False
    Filtered = True
    OnCalcFields = selaT050CalcFields
    Left = 61
    Top = 64
    object FloatField1: TFloatField
      FieldName = 'ID'
    end
    object FloatField2: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object FloatField3: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object IntegerField1: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object StringField1: TStringField
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object StringField2: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object StringField3: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object StringField4: TStringField
      FieldName = 'COD_ITER'
    end
    object StringField5: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object StringField6: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object StringField7: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy hhhh.nn'
    end
    object FloatField4: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object StringField8: TStringField
      DisplayLabel = ' '
      FieldName = 'AUTORIZZAZIONE'
      Visible = False
      Size = 1
    end
    object StringField9: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 61
    end
    object StringField10: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object StringField11: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object StringField12: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object StringField13: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object StringField14: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object StringField15: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object StringField16: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object StringField17: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object StringField18: TStringField
      FieldName = 'ELABORATO'
      Size = 1
    end
    object StringField19: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_ELABORATO'
      Size = 10
      Calculated = True
    end
    object DateTimeField3: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DAL'
    end
    object DateTimeField4: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'AL'
    end
    object StringField20: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Visible = False
      Size = 5
    end
    object StringField21: TStringField
      FieldName = 'TIPOGIUST'
      Visible = False
      Size = 1
    end
    object selaT050CSI_TIPO_MG: TStringField
      FieldName = 'CSI_TIPO_MG'
      Size = 1
    end
    object StringField22: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'NUMEROORE'
      Size = 5
    end
    object StringField23: TStringField
      FieldName = 'AORE'
      Size = 5
    end
    object DateTimeField5: TDateTimeField
      DisplayLabel = 'Familiare'
      FieldName = 'DATANAS'
      DisplayFormat = 'dd/mm/yyyy hh.nn'
    end
    object StringField24: TStringField
      FieldName = 'NUMEROORE_PREV'
      Size = 5
    end
    object StringField25: TStringField
      FieldName = 'AORE_PREV'
      Size = 5
    end
    object StringField26: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CAUSALE'
      Size = 100
      Calculated = True
    end
    object StringField27: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CAUSALE_2'
      Size = 100
      Calculated = True
    end
    object StringField28: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPOGIUST'
      Calculated = True
    end
    object StringField29: TStringField
      DisplayLabel = 'Ore'
      FieldKind = fkCalculated
      FieldName = 'D_DAORE_AORE'
      Size = 13
      Calculated = True
    end
    object StringField30: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_DAORE_AORE_PREV'
      Size = 13
      Calculated = True
    end
    object StringField31: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_VISTI_PREC'
      Size = 30
      Calculated = True
    end
    object StringField32: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AVVERTIMENTI'
      Size = 1
      Calculated = True
    end
    object selaT050D_CSI_TIPO_MG: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CSI_TIPO_MG'
      Size = 10
      Calculated = True
    end
  end
  object cdsT050: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 110
    Top = 64
  end
  object dsrT050: TDataSource
    DataSet = cdsT050
    Left = 158
    Top = 64
  end
  object T010F_GGSIGNIFICATIVO: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  :SIGNIFICATIVO:=T010F_GGSIGNIFICATIVO(:PROGRESSIVO,:DATA,:GSIG' +
        'NIFIC);'
      'END;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000001C0000003A005300490047004E004900460049004300
      41005400490056004F00050000000000000000000000140000003A0047005300
      490047004E004900460049004300050000000000000000000000}
    Left = 450
    Top = 64
  end
  object D010: TDataSource
    Left = 12
    Top = 65
  end
  object selSQL: TOracleDataSet
    Optimize = False
    Left = 216
    Top = 66
  end
  object selT050Canc: TOracleDataSet
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00460049004C00540052004F005F0041004E00
      41004700010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C00000000000000000000001A0000003A0051005600
      49005300540041004F005200410043004C004500010000000000000000000000
      1E0000003A00460049004C00540052004F005F0050004500520049004F004400
      4F000100000000000000000000002E0000003A00460049004C00540052004F00
      5F00560049005300550041004C0049005A005A0041005A0049004F004E004500
      0100000000000000000000000A0000003A004900540045005200050000000000
      000000000000260000003A004C004900560045004C004C004F005F0049004E00
      5400450052004D004500440049004F0001000000000000000000000010000000
      3A0041005A00490045004E00440041000500000000000000000000002E000000
      3A004C004900560045004C004C004F005F004100550054004F00520049005A00
      5A0041005A0049004F004E004500010000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    UpdatingTable = 'T050_RICHIESTEASSENZA'
    CommitOnPost = False
    Filtered = True
    OnCalcFields = selaT050CalcFields
    Left = 61
    Top = 120
    object FloatField5: TFloatField
      FieldName = 'ID'
    end
    object FloatField6: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object FloatField7: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object IntegerField2: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object StringField33: TStringField
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object StringField34: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object StringField35: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object StringField36: TStringField
      FieldName = 'COD_ITER'
    end
    object StringField37: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object StringField38: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object StringField39: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object DateTimeField6: TDateTimeField
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy hhhh.nn'
    end
    object FloatField8: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object DateTimeField7: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object StringField40: TStringField
      DisplayLabel = ' '
      FieldName = 'AUTORIZZAZIONE'
      Visible = False
      Size = 1
    end
    object StringField41: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 61
    end
    object StringField42: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object StringField43: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object StringField44: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object StringField45: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object StringField46: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object StringField47: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object StringField48: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object StringField49: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object StringField50: TStringField
      FieldName = 'ELABORATO'
      Size = 1
    end
    object StringField51: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_ELABORATO'
      Size = 10
      Calculated = True
    end
    object DateTimeField8: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DAL'
    end
    object DateTimeField9: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'AL'
    end
    object StringField52: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Visible = False
      Size = 5
    end
    object StringField53: TStringField
      FieldName = 'TIPOGIUST'
      Visible = False
      Size = 1
    end
    object StringField54: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'NUMEROORE'
      Size = 5
    end
    object StringField55: TStringField
      FieldName = 'AORE'
      Size = 5
    end
    object DateTimeField10: TDateTimeField
      DisplayLabel = 'Familiare'
      FieldName = 'DATANAS'
      DisplayFormat = 'dd/mm/yyyy hh.nn'
    end
    object StringField56: TStringField
      FieldName = 'NUMEROORE_PREV'
      Size = 5
    end
    object StringField57: TStringField
      FieldName = 'AORE_PREV'
      Size = 5
    end
    object StringField58: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CAUSALE'
      Size = 100
      Calculated = True
    end
    object StringField59: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CAUSALE_2'
      Size = 100
      Calculated = True
    end
    object StringField60: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPOGIUST'
      Calculated = True
    end
    object StringField61: TStringField
      DisplayLabel = 'Ore'
      FieldKind = fkCalculated
      FieldName = 'D_DAORE_AORE'
      Size = 13
      Calculated = True
    end
    object StringField62: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_DAORE_AORE_PREV'
      Size = 13
      Calculated = True
    end
    object StringField63: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_VISTI_PREC'
      Size = 30
      Calculated = True
    end
    object StringField64: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AVVERTIMENTI'
      Size = 1
      Calculated = True
    end
  end
  object selCausali: TOracleDataSet
    SQL.Strings = (
      
        'select '#39'A'#39' tipo, t265.codice, t265.descrizione, t265.sigla_causa' +
        'le'
      'from   t265_cauassenze t265'
      'union all'
      'select '#39'P'#39', t275.codice, t275.descrizione, t275.sigla'
      'from   t275_caupresenze t275'
      'order by 1, 2')
    Optimize = False
    Left = 268
    Top = 67
  end
end
