object B000FConfigWebServerDM: TB000FConfigWebServerDM
  OldCreateOrder = False
  Height = 132
  Width = 277
  object DbMessaggi: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 28
    Top = 8
  end
  object selMsgHead: TOracleDataSet
    SQL.Strings = (
      
        'select I005.ID, I005.DATA, I005.HOSTNAME, I005.HOSTIPADDRESS, I0' +
        '05.MASCHERA, count(*) COUNTMSG, min(I006.DATA_MSG) DATA_INI, max' +
        '(I006.DATA_MSG) DATA_FINE, max(substr(I006.MSG,6,5)) MAX_SESSION' +
        'I'
      'from   MONDOEDP.I006_MSGDATI I006, MONDOEDP.I005_MSGINFO I005'
      'where  I005.ID = I006.ID '
      'and    I005.MASCHERA like '#39'W%'#39
      
        'group by I005.ID, I005.DATA, I005.HOSTNAME, I005.HOSTIPADDRESS, ' +
        'I005.MASCHERA'
      ':FILTRO_PERIODO'
      'order by I005.ID desc, I005.DATA desc')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000010000001E0000003A00460049004C00540052004F005F0050004500
      520049004F0044004F00010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C004900410053000100000000000C0000005500540045004E00
      54004500010000000000180000005000410052004F004C004100430048004900
      41005600450001000000000010000000540053004C00410056004F0052004F00
      010000000000100000005400530049004E004400490043004900010000000000
      14000000560045005200530049004F004E00450044004200010000000000}
    ReadOnly = True
    CountAllRecords = True
    Session = DbMessaggi
    AfterScroll = selMsgHeadAfterScroll
    Left = 104
    Top = 8
    object selMsgHeadID: TFloatField
      FieldName = 'ID'
    end
    object selMsgHeadDATA: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DATA'
      DisplayFormat = 'dd/mm/yyyy hhhh.mm.ss'
    end
    object selMsgHeadHOSTNAME: TStringField
      FieldName = 'HOSTNAME'
      Size = 24
    end
    object selMsgHeadHOSTIPADDRESS: TStringField
      FieldName = 'HOSTIPADDRESS'
      Size = 39
    end
    object selMsgHeadMASCHERA: TStringField
      FieldName = 'MASCHERA'
      Size = 5
    end
    object selMsgHeadCOUNTMSG: TFloatField
      DisplayWidth = 6
      FieldName = 'COUNTMSG'
    end
    object selMsgHeadDATA_INI: TDateTimeField
      DisplayWidth = 14
      FieldName = 'DATA_INI'
      DisplayFormat = 'dd/mm hhhh.mm.ss'
    end
    object selMsgHeadDATA_FINE: TDateTimeField
      DisplayWidth = 14
      FieldName = 'DATA_FINE'
      DisplayFormat = 'dd/mm hhhh.mm.ss'
    end
    object selMsgHeadMAX_SESSIONI: TStringField
      FieldName = 'MAX_SESSIONI'
      Size = 5
    end
  end
  object selMsgDett: TOracleDataSet
    SQL.Strings = (
      'select DATA_MSG, MSG '
      'from   MONDOEDP.I006_MSGDATI'
      'where  ID = :ID'
      'order by ID_MSG desc')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000000E00000041005A00490045004E0044004100010000000000
      0A00000041004C004900410053000100000000000C0000005500540045004E00
      54004500010000000000180000005000410052004F004C004100430048004900
      41005600450001000000000010000000540053004C00410056004F0052004F00
      010000000000100000005400530049004E004400490043004900010000000000
      14000000560045005200530049004F004E00450044004200010000000000}
    ReadOnly = True
    QueryAllRecords = False
    CountAllRecords = True
    Session = DbMessaggi
    OnCalcFields = selMsgDettCalcFields
    Left = 104
    Top = 72
    object selMsgDettDATA_MSG: TDateTimeField
      FieldName = 'DATA_MSG'
      DisplayFormat = 'dd/mm hhhh.nn.ss'
    end
    object selMsgDettMSG: TStringField
      FieldName = 'MSG'
      Size = 2000
    end
    object selMsgDettC_TIPO_MSG: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_TIPO_MSG'
      Size = 2
      Calculated = True
    end
    object selMsgDettC_NUMSESS: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_NUMSESS'
      Size = 5
      Calculated = True
    end
    object selMsgDettC_IDSESS: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_IDSESS'
      Size = 28
      Calculated = True
    end
    object selMsgDettC_IPCLIENT: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_IPCLIENT'
      Size = 39
      Calculated = True
    end
    object selMsgDettC_BROWSER: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_BROWSER'
      Size = 4
      Calculated = True
    end
    object selMsgDettC_FORM: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_FORM'
      Size = 5
      Calculated = True
    end
    object selMsgDettC_DETT: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_DETT'
      Size = 500
      Calculated = True
    end
  end
  object dsrMsgHead: TDataSource
    DataSet = selMsgHead
    Left = 168
    Top = 8
  end
  object dsrMsgDett: TDataSource
    DataSet = selMsgDett
    Left = 168
    Top = 72
  end
end
