object A047FAccessoManuale: TA047FAccessoManuale
  Left = 344
  Top = 202
  BorderStyle = bsDialog
  Caption = '<A047> Propriet'#224' pasto'
  ClientHeight = 155
  ClientWidth = 259
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 41
    Height = 13
    Caption = 'Causale:'
  end
  object Label2: TLabel
    Left = 8
    Top = 44
    Width = 51
    Height = 13
    Caption = 'Rilevatore:'
  end
  object rgpPasto: TRadioGroup
    Left = 8
    Top = 68
    Width = 242
    Height = 41
    Caption = 'Pasto'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Pranzo'
      'Cena')
    TabOrder = 0
  end
  object cmbCausali: TComboBox
    Left = 64
    Top = 13
    Width = 187
    Height = 22
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 122
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 104
    Top = 122
    Width = 75
    Height = 25
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
  end
  object cmbRilevatori: TComboBox
    Left = 64
    Top = 41
    Width = 187
    Height = 22
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
end
