inherited Bc06FMonitorB006DtM: TBc06FMonitorB006DtM
  OldCreateOrder = True
  object selI190: TOracleDataSet
    SQL.Strings = (
      'select I190.*,'
      '       I190.ROWID '
      'from MONDOEDP.I190_MONITORSERVIZI I190'
      'order by I190.ID')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000008000000040000004900440001000000000010000000530045005200
      560049005A0049004F000100000000002400000049004E005400450052005600
      41004C004C004F005F004D004F004E00490054004F0052000100000000001E00
      000045004D00410049004C005F0053004D00540050005F0048004F0053005400
      0100000000001E00000045004D00410049004C005F0053004D00540050005F00
      50004F00520054000100000000002600000045004D00410049004C005F005300
      4D00540050005F0055005300450052004E0041004D0045000100000000002600
      000045004D00410049004C005F0053004D00540050005F005000410053005300
      57004F00520044000100000000001E00000045004D00410049004C005F004100
      5500540048005F005400590050004500010000000000}
    BeforeInsert = selI190BeforeInsert
    AfterScroll = selI190AfterScroll
    OnCalcFields = selI190CalcFields
    Left = 24
    Top = 16
    object selI190ID: TIntegerField
      FieldName = 'ID'
      ReadOnly = True
    end
    object selI190SERVIZIO: TStringField
      DisplayLabel = 'Servizio'
      FieldName = 'SERVIZIO'
      ReadOnly = True
      Required = True
      Size = 10
    end
    object selI190INTERVALLO_MONITOR: TStringField
      DisplayLabel = 'Intervallo di monitoraggio'
      FieldName = 'INTERVALLO_MONITOR'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selI190EMAIL_SMTP_HOST: TStringField
      DisplayLabel = 'Host SMTP email'
      DisplayWidth = 30
      FieldName = 'EMAIL_SMTP_HOST'
      Size = 60
    end
    object selI190EMAIL_SMTP_PORT: TIntegerField
      DisplayLabel = 'Porta host SMTP'
      FieldName = 'EMAIL_SMTP_PORT'
    end
    object selI190EMAIL_SMTP_USERNAME: TStringField
      DisplayLabel = 'Username host SMTP'
      FieldName = 'EMAIL_SMTP_USERNAME'
      Size = 60
    end
    object selI190EMAIL_SMTP_PASSWORD: TStringField
      DisplayLabel = 'Password host SMTP'
      FieldName = 'EMAIL_SMTP_PASSWORD'
      Size = 60
    end
    object selI190EMAIL_AUTH_TYPE: TStringField
      DisplayLabel = 'Autenticazione SMTP'
      FieldName = 'EMAIL_AUTH_TYPE'
    end
    object selI190D_EMAIL_SMTP_PASSWORD: TStringField
      DisplayLabel = 'Password host SMTP'
      FieldKind = fkCalculated
      FieldName = 'D_EMAIL_SMTP_PASSWORD'
      Size = 60
      Calculated = True
    end
  end
  object selI191: TOracleDataSet
    SQL.Strings = (
      'select I191.ROWID,I191.*'
      'from MONDOEDP.I191_MONITORSERVIZI_DB I191'
      'where I191.ID = :ID'
      'order by I191.DATABASE_NAME')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000004000000490044000100000000001A000000440041005400
      410042004100530045005F004E0041004D0045000100000000001E0000004300
      4F004E004E0045005300530049004F004E0045005F0050005700440001000000
      00002E000000510055004500520059005F00530045005200560049005A004900
      4F005F0043004F004E004E004500530053004F00010000000000140000005100
      55004500520059005F004D005300470031000100000000001400000051005500
      4500520059005F004D00530047003200010000000000200000004E004F005F00
      4D004F004E00490054004F0052005F00440041004C004C004500010000000000
      1E0000004E004F005F004D004F004E00490054004F0052005F0041004C004C00
      4500010000000000260000004D00530047005F0045004C00410042004F005200
      41005A0049004F004E0049005F00470047000100000000002C0000004D005300
      47005F0045004C00410042004F00520041005A0049004F004E0049005F005200
      49004700480045000100000000001C00000045004D00410049004C005F004D00
      49005400540045004E00540045000100000000002200000045004D0041004900
      4C005F00440045005300540049004E0041005400410052004900010000000000
      2800000045004D00410049004C005F00440045005300540049004E0041005400
      4100520049005F0043004300010000000000}
    BeforeInsert = selI191BeforeInsert
    BeforePost = selI191BeforePost
    AfterPost = selI191AfterPost
    OnCalcFields = selI191CalcFields
    OnNewRecord = selI191NewRecord
    Left = 88
    Top = 16
    object selI191ID: TIntegerField
      FieldName = 'ID'
      ReadOnly = True
      Required = True
    end
    object selI191DATABASE_NAME: TStringField
      FieldName = 'DATABASE_NAME'
      Required = True
      Size = 1000
    end
    object selI191CONNESSIONE_PWD: TStringField
      FieldName = 'CONNESSIONE_PWD'
      Size = 30
    end
    object selI191QUERY_SERVIZIO_CONNESSO: TStringField
      FieldName = 'QUERY_SERVIZIO_CONNESSO'
      Size = 1000
    end
    object selI191QUERY_MSG1: TStringField
      FieldName = 'QUERY_MSG1'
      Size = 2000
    end
    object selI191QUERY_MSG2: TStringField
      FieldName = 'QUERY_MSG2'
      Size = 2000
    end
    object selI191NO_MONITOR_DALLE: TStringField
      FieldName = 'NO_MONITOR_DALLE'
      OnValidate = selI191NO_MONITOR_DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selI191NO_MONITOR_ALLE: TStringField
      FieldName = 'NO_MONITOR_ALLE'
      OnValidate = selI191NO_MONITOR_ALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selI191MSG_ELABORAZIONI_GG: TIntegerField
      FieldName = 'MSG_ELABORAZIONI_GG'
      OnValidate = selI191MSG_ELABORAZIONI_GGValidate
    end
    object selI191MSG_ELABORAZIONI_RIGHE: TIntegerField
      FieldName = 'MSG_ELABORAZIONI_RIGHE'
      OnValidate = selI191MSG_ELABORAZIONI_RIGHEValidate
    end
    object selI191EMAIL_MITTENTE: TStringField
      FieldName = 'EMAIL_MITTENTE'
      Size = 1000
    end
    object selI191EMAIL_DESTINATARI: TStringField
      FieldName = 'EMAIL_DESTINATARI'
      Size = 1000
    end
    object selI191EMAIL_DESTINATARI_CC: TStringField
      FieldName = 'EMAIL_DESTINATARI_CC'
      Size = 1000
    end
    object selI191D_CONNESSIONE_PWD: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CONNESSIONE_PWD'
      Size = 30
      Calculated = True
    end
    object selI191D_CONNESSIONE_PWD_DECRYPT: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_CONNESSIONE_PWD_DECRYPT'
      Size = 30
      Calculated = True
    end
  end
  object dsrI191: TDataSource
    DataSet = selI191
    Left = 88
    Top = 64
  end
  object cdsInfoControlli: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'ID;SERVIZIO'
    Params = <>
    StoreDefs = True
    AfterScroll = cdsInfoControlliAfterScroll
    Left = 160
    Top = 16
    object cdsInfoControlliID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object cdsInfoControlliSERVIZIO: TStringField
      DisplayLabel = 'Servizio'
      DisplayWidth = 10
      FieldName = 'SERVIZIO'
      Visible = False
      Size = 50
    end
    object cdsInfoControlliDATABASE: TStringField
      DisplayLabel = 'Database'
      DisplayWidth = 30
      FieldName = 'DATABASE'
      Size = 1000
    end
    object cdsInfoControlliINTERVALLO: TStringField
      DisplayLabel = 'Controllo ogni'
      FieldName = 'INTERVALLO'
      Size = 5
    end
    object cdsInfoControlliESITO_CONTROLLO: TIntegerField
      FieldName = 'ESITO_CONTROLLO'
      Visible = False
    end
    object cdsInfoControlliD_ESITO_CONTROLLO: TStringField
      DisplayLabel = 'Esito'
      FieldName = 'D_ESITO_CONTROLLO'
      Size = 10
    end
    object cdsInfoControlliDATA_ULT_CONTROLLO: TStringField
      DisplayLabel = 'Ultimo controllo'
      FieldName = 'DATA_ULT_CONTROLLO'
    end
    object cdsInfoControlliDESC_ESITO_CONTROLLO: TStringField
      DisplayLabel = 'Descrizione esito'
      DisplayWidth = 50
      FieldName = 'DESC_ESITO_CONTROLLO'
      Size = 100
    end
  end
  object dsrInfoControlli: TDataSource
    DataSet = cdsInfoControlli
    Left = 160
    Top = 64
  end
end
