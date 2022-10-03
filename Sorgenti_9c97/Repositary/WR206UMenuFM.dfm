object WR206FMenuFM: TWR206FMenuFM
  Left = 0
  Top = 0
  Width = 534
  Height = 197
  TabOrder = 0
  object IWFrameRegion: TIWRegion
    Left = 0
    Top = 0
    Width = 534
    Height = 197
    RenderInvisibleControls = False
    OnRender = IWFrameRegionRender
    TabOrder = 0
    Align = alClient
    BorderOptions.NumericWidth = 1
    BorderOptions.BorderWidth = cbwNumeric
    BorderOptions.Style = cbsSolid
    BorderOptions.Color = clNone
    Color = clWebALICEBLUE
    ClipRegion = False
    OnCreate = IWFrameRegionCreate
    object IWMainMenu: TmeIWMenu
      Left = 200
      Top = 27
      Width = 313
      Height = 22
      Css = 'menu gradient'
      RenderSize = False
      StyleRenderOptions.RenderSize = False
      StyleRenderOptions.RenderPosition = False
      StyleRenderOptions.RenderFont = False
      StyleRenderOptions.RenderZIndex = False
      StyleRenderOptions.RenderStatus = False
      StyleRenderOptions.RenderAbsolute = False
      StyleRenderOptions.RenderPadding = False
      FriendlyName = 'IWMainMenu'
      ItemSpacing = itsNone
      AutoSize = mnaNone
      MainMenuStyle.MenuItemFont.Color = clNone
      MainMenuStyle.MenuItemFont.Enabled = False
      MainMenuStyle.MenuItemFont.Size = 10
      MainMenuStyle.MenuItemFont.Style = []
      MainMenuStyle.SelectedMenuItemFont.Color = clNone
      MainMenuStyle.SelectedMenuItemFont.Size = 10
      MainMenuStyle.SelectedMenuItemFont.Style = []
      MainMenuStyle.DisabledMenuItemFont.Color = clWebSILVER
      MainMenuStyle.DisabledMenuItemFont.Enabled = False
      MainMenuStyle.DisabledMenuItemFont.Size = 10
      MainMenuStyle.DisabledMenuItemFont.Style = []
      MainMenuStyle.BGColor = 14933984
      MainMenuStyle.ItemBGColor = clNone
      MainMenuStyle.SelectedItemBGColor = clNone
      MainMenuStyle.DisabledItemBGColor = clNone
      MainMenuStyle.BorderColor = clNone
      MainMenuStyle.Css = 'menuItem'
      MainMenuStyle.SelectedMenuCss = 'menuItem_selezionato'
      MainMenuStyle.DisabledMenuCss = 'menuItem_disabilitato'
      MainMenuStyle.Orientation = iwOHorizontal
      SubMenuStyle.MenuItemFont.Color = clNone
      SubMenuStyle.MenuItemFont.Enabled = False
      SubMenuStyle.MenuItemFont.Size = 10
      SubMenuStyle.MenuItemFont.Style = []
      SubMenuStyle.SelectedMenuItemFont.Color = clNone
      SubMenuStyle.SelectedMenuItemFont.Enabled = False
      SubMenuStyle.SelectedMenuItemFont.Size = 10
      SubMenuStyle.SelectedMenuItemFont.Style = []
      SubMenuStyle.DisabledMenuItemFont.Color = clWebSILVER
      SubMenuStyle.DisabledMenuItemFont.Enabled = False
      SubMenuStyle.DisabledMenuItemFont.Size = 10
      SubMenuStyle.DisabledMenuItemFont.Style = []
      SubMenuStyle.BGColor = clNone
      SubMenuStyle.ItemBGColor = clNone
      SubMenuStyle.SelectedItemBGColor = clNone
      SubMenuStyle.DisabledItemBGColor = clNone
      SubMenuStyle.BorderColor = clNone
      SubMenuStyle.Css = 'menuItem'
      SubMenuStyle.SelectedMenuCss = 'menuItem_selezionato'
      SubMenuStyle.DisabledMenuCss = 'menuItem_disabilitato'
      SubMenuStyle.Orientation = iwOVertical
      SubMenuCss = 'menu_tendina gradient'
      TimeOut = 0
    end
  end
  object TemplateProcessor: TIWTemplateProcessorHTML
    TagType = ttIntraWeb
    Left = 136
    Top = 16
  end
  object ActionList: TActionList
    Left = 108
    Top = 88
  end
  object MainMenu: TMainMenu
    Left = 40
    Top = 88
  end
  object JQuery: TIWJQueryWidget
    Enabled = True
    Left = 40
    Top = 16
  end
  object IWImageList: TmeIWImageListCache
    Left = 208
    Top = 88
  end
end
