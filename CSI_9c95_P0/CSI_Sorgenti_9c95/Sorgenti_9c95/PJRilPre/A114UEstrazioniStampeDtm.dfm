object A114FEstrazioniStampeDtm: TA114FEstrazioniStampeDtm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 375
  Width = 651
  object SelT930: TOracleDataSet
    SQL.Strings = (
      
        'select a.codice_par, a.codice_stampa, a.tipo_file, a.nome_file, ' +
        'a.utenti_privilegi, b.titolo, b.tabella_generata'
      '  from t930_parestrazionistampe a, t910_riepilogo b'
      ' where a.codice_stampa = b.codice'
      ' order by codice_par')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000001400000043004F0044004900430045005F00500041005200
      0100000000001A00000043004F0044004900430045005F005300540041004D00
      50004100010000000000120000005400490050004F005F00460049004C004500
      010000000000120000004E004F004D0045005F00460049004C00450001000000
      00000C0000005400490054004F004C004F000100000000002000000054004100
      420045004C004C0041005F00470045004E004500520041005400410001000000
      0000200000005500540045004E00540049005F00500052004900560049004C00
      450047004900010000000000}
    Left = 16
    Top = 16
    object SelT930CODICE_PAR: TStringField
      FieldName = 'CODICE_PAR'
      Required = True
      Size = 10
    end
    object SelT930CODICE_STAMPA: TStringField
      FieldName = 'CODICE_STAMPA'
      Required = True
      Size = 10
    end
    object SelT930TITOLO: TStringField
      FieldName = 'TITOLO'
      Size = 80
    end
    object SelT930TIPO_FILE: TStringField
      FieldName = 'TIPO_FILE'
      Size = 1
    end
    object SelT930NOME_FILE: TStringField
      FieldName = 'NOME_FILE'
      Size = 200
    end
    object SelT930TABELLA_GENERATA: TStringField
      FieldName = 'TABELLA_GENERATA'
      Size = 40
    end
    object SelT930UTENTI_PRIVILEGI: TStringField
      FieldName = 'UTENTI_PRIVILEGI'
      Size = 50
    end
  end
  object QSelect: TOracleDataSet
    Optimize = False
    Left = 16
    Top = 72
  end
  object SelT931: TOracleDataSet
    SQL.Strings = (
      'select *'
      '  from t931_tracciatoestrazionistampe t'
      ' where codice_par = :codicepar'
      ' order by posizione')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A0043004F004400490043004500500041005200
      050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000009000000080000004400410054004F00010000000000120000005000
      4F00530049005A0049004F004E00450001000000000008000000540049005000
      4F000100000000001C000000560041005200490041005A0049004F004E004900
      5F004D00410058000100000000000C0000004300480049004100560045000100
      0000000016000000560041004C004F00520045005F004E0055004C004C000100
      000000000E00000046004F0052004D00410054004F0001000000000014000000
      43004F0044004900430045005F00500041005200010000000000200000005300
      4F004D004D0041005F005200490043004F005200520045004E005A0045000100
      00000000}
    Left = 120
    Top = 72
    object SelT931DATO: TStringField
      FieldName = 'DATO'
      Required = True
      Size = 40
    end
    object SelT931CHIAVE: TStringField
      FieldName = 'CHIAVE'
      Required = True
      Size = 1
    end
    object SelT931POSIZIONE: TIntegerField
      FieldName = 'POSIZIONE'
    end
    object SelT931TIPO: TStringField
      FieldName = 'TIPO'
    end
    object SelT931VARIAZIONI_MAX: TIntegerField
      FieldName = 'VARIAZIONI_MAX'
    end
    object SelT931VALORE_NULL: TStringField
      FieldName = 'VALORE_NULL'
      Size = 1
    end
    object SelT931FORMATO: TStringField
      FieldName = 'FORMATO'
    end
    object SelT931SOMMA_RICORRENZE: TStringField
      FieldName = 'SOMMA_RICORRENZE'
      Required = True
      Size = 25
    end
  end
  object TabellaTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 136
  end
  object DSel930: TDataSource
    DataSet = SelT930
    Left = 64
    Top = 16
  end
  object SelT932: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      '  from t932_log t'
      'where operatore = :operatore'
      '  and maschera = :maschera'
      ' order by id')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A004F00500045005200410054004F0052004500
      050000000000000000000000120000003A004D00410053004300480045005200
      4100050000000000000000000000}
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T932_ID'
    SequenceField.ApplyMoment = amOnNewRecord
    QBEDefinition.QBEFieldDefs = {
      05000000050000000400000049004400010000000000120000004F0050004500
      5200410054004F00520045000100000000000800000044004100540041000100
      00000000160000004400450053004300520049005A0049004F004E0045000000
      00000000100000004D004100530043004800450052004100010000000000}
    Left = 120
    Top = 16
    object SelT932ID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object SelT932OPERATORE: TStringField
      FieldName = 'OPERATORE'
    end
    object SelT932DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object SelT932DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 1000
    end
    object SelT932MASCHERA: TStringField
      FieldName = 'MASCHERA'
      Size = 10
    end
  end
  object DelT932: TOracleQuery
    SQL.Strings = (
      'delete t932_log'
      ' where operatore=:operatore'
      '   and maschera=:maschera')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A004F00500045005200410054004F0052004500
      050000000000000000000000120000003A004D00410053004300480045005200
      4100050000000000000000000000}
    Left = 168
    Top = 72
  end
  object DSelect: TDataSource
    DataSet = QSelect
    Left = 64
    Top = 72
  end
  object D932: TDataSource
    DataSet = SelT932
    Left = 168
    Top = 16
  end
end
