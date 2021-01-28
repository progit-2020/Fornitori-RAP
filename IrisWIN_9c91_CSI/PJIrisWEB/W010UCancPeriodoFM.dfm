object W010FCancPeriodoFM: TW010FCancPeriodoFM
  Left = 0
  Top = 0
  Width = 520
  Height = 318
  TabOrder = 0
  object IWFrameRegion: TIWRegion
    Left = 0
    Top = 0
    Width = 520
    Height = 318
    RenderInvisibleControls = False
    TabOrder = 0
    Align = alClient
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwThin
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clWebHOTPINK
    Color = clWebALICEBLUE
    ClipRegion = False
    LayoutMgr = IWTemplateProcessorFrame
    OnCreate = IWFrameRegionCreate
    object lblRichiestaOrig: TmeIWLabel
      Left = 52
      Top = 25
      Width = 140
      Height = 16
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
      FriendlyName = 'lblRichiestaOrig'
      Caption = 'Richiesta da rettificare'
      RawText = True
      Enabled = True
    end
    object lblErrore: TmeIWLabel
      Left = 54
      Top = 223
      Width = 123
      Height = 16
      Css = 'segnalazione'
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
      AutoSize = False
      FriendlyName = 'lblErrore'
      Enabled = True
    end
    object btnConferma: TmeIWButton
      Left = 54
      Top = 261
      Width = 75
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
      Caption = 'Conferma'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      TabOrder = 0
      OnClick = btnConfermaClick
      medpDownloadButton = False
    end
    object btnAnnulla: TmeIWButton
      Left = 158
      Top = 261
      Width = 75
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
      Caption = 'Annulla'
      Color = clBtnFace
      Font.Color = clNone
      Font.Enabled = False
      Font.Size = 10
      Font.Style = []
      FriendlyName = 'btnConferma'
      TabOrder = 1
      OnClick = btnAnnullaClick
      medpDownloadButton = False
    end
    object lblDal: TmeIWLabel
      Left = 52
      Top = 136
      Width = 18
      Height = 16
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
      ForControl = edtDal
      HasTabOrder = False
      FriendlyName = 'lblDal'
      Caption = 'dal'
      Enabled = True
    end
    object edtDal: TmeIWEdit
      Left = 76
      Top = 136
      Width = 73
      Height = 21
      Hint = 'Data di inizio del periodo da cancellare. Formato ddmmyyyy'
      Css = 'input_data_dmy'
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
      FriendlyName = 'edtDal'
      MaxLength = 10
      SubmitOnAsyncEvent = True
      TabOrder = 2
    end
    object lblAl: TmeIWLabel
      Left = 179
      Top = 136
      Width = 11
      Height = 16
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
      ForControl = edtAl
      HasTabOrder = False
      FriendlyName = 'lblAl'
      Caption = 'al'
      Enabled = True
    end
    object edtAl: TmeIWEdit
      Left = 205
      Top = 136
      Width = 73
      Height = 21
      Hint = 'Data di fine del periodo da cancellare. Formato ddmmyyyy'
      Css = 'input_data_dmy'
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
      FriendlyName = 'edtAl'
      MaxLength = 10
      SubmitOnAsyncEvent = True
      TabOrder = 3
    end
    object lblPeriodo: TmeIWLabel
      Left = 52
      Top = 114
      Width = 135
      Height = 16
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
      FriendlyName = 'lblPeriodo'
      Caption = 'Periodo da cancellare'
      RawText = True
      Enabled = True
    end
    object lblPeriodoOrig: TmeIWLabel
      Left = 76
      Top = 70
      Width = 80
      Height = 16
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
      FriendlyName = 'lblPeriodoOrig'
      Caption = 'Periodo orig.'
      RawText = True
      Enabled = True
    end
    object lblCausaleOrig: TmeIWLabel
      Left = 76
      Top = 48
      Width = 82
      Height = 16
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
      FriendlyName = 'lblRichiestaOrig'
      Caption = 'Causale orig.'
      RawText = True
      Enabled = True
    end
  end
  object IWTemplateProcessorFrame: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W010FCancPeriodoFM.html'
    RenderStyles = False
    Left = 64
    Top = 168
  end
  object jQVisFrame: TIWJQueryWidget
    Enabled = True
    Left = 176
    Top = 172
  end
  object jqPeriodo: TIWJQueryWidget
    Enabled = True
    OnReady.Strings = (
      'var w010Ini = new Date(%d, %d, %d);'
      'try {'
      '  var w010Fine = new Date(%d, %d, %d);'
      '  var $w010Dal = jQuery.root.find("#%s");'
      '  var $w010Al = jQuery.root.find("#%s");'
      '  if (($w010Dal.length) && ($w010Al.length)) {'
      '    var oldDate = $inputDal.val();'
      '    // limiti periodo'
      '    $w010Dal.datepicker("option", "minDate", w010Ini);'
      '    $w010Dal.datepicker("option", "maxDate", w010Fine);'
      '    $w010Al.datepicker("option", "minDate", w010Ini);'
      '    $w010Al.datepicker("option", "maxDate", w010Fine);'
      '  }'
      '}'
      'catch(err) {}'
      '')
    Left = 240
    Top = 172
  end
end
