object W035MessaggisticaFM: TW035MessaggisticaFM
  Left = 0
  Top = 0
  Width = 343
  Height = 169
  TabOrder = 0
  object IWFrameRegion: TIWRegion
    Left = 0
    Top = 0
    Width = 343
    Height = 169
    Cursor = crAuto
    RenderInvisibleControls = False
    TabOrder = 0
    Align = alClient
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clWebHOTPINK
    Color = clWebALICEBLUE
    ParentShowHint = False
    ShowHint = True
    ZIndex = 1000
    Splitter = False
  end
  object IWTemplateProcessorFrame: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'W032MotivazioneFM.html'
    RenderStyles = False
    Left = 64
    Top = 80
  end
end
