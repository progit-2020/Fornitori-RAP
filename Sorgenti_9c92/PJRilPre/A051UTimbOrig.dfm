object A051FTimbOrig: TA051FTimbOrig
  Left = 302
  Top = 207
  HelpContext = 51000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A051> Stampa timbrature originali'
  ClientHeight = 305
  ClientWidth = 367
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
  object LblRaggr: TLabel
    Left = 6
    Top = 140
    Width = 177
    Height = 13
    Caption = 'Campo anagrafico di raggruppamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 6
    Top = 34
    Width = 28
    Height = 13
    Caption = 'Anno:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 130
    Top = 34
    Width = 29
    Height = 13
    Caption = 'Mese:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 6
    Top = 68
    Width = 48
    Height = 13
    Caption = 'Dal giorno'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 6
    Top = 91
    Width = 41
    Height = 13
    Caption = 'Al giorno'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BtnPrinterSetUp: TBitBtn
    Left = 11
    Top = 235
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
    TabOrder = 7
    OnClick = BtnPrinterSetUpClick
  end
  object BtnStampa: TBitBtn
    Left = 131
    Top = 236
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
    TabOrder = 8
    OnClick = BtnStampaClick
  end
  object BtnClose: TBitBtn
    Left = 255
    Top = 236
    Width = 100
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    TabOrder = 9
  end
  object dcmbCampoRaggr: TDBLookupComboBox
    Left = 6
    Top = 156
    Width = 212
    Height = 21
    KeyField = 'NOME_CAMPO'
    ListField = 'NOME_LOGICO'
    ListSource = A051FTimbOrigDtM1.D010
    TabOrder = 5
    OnKeyDown = dcmbCampoRaggrKeyDown
  end
  object edtAnno: TSpinEdit
    Left = 67
    Top = 30
    Width = 53
    Height = 22
    MaxLength = 4
    MaxValue = 3000
    MinValue = 1900
    TabOrder = 0
    Value = 1997
    OnChange = CmBMeseChange
  end
  object CmBMese: TComboBox
    Left = 167
    Top = 30
    Width = 148
    Height = 21
    Style = csDropDownList
    TabOrder = 1
    OnChange = CmBMeseChange
    Items.Strings = (
      'Gennaio'
      'Febbraio'
      'Marzo'
      'Aprile'
      'Maggio'
      'Giugno'
      'Luglio'
      'Agosto'
      'Settembre'
      'Ottobre'
      'Novembre'
      'Dicembre')
  end
  object edtDa: TSpinEdit
    Left = 67
    Top = 63
    Width = 53
    Height = 22
    MaxLength = 2
    MaxValue = 31
    MinValue = 1
    TabOrder = 2
    Value = 1
  end
  object edtA: TSpinEdit
    Left = 67
    Top = 86
    Width = 53
    Height = 22
    MaxLength = 2
    MaxValue = 31
    MinValue = 1
    TabOrder = 3
    Value = 31
  end
  object chkSaltoPagina: TCheckBox
    Left = 6
    Top = 113
    Width = 243
    Height = 17
    Caption = 'Salto pagina per dipendente/raggruppamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 270
    Width = 367
    Height = 16
    Align = alBottom
    TabOrder = 10
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 286
    Width = 367
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 367
    Height = 24
    Align = alTop
    TabOrder = 12
    TabStop = True
    ExplicitWidth = 367
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 367
      Height = 24
      ExplicitWidth = 367
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
  object rgpTimbrature: TRadioGroup
    Left = 7
    Top = 184
    Width = 350
    Height = 41
    Caption = 'Timbrature richieste'
    Columns = 4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Originali'
      'Cancellate'
      'Non originali'
      'Tutte')
    ParentFont = False
    TabOrder = 6
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 181
    Top = 61
  end
end
