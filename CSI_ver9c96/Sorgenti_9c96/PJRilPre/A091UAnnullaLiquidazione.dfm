object A091FAnnullaLiquidazione: TA091FAnnullaLiquidazione
  Left = 435
  Top = 344
  BorderStyle = bsDialog
  Caption = '<A091> Annulla liquidazione'
  ClientHeight = 128
  ClientWidth = 379
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
  object lblMessaggio: TLabel
    Left = 8
    Top = 8
    Width = 61
    Height = 13
    Caption = 'lblMessaggio'
  end
  object btnEsegui: TBitBtn
    Left = 288
    Top = 36
    Width = 75
    Height = 25
    Caption = 'Esegui'
    Default = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    TabOrder = 1
    OnClick = btnEseguiClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 31
    Width = 205
    Height = 62
    Caption = 'Dati da annullare'
    TabOrder = 0
    object chkLiquidazioni: TCheckBox
      Left = 12
      Top = 28
      Width = 85
      Height = 17
      Caption = 'Liquidazioni'
      TabOrder = 0
      OnClick = chkLiquidazioniClick
    end
    object chkCompensazioni: TCheckBox
      Left = 100
      Top = 28
      Width = 97
      Height = 17
      Caption = 'Compensazioni'
      TabOrder = 1
      OnClick = chkLiquidazioniClick
    end
  end
  object BitBtn1: TBitBtn
    Left = 288
    Top = 68
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 2
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 112
    Width = 379
    Height = 16
    Align = alBottom
    TabOrder = 3
  end
end
