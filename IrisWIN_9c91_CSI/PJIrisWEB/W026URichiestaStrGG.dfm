inherited W026FRichiestaStrGG: TW026FRichiestaStrGG
  Tag = 432
  Width = 805
  Height = 358
  HelpType = htKeyword
  HelpKeyword = 'W010P0'
  ExplicitWidth = 805
  ExplicitHeight = 358
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 6
  end
  inherited grdRichieste: TmedpIWDBGrid
    Left = 21
    Top = 228
    Width = 781
    Height = 108
    ExtraTagParams.Strings = (
      
        'summary=Tabella contenente l'#39'elenco delle richieste di eccedenze' +
        ' giornaliere')
    StyleRenderOptions.RenderStatus = False
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    Caption = 'Richieste di eccedenze giornaliere'
    OnRenderCell = grdRichiesteRenderCell
    DataSource = dsrT325
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitLeft = 21
    ExplicitTop = 228
    ExplicitWidth = 781
    ExplicitHeight = 108
  end
  object grdRiepilogo: TmeIWGrid [9]
    Left = 600
    Top = 181
    Width = 196
    Height = 41
    Visible = False
    Css = 'grid width100pc'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    BGColor = clNone
    BorderSize = 0
    BorderStyle = tfVoid
    CellPadding = 0
    CellSpacing = 0
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FrameBuffer = 40
    Lines = tlAll
    OnRenderCell = grdRiepilogoRenderCell
    UseFrame = False
    UseSize = False
    HeaderRowCount = 0
    CellRenderOptions = []
    FriendlyName = 'grdRiepilogo'
    ColumnCount = 2
    RowCount = 2
    ShowEmptyCells = True
    ShowInvisibleRows = True
    ScrollToCurrentRow = False
  end
  object edtRiepilogo: TmeIWEdit [10]
    Left = 600
    Top = 159
    Width = 196
    Height = 21
    Visible = False
    Css = 'riga_intestazione width97pc nomargin align_center'
    ShowHint = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'edtRiepilogo'
    ReadOnly = True
    SubmitOnAsyncEvent = True
    TabOrder = 4
    Text = 'Tot. ore richieste da inizio anno'
  end
  object btnEseguiConteggi: TmeIWButton [11]
    Left = 85
    Top = 159
    Width = 131
    Height = 25
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Importa eccedenze'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnEseguiConteggi'
    TabOrder = 7
    OnClick = btnEseguiConteggiClick
    medpDownloadButton = False
  end
  object btnRichiestaCumulativa: TmeIWButton [12]
    Left = 222
    Top = 159
    Width = 131
    Height = 25
    Hint = 'Inoltra le richieste in stato P = salvataggio parziale'
    Css = 'pulsante'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Caption = 'Inoltra richieste'
    Confirmation = 
      'Confermare l'#39'inserimento della richiesta cumulativa per il perio' +
      'do?'
    Color = clBtnFace
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    FriendlyName = 'btnRichiestaCumulativa'
    TabOrder = 8
    OnClick = btnRichiestaCumulativaClick
    medpDownloadButton = False
  end
  object lblSaldoMeseDisp: TmeIWLabel [13]
    Left = 421
    Top = 181
    Width = 108
    Height = 16
    Visible = False
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    HasTabOrder = False
    FriendlyName = 'lblSaldoMeseDisp'
    Caption = 'lblSaldoMeseDisp'
    Enabled = True
  end
  object lblSaldoMese: TmeIWLabel [14]
    Left = 421
    Top = 159
    Width = 105
    Height = 16
    Visible = False
    Css = 'intestazione'
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    StyleRenderOptions.RenderBorder = False
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = []
    HasTabOrder = False
    FriendlyName = 'lblSaldoMese'
    Caption = 'Saldo disponibile'
    Enabled = True
  end
  inherited pmnTabella: TPopupMenu
    Left = 288
    Top = 272
  end
  object dsrT325: TDataSource
    DataSet = cdsT325
    Left = 541
    Top = 267
  end
  object cdsT325: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 493
    Top = 267
  end
  object cdsGestMese: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'FLAG_RIGA'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'FLAG_RIGA_SUBCOD'
        DataType = ftInteger
      end
      item
        Name = 'DATA'
        DataType = ftDateTime
      end
      item
        Name = 'DATA_CONTEGGI'
        DataType = ftDateTime
      end
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'DALLE_H'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ALLE_H'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'C_AUTORIZZATO'
        DataType = ftString
        Size = 13
      end
      item
        Name = 'DESC_CAUSALE'
        DataType = ftString
        Size = 47
      end
      item
        Name = 'CAUSALE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'TOTLAV'
        DataType = ftInteger
      end
      item
        Name = 'DEBITOGG'
        DataType = ftInteger
      end
      item
        Name = 'SCOST'
        DataType = ftInteger
      end
      item
        Name = 'C_TOTLAV_H'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'C_DEBITOGG_H'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'C_SCOST_H'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'CAVALLO_MEZZANOTTE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'DATA_ORIG'
        DataType = ftDateTime
      end
      item
        Name = 'DALLE_ORIG'
        DataType = ftInteger
      end
      item
        Name = 'ALLE_ORIG'
        DataType = ftInteger
      end
      item
        Name = 'CAUSALE_ORIG'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'C_ARROT_RIEPGG'
        DataType = ftInteger
      end
      item
        Name = 'C_MODIFICATO'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ID_EVENTO_STR'
        DataType = ftInteger
      end
      item
        Name = 'SERVIZIO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'SERVIZIO_ORIG'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <
      item
        Name = 'cdsGestMeseIdx1'
        Fields = 'DATA;DALLE_H;ALLE_H;TIPO;FLAG_RIGA'
        Options = [ixPrimary, ixUnique]
      end>
    IndexName = 'cdsGestMeseIdx1'
    Params = <>
    StoreDefs = True
    Left = 352
    Top = 274
    object cdsGestMeseFLAG_RIGA: TStringField
      Alignment = taCenter
      FieldName = 'FLAG_RIGA'
      Size = 1
    end
    object cdsGestMeseFLAG_RIGA_SUBCOD: TIntegerField
      DisplayLabel = 'T1'
      FieldName = 'FLAG_RIGA_SUBCOD'
    end
    object cdsGestMeseDATA: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      EditMask = '!99/99/9999;1;_'
    end
    object cdsGestMeseDATA_CONTEGGI: TDateTimeField
      DisplayWidth = 10
      FieldName = 'DATA_CONTEGGI'
      Visible = False
    end
    object cdsGestMeseTIPO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Size = 2
    end
    object cdsGestMeseDALLE_H: TStringField
      Alignment = taCenter
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE_H'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object cdsGestMeseALLE_H: TStringField
      Alignment = taCenter
      DisplayLabel = 'Alle'
      FieldName = 'ALLE_H'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object cdsGestMeseC_AUTORIZZATO: TStringField
      FieldKind = fkCalculated
      FieldName = 'C_AUTORIZZATO'
      Size = 13
      Calculated = True
    end
    object cdsGestMeseDESC_CAUSALE: TStringField
      DisplayLabel = 'Causale'
      DisplayWidth = 47
      FieldKind = fkLookup
      FieldName = 'DESC_CAUSALE'
      LookupDataSet = W001FIrisWebDtM.selAssPres
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 47
      Lookup = True
    end
    object cdsGestMeseCAUSALE: TStringField
      DisplayLabel = 'Cod. caus.'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object cdsGestMeseTOTLAV: TIntegerField
      DisplayLabel = 'Tot. lavorato'
      FieldName = 'TOTLAV'
      Visible = False
    end
    object cdsGestMeseDEBITOGG: TIntegerField
      DisplayLabel = 'Debito gg.'
      FieldName = 'DEBITOGG'
      Visible = False
    end
    object cdsGestMeseSCOST: TIntegerField
      DisplayLabel = 'Scost.'
      FieldName = 'SCOST'
      Visible = False
    end
    object cdsGestMeseC_TOTLAV_H: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Tot. lavorato'
      FieldKind = fkCalculated
      FieldName = 'C_TOTLAV_H'
      Visible = False
      Size = 6
      Calculated = True
    end
    object cdsGestMeseC_DEBITOGG_H: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Debito gg.'
      FieldKind = fkCalculated
      FieldName = 'C_DEBITOGG_H'
      Visible = False
      Size = 6
      Calculated = True
    end
    object cdsGestMeseC_SCOST_H: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Scost.'
      FieldKind = fkCalculated
      FieldName = 'C_SCOST_H'
      Size = 6
      Calculated = True
    end
    object cdsGestMeseCAVALLO_MEZZANOTTE: TStringField
      FieldName = 'CAVALLO_MEZZANOTTE'
      Size = 1
    end
    object cdsGestMeseDATA_ORIG: TDateTimeField
      DisplayLabel = 'Data orig'
      FieldName = 'DATA_ORIG'
    end
    object cdsGestMeseDALLE_ORIG: TIntegerField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE_ORIG'
      Visible = False
    end
    object cdsGestMeseALLE_ORIG: TIntegerField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE_ORIG'
      Visible = False
    end
    object cdsGestMeseCAUSALE_ORIG: TStringField
      FieldName = 'CAUSALE_ORIG'
      Size = 5
    end
    object cdsGestMeseC_ARROT_RIEPGG: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'C_ARROT_RIEPGG'
      Calculated = True
    end
    object cdsGestMeseC_MODIFICATO: TStringField
      DisplayLabel = 'Modificato'
      FieldKind = fkCalculated
      FieldName = 'C_MODIFICATO'
      Size = 1
      Calculated = True
    end
    object cdsGestMeseID_EVENTO_STR: TIntegerField
      FieldName = 'ID_EVENTO_STR'
      Visible = False
    end
    object cdsGestMeseSERVIZIO: TStringField
      FieldName = 'SERVIZIO'
    end
    object cdsGestMeseSERVIZIO_ORIG: TStringField
      FieldName = 'SERVIZIO_ORIG'
    end
  end
end
