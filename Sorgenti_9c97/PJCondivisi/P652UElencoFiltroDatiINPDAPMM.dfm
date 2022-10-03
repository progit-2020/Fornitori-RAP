object P652FElencoFiltroDatiINPDAPMM: TP652FElencoFiltroDatiINPDAPMM
  Left = 219
  Top = 172
  Width = 454
  Height = 296
  Caption = '<P652> Filtro Dati'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object clbListaDati: TCheckListBox
    Left = 0
    Top = 0
    Width = 446
    Height = 243
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    PopupMenu = pmnFiltroDati
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 243
    Width = 446
    Height = 26
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 94
      Top = 1
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object pmnFiltroDati: TPopupMenu
    Left = 22
    Top = 34
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Selezionatutto1Click
    end
  end
end
