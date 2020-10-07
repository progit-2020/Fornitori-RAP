object WR200FBaseFM: TWR200FBaseFM
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
    RenderInvisibleControls = False
    TabOrder = 0
    Align = alClient
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    LayoutMgr = TemplateProcessor
    OnCreate = IWFrameRegionCreate
  end
  object TemplateProcessor: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    RenderStyles = False
    Left = 96
    Top = 8
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 16
    Top = 8
  end
end
