object A125FBadgeServizioDtM: TA125FBadgeServizioDtM
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 61
  Width = 83
  object Q435: TOracleDataSet
    SQL.Strings = (
      'SELECT T435.*,T435.ROWID FROM T435_BADGESERVIZIO T435'
      'WHERE PROGRESSIVO = :Progressivo'
      'ORDER BY DECORRENZA DESC')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000400000016000000500052004F004700520045005300530049005600
      4F00010000000000140000004400450043004F005200520045004E005A004100
      01000000000010000000530043004100440045004E005A004100010000000000
      12000000420041004400470045005300450052005600010000000000}
    BeforePost = Q435BeforePost
    AfterPost = Q435AfterPost
    BeforeDelete = Q435BeforeDelete
    AfterDelete = Q435AfterDelete
    OnNewRecord = Q435NewRecord
    Left = 24
    Top = 8
    object Q435PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object Q435DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
      DisplayFormat = 'dd/mm/yyyy hh:mm'
      EditMask = '!00/00/0000 00:00;1;_'
    end
    object Q435SCADENZA: TDateTimeField
      FieldName = 'SCADENZA'
      DisplayFormat = 'dd/mm/yyyy hh:mm'
      EditMask = '!00/00/0000 00:00;1;_'
    end
    object Q435BADGESERV: TFloatField
      FieldName = 'BADGESERV'
      Required = True
    end
  end
end
