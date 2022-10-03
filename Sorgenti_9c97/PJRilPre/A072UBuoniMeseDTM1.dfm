object A072FBuoniMeseDtM1: TA072FBuoniMeseDtM1
  OldCreateOrder = True
  OnCreate = A048FPastiMeseDTM1Create
  OnDestroy = A048FPastiMeseDTM1Destroy
  Height = 92
  Width = 228
  object Q680: TOracleDataSet
    SQL.Strings = (
      'SELECT T680.*,T680.ROWID FROM T680_BUONIMENSILI T680 WHERE '
      '  PROGRESSIVO =:PROGRESSIVO'
      'ORDER BY ANNO DESC,MESE DESC')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforePost = Q680BeforePost
    AfterPost = Q680AfterPost
    BeforeDelete = Q680BeforeDelete
    AfterDelete = Q680AfterPost
    OnCalcFields = Q680CalcFields
    OnNewRecord = Q680NewRecord
    Left = 88
    Top = 12
    object Q680PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object Q680ANNO: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 5
      FieldName = 'ANNO'
      Required = True
    end
    object Q680MESE: TIntegerField
      DisplayLabel = 'Mese'
      DisplayWidth = 5
      FieldName = 'MESE'
      Required = True
      MaxValue = 12
      MinValue = 1
    end
    object Q680CALCMESE: TStringField
      DisplayLabel = ' '
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'CALCMESE'
      Calculated = True
    end
    object Q680BUONIPASTO: TIntegerField
      DisplayLabel = 'Buoni pasto'
      FieldName = 'BUONIPASTO'
      ReadOnly = True
    end
    object Q680VARBUONIPASTO: TIntegerField
      DisplayLabel = 'Variazioni'
      FieldName = 'VARBUONIPASTO'
    end
    object Q680TICKET: TIntegerField
      DisplayLabel = 'Ticket'
      FieldName = 'TICKET'
      ReadOnly = True
    end
    object Q680VARTICKET: TIntegerField
      DisplayLabel = 'Variazioni'
      FieldName = 'VARTICKET'
    end
    object Q680NOTE: TStringField
      DisplayLabel = 'Note'
      DisplayWidth = 10
      FieldName = 'NOTE'
      Size = 2000
    end
  end
end
