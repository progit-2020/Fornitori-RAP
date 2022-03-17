inherited A082FCdcPercent: TA082FCdcPercent
  Tag = 162
  Left = 195
  Top = 162
  HelpContext = 82000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = '<A082> Centri di costo percentualizzati'
  ClientHeight = 405
  ClientWidth = 574
  ExplicitWidth = 590
  ExplicitHeight = 463
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 297
    Width = 574
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 285
    ExplicitWidth = 570
  end
  inherited StatusBar: TStatusBar
    Top = 387
    Width = 574
    Panels = <
      item
        Text = 'Data'
        Width = 70
      end
      item
        Text = 'Data lavoro'
        Width = 130
      end
      item
        Text = 'Records'
        Width = 100
      end
      item
        Text = 'Anagrafiche'
        Width = 100
      end
      item
        Text = 'Messaggi'
        Width = 150
      end>
    ExplicitTop = 387
    ExplicitWidth = 574
  end
  inherited grbDecorrenza: TGroupBox
    Top = 48
    Width = 574
    TabOrder = 2
    ExplicitTop = 48
    ExplicitWidth = 574
    inherited lblDecorrenza: TLabel
      Visible = False
    end
    inherited btnStoricizza: TSpeedButton
      Left = 316
      ExplicitLeft = 316
    end
    inherited dedtDecorrenza: TDBEdit
      DataField = 'DECORRENZA'
      Visible = False
    end
    inherited chkStoriciPrec: TCheckBox
      Visible = False
    end
    inherited chkStoriciSucc: TCheckBox
      Visible = False
    end
    object btnRipristino: TButton
      Left = 371
      Top = 10
      Width = 176
      Height = 24
      Caption = 'Ripristina situazione precedente'
      TabOrder = 3
      OnClick = btnRipristinoClick
    end
    object btnCopia: TBitBtn
      Left = 5
      Top = 10
      Width = 154
      Height = 24
      Action = actCopiaSuAltriDip
      Caption = 'Copia su altri dipendenti'
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1000100010001000100010001000
        100010001F7C1F7C1F7C1F7C1F7C1F7C1F7C1000FF7FFF7FFF7FFF7FFF7FFF7F
        FF7F10001F7C1F7C1F7C1F7C1F7C1F7C1F7C1000FF7F00000000000000000000
        FF7F10001F7C0000000000000000000000001000FF7FFF7FFF7FFF7FFF7FFF7F
        FF7F10001F7C0000FF7FFF7FFF7FFF7FFF7F1000FF7F00000000000000000000
        FF7F10001F7C0000FF7F00000000000000001000FF7FFF7FFF7FFF7FFF7FFF7F
        FF7F10001F7C0000FF7FFF7FFF7FFF7FFF7F1000FF7F00000000FF7F10001000
        100010001F7C0000FF7F00000000000000001000FF7FFF7FFF7FFF7F1000FF7F
        10001F7C1F7C0000FF7FFF7FFF7FFF7FFF7F1000FF7FFF7FFF7FFF7F10001000
        1F7C1F7C1F7C0000FF7F00000000FF7F00001000100010001000100010001F7C
        1F7C1F7C1F7C0000FF7FFF7FFF7FFF7F0000FF7F00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C0000FF7FFF7FFF7FFF7F000000001F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C0000000000000000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      TabOrder = 4
    end
  end
  inherited ToolBar1: TToolBar
    Top = 24
    Width = 574
    TabOrder = 1
    ExplicitTop = 24
    ExplicitWidth = 574
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [4]
    Left = 0
    Top = 0
    Width = 574
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 574
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 574
      Height = 24
      ExplicitWidth = 574
      ExplicitHeight = 24
      inherited btnPrimo: TSpeedButton
        OnClick = frmSelAnagrafebtnPrimoClick
      end
      inherited btnPrecedente: TSpeedButton
        OnClick = frmSelAnagrafebtnPrimoClick
      end
      inherited btnSuccessivo: TSpeedButton
        OnClick = frmSelAnagrafebtnPrimoClick
      end
      inherited btnUltimo: TSpeedButton
        OnClick = frmSelAnagrafebtnPrimoClick
      end
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
      inherited btnRicerca: TBitBtn
        OnClick = frmSelAnagrafebtnRicercaClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object dgrdCdcPercent: TDBGrid [5]
    Left = 0
    Top = 87
    Width = 574
    Height = 210
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PROGRESSIVO'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA_FINE'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODICE'
        PopupMenu = pmnNuovoElemento
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODICE_DESCRIZIONE'
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERCENTUALE'
        Width = 90
        Visible = True
      end>
  end
  object MemoControlli: TMemo [6]
    Left = 0
    Top = 300
    Width = 574
    Height = 87
    Align = alBottom
    Color = cl3DLight
    Lines.Strings = (
      'MemoControlli')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 5
  end
  inherited MainMenu1: TMainMenu [7]
    Left = 390
    Top = 65531
    inherited Strumenti1: TMenuItem
      inherited Primo1: TMenuItem
        Enabled = False
        Visible = False
      end
      inherited Precedente1: TMenuItem
        Enabled = False
        Visible = False
      end
      inherited Successivo1: TMenuItem
        Enabled = False
        Visible = False
      end
      inherited Ultimo1: TMenuItem
        Enabled = False
        Visible = False
      end
      inherited Inserisci1: TMenuItem
        Enabled = False
        Visible = False
      end
    end
  end
  inherited DButton: TDataSource [8]
    Left = 417
    Top = 65531
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [9]
    Left = 444
    Top = 65531
  end
  inherited ImageList1: TImageList [10]
    Left = 473
    Top = 65530
  end
  inherited ActionList1: TActionList
    Left = 500
    Top = 65530
    inherited actCopiaSu: TAction
      Visible = False
    end
    object actCopiaSuAltriDip: TAction
      Caption = 'Copia su altri dipendenti'
      Hint = 'Copia su altri dipendenti'
      ImageIndex = 11
      OnExecute = actCopiaSuAltriDipExecute
    end
  end
  object pmnNuovoElemento: TPopupMenu
    Left = 500
    Top = 124
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
