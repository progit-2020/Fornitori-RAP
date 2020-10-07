inherited W025FCambioOrario: TW025FCambioOrario
  Tag = 430
  Width = 769
  Height = 298
  HelpType = htKeyword
  HelpKeyword = 'W025P0'
  ExplicitWidth = 769
  ExplicitHeight = 298
  DesignLeft = 8
  DesignTop = 8
  inherited btnSendFile: TmeIWButton
    TabOrder = 5
  end
  inherited grdRichieste: TmedpIWDBGrid
    Left = 14
    Top = 202
    Width = 697
    Height = 75
    ExtraTagParams.Strings = (
      'summary=tabella contenente le richieste di cambio orario')
    StyleRenderOptions.RenderPosition = True
    StyleRenderOptions.RenderFont = True
    StyleRenderOptions.RenderZIndex = True
    StyleRenderOptions.RenderAbsolute = True
    BorderColors.Color = clNone
    BorderColors.Light = clNone
    BorderColors.Dark = clNone
    Caption = 'Richieste di cambio orario'
    OnRenderCell = grdRichiesteRenderCell
    DataSource = dsrT085
    OnAfterCaricaCDS = grdRichiesteAfterCaricaCDS
    ExplicitLeft = 14
    ExplicitTop = 202
    ExplicitWidth = 697
    ExplicitHeight = 75
  end
  object lnkLegendaColoriGiorni: TmeIWLink [7]
    Left = 327
    Top = 160
    Width = 186
    Height = 17
    Cursor = crAuto
    Css = 'link'
    ParentShowHint = False
    ShowHint = True
    ZIndex = 0
    RenderSize = False
    StyleRenderOptions.RenderSize = False
    StyleRenderOptions.RenderPosition = False
    StyleRenderOptions.RenderFont = False
    StyleRenderOptions.RenderZIndex = False
    StyleRenderOptions.RenderAbsolute = False
    StyleRenderOptions.RenderPadding = False
    Alignment = taLeftJustify
    Color = clNone
    Font.Color = clNone
    Font.Enabled = False
    Font.Size = 10
    Font.Style = [fsUnderline]
    ScriptEvents = <>
    DoSubmitValidation = False
    FriendlyName = 'lnkLegendaColoriGiorni'
    OnClick = lnkLegendaColoriGiorniClick
    TabOrder = 4
    RawText = False
    Caption = 'Legenda tipologia giorni'
    medpDownloadButton = False
  end
  object dsrT085: TDataSource
    DataSet = cdsT085
    Left = 664
    Top = 220
  end
  object cdsT085: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 608
    Top = 220
  end
end
