object Bc28FTest: TBc28FTest
  Left = 0
  Top = 0
  Caption = '<Bc28 PrintServer>'
  ClientHeight = 313
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 375
    Top = 5
    Width = 31
    Height = 13
    Caption = 'Label1'
    Visible = False
  end
  object Button1: TButton
    Left = 8
    Top = 5
    Width = 113
    Height = 25
    Caption = 'Esegui stampa pova'
    TabOrder = 0
    Visible = False
    OnClick = Button1Click
  end
  object btnPrinters: TButton
    Left = 361
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Get printers'
    TabOrder = 1
    Visible = False
    OnClick = btnPrintersClick
  end
  object ListBox1: TListBox
    Left = 432
    Top = 24
    Width = 169
    Height = 225
    ItemHeight = 13
    TabOrder = 2
    Visible = False
  end
  object btnSetPrinter: TButton
    Left = 361
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Set printer'
    TabOrder = 3
    Visible = False
    OnClick = btnSetPrinterClick
  end
  object Button2: TButton
    Left = 8
    Top = 98
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A045'
    TabOrder = 4
    Visible = False
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 128
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A061'
    TabOrder = 5
    Visible = False
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 67
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A043'
    TabOrder = 6
    Visible = False
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 160
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A074'
    TabOrder = 7
    Visible = False
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 8
    Top = 36
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A042'
    TabOrder = 8
    Visible = False
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 8
    Top = 249
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A092'
    TabOrder = 9
    Visible = False
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 8
    Top = 191
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A081'
    TabOrder = 10
    Visible = False
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 8
    Top = 222
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A090'
    TabOrder = 11
    Visible = False
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 8
    Top = 280
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A116'
    TabOrder = 12
    Visible = False
    OnClick = Button10Click
  end
  object Button11: TButton
    Left = 122
    Top = 4
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A077'
    TabOrder = 13
    Visible = False
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 122
    Top = 35
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A059'
    TabOrder = 14
    Visible = False
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 122
    Top = 66
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A068'
    TabOrder = 15
    Visible = False
    OnClick = Button13Click
  end
  object Button14: TButton
    Left = 127
    Top = 97
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A058'
    TabOrder = 17
    Visible = False
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 127
    Top = 129
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A105'
    TabOrder = 16
    Visible = False
    OnClick = Button15Click
  end
  object Button16: TButton
    Left = 127
    Top = 160
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A051'
    TabOrder = 18
    Visible = False
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 127
    Top = 191
    Width = 113
    Height = 25
    Caption = 'Esegui Stampa 104'
    TabOrder = 19
    Visible = False
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 127
    Top = 218
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A047'
    TabOrder = 20
    Visible = False
    OnClick = Button18Click
  end
  object Button19: TButton
    Left = 127
    Top = 249
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A167'
    TabOrder = 21
    Visible = False
    OnClick = Button19Click
  end
  object Button20: TButton
    Left = 127
    Top = 280
    Width = 113
    Height = 25
    Caption = 'Esegui stampa A145'
    TabOrder = 22
    Visible = False
    OnClick = Button20Click
  end
  object Button21: TButton
    Left = 241
    Top = 4
    Width = 113
    Height = 25
    Caption = 'Esegui stampa S715'
    TabOrder = 23
    Visible = False
    WordWrap = True
    OnClick = Button21Click
  end
  object Button22: TButton
    Left = 242
    Top = 35
    Width = 113
    Height = 25
    Caption = 'Esegui stampa Ac04'
    TabOrder = 24
    Visible = False
    WordWrap = True
    OnClick = Button22Click
  end
  object DCOMConnection1: TDCOMConnection
    ServerGUID = '{0C94F43B-4783-4BA0-9128-297C40CEE7EF}'
    ServerName = 'Bc28PPrintServer_COM.Bc28PrintServer'
    ComputerName = 'localhost'
    Left = 376
    Top = 152
  end
end
