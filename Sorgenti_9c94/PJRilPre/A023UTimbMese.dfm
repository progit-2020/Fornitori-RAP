object A023FTimbMese: TA023FTimbMese
  Left = 259
  Top = 252
  Caption = '<A023> Timbrature mensili'
  ClientHeight = 523
  ClientWidth = 437
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
  object Label7: TLabel
    Left = 201
    Top = 3
    Width = 80
    Height = 13
    AutoSize = False
    Caption = 'Timb. originali'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 201
    Top = 19
    Width = 80
    Height = 13
    AutoSize = False
    Caption = 'Timb. manuali'
  end
  object RichEdit1: TRichEdit
    Left = 0
    Top = 50
    Width = 437
    Height = 473
    Align = alClient
    Color = cl3DLight
    Ctl3D = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    HideScrollBars = False
    Lines.Strings = (
      'RichEdit1')
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 437
    Height = 50
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 90
      Top = 3
      Width = 110
      Height = 13
      AutoSize = False
      Caption = 'Linea1 : Timbrature'
    end
    object Label2: TLabel
      Left = 90
      Top = 19
      Width = 110
      Height = 13
      AutoSize = False
      Caption = 'Linea2 : Giustificativi'
    end
    object Label3: TLabel
      Left = 201
      Top = 3
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Timb. originali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 201
      Top = 19
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Timb. manuali'
    end
    object Label5: TLabel
      Left = 364
      Top = 3
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Presenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 364
      Top = 19
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Assenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 285
      Top = 3
      Width = 70
      Height = 13
      AutoSize = False
      Caption = 'E = Entrata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 285
      Top = 19
      Width = 70
      Height = 13
      AutoSize = False
      Caption = 'U = Uscita'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object G: TLabel
      Left = 364
      Top = 35
      Width = 80
      Height = 13
      AutoSize = False
      Caption = 'Giustificativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTMensa: TLabel
      Left = 90
      Top = 35
      Width = 131
      Height = 13
      Caption = 'Linea3 : Timbrature mensa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 6
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Stampa'
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
    end
  end
end
