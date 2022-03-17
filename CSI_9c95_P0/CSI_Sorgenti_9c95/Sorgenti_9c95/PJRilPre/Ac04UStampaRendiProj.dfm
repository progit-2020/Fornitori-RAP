object Ac04FStampaRendiProj: TAc04FStampaRendiProj
  Left = 318
  Top = 173
  HelpContext = 1004000
  BorderIcons = [biSystemMenu]
  Caption = '<Ac04> Stampa rendicontazione'
  ClientHeight = 494
  ClientWidth = 571
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
    Top = 475
    Width = 571
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 459
    Width = 571
    Height = 16
    Align = alBottom
    TabOrder = 1
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 571
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 571
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 571
      Height = 24
      ExplicitWidth = 571
      ExplicitHeight = 24
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
  object Panel1: TPanel
    Left = 0
    Top = 24
    Width = 571
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblFeste: TLabel
      Left = 8
      Top = 58
      Width = 39
      Height = 13
      Caption = 'Progetti:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPartnerName: TLabel
      Left = 185
      Top = 8
      Width = 63
      Height = 13
      Caption = 'Partner name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMeseDal: TLabel
      Left = 8
      Top = 8
      Width = 44
      Height = 13
      Caption = 'Dal mese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtDaData: TSpeedButton
      Left = 62
      Top = 22
      Width = 14
      Height = 21
      Caption = '...'
      NumGlyphs = 2
      OnClick = sbtDaDataClick
    end
    object lblMeseAl: TLabel
      Left = 86
      Top = 8
      Width = 37
      Height = 13
      Caption = 'Al mese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtAData: TSpeedButton
      Left = 140
      Top = 22
      Width = 14
      Height = 21
      Caption = '...'
      NumGlyphs = 2
      OnClick = sbtADataClick
    end
    object edtPartnerName: TEdit
      Left = 185
      Top = 22
      Width = 377
      Height = 21
      TabOrder = 2
    end
    object edtDaData: TMaskEdit
      Left = 8
      Top = 22
      Width = 54
      Height = 21
      EditMask = '!99/0000;1;_'
      MaxLength = 7
      TabOrder = 0
      Text = '  /    '
      OnExit = edtDaDataExit
    end
    object edtAData: TMaskEdit
      Left = 86
      Top = 22
      Width = 54
      Height = 21
      EditMask = '!99/0000;1;_'
      MaxLength = 7
      TabOrder = 1
      Text = '  /    '
      OnDblClick = edtADataDblClick
      OnExit = edtADataExit
    end
  end
  object clbProgetti: TCheckListBox
    Left = 0
    Top = 97
    Width = 571
    Height = 306
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    Sorted = True
    TabOrder = 4
  end
  object Panel2: TPanel
    Left = 0
    Top = 403
    Width = 571
    Height = 56
    Align = alBottom
    TabOrder = 5
    object BtnPrinterSetUp: TBitBtn
      Left = 8
      Top = 15
      Width = 94
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
      TabOrder = 0
      OnClick = BtnPrinterSetUpClick
    end
    object BtnStampa: TBitBtn
      Left = 238
      Top = 15
      Width = 94
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
    object BtnClose: TBitBtn
      Left = 468
      Top = 15
      Width = 94
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 308
    Top = 12
  end
end
