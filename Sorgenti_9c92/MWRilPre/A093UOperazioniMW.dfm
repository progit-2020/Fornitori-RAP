inherited A093FOperazioniMW: TA093FOperazioniMW
  OldCreateOrder = True
  Height = 117
  Width = 177
  object selI000_T040: TOracleDataSet
    SQL.Strings = (
      'select I000.*'
      'from   I000_LOGINFO I000'
      'where  I000.PROGRESSIVO = :PROGRESSIVO'
      'and    I000.TABELLA = '#39'T040_GIUSTIFICATIVI'#39
      'and    I000.OPERAZIONE = '#39'I'#39
      
        'and    I001F_CHEKVALORI_T040(I000.ID, :DATA, :CAUSALE, :TIPOGIUS' +
        'T, :DAORE, :AORE, :DATANAS) = '#39'S'#39
      'order by I000.ID desc')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000100000003A00430041005500530041004C0045000500
      00000000000000000000140000003A005400490050004F004700490055005300
      54000500000000000000000000000C0000003A00440041004F00520045000500
      000000000000000000000A0000003A0041004F00520045000500000000000000
      00000000100000003A0044004100540041004E00410053000C00000000000000
      00000000}
    ReadOnly = True
    OnCalcFields = selI000_T040CalcFields
    Left = 24
    Top = 62
    object selI000_T040OPERATORE: TStringField
      DisplayLabel = 'Operatore'
      DisplayWidth = 20
      FieldName = 'OPERATORE'
      Size = 30
    end
    object selI000_T040DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 15
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy hh.mm'
    end
    object selI000_T040MASCHERA: TStringField
      DisplayLabel = 'Funzione'
      DisplayWidth = 15
      FieldName = 'MASCHERA'
      Size = 30
    end
    object selI000_T040C_OPERAZIONE: TStringField
      DisplayLabel = 'Operazione'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'C_OPERAZIONE'
      Size = 30
      Calculated = True
    end
    object selI000_T040OPERAZIONE: TStringField
      FieldName = 'OPERAZIONE'
      Visible = False
      Size = 1
    end
    object selI000_T040HOSTNAME: TStringField
      DisplayLabel = 'Hostname'
      DisplayWidth = 20
      FieldName = 'HOSTNAME'
      Size = 24
    end
    object selI000_T040HOSTIPADDRESS: TStringField
      DisplayLabel = 'Host IP'
      DisplayWidth = 15
      FieldName = 'HOSTIPADDRESS'
      Size = 39
    end
  end
  object selI000_T100: TOracleDataSet
    SQL.Strings = (
      'select I000.*'
      'from   I000_LOGINFO I000'
      'where  I000.PROGRESSIVO = :PROGRESSIVO'
      'and    I000.TABELLA = '#39'T100_TIMBRATURE'#39
      'and    I000.OPERAZIONE in ('#39'I'#39','#39'M'#39')'
      
        'and    I001F_CHEKVALORI_T100(I000.ID, :DATA, :ORA, :VERSO, :FLAG' +
        ') = '#39'S'#39
      'order by I000.ID desc')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000080000003A004F005200410005000000000000000000
      00000C0000003A0056004500520053004F000500000000000000000000000A00
      00003A0046004C0041004700050000000000000000000000}
    ReadOnly = True
    OnCalcFields = selI000_T100CalcFields
    Left = 112
    Top = 62
    object selI000_T100OPERATORE: TStringField
      DisplayLabel = 'Operatore'
      DisplayWidth = 20
      FieldName = 'OPERATORE'
      Size = 30
    end
    object selI000_T100DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 15
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy hh.mm'
    end
    object selI000_T100MASCHERA: TStringField
      DisplayLabel = 'Funzione'
      DisplayWidth = 8
      FieldName = 'MASCHERA'
      Size = 30
    end
    object selI000_T100C_OPERAZIONE: TStringField
      DisplayLabel = 'Operazione'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'C_OPERAZIONE'
      Size = 30
      Calculated = True
    end
    object selI000_T100OPERAZIONE: TStringField
      FieldName = 'OPERAZIONE'
      Visible = False
      Size = 1
    end
    object selI000_T100HOSTNAME: TStringField
      DisplayLabel = 'Hostname'
      DisplayWidth = 20
      FieldName = 'HOSTNAME'
      Size = 24
    end
    object selI000_T100HOSTIPADDRESS: TStringField
      DisplayLabel = 'Host IP'
      DisplayWidth = 15
      FieldName = 'HOSTIPADDRESS'
      Size = 39
    end
  end
  object selI000Idx: TOracleQuery
    SQL.Strings = (
      'select COUNT(INDEX_NAME)'
      'from   USER_INDEXES'
      'where  INDEX_NAME = '#39'I000I_TABELLAPROGRESSIVO'#39)
    ReadBuffer = 2
    Optimize = False
    Left = 24
    Top = 8
  end
end
