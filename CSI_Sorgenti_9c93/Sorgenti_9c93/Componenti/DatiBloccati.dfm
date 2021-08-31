object frmDatiBloccati: TfrmDatiBloccati
  Left = 288
  Top = 315
  Width = 433
  Height = 296
  Caption = 'Riepiloghi bloccati'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object selT180: TOracleDataSet
    SQL.Strings = (
      
        'SELECT COGNOME|| '#39' '#39' ||NOME,MATRICOLA,BADGE FROM T180_DATIBLOCCA' +
        'TI T180, T030_ANAGRAFICO T030, T430_STORICO T430'
      
        'WHERE T180.PROGRESSIVO = T030.PROGRESSIVO AND T030.PROGRESSIVO =' +
        ' T430.PROGRESSIVO AND '
      
        ':DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE AND T030.PRO' +
        'GRESSIVO = :PROGRESSIVO AND T180.DATA = :DATA AND T180.RIEPILOGO' +
        ' = :RIEPILOGO')
    ReadBuffer = 1
    Optimize = False
    Debug = False
    Variables.Data = {
      0300000003000000050000003A444154410C00000000000000000000000C0000
      003A50524F475245535349564F0300000000000000000000000A0000003A5249
      4550494C4F474F050000000000000000000000}
    StringFieldsOnly = False
    SequenceField.ApplyMoment = amOnPost
    OracleDictionary.EnforceConstraints = False
    OracleDictionary.UseMessageTable = False
    OracleDictionary.DefaultValues = False
    OracleDictionary.DynamicDefaults = False
    OracleDictionary.FieldKinds = False
    OracleDictionary.DisplayFormats = False
    OracleDictionary.RangeValues = False
    OracleDictionary.RequiredFields = True
    QBEDefinition.SaveQBEValues = True
    QBEDefinition.AllowFileWildCards = True
    QBEDefinition.QBEFontColor = clNone
    QBEDefinition.QBEBackgroundColor = clNone
    Cursor = crDefault
    ReadOnly = False
    LockingMode = lmCheckImmediate
    QueryAllRecords = True
    CountAllRecords = False
    RefreshOptions = []
    CommitOnPost = True
    CachedUpdates = False
    QBEMode = False
    DesignActivation = False
    Active = False
  end
end
