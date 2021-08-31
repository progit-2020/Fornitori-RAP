object C001FLineSettings: TC001FLineSettings
  Left = 1
  Top = 16
  HelpContext = 1001200
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<C001> Impostazione della linea'
  ClientHeight = 202
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GBDimensioni: TGroupBox
    Left = 218
    Top = 5
    Width = 155
    Height = 77
    Caption = 'Dimensioni'
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 24
      Width = 44
      Height = 13
      Caption = 'Spessore'
    end
    object Label2: TLabel
      Left = 10
      Top = 50
      Width = 49
      Height = 13
      Caption = 'Larghezza'
    end
    object EAltezza: TEdit
      Left = 82
      Top = 19
      Width = 57
      Height = 21
      TabOrder = 0
      OnChange = EAltezzaChange
      OnKeyPress = FiltraTasti
    end
    object ELarghezza: TEdit
      Left = 82
      Top = 43
      Width = 58
      Height = 21
      TabOrder = 1
      OnChange = ELarghezzaChange
      OnKeyPress = FiltraTasti
    end
  end
  object RGTratteggio: TRadioGroup
    Left = 4
    Top = 5
    Width = 208
    Height = 192
    Caption = 'Tratteggio'
    ItemIndex = 0
    Items.Strings = (
      'Nessuno                      ___________'
      'Normale  linea lunga    __  __  __  __ '
      'Normale  linea corta     _  _  _  _  _'
      'Tratto punto                 __ . __ . __ .'
      'Linea Linea                 -- -- -- -- -- -- -- '
      'Tratto Punto Punto     __ -- __ -- __'
      'Linea-Linea-Linea       ---  --- --- --- ---   ')
    TabOrder = 1
    OnClick = RGTratteggioClick
  end
  object BitBtn1: TBitBtn
    Left = 218
    Top = 172
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 298
    Top = 172
    Width = 75
    Height = 25
    Caption = '&Annulla'
    TabOrder = 3
    Kind = bkCancel
  end
  object RGAllineamento: TRadioGroup
    Left = 218
    Top = 89
    Width = 155
    Height = 74
    Caption = 'Allineamento'
    ItemIndex = 0
    Items.Strings = (
      'Centrata'
      'Sinistra'
      'Destra')
    TabOrder = 4
    OnClick = RGAllineamentoClick
  end
end
