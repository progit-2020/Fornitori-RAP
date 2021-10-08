object A104FDialogStampa: TA104FDialogStampa
  Left = 162
  Top = 231
  HelpContext = 104000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A104> Stampa trasferte'
  ClientHeight = 265
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 246
    Width = 397
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 230
    Width = 397
    Height = 16
    Align = alBottom
    TabOrder = 1
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 397
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 397
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 397
      Height = 24
      ExplicitWidth = 397
      ExplicitHeight = 24
      inherited btnPrimo: TSpeedButton
        OnClick = frmSelAnagrafebtnPrimoClick
      end
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 24
    Width = 397
    Height = 171
    Align = alClient
    TabOrder = 3
    object Label2: TLabel
      Left = 88
      Top = 20
      Width = 105
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Mese scarico da:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 94
      Top = 52
      Width = 99
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Mese scarico a:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 121
      Top = 82
      Width = 72
      Height = 13
      Caption = 'Stato Missione:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label3: TLabel
      Left = 4
      Top = 128
      Width = 65
      Height = 13
      Caption = 'Titolo Stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtMeseScaricoDa: TMaskEdit
      Left = 195
      Top = 17
      Width = 66
      Height = 21
      EditMask = '99/0000;1;_'
      MaxLength = 7
      TabOrder = 0
      Text = '  /    '
      OnKeyUp = edtMeseScaricoDaKeyUp
    end
    object edtMeseScaricoA: TMaskEdit
      Left = 195
      Top = 49
      Width = 68
      Height = 21
      EditMask = '99/0000;1;_'
      MaxLength = 7
      TabOrder = 1
      Text = '  /    '
      OnKeyUp = edtMeseScaricoDaKeyUp
    end
    object ChkSaltoPagina: TCheckBox
      Left = 116
      Top = 111
      Width = 148
      Height = 14
      Alignment = taLeftJustify
      Caption = 'Salto pagina individuale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object Button1: TButton
      Left = 266
      Top = 17
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 3
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 266
      Top = 49
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 4
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 266
      Top = 80
      Width = 15
      Height = 21
      Caption = '...'
      TabOrder = 5
      OnClick = Button3Click
    end
    object EdtStato: TEdit
      Left = 196
      Top = 80
      Width = 68
      Height = 21
      ReadOnly = True
      TabOrder = 6
    end
    object EdtTitolo: TEdit
      Left = 4
      Top = 144
      Width = 389
      Height = 21
      TabOrder = 7
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 195
    Width = 397
    Height = 35
    Align = alBottom
    TabOrder = 4
    object BtnClose: TBitBtn
      Left = 269
      Top = 5
      Width = 100
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object BtnStampa: TBitBtn
      Left = 146
      Top = 5
      Width = 100
      Height = 25
      Caption = '&Stampa'
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
      TabOrder = 1
      OnClick = BtnStampaClick
    end
    object BtnPrinterSetUp: TBitBtn
      Left = 24
      Top = 5
      Width = 100
      Height = 25
      Caption = 'S&tampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
        070F00000000000007700778888778807070F000000000070700FF0777777770
        7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
        6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
      TabOrder = 2
      OnClick = BtnPrinterSetUpClick
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 344
  end
end
