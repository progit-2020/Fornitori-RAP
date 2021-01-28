object Ac08FRegistraIndFunzione: TAc08FRegistraIndFunzione
  Left = 116
  Top = 178
  HelpContext = 1008000
  Caption = '<Ac08> Calcolo indennit'#224' di funzione'
  ClientHeight = 226
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 207
    Width = 385
    Height = 19
    Panels = <
      item
        Width = 100
      end>
    SimpleText = '1 Record'
    SizeGrip = False
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 191
    Width = 385
    Height = 16
    Align = alBottom
    TabOrder = 1
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 385
    Height = 24
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitWidth = 385
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 385
      Height = 24
      ExplicitWidth = 385
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
    Width = 385
    Height = 167
    Align = alClient
    TabOrder = 0
    object lblAnno: TLabel
      Left = 24
      Top = 21
      Width = 25
      Height = 13
      Caption = 'Anno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMese: TLabel
      Left = 114
      Top = 21
      Width = 26
      Height = 13
      Caption = 'Mese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDa: TLabel
      Left = 243
      Top = 21
      Width = 16
      Height = 13
      Caption = 'Dal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblA: TLabel
      Left = 308
      Top = 21
      Width = 9
      Height = 13
      Caption = 'Al'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnAnomalie: TBitBtn
      Left = 145
      Top = 125
      Width = 90
      Height = 25
      Caption = '&Anomalie'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000333333333933333333333333333833333333000033333BFB999BFB333333
        333F3F080F3F333300003333BFBF393FBFB33333337F7F383F7F73330000333B
        FBFBFBFBFBFB33333FFFFFF7FFF7FF3300003333BFBFB9BFBFB33333337F7F78
        7F7FF3330000333BFBFBF98BFBFB333337FFF7F887FFF733000033BFBFBFB99F
        BFBFB333FF7FFFF08FFF7FF3000033FBFBFBFB99FBFB3333F7FFF7F780F7FF33
        000033BFBF88BF899FBFB333FFFF88FF808F7F730000333BFB99FB899BFB3333
        37F7087F8887FF3300003333BF998F899FB3333333FF888F880F73330000333B
        FBF99999FBFB33333FF7F08080FFFF3300003333BFBF999FBFB33333337FFF80
        8F7F7333000033333B3BFBFB3B333333333F37FFF73F3333000033333333BFB3
        33333333333333FF733333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 7
      OnClick = btnAnomalieClick
    end
    object BtnClose: TBitBtn
      Left = 271
      Top = 125
      Width = 90
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 8
    end
    object btnEsegui: TBitBtn
      Left = 24
      Top = 125
      Width = 90
      Height = 25
      Caption = '&Esegui'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
        8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
        3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
        FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
        FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
      TabOrder = 6
      OnClick = btnEseguiClick
    end
    object chkCalcola: TCheckBox
      Left = 24
      Top = 71
      Width = 90
      Height = 17
      Caption = 'Calcolo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkCalcolaClick
    end
    object chkAnnulla: TCheckBox
      Left = 145
      Top = 71
      Width = 90
      Height = 17
      Caption = 'Annullamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = chkCalcolaClick
    end
    object edtAnno: TSpinEdit
      Left = 54
      Top = 18
      Width = 53
      Height = 22
      MaxLength = 4
      MaxValue = 3000
      MinValue = 1900
      TabOrder = 0
      Value = 1997
      OnChange = cmbMeseChange
    end
    object cmbMese: TComboBox
      Left = 145
      Top = 18
      Width = 90
      Height = 21
      Style = csDropDownList
      DropDownCount = 12
      TabOrder = 1
      OnChange = cmbMeseChange
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
      Left = 264
      Top = 18
      Width = 38
      Height = 22
      MaxLength = 2
      MaxValue = 31
      MinValue = 1
      TabOrder = 2
      Value = 1
    end
    object edtA: TSpinEdit
      Left = 323
      Top = 17
      Width = 38
      Height = 22
      MaxLength = 2
      MaxValue = 31
      MinValue = 1
      TabOrder = 3
      Value = 31
    end
  end
end
