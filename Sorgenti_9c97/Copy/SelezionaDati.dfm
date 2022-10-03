object FSelezionaDati: TFSelezionaDati
  Left = 256
  Top = 319
  Width = 435
  Height = 275
  Caption = 'Ripristina campi'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 84
    Height = 13
    Caption = 'Dati disponibili'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 272
    Top = 16
    Width = 88
    Height = 13
    Caption = 'Dati selezionati'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ListBox1: TListBox
    Left = 32
    Top = 40
    Width = 121
    Height = 145
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
    OnClick = ListBox1Click
    OnDblClick = Button1Click
  end
  object ListBox2: TListBox
    Left = 272
    Top = 40
    Width = 121
    Height = 145
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 1
    OnClick = ListBox2Click
    OnDblClick = Button4Click
  end
  object Button1: TButton
    Left = 192
    Top = 40
    Width = 41
    Height = 25
    Caption = '>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 192
    Top = 80
    Width = 41
    Height = 25
    Caption = '>>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 192
    Top = 120
    Width = 41
    Height = 25
    Caption = '<<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 192
    Top = 160
    Width = 41
    Height = 25
    Caption = '<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TBitBtn
    Left = 112
    Top = 204
    Width = 75
    Height = 25
    TabOrder = 6
    Kind = bkOK
  end
  object Button6: TBitBtn
    Left = 236
    Top = 204
    Width = 75
    Height = 25
    Caption = 'Annulla'
    TabOrder = 7
    Kind = bkAbort
  end
end
