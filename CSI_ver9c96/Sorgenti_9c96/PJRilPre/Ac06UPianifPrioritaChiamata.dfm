object Ac06FPianifPrioritaChiamata: TAc06FPianifPrioritaChiamata
  Left = 370
  Top = 259
  HelpContext = 1006000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<Ac06> Priorit'#224' di chiamata reperibilit'#224
  ClientHeight = 493
  ClientWidth = 551
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
  object Panel1: TPanel
    Left = 0
    Top = 24
    Width = 551
    Height = 139
    Align = alTop
    TabOrder = 0
    object lblPrioritaChiamata: TLabel
      Left = 7
      Top = 44
      Width = 89
      Height = 13
      Caption = 'Priorit'#224' di chiamata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDataPartenza: TLabel
      Left = 7
      Top = 15
      Width = 78
      Height = 13
      Caption = 'Data di partenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnDataPartenza: TBitBtn
      Left = 171
      Top = 11
      Width = 15
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnDataPartenzaClick
    end
    object edtPrioritaChiamata: TSpinEdit
      Left = 105
      Top = 41
      Width = 35
      Height = 22
      MaxLength = 4
      MaxValue = 3
      MinValue = 1
      TabOrder = 2
      Value = 1
    end
    object btnInserisci: TBitBtn
      Left = 7
      Top = 102
      Width = 92
      Height = 23
      Caption = 'Inserisci'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000CE0E0000D80E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080000080000080FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF800000FFFFFF800000FFFFFF000000FFFFFFFFFFFFFFFFFF
        000080000080000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000008000
        00800000FFFFFFFFFFFFFFFFFFFFFFFF000080000080000080000080000080FF
        FFFFFFFFFF800000800000800000800000800000800000FFFFFFFFFFFFFFFFFF
        000080000080000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000008000
        00800000FFFFFFFFFFFFFFFFFFFFFFFF000080000080000080FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF800000FFFFFF800000FFFFFF000000FFFFFFFFFFFFFFFFFF
        000080000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000080FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 4
      OnClick = btnInserisciClick
    end
    object btnCancella: TBitBtn
      Left = 109
      Top = 102
      Width = 92
      Height = 23
      Caption = 'Cancella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF188FFFFF88FF1FFF1188FF
        FF10FF11FF8118FFF81FFF111FF1188F118FFF1111F8118811FFFF11111F1111
        1FFFFF1111FF81118FFFFF111F88111188FFFF11F811FF81188FFF1FFFFFFFF8
        1180FFFFFFFFFFFFF01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 5
      OnClick = btnInserisciClick
    end
    object chkTuttiDip: TCheckBox
      Left = 7
      Top = 73
      Width = 154
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Esegui per tutti i dipendenti '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtDataPartenza: TMaskEdit
      Left = 105
      Top = 11
      Width = 66
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnExit = edtDataPartenzaExit
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 163
    Width = 551
    Height = 295
    Align = alClient
    DataSource = Ac06FPianifPrioritaChiamataDM.dsrT381
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'PRIORITA'
        Width = 40
        Visible = True
      end>
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 474
    Width = 551
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '0 Records'
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 458
    Width = 551
    Height = 16
    Align = alBottom
    TabOrder = 3
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 551
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 551
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 551
      Height = 24
      ExplicitWidth = 551
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      Left = 240
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
end
