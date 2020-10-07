object C001FAllineaStampa: TC001FAllineaStampa
  Left = 120
  Top = 138
  HelpContext = 1001200
  BorderIcons = []
  Caption = '<C001> Imposta Allineamento'
  ClientHeight = 202
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 98
    Height = 13
    Caption = 'Oggetto da allineare:'
  end
  object Label2: TLabel
    Left = 216
    Top = 8
    Width = 112
    Height = 13
    Caption = 'Oggetto a cui allineare :'
  end
  object LblOggetto: TLabel
    Left = 8
    Top = 32
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 61
    Width = 100
    Height = 13
    Caption = 'Tipo di allineamento :'
  end
  object ListBoxOggetti: TListBox
    Left = 216
    Top = 32
    Width = 169
    Height = 145
    ItemHeight = 13
    TabOrder = 0
  end
  object BtnOk: TButton
    Left = 16
    Top = 166
    Width = 65
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
    OnClick = BtnOkClick
  end
  object Button2: TButton
    Left = 110
    Top = 166
    Width = 65
    Height = 25
    Cancel = True
    Caption = 'Annulla'
    ModalResult = 2
    TabOrder = 2
    OnClick = Button2Click
  end
  object CmbAllinea: TComboBox
    Left = 8
    Top = 88
    Width = 145
    Height = 21
    TabOrder = 3
    OnKeyPress = CmbAllineaKeyPress
    Items.Strings = (
      'Sotto'
      'a Destra'
      'a Sinistra'
      'Sopra'
      'Allineato in Alto'
      'Allineato in Basso'
      'Allineato a Sinistra'
      'Allineato a Destra')
  end
end
