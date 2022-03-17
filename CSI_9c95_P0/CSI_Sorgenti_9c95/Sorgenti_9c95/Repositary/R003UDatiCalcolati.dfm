inherited R003FDatiCalcolati: TR003FDatiCalcolati
  Left = 328
  Top = 115
  HelpContext = 77100
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A077> Dati calcolati'
  ClientHeight = 442
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 214
    Width = 542
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 474
  end
  inherited StatusBar: TStatusBar
    Top = 424
    ExplicitTop = 424
  end
  object dmemoEspressione: TDBMemo [3]
    Left = 0
    Top = 141
    Width = 542
    Height = 73
    Align = alTop
    DataField = 'ESPRESSIONE'
    DataSource = DButton
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 29
    Width = 542
    Height = 112
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 5
      Top = 8
      Width = 48
      Height = 13
      Caption = 'Serbatoio:'
    end
    object Label6: TLabel
      Left = 236
      Top = 8
      Width = 39
      Height = 13
      Caption = 'Stampa:'
    end
    object Label2: TLabel
      Left = 5
      Top = 35
      Width = 55
      Height = 13
      Caption = 'Nome dato:'
    end
    object Label3: TLabel
      Left = 0
      Top = 94
      Width = 60
      Height = 13
      Caption = 'Espressione:'
    end
    object dcmbSerbatoi: TDBComboBox
      Left = 65
      Top = 4
      Width = 160
      Height = 22
      Style = csOwnerDrawFixed
      DataField = 'ID_SERBATOIO'
      DataSource = DButton
      TabOrder = 0
      OnChange = dcmbSerbatoiChange
      OnDrawItem = dcmbSerbatoiDrawItem
    end
    object dcmbStampa: TDBComboBox
      Left = 281
      Top = 4
      Width = 160
      Height = 21
      DataField = 'CODICE_STAMPA'
      DataSource = DButton
      TabOrder = 1
      OnChange = dcmbSerbatoiChange
      OnDrawItem = dcmbSerbatoiDrawItem
    end
    object DBEdit1: TDBEdit
      Left = 65
      Top = 32
      Width = 376
      Height = 21
      DataField = 'NOME'
      DataSource = DButton
      TabOrder = 2
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 65
      Top = 55
      Width = 376
      Height = 33
      Caption = 'Formato'
      Columns = 5
      DataField = 'TIPO'
      DataSource = DButton
      Items.Strings = (
        'Testo'
        'Numero'
        'Ora'
        'Data'
        'Speciale')
      TabOrder = 3
      Values.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4')
    end
  end
  object Panel3: TPanel [5]
    Left = 0
    Top = 217
    Width = 542
    Height = 207
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object Splitter2: TSplitter
      Left = 236
      Top = 0
      Height = 207
      ExplicitHeight = 219
    end
    object Panel4: TPanel
      Left = 239
      Top = 0
      Width = 303
      Height = 207
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Label5: TLabel
        Left = 0
        Top = 0
        Width = 303
        Height = 13
        Align = alTop
        Alignment = taCenter
        Caption = 'Funzioni disponibili'
        ExplicitWidth = 87
      end
      object lstFunzioniDisponibili: TListBox
        Left = 0
        Top = 13
        Width = 303
        Height = 194
        Align = alClient
        ItemHeight = 13
        PopupMenu = PopupMenu2
        Sorted = True
        TabOrder = 0
        OnDblClick = lstFunzioniDisponibiliDblClick
      end
    end
    object Panel5: TPanel
      Left = 0
      Top = 0
      Width = 236
      Height = 207
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 1
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 236
        Height = 13
        Align = alTop
        Alignment = taCenter
        Caption = 'Dati disponibili'
        ExplicitWidth = 67
      end
      object lstDatiDisponibili: TListBox
        Left = 0
        Top = 13
        Width = 236
        Height = 194
        Align = alClient
        ItemHeight = 13
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnDblClick = lstDatiDisponibiliDblClick
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 336
    inherited File1: TMenuItem
      object actFiltroInutilizzati1: TMenuItem [2]
        Action = actFiltroInutilizzati
      end
    end
  end
  inherited DButton: TDataSource
    OnDataChange = DButtonDataChange
    Left = 364
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 392
  end
  inherited ImageList1: TImageList
    Left = 420
  end
  inherited ActionList1: TActionList
    Left = 448
    object actFiltroInutilizzati: TAction
      Caption = 'Solo dati non utilizzati'
      OnExecute = actFiltroInutilizzatiExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 3
    Top = 233
    object Ordinealfabetico1: TMenuItem
      Caption = 'Ordine alfabetico'
      OnClick = Ordinealfabetico1Click
    end
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu2Popup
    Left = 243
    Top = 233
    object VisualizzaCodice1: TMenuItem
      Caption = 'Visualizza codice'
      OnClick = VisualizzaCodice1Click
    end
  end
end
