inherited A136FRelazioniAnagrafeDtM: TA136FRelazioniAnagrafeDtM
  OldCreateOrder = True
  Height = 194
  Width = 344
  object selI030: TOracleDataSet
    SQL.Strings = (
      'SELECT I030.ROWID, I030.*'
      'FROM   I030_RELAZIONI_ANAGRAFE I030'
      
        'ORDER BY I030.TABELLA, I030.ORDINE, I030.COLONNA, I030.DECORRENZ' +
        'A, I030.TIPO')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000060000000E00000054004100420045004C004C004100010000000000
      0E00000043004F004C004F004E004E0041000100000000001400000044004500
      43004F005200520045004E005A0041000100000000001E000000440045004300
      4F005200520045004E005A0041005F00460049004E0045000100000000000C00
      00004F005200440049004E004500010000000000080000005400490050004F00
      010000000000}
    BeforeInsert = BeforeInsert
    AfterInsert = selI030AfterInsert
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterCancel = selI030AfterCancel
    BeforeDelete = BeforeDelete
    AfterScroll = selI030AfterScroll
    OnCalcFields = selI030CalcFields
    Left = 24
    Top = 16
    object selI030TABELLA: TStringField
      DisplayLabel = 'Tabella'
      DisplayWidth = 25
      FieldName = 'TABELLA'
      Required = True
      OnValidate = selI030TABELLAValidate
      Size = 40
    end
    object selI030COLONNA: TStringField
      DisplayLabel = 'Colonna'
      DisplayWidth = 25
      FieldName = 'COLONNA'
      Required = True
      Visible = False
      OnValidate = selI030COLONNAValidate
      Size = 40
    end
    object selI030DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selI030DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selI030ORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      DisplayWidth = 4
      FieldName = 'ORDINE'
      Required = True
    end
    object selI030TIPO: TStringField
      DisplayLabel = 'Desc. tipo'
      FieldName = 'TIPO'
      Required = True
      OnValidate = selI030TIPOValidate
      Size = 1
    end
    object selI030D_TIPO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO'
      ReadOnly = True
      Size = 50
      Calculated = True
    end
    object selI030TAB_ORIGINE: TStringField
      FieldName = 'TAB_ORIGINE'
      OnValidate = selI030TAB_ORIGINEValidate
      Size = 40
    end
    object selI030COL_ORIGINE: TStringField
      FieldKind = fkCalculated
      FieldName = 'COL_ORIGINE'
      Size = 40
      Calculated = True
    end
  end
end
