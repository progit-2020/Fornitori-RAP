inherited A145FComVisiteFiscaliMW: TA145FComVisiteFiscaliMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 343
  Width = 736
  object selT485: TOracleDataSet
    SQL.Strings = (
      'select * from ('
      'select CODICE, DESCRIZIONE'
      'from   T485_MEDICINELEGALI T485'
      'union'
      'select null, null from DUAL)'
      'order by nvl(CODICE,'#39' '#39')')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    ReadOnly = True
    Left = 183
    Top = 118
  end
  object selT047UltimaCom: TOracleDataSet
    SQL.Strings = (
      '-- estrae la data di ultima comunicazione effettuata'
      '-- (considera anche le comunicazioni di prolungamento periodo)'
      
        'select nvl(max(DATA_PRIMA_COMUNICAZIONE), to_date('#39'01/01/1800'#39','#39 +
        'DD/MM/YYYY'#39')), '
      
        '       nvl(max(DATA_COMUN_PROLUNGAMENTO), to_date('#39'01/01/1800'#39','#39 +
        'DD/MM/YYYY'#39')) '
      'from T047_VISITEFISCALI'
      'where TIPO_EVENTO = '#39'01'#39)
    Optimize = False
    Left = 312
    Top = 129
  end
  object selT047CompensaIns: TOracleDataSet
    SQL.Strings = (
      
        '-- estrae tutte le operazioni di inserimento non ancora comunica' +
        'te'
      
        '-- (primo periodo non comunicato oppure oppure prolungamento non' +
        ' comunicato)'
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       OPERAZIONE = '#39'I'#39' and'
      '       ((NUOVA_DATA_FINE is null and'
      '         DATA_PRIMA_COMUNICAZIONE is null) or'
      '        (NUOVA_DATA_FINE is not null and'
      '         DATA_COMUN_PROLUNGAMENTO is null)) and'
      '      nvl(NUOVA_DATA_FINE,DATA_FINE_ASSENZA) >= sysdate'
      'order  by PROGRESSIVO,'
      '          DATA_INIZIO_ASSENZA')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    Left = 45
    Top = 192
  end
  object selT047CancInterne: TOracleDataSet
    SQL.Strings = (
      '-- estrae i periodi cancellati interni ad un periodo definito'
      '-- ordinati per data di inizio assenza'
      'select T047.*,'
      '       T047.rowid'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       PROGRESSIVO = :PROGRESSIVO and'
      '       OPERAZIONE = '#39'C'#39' and'
      '       DATA_INIZIO_ASSENZA >= :DATA_INIZIO_ASSENZA and'
      '       DATA_FINE_ASSENZA <= :DATA_FINE_ASSENZA and'
      '       DATA_PRIMA_COMUNICAZIONE is null'
      'order  by DATA_INIZIO_ASSENZA')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000280000003A0044004100540041005F00
      49004E0049005A0049004F005F0041005300530045004E005A0041000C000000
      0000000000000000240000003A0044004100540041005F00460049004E004500
      5F0041005300530045004E005A0041000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    Left = 150
    Top = 192
  end
  object selT047Add: TOracleDataSet
    SQL.Strings = (
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39)
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    Left = 201
    Top = 66
  end
  object selT047PAnnullato: TOracleDataSet
    SQL.Strings = (
      
        '-- estrae le comunicazioni effettuate in una certa data al fine ' +
        'di annullarle'
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       DATA_COMUN_PROLUNGAMENTO = :DATA_ANNULLAMENTO or'
      '       DATA_PRIMA_COMUNICAZIONE = :DATA_ANNULLAMENTO'
      'order by PROGRESSIVO, OPERAZIONE desc, DATA_INIZIO_ASSENZA'
      
        '-- NOTA: se la data di prima comunicazione '#232' uguale alla data da' +
        ' annullare'
      
        '-- sicuramente DATA_COMUN_PROLUNGAMENTO '#232' null, perch'#233' il contro' +
        'llo a monte'
      '-- verifica che la data da annullare sia l'#39'ultima in assoluto')
    Optimize = False
    Variables.Data = {
      0400000001000000240000003A0044004100540041005F0041004E004E005500
      4C004C0041004D0045004E0054004F000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    BeforePost = selT047PAnnullatoBeforePost
    AfterPost = selT047PAnnullatoAfterPost
    Left = 113
    Top = 66
  end
  object selT047UnificaPeriodi: TOracleDataSet
    SQL.Strings = (
      '-- estrae tutte le operazioni (ins/can) non ancora comunicate'
      
        '-- (primo periodo non comunicato oppure oppure prolungamento non' +
        ' comunicato)'
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       ((OPERAZIONE = '#39'C'#39' and'
      '         DATA_PRIMA_COMUNICAZIONE is null) or'
      '        (OPERAZIONE = '#39'I'#39' and'
      '         (NUOVA_DATA_FINE is null or'
      '          (NUOVA_DATA_FINE is not null and'
      '           DATA_COMUN_PROLUNGAMENTO is null)))) and'
      '      nvl(NUOVA_DATA_FINE,DATA_FINE_ASSENZA) >= sysdate'
      'order by PROGRESSIVO,'
      '         OPERAZIONE,'
      '         DATA_INIZIO_ASSENZA')
    Optimize = False
    Left = 315
    Top = 192
  end
  object selT047PeriodoSucc: TOracleDataSet
    SQL.Strings = (
      '-- estrae un periodo non comunicato consecutivo ad un altro'
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       PROGRESSIVO = :PROGRESSIVO and'
      '       OPERAZIONE = :OPERAZIONE and'
      '       DATA_INIZIO_ASSENZA = :DATA_INIZIO and'
      '       DATA_PRIMA_COMUNICAZIONE is null')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A004F005000450052004100
      5A0049004F004E004500050000000000000000000000180000003A0044004100
      540041005F0049004E0049005A0049004F000C0000000000000000000000}
    Left = 424
    Top = 192
  end
  object selT047: TOracleDataSet
    SQL.Strings = (
      'select T047.*, T047.ROWID, T480.CITTA, T480.CAP, T480.PROVINCIA'
      'from   T047_VISITEFISCALI T047, T480_COMUNI T480'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       PROGRESSIVO = :PROGRESSIVO and'
      '       OPERAZIONE like :OPERAZIONE and'
      '       :PROLUNGAMENTO'
      '       T047.COD_COMUNE = T480.CODICE(+) and'
      '       ('
      '        (:INCLUDI_COMUNICATI = '#39'N'#39' and'
      '         --DATA_INIZIO_ASSENZA <= :DATA_ELABORAZIONE and'
      
        '         --DATA_INIZIO_ASSENZA <= decode(OPERAZIONE,'#39'I'#39',:DATA_EL' +
        'ABORAZIONE,to_date('#39'31123999'#39','#39'ddmmyyyy'#39')) and'
      
        '         DATA_INIZIO_ASSENZA <= decode(OPERAZIONE,'#39'I'#39',decode(:ES' +
        'ENZIONI,'#39'S'#39',to_date('#39'31123999'#39','#39'ddmmyyyy'#39'),:DATA_ELABORAZIONE),t' +
        'o_date('#39'31123999'#39','#39'ddmmyyyy'#39')) and'
      '         ((DATA_FINE_ASSENZA >= :DATA_ELABORAZIONE and'
      '           NUOVA_DATA_FINE is null and'
      '           DATA_PRIMA_COMUNICAZIONE is null) or '
      '          (NUOVA_DATA_FINE >= :DATA_ELABORAZIONE and'
      '           DATA_COMUN_PROLUNGAMENTO is null)'
      '         )) or'
      '        (:INCLUDI_COMUNICATI = '#39'S'#39' and'
      '         (DATA_INIZIO_ASSENZA BETWEEN :DATADA and :DATAA or'
      '          DATA_FINE_ASSENZA BETWEEN :DATADA and :DATAA or'
      '          NUOVA_DATA_FINE BETWEEN :DATADA and :DATAA)) or'
      '        /*Il filtro per data comunicazione*/'
      '        (:INCLUDI_COMUNICATI = '#39'C'#39' and'
      
        '        (nvl(T047.DATA_COMUN_PROLUNGAMENTO,T047.DATA_PRIMA_COMUN' +
        'ICAZIONE) between :DATADA and :DATAA))'
      '       )'
      'order by DATA_INIZIO_ASSENZA, OPERAZIONE desc'
      '')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000008000000160000003A004F0050004500520041005A0049004F004E00
      45000500000000000000000000000E0000003A00440041005400410044004100
      0C00000000000000000000000C0000003A00440041005400410041000C000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00080000000000000000000000260000003A0049004E0043004C005500
      440049005F0043004F004D0055004E0049004300410054004900050000000000
      000000000000240000003A0044004100540041005F0045004C00410042004F00
      520041005A0049004F004E0045000C00000000000000000000001C0000003A00
      500052004F004C0055004E00470041004D0045004E0054004F00010000000000
      000000000000140000003A004500530045004E005A0049004F004E0049000500
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000015000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F000100000000001E0000004D00450044004900430049004E0041005F00
      4C004500470041004C0045000100000000001C0000005400490050004F005F00
      4500530045004E005A0049004F004E0045000100000000001C00000044004100
      540041005F004500530045004E005A0049004F004E0045000100000000001200
      00004F00500045005200410054004F00520045000100000000000A0000004300
      49005400540041000100000000000A0000004300410050005F00310001000000
      000012000000500052004F00560049004E00430049004100010000000000}
    BeforePost = selT047BeforePost
    AfterPost = selT047AfterPost
    OnCalcFields = selT047CalcFields
    Left = 40
    Top = 66
    object selT047TIPO_EVENTO: TStringField
      FieldName = 'TIPO_EVENTO'
      Required = True
      Size = 2
    end
    object selT047PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
    end
    object selT047OPERAZIONE: TStringField
      FieldName = 'OPERAZIONE'
      Required = True
      Size = 1
    end
    object selT047DATA_INIZIO_ASSENZA: TDateTimeField
      FieldName = 'DATA_INIZIO_ASSENZA'
      Required = True
    end
    object selT047DATA_FINE_ASSENZA: TDateTimeField
      FieldName = 'DATA_FINE_ASSENZA'
    end
    object selT047NUOVA_DATA_FINE: TDateTimeField
      FieldName = 'NUOVA_DATA_FINE'
    end
    object selT047DATA_REGISTRAZIONE: TDateTimeField
      FieldName = 'DATA_REGISTRAZIONE'
    end
    object selT047DATA_PRIMA_COMUNICAZIONE: TDateTimeField
      FieldName = 'DATA_PRIMA_COMUNICAZIONE'
    end
    object selT047DATA_REGIS_PROLUNGAMENTO: TDateTimeField
      FieldName = 'DATA_REGIS_PROLUNGAMENTO'
    end
    object selT047DATA_COMUN_PROLUNGAMENTO: TDateTimeField
      FieldName = 'DATA_COMUN_PROLUNGAMENTO'
    end
    object selT047COD_COMUNE: TStringField
      FieldName = 'COD_COMUNE'
      Size = 6
    end
    object selT047INDIRIZZO: TStringField
      FieldName = 'INDIRIZZO'
      Size = 80
    end
    object selT047CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selT047TELEFONO: TStringField
      FieldName = 'TELEFONO'
      Size = 15
    end
    object selT047PROGNOSI: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'PROGNOSI'
      Calculated = True
    end
    object selT047PROGNOSI_PRIMA: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'PROGNOSI_PRIMA'
      Calculated = True
    end
    object selT047PROGNOSI_PROL: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'PROGNOSI_PROL'
      Calculated = True
    end
    object selT047CITTA: TStringField
      FieldName = 'CITTA'
      Size = 40
    end
    object selT047PROVINCIA: TStringField
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object selT047MEDICINA_LEGALE: TStringField
      FieldName = 'MEDICINA_LEGALE'
      Size = 10
    end
    object selT047TIPO_ESENZIONE: TStringField
      FieldName = 'TIPO_ESENZIONE'
      Size = 50
    end
    object selT047DATA_ESENZIONE: TDateTimeField
      FieldName = 'DATA_ESENZIONE'
    end
    object selT047OPERATORE: TStringField
      FieldName = 'OPERATORE'
    end
    object selT047NOTE: TStringField
      FieldName = 'NOTE'
      Size = 2000
    end
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    FilterOptions = [foNoPartialCompare]
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 44
    Top = 16
  end
  object selV430: TOracleDataSet
    SQL.Strings = (
      
        'select T430INDIRIZZO_DOM_BASE, T430CAP_DOM_BASE, T430COMUNE_DOM_' +
        'BASE, T430D_COMUNE_DOM_BASE, T430D_PROVINCIA_DOM_BASE,'
      
        '       T430INDIRIZZO, T430CAP, T430COMUNE, T430D_COMUNE, T430D_P' +
        'ROVINCIA'
      'from   V430_STORICO V430'
      'where  V430.T430PROGRESSIVO = :PROGRESSIVO '
      
        'and    :DATA_LIMITE between V430.T430DATADECORRENZA and V430.T43' +
        '0DATAFINE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A0044004100540041005F00
      4C0049004D004900540045000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    Left = 329
    Top = 66
  end
  object selCercaMedLeg: TOracleDataSet
    SQL.Strings = (
      'select T486.*'
      'from   T486_COMUNI_MEDLEGALI T486'
      'where  T486.COD_COMUNE = :COD_COMUNE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0043004F0044005F0043004F004D0055004E00
      4500050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    Left = 118
    Top = 256
  end
  object selMedLegali: TOracleDataSet
    SQL.Strings = (
      'select T485.*, T480.CITTA'
      'from   T485_MEDICINELEGALI T485, T480_COMUNI T480'
      'where  T485.COD_COMUNE = T480.CODICE(+) '
      'order by T485.CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    Left = 42
    Top = 256
  end
  object updT047: TOracleQuery
    SQL.Strings = (
      'update t047_visitefiscali'
      'set tipo_esenzione = :TIPO,'
      '    data_esenzione = :DATA,'
      '    operatore = :OPERATORE'
      'where tipo_evento = '#39'01'#39
      '  and operazione = :OPER'
      '  and progressivo = :PROG'
      '  and data_inizio_assenza = :INIZIO')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A005400490050004F0005000000000000000000
      00000A0000003A0044004100540041000C00000000000000000000000A000000
      3A004F005000450052000500000000000000000000000A0000003A0050005200
      4F0047000300000000000000000000000E0000003A0049004E0049005A004900
      4F000C0000000000000000000000140000003A004F0050004500520041005400
      4F0052004500050000000000000000000000}
    Left = 564
    Top = 116
  end
  object selV430MedLeg: TOracleDataSet
    SQL.Strings = (
      'select T430MEDICINA_LEGALE'
      'from   V430_STORICO V430'
      'where  V430.T430PROGRESSIVO = :PROGRESSIVO '
      
        'and    :DATA_LIMITE between V430.T430DATADECORRENZA and V430.T43' +
        '0DATAFINE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000180000003A0044004100540041005F00
      4C0049004D004900540045000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    Left = 390
    Top = 66
  end
  object selT040: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from  T040_GIUSTIFICATIVI'
      'where PROGRESSIVO = :PROGRESSIVO and'
      '      CAUSALE in (:LISTACAUSALI) and'
      '      DATA >= ADD_MONTHS(:DATA_LIMITE, -12) and '
      '      DATA < :DATA_LIMITE'
      'order by DATA'
      
        '-- ci sono possibilit'#224' che venga considerato anche il periodo st' +
        'esso'
      '-- nel conteggio dei giorni/eventi dell'#39'ultimo anno...')
    ReadBuffer = 250
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001A0000003A004C004900530054004100
      430041005500530041004C004900010000000000000000000000180000003A00
      44004100540041005F004C0049004D004900540045000C000000000000000000
      0000}
    Left = 107
    Top = 129
  end
  object prcGetInizioAssenza: TOracleQuery
    SQL.Strings = (
      'begin'
      '  getinizioassenza(:PROGRESSIVO,'
      '                   :DATA,'
      '                   :CAUSALE,'
      '                   :DATA_INIZIO_ASSENZA);'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000280000003A0044004100540041005F0049004E004900
      5A0049004F005F0041005300530045004E005A0041000C000000000000000000
      0000}
    Left = 216
    Top = 168
  end
  object selT047Canc: TOracleDataSet
    SQL.Strings = (
      
        '-- estrae tutte le operazioni di cancellazione non ancora comuni' +
        'cate'
      'select T047.*, T047.ROWID'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       OPERAZIONE = '#39'C'#39' and'
      '       DATA_PRIMA_COMUNICAZIONE is null and'
      '       TIPO_ESENZIONE IS NULL'
      'order  by PROGRESSIVO,'
      '          DATA_INIZIO_ASSENZA')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    Left = 653
    Top = 112
  end
  object selT047Esen: TOracleDataSet
    SQL.Strings = (
      'select T047.PROGRESSIVO, DATA_INIZIO_ASSENZA, TIPO_ESENZIONE'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' and'
      '       OPERAZIONE = '#39'I'#39' and'
      '       PROGRESSIVO = :PROG '
      '       AND TIPO_ESENZIONE IS NOT NULL'
      '       AND DATA_INIZIO_ASSENZA <= :INIZIO AND'
      '       NVL(NUOVA_DATA_FINE,DATA_FINE_ASSENZA) >= :FINE'
      'order  by PROGRESSIVO,'
      '          DATA_INIZIO_ASSENZA')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0049004E0049005A0049004F000C0000000000
      0000000000000A0000003A00460049004E0045000C0000000000000000000000
      0A0000003A00500052004F004700030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    Left = 653
    Top = 68
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE, GSIGNIFIC, VISITA_FISCALE'
      'from   T265_CAUASSENZE '
      'where  VISITA_FISCALE = '#39'S'#39
      'order by CODICE')
    ReadBuffer = 200
    Optimize = False
    Left = 40
    Top = 128
  end
  object TabellaEsenzioni: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = TabellaEsenzioniBeforePost
    AfterPost = TabellaEsenzioniAfterPost
    OnFilterRecord = TabellaEsenzioniFilterRecord
    Left = 124
    Top = 16
  end
  object GetCalendario: TOracleQuery
    SQL.Strings = (
      'begin'
      '  GETCALENDARIO(:PROG,:DATA,:FEST,:LAV,:GG,:MONTEORE);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C00000000000000000000000A000000
      3A004600450053005400050000000000000000000000080000003A004C004100
      5600050000000000000000000000060000003A00470047000300000000000000
      00000000120000003A004D004F004E00540045004F0052004500050000000000
      000000000000}
    Left = 560
    Top = 168
  end
  object selT047Esenzioni: TOracleDataSet
    SQL.Strings = (
      
        'select distinct TRIM(tipo_esenzione) tipo_esenzione from t047_vi' +
        'sitefiscali'
      'where tipo_esenzione is not null'
      'UNION'
      'select '#39'Generica'#39' tipo_esenzione from t047_visitefiscali'
      'UNION'
      
        'select '#39'Terapia salvavita'#39' tipo_esenzione from t047_visitefiscal' +
        'i'
      'order by tipo_esenzione')
    Optimize = False
    Left = 564
    Top = 64
  end
  object selT047Prog: TOracleDataSet
    SQL.Strings = (
      
        'select PROGRESSIVO, DATA_INIZIO_ASSENZA, NVL(NUOVA_DATA_FINE,DAT' +
        'A_FINE_ASSENZA) DATA_FINE_ASSENZA, OPERAZIONE, TIPO_ESENZIONE,'
      
        '       NVL(NUOVA_DATA_FINE,DATA_FINE_ASSENZA) - DATA_INIZIO_ASSE' +
        'NZA +1 GIORNI'
      'from   T047_VISITEFISCALI T047'
      'where  TIPO_EVENTO = '#39'01'#39' AND'
      '       PROGRESSIVO = :PROG '
      'order  by PROGRESSIVO,'
      '          DATA_INIZIO_ASSENZA DESC,'
      '          OPERAZIONE DESC')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A00500052004F00470003000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      050000000E000000160000005400490050004F005F004500560045004E005400
      4F0001000000000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004F0050004500520041005A0049004F004E004500
      0100000000002600000044004100540041005F0049004E0049005A0049004F00
      5F0041005300530045004E005A00410001000000000022000000440041005400
      41005F00460049004E0045005F0041005300530045004E005A00410001000000
      00001E0000004E0055004F00560041005F0044004100540041005F0046004900
      4E0045000100000000002400000044004100540041005F005200450047004900
      53005400520041005A0049004F004E0045000100000000003000000044004100
      540041005F005000520049004D0041005F0043004F004D0055004E0049004300
      41005A0049004F004E0045000100000000003000000044004100540041005F00
      520045004700490053005F00500052004F004C0055004E00470041004D004500
      4E0054004F000100000000003000000044004100540041005F0043004F004D00
      55004E005F00500052004F004C0055004E00470041004D0045004E0054004F00
      0100000000001400000043004F0044005F0043004F004D0055004E0045000100
      000000001200000049004E0044004900520049005A005A004F00010000000000
      0600000043004100500001000000000010000000540045004C00450046004F00
      4E004F00010000000000}
    Left = 653
    Top = 164
  end
end
