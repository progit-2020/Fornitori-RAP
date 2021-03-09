object C020FVisualizzaDataSet: TC020FVisualizzaDataSet
  Left = 0
  Top = 0
  Caption = 'C020FVisualizzaDataSet'
  ClientHeight = 393
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotttom: TPanel
    Left = 0
    Top = 360
    Width = 640
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      640
      33)
    object btnChiudi: TBitBtn
      Left = 538
      Top = 4
      Width = 99
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Chiudi'
      Glyph.Data = {
        06010000424D0601000000000000760000002800000010000000120000000100
        04000000000090000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFF77
        F7F74444400FFFFFF444FFFF4D5007FFF4FFFFFF45D50FFFF4FFFFFF4D5D0FFF
        F4FFFFFF45D50FEFE4FFFFFF4D5D0FFFF4FFFFFF45D50FEFE4FFFFFF4D5D0FFF
        F4FFFFFF45D50FEFE4FFFFFF4D5D0EFEF4FFFFFF45D50FEFE4FFFFFF4D5D0EFE
        F4FFFFFF4444444444FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF0AAAA0
        FFFFFFFFFF000000FFFF}
      TabOrder = 0
      OnClick = btnChiudiClick
    end
  end
  object dGrdVisualizzazione: TDBGrid
    Left = 0
    Top = 0
    Width = 640
    Height = 360
    Align = alClient
    DataSource = dsrGenerico
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = ppMnu
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dGrdVisualizzazioneTitleClick
  end
  object dsrGenerico: TDataSource
    Left = 32
    Top = 24
  end
  object ppMnu: TPopupMenu
    Left = 128
    Top = 24
    object actRicercaTestoContenuto1: TMenuItem
      Action = actRicercaTestoContenuto
    end
    object actSuccessivo1: TMenuItem
      Action = actSuccessivo
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Deselezionatatutto1: TMenuItem
      Action = actSelezionaTutto
    end
    object Deselezionatatutto2: TMenuItem
      Action = actDeselezionaTutto
    end
    object Invertiselezione1: TMenuItem
      Action = actInvertiSelezione
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Copia1: TMenuItem
      Action = actCopia
    end
    object CopiaInExcel1: TMenuItem
      Action = actCopiaInExcel
    end
  end
  object ActionList1: TActionList
    Left = 160
    Top = 24
    object actRicercaTestoContenuto: TAction
      Caption = 'Ricerca contenuto'
      ShortCut = 16454
      OnExecute = actRicercaTestoContenutoExecute
    end
    object actSuccessivo: TAction
      Caption = 'Successivo'
      ShortCut = 114
      OnExecute = actRicercaTestoContenutoExecute
    end
    object actSelezionaTutto: TAction
      Caption = 'Seleziona tutto'
      OnExecute = actSelezionaTuttoExecute
    end
    object actDeselezionaTutto: TAction
      Caption = 'Deselezionata tutto'
      OnExecute = actDeselezionaTuttoExecute
    end
    object actInvertiSelezione: TAction
      Caption = 'Inverti selezione'
      OnExecute = actInvertiSelezioneExecute
    end
    object actCopia: TAction
      Caption = 'Copia'
      OnExecute = actCopiaExecute
    end
    object actCopiaInExcel: TAction
      Caption = 'Copia in Excel'
      OnExecute = actCopiaInExcelExecute
    end
  end
end
