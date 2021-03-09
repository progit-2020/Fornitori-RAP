object WC026FAllegatiIterFM: TWC026FAllegatiIterFM
  Left = 0
  Top = 0
  Width = 510
  Height = 246
  TabOrder = 0
  object IWFrameRegion: TIWRegion
    Left = 0
    Top = 0
    Width = 510
    Height = 246
    Cursor = crAuto
    RenderInvisibleControls = False
    TabOrder = 0
    Align = alClient
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    Color = clWebALICEBLUE
    ParentShowHint = False
    ShowHint = True
    ZIndex = 1000
    Splitter = False
    ExplicitWidth = 343
    ExplicitHeight = 169
  end
  object IWTemplateProcessorFrame: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Templates.Default = 'WC018FRiepilogoIterFM.html'
    RenderStyles = False
    Left = 72
    Top = 8
  end
  object jqAllegIter: TIWJQueryWidget
    Enabled = True
    Left = 368
    Top = 8
  end
end
