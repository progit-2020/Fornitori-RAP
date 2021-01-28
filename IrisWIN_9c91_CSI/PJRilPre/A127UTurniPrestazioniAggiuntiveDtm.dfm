object A127FTurniPrestazioniAggiuntiveDtm: TA127FTurniPrestazioniAggiuntiveDtm
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 63
  Width = 94
  object selT330: TOracleDataSet
    SQL.Strings = (
      'SELECT T330.*,T330.ROWID FROM T330_REG_ATT_AGGIUNTIVE T330'
      'ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00004F005200410049004E0049005A0049004F000100000000000E0000004F00
      52004100460049004E0045000100000000001800000043004F004E0054005200
      4F004C004C004F005F0050005400010000000000}
    BeforePost = selT330BeforePost
    AfterPost = selT330AfterPost
    BeforeDelete = selT330BeforeDelete
    AfterDelete = selT330AfterDelete
    Left = 28
    Top = 4
    object selT330CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT330DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT330ORAINIZIO: TDateTimeField
      DisplayLabel = 'Ora inizio'
      FieldName = 'ORAINIZIO'
      Required = True
      OnGetText = selT330ORAINIZIOGetText
      OnSetText = selT330ORAINIZIOSetText
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selT330ORAFINE: TDateTimeField
      DisplayLabel = 'Ora fine'
      FieldName = 'ORAFINE'
      Required = True
      OnGetText = selT330ORAINIZIOGetText
      OnSetText = selT330ORAINIZIOSetText
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selT330CONTROLLO_PT: TStringField
      DisplayLabel = 'Controllo Part Time'
      FieldName = 'CONTROLLO_PT'
      Size = 1
    end
  end
end
