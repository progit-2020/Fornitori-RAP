object A002FAnagrafeGestPadre: TA002FAnagrafeGestPadre
  Left = 132
  Top = 186
  HelpContext = 2100
  Caption = 'Scheda dati anagrafici'
  ClientHeight = 512
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 655
    Height = 38
    Align = alTop
    TabOrder = 0
    object Label48: TLabel
      Left = 128
      Top = 2
      Width = 41
      Height = 13
      Caption = 'Badge:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 170
      Top = 2
      Width = 61
      Height = 13
      DataField = 'Badge'
      DataSource = A002FAnagrafeDtM1.D430
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 236
      Top = 2
      Width = 42
      Height = 13
      AutoSize = True
      DataField = 'NomeCognome'
      DataSource = A002FAnagrafeDtM1.D030
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 5
      Top = 17
      Width = 73
      Height = 13
      Caption = 'Periodo storico:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText3: TDBText
      Left = 82
      Top = 17
      Width = 58
      Height = 13
      DataField = 'DATADECORRENZA'
      DataSource = A002FAnagrafeDtM1.D430
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 143
      Top = 17
      Width = 3
      Height = 13
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText4: TDBText
      Left = 150
      Top = 17
      Width = 58
      Height = 13
      DataField = 'DATAFINE'
      DataSource = A002FAnagrafeDtM1.D430
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 218
      Top = 17
      Width = 90
      Height = 13
      Caption = 'Rapporto di lavoro:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText5: TDBText
      Left = 309
      Top = 17
      Width = 58
      Height = 13
      DataField = 'INIZIO'
      DataSource = A002FAnagrafeDtM1.D430
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 369
      Top = 17
      Width = 3
      Height = 13
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText6: TDBText
      Left = 375
      Top = 17
      Width = 58
      Height = 13
      DataField = 'FINE'
      DataSource = A002FAnagrafeDtM1.D430
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText7: TDBText
      Left = 62
      Top = 2
      Width = 61
      Height = 13
      DataField = 'MATRICOLA'
      DataSource = A002FAnagrafeDtM1.D030
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 4
      Top = 2
      Width = 57
      Height = 13
      Caption = 'Matricola:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 493
    Width = 655
    Height = 19
    Panels = <
      item
        Text = 'Data'
        Width = 130
      end
      item
        Text = 'Records'
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 101
    Width = 655
    Height = 392
    ActivePage = TabSheet3
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabHeight = 18
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Dati Anagrafici'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object L1: TLabel
        Tag = 1
        Left = 8
        Top = 6
        Width = 43
        Height = 13
        Caption = 'Matricola'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L2: TLabel
        Tag = 2
        Left = 92
        Top = 6
        Width = 45
        Height = 13
        Caption = 'Cognome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L3: TLabel
        Tag = 3
        Left = 228
        Top = 6
        Width = 28
        Height = 13
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L7: TLabel
        Tag = 7
        Left = 362
        Top = 6
        Width = 31
        Height = 13
        Caption = 'Badge'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L53: TLabel
        Tag = 7
        Left = 424
        Top = 6
        Width = 40
        Height = 13
        Caption = 'Edizione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L4: TLabel
        Tag = 4
        Left = 148
        Top = 46
        Width = 60
        Height = 13
        Caption = 'Data nascita'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L5: TLabel
        Tag = 5
        Left = 228
        Top = 46
        Width = 87
        Height = 13
        Caption = 'Comune di nascita'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L6: TLabel
        Tag = 6
        Left = 427
        Top = 46
        Width = 21
        Height = 13
        Caption = 'CAP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L50: TLabel
        Tag = 6
        Left = 479
        Top = 46
        Width = 25
        Height = 13
        Caption = 'Prov.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L52: TLabel
        Left = 8
        Top = 86
        Width = 66
        Height = 13
        Caption = 'Codice fiscale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTelefono: TLabel
        Left = 148
        Top = 86
        Width = 42
        Height = 13
        Caption = 'Telefono'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblIndirizzo: TLabel
        Left = 8
        Top = 126
        Width = 38
        Height = 13
        Caption = 'Indirizzo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblComune: TLabel
        Tag = 9
        Left = 228
        Top = 126
        Width = 98
        Height = 13
        Caption = 'Comune di residenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCap: TLabel
        Left = 428
        Top = 126
        Width = 21
        Height = 13
        Caption = 'CAP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblProvincia: TLabel
        Left = 480
        Top = 126
        Width = 25
        Height = 13
        Caption = 'Prov.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L15: TLabel
        Left = 8
        Top = 206
        Width = 66
        Height = 13
        Caption = 'Inizio rapporto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L16: TLabel
        Left = 100
        Top = 206
        Width = 62
        Height = 13
        Caption = 'Fine rapporto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L17: TLabel
        Left = 256
        Top = 206
        Width = 145
        Height = 13
        Caption = 'Data inizio servizio (comp.ferie)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L54: TLabel
        Tag = 10
        Left = 8
        Top = 244
        Width = 63
        Height = 13
        Caption = 'Tipo rapporto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LTipoRapp: TDBText
        Left = 79
        Top = 262
        Width = 170
        Height = 13
        DataField = 'D_TipoRapporto'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L28: TLabel
        Left = 256
        Top = 244
        Width = 77
        Height = 13
        Caption = 'Terminali abilitati'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L26: TLabel
        Tag = 10
        Left = 8
        Top = 284
        Width = 63
        Height = 13
        Caption = 'Squadra turni'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LSquadra: TDBText
        Left = 79
        Top = 302
        Width = 170
        Height = 13
        DataField = 'D_Squadra'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L27: TLabel
        Left = 256
        Top = 284
        Width = 69
        Height = 13
        Caption = 'Tipo operatore'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L57: TLabel
        Left = 8
        Top = 325
        Width = 87
        Height = 13
        Caption = 'Inizio ind.maternit'#224
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L58: TLabel
        Left = 115
        Top = 325
        Width = 83
        Height = 13
        Caption = 'Fine ind.maternit'#224
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LI060EMail: TLabel
        Tag = 2
        Left = 256
        Top = 86
        Width = 26
        Height = 13
        Caption = 'EMail'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblIndirizzoDomBase: TLabel
        Left = 8
        Top = 166
        Width = 92
        Height = 13
        Caption = 'Indirizzo di domicilio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblComuneDomBase: TLabel
        Tag = 9
        Left = 228
        Top = 166
        Width = 93
        Height = 13
        Caption = 'Comune di domicilio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCapDomBase: TLabel
        Left = 428
        Top = 166
        Width = 47
        Height = 13
        Caption = 'CAP dom.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblProvinciaDomBase: TLabel
        Left = 480
        Top = 166
        Width = 51
        Height = 13
        Caption = 'Prov. dom.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object EMatricola: TDBEdit
        Tag = 1
        Left = 8
        Top = 20
        Width = 57
        Height = 21
        HelpContext = 2300
        DataField = 'Matricola'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 0
      end
      object ECognome: TDBEdit
        Tag = 2
        Left = 92
        Top = 20
        Width = 121
        Height = 21
        HelpContext = 2300
        DataField = 'Cognome'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 1
      end
      object ENome: TDBEdit
        Tag = 3
        Left = 228
        Top = 20
        Width = 121
        Height = 21
        HelpContext = 2300
        DataField = 'Nome'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 2
      end
      object EditBadge: TDBEdit
        Tag = 7
        Left = 362
        Top = 20
        Width = 57
        Height = 21
        Hint = 
          'BADGE LIBERI: <Ctrl + A> Primo   <Ctrl + Z> Ultimo   <Doppio cli' +
          'ck> Successivo'
        HelpContext = 2300
        DataField = 'Badge'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        TabOrder = 3
        OnDblClick = EditBadgeDblClick
        OnKeyDown = EditBadgeKeyDown
      end
      object EEdBadge: TDBEdit
        Tag = 7
        Left = 424
        Top = 20
        Width = 43
        Height = 21
        HelpContext = 2300
        DataField = 'EDBADGE'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 4
      end
      object DBRadioGroup1: TDBRadioGroup
        Left = 8
        Top = 48
        Width = 133
        Height = 33
        HelpContext = 2300
        Caption = 'Sesso'
        Columns = 2
        DataField = 'Sesso'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Maschio'
          'Femmina')
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 5
        TabStop = True
        Values.Strings = (
          'M'
          'F')
      end
      object ENascita: TDBEdit
        Tag = 4
        Left = 148
        Top = 60
        Width = 65
        Height = 21
        HelpContext = 2300
        DataField = 'DataNas'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 6
      end
      object LookupComune: TDBLookupComboBox
        Tag = 1
        Left = 228
        Top = 60
        Width = 137
        Height = 21
        HelpContext = 2300
        DataField = 'DescComune'
        DataSource = A002FAnagrafeDtM1.D030
        DropDownWidth = 280
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ListField = 'Citta;Provincia;Codice'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 7
      end
      object EComune: TDBEdit
        Tag = 5
        Left = 364
        Top = 60
        Width = 60
        Height = 21
        HelpContext = 2300
        DataField = 'ComuneNas'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 8
      end
      object ECapNas: TDBEdit
        Tag = 6
        Left = 428
        Top = 60
        Width = 48
        Height = 21
        HelpContext = 2300
        DataField = 'CAPNas'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 9
        OnDblClick = ECapNasDblClick
        OnKeyDown = ECapNasKeyDown
      end
      object EProvNas: TDBEdit
        Tag = 6
        Left = 480
        Top = 60
        Width = 30
        Height = 21
        HelpContext = 2300
        DataField = 'D_ProvinciaNas'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 10
        OnDblClick = ECapNasDblClick
      end
      object ECodFiscale: TDBEdit
        Left = 8
        Top = 100
        Width = 133
        Height = 21
        HelpContext = 2300
        DataField = 'CODFISCALE'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 11
        OnEnter = ECodFiscaleEnter
        OnKeyDown = ECodFiscaleKeyDown
      end
      object dedtTelefono: TDBEdit
        Left = 148
        Top = 100
        Width = 103
        Height = 21
        HelpContext = 2300
        DataField = 'Telefono'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 12
      end
      object dedtIndirizzo: TDBEdit
        Left = 8
        Top = 140
        Width = 209
        Height = 21
        HelpContext = 2300
        DataField = 'Indirizzo'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 13
      end
      object dcmbComune: TDBLookupComboBox
        Tag = 1
        Left = 228
        Top = 140
        Width = 137
        Height = 21
        HelpContext = 2300
        DataField = 'D_COMUNE'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 280
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ListField = 'CITTA;PROVINCIA;CODICE'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 14
      end
      object dedtComune: TDBEdit
        Tag = 9
        Left = 364
        Top = 140
        Width = 60
        Height = 21
        HelpContext = 2300
        DataField = 'Comune'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 15
      end
      object dedtCap: TDBEdit
        Left = 428
        Top = 140
        Width = 48
        Height = 21
        HelpContext = 2300
        DataField = 'CAP'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 16
        OnDblClick = ECapNasDblClick
        OnKeyDown = ECapNasKeyDown
      end
      object dedtProvincia: TDBEdit
        Left = 480
        Top = 140
        Width = 30
        Height = 21
        HelpContext = 2300
        DataField = 'D_Provincia'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 17
        OnDblClick = ECapNasDblClick
      end
      object EInizio: TDBEdit
        Left = 8
        Top = 220
        Width = 83
        Height = 21
        HelpContext = 2300
        DataField = 'Inizio'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 18
      end
      object EFine: TDBEdit
        Left = 100
        Top = 220
        Width = 83
        Height = 21
        HelpContext = 2300
        DataField = 'Fine'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 19
      end
      object EInizioServizio: TDBEdit
        Left = 256
        Top = 220
        Width = 83
        Height = 21
        HelpContext = 2300
        DataField = 'INIZIOSERVIZIO'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 20
      end
      object ETipoRapp: TDBLookupComboBox
        Tag = 12
        Left = 8
        Top = 258
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'TIPORAPPORTO'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        TabOrder = 22
        OnKeyDown = dcmbKeyDown
      end
      object ETerminali: TDBEdit
        Left = 256
        Top = 258
        Width = 93
        Height = 21
        HelpContext = 2300
        DataField = 'Terminali'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 23
      end
      object ESquadra: TDBLookupComboBox
        Tag = 2
        Left = 8
        Top = 298
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'Squadra'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 24
        OnKeyDown = dcmbKeyDown
      end
      object ETipoOpe: TDBEdit
        Left = 256
        Top = 298
        Width = 47
        Height = 21
        HelpContext = 2300
        DataField = 'TipoOpe'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 25
      end
      object dchkRapportiUniti: TDBCheckBox
        Left = 368
        Top = 222
        Width = 141
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Rapporti di lavoro unificati'
        DataField = 'RAPPORTI_UNITI'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 21
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBRadioGroup2: TDBRadioGroup
        Left = 477
        Top = 9
        Width = 122
        Height = 33
        HelpContext = 2300
        Caption = 'Tipo personale'
        Columns = 2
        DataField = 'TIPO_PERSONALE'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Interno'
          'Esterno')
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 26
        TabStop = True
        Values.Strings = (
          'I'
          'E')
      end
      object dchkDocente: TDBCheckBox
        Left = 448
        Top = 262
        Width = 61
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Docente'
        DataField = 'DOCENTE'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 27
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object EInizioIndMat: TDBEdit
        Left = 8
        Top = 338
        Width = 83
        Height = 21
        HelpContext = 2300
        DataField = 'INIZIO_IND_MAT'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 28
      end
      object EFineIndMat: TDBEdit
        Left = 115
        Top = 338
        Width = 83
        Height = 21
        HelpContext = 2300
        DataField = 'FINE_IND_MAT'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 29
      end
      object EI060EMail: TDBEdit
        Tag = 2
        Left = 256
        Top = 100
        Width = 217
        Height = 21
        HelpContext = 2300
        DataField = 'I060EMAIL'
        DataSource = A002FAnagrafeDtM1.D030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 30
        OnDblClick = EI060EMailDblClick
      end
      object dedtIndirizzoDomBase: TDBEdit
        Left = 8
        Top = 182
        Width = 209
        Height = 21
        HelpContext = 2300
        DataField = 'INDIRIZZO_DOM_BASE'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 31
      end
      object dcmbComuneDomBase: TDBLookupComboBox
        Tag = 1
        Left = 228
        Top = 182
        Width = 137
        Height = 21
        HelpContext = 2300
        DataField = 'D_COMUNE_DOM_BASE'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 280
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ListField = 'CITTA;PROVINCIA;CODICE'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 32
      end
      object dedtComuneDomBase: TDBEdit
        Tag = 9
        Left = 364
        Top = 182
        Width = 60
        Height = 21
        HelpContext = 2300
        DataField = 'COMUNE_DOM_BASE'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 33
      end
      object dedtCapDomBase: TDBEdit
        Left = 428
        Top = 182
        Width = 48
        Height = 21
        HelpContext = 2300
        DataField = 'CAP_DOM_BASE'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 34
        OnDblClick = ECapNasDblClick
        OnKeyDown = ECapNasKeyDown
      end
      object dedtProvinciaDomBase: TDBEdit
        Left = 480
        Top = 182
        Width = 30
        Height = 21
        HelpContext = 2300
        DataField = 'D_PROVINCIA_DOM_BASE'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 35
        OnDblClick = ECapNasDblClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Parametri orario'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object L29: TLabel
        Tag = 10
        Left = 8
        Top = 87
        Width = 43
        Height = 13
        Caption = 'Contratto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LContratto: TDBText
        Left = 79
        Top = 104
        Width = 170
        Height = 13
        DataField = 'D_Contratto'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L30: TLabel
        Left = 278
        Top = 87
        Width = 69
        Height = 13
        Caption = 'Ore settimanali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L55: TLabel
        Tag = 10
        Left = 278
        Top = 126
        Width = 45
        Height = 13
        Caption = 'Part Time'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LPartTime: TDBText
        Left = 349
        Top = 144
        Width = 170
        Height = 13
        DataField = 'D_PartTime'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L32: TLabel
        Tag = 10
        Left = 278
        Top = 168
        Width = 50
        Height = 13
        Caption = 'Calendario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LCalendario: TDBText
        Left = 349
        Top = 185
        Width = 170
        Height = 13
        DataField = 'D_Calendario'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L31: TLabel
        Tag = 10
        Left = 8
        Top = 210
        Width = 83
        Height = 13
        Caption = 'Debito aggiuntivo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LPlusOra: TDBText
        Left = 79
        Top = 227
        Width = 170
        Height = 13
        DataField = 'D_PlusOra'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L34: TLabel
        Tag = 10
        Left = 278
        Top = 210
        Width = 58
        Height = 13
        Caption = 'Profilo orario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LPOrario: TDBText
        Left = 349
        Top = 227
        Width = 170
        Height = 13
        DataField = 'D_POrario'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L33: TLabel
        Tag = 10
        Left = 8
        Top = 250
        Width = 101
        Height = 13
        Caption = 'Indennit'#224' di presenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LIPresenza: TDBText
        Left = 79
        Top = 267
        Width = 170
        Height = 13
        DataField = 'D_IPresenza'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L56: TLabel
        Tag = 10
        Left = 278
        Top = 250
        Width = 66
        Height = 13
        Caption = 'Tipo cartellino'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LTipoCart: TDBText
        Left = 349
        Top = 267
        Width = 170
        Height = 13
        DataField = 'D_TIPOCART'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ECausStraord: TDBCheckBox
        Left = 8
        Top = 3
        Width = 191
        Height = 17
        HelpContext = 2300
        Alignment = taLeftJustify
        Caption = 'Causale per straordinario fuori fascia'
        DataField = 'CausStraord'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 0
        ValueChecked = 'O'
        ValueUnchecked = 'F'
      end
      object EStraordE: TDBRadioGroup
        Left = 8
        Top = 21
        Width = 130
        Height = 63
        HelpContext = 2300
        Caption = 'Straord. su prima entrata'
        DataField = 'StraordE'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Inibito'
          'Causalizzato'
          'Libero')
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 1
        TabStop = True
        Values.Strings = (
          '0'
          '1'
          '2')
      end
      object EStraordEU2: TDBRadioGroup
        Left = 143
        Top = 21
        Width = 150
        Height = 63
        HelpContext = 2300
        Caption = 'Straord. su prima uscita'
        DataField = 'StraordEU2'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Inibito'
          'Causalizzato'
          'Libero')
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 2
        TabStop = True
        Values.Strings = (
          '0'
          '1'
          '2')
      end
      object EStraordEU: TDBRadioGroup
        Left = 298
        Top = 21
        Width = 150
        Height = 63
        HelpContext = 2300
        Caption = 'Straord. su seconda entrata'
        DataField = 'StraordEU'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Inibito'
          'Causalizzato'
          'Libero')
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 3
        TabStop = True
        Values.Strings = (
          '0'
          '1'
          '2')
      end
      object EStraordU: TDBRadioGroup
        Left = 453
        Top = 21
        Width = 130
        Height = 63
        HelpContext = 2300
        Caption = 'Straord. su ultima uscita'
        DataField = 'StraordU'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Inibito'
          'Causalizzato'
          'Libero')
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 4
        TabStop = True
        Values.Strings = (
          '0'
          '1'
          '2')
      end
      object EContratto: TDBLookupComboBox
        Tag = 3
        Left = 8
        Top = 101
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'Contratto'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 5
        OnKeyDown = dcmbKeyDown
      end
      object EOrario: TDBEdit
        Left = 278
        Top = 101
        Width = 47
        Height = 21
        HelpContext = 2300
        DataField = 'Orario'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 6
      end
      object ETGestione: TDBCheckBox
        Left = 364
        Top = 103
        Width = 99
        Height = 17
        HelpContext = 2300
        Alignment = taLeftJustify
        Caption = 'Gestione turnista'
        DataField = 'TGestione'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 7
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object EHTeoriche: TDBRadioGroup
        Left = 3
        Top = 128
        Width = 244
        Height = 84
        HelpContext = 2300
        Caption = 'Ore teoriche'
        DataField = 'HTeoriche'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Giornaliero/mensile da gg.lavorativi'
          'Giornaliero/mensile da tipo orario'
          'Giorn. da tipo orario, mens. da calendario'
          'Giornaliero/Mensile da calendario'
          'Giorn. da tipo orario, mens. da gg.lavorativi')
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 8
        TabStop = True
        Values.Strings = (
          '0'
          '1'
          '2'
          '3'
          '4')
      end
      object EParttime: TDBLookupComboBox
        Tag = 13
        Left = 278
        Top = 141
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'PARTTIME'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 9
        OnKeyDown = dcmbKeyDown
      end
      object ECalendario: TDBLookupComboBox
        Tag = 5
        Left = 278
        Top = 182
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'Calendario'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 10
        OnKeyDown = dcmbKeyDown
      end
      object EPlusOra: TDBLookupComboBox
        Tag = 4
        Left = 8
        Top = 224
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'PlusOra'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 11
        OnKeyDown = dcmbKeyDown
      end
      object EPOrario: TDBLookupComboBox
        Tag = 7
        Left = 278
        Top = 224
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'POrario'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 12
        OnKeyDown = dcmbKeyDown
      end
      object EIPresenza: TDBLookupComboBox
        Tag = 6
        Left = 8
        Top = 264
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'IPRESENZA'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 13
        OnKeyDown = dcmbKeyDown
      end
      object ETipoCart: TDBLookupComboBox
        Tag = 11
        Left = 278
        Top = 264
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'PERSELASTICO'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 14
        OnKeyDown = dcmbKeyDown
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Presenze/Assenze'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object L35: TLabel
        Tag = 10
        Left = 8
        Top = 6
        Width = 71
        Height = 13
        Caption = 'Profilo assenze'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LPAssenze: TDBText
        Left = 79
        Top = 23
        Width = 170
        Height = 13
        DataField = 'D_PAssenze'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L42: TLabel
        Tag = 10
        Left = 8
        Top = 86
        Width = 83
        Height = 13
        Caption = 'Presenze abilitate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object L36: TLabel
        Tag = 10
        Left = 8
        Top = 46
        Width = 79
        Height = 13
        Caption = 'Assenze abilitate'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblLocalitaDistLavoro: TLabel
        Tag = 9
        Left = 168
        Top = 169
        Width = 37
        Height = 13
        Caption = 'Localit'#224
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblQualificaMinisteriale: TLabel
        Tag = 10
        Left = 8
        Top = 124
        Width = 95
        Height = 13
        Caption = 'Qualifica ministeriale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dlblQualificaMinisteriale: TDBText
        Left = 79
        Top = 142
        Width = 360
        Height = 13
        DataField = 'D_QUALIFICAMINIST'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblMedicinaLegale: TLabel
        Tag = 10
        Left = 8
        Top = 207
        Width = 74
        Height = 13
        Caption = 'Medicina legale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dlblMedicinaLegale: TDBText
        Left = 120
        Top = 227
        Width = 255
        Height = 13
        DataField = 'D_MEDICINA_LEGALE'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object EPAssenze: TDBLookupComboBox
        Tag = 8
        Left = 8
        Top = 20
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'PAssenze'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnKeyDown = dcmbKeyDown
      end
      object dedtAssenzeAbilitate: TDBEdit
        Left = 8
        Top = 60
        Width = 557
        Height = 21
        DataField = 'AbCausale1'
        DataSource = A002FAnagrafeDtM1.D430
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 1
      end
      object btnSceltaAssenze: TButton
        Left = 564
        Top = 60
        Width = 13
        Height = 21
        Caption = '...'
        TabOrder = 2
        OnClick = btnSceltaAssenzeClick
      end
      object dedtPresenzeAbilitate: TDBEdit
        Left = 8
        Top = 100
        Width = 557
        Height = 21
        DataField = 'ABPRESENZA1'
        DataSource = A002FAnagrafeDtM1.D430
        PopupMenu = PopupMenu1
        ReadOnly = True
        TabOrder = 3
      end
      object btnSceltaPresenze: TButton
        Left = 564
        Top = 100
        Width = 13
        Height = 21
        Caption = '...'
        TabOrder = 4
        OnClick = btnSceltaPresenzeClick
      end
      object drgpTipoLocalitaDistLavoro: TDBRadioGroup
        Left = 8
        Top = 161
        Width = 146
        Height = 44
        HelpContext = 2300
        Caption = 'Tipo localit'#224
        DataField = 'TIPO_LOCALITA_DIST_LAVORO'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Comune'
          'Localit'#224' personalizzata')
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 5
        TabStop = True
        Values.Strings = (
          'C'
          'P')
        OnChange = drgpTipoLocalitaDistLavoroChange
      end
      object dcmbLocalitaDistLavoro: TDBLookupComboBox
        Tag = 1
        Left = 168
        Top = 183
        Width = 137
        Height = 21
        HelpContext = 2300
        DataField = 'D_COD_LOCALITA_DIST_LAVORO'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 280
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 6
      end
      object dedtLocalitaDistLavoro: TDBEdit
        Tag = 9
        Left = 304
        Top = 183
        Width = 60
        Height = 21
        HelpContext = 2300
        DataField = 'COD_LOCALITA_DIST_LAVORO'
        DataSource = A002FAnagrafeDtM1.D430
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 7
      end
      object dcmbQualificaMinisteriale: TDBLookupComboBox
        Tag = 14
        Left = 8
        Top = 139
        Width = 69
        Height = 21
        HelpContext = 2300
        DataField = 'QUALIFICAMINIST'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 8
        OnKeyDown = dcmbKeyDown
      end
      object dcmbMedicinaLegale: TDBLookupComboBox
        Tag = 15
        Left = 8
        Top = 222
        Width = 109
        Height = 21
        HelpContext = 2300
        DataField = 'MEDICINA_LEGALE'
        DataSource = A002FAnagrafeDtM1.D430
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        NullValueKey = 46
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 9
        OnKeyDown = dcmbKeyDown
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 38
    Width = 655
    Height = 27
    ButtonHeight = 23
    EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
    EdgeOuter = esNone
    Flat = False
    Images = ImageList1
    TabOrder = 3
    Wrapable = False
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actRicerca
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton13: TToolButton
      Left = 23
      Top = 0
      Width = 10
      Caption = 'ToolButton13'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 33
      Top = 0
      Action = actPrimo
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton3: TToolButton
      Left = 56
      Top = 0
      Action = actPrecedente
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton4: TToolButton
      Left = 79
      Top = 0
      Action = actSuccessivo
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton5: TToolButton
      Left = 102
      Top = 0
      Action = actUltimo
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton6: TToolButton
      Left = 125
      Top = 0
      Width = 10
      Caption = 'ToolButton5'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 135
      Top = 0
      Action = actInserisci
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton8: TToolButton
      Left = 158
      Top = 0
      Action = actModifica
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton19: TToolButton
      Left = 181
      Top = 0
      Action = actCancella
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton10: TToolButton
      Left = 204
      Top = 0
      Width = 10
      Caption = 'ToolButton9'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object ToolButton9: TToolButton
      Left = 214
      Top = 0
      Action = actAnnulla
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton11: TToolButton
      Left = 237
      Top = 0
      Action = actConferma
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton14: TToolButton
      Left = 260
      Top = 0
      Width = 10
      Caption = 'ToolButton14'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object ToolButton12: TToolButton
      Left = 270
      Top = 0
      Action = actGomma
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton16: TToolButton
      Left = 293
      Top = 0
      Width = 15
      Caption = 'ToolButton1'
      ImageIndex = 11
      Style = tbsSeparator
    end
    object ToolButton15: TToolButton
      Left = 308
      Top = 0
      Action = actStoricoPrecedente
    end
    object cmbDateDecorrenza: TComboBox
      Left = 331
      Top = 0
      Width = 85
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbDateDecorrenzaChange
    end
    object ToolButton17: TToolButton
      Left = 416
      Top = 0
      Action = actStoricoSuccessivo
    end
    object ToolButton18: TToolButton
      Left = 439
      Top = 0
      Width = 10
      Caption = 'ToolButton18'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object TStampa: TToolButton
      Left = 449
      Top = 0
      Action = actStampa
      ParentShowHint = False
      ShowHint = True
    end
    object Tseparator: TToolButton
      Left = 472
      Top = 0
      Width = 22
      Caption = 'Tseparator'
      ImageIndex = 10
      Style = tbsSeparator
    end
    object tbtnFotoDipendente: TToolButton
      Left = 494
      Top = 0
      Action = actFotoDipendente
    end
    object tbtnSepFoto: TToolButton
      Left = 517
      Top = 0
      Width = 8
      Caption = 'tbtnSepFoto'
      ImageIndex = 23
      Style = tbsSeparator
    end
    object TCdcPercent: TToolButton
      Left = 525
      Top = 0
      Action = actCdcPercent
    end
    object ToolButton20: TToolButton
      Left = 548
      Top = 0
      Width = 8
      Caption = 'ToolButton20'
      ImageIndex = 23
      Style = tbsSeparator
    end
    object TAnagraficoStipendi: TToolButton
      Left = 556
      Top = 0
      Action = actAnagraficoStipendi
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton21: TToolButton
      Left = 579
      Top = 0
      Width = 8
      Caption = 'ToolButton21'
      ImageIndex = 25
      Style = tbsSeparator
    end
    object TCercaDato: TToolButton
      Left = 587
      Top = 0
      Action = actCercaCampo
      ParentShowHint = False
      ShowHint = True
    end
  end
  object grbDecorrenza: TGroupBox
    Left = 0
    Top = 65
    Width = 655
    Height = 36
    Align = alTop
    TabOrder = 4
    object lblDecorrenza: TLabel
      Left = 4
      Top = 13
      Width = 58
      Height = 13
      Caption = 'Decorrenza:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnStoricizza: TSpeedButton
      Left = 320
      Top = 8
      Width = 23
      Height = 24
      Hint = 'Storicizzazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clFuchsia
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FFFF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FFFF00FF00FF0000FF
        FF0000FFFF00FF00FF007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B
        7B007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF00FF00FF00FF00FF00FF00
        FF0000FFFF000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000FFFF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000007B7B7B00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000007B7B7B00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000007B7B7B00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000007B7B7B00FF00FF00FF00FF0000FFFF0000FF
        FF0000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000000000FFFF0000FFFF00FF00FF00FF00FF0000FF
        FF0000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000000000FFFF0000FFFF0000FFFF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
        FF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
        FF000000000000FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
        0000FF00FF0000FFFF0000FFFF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF0000FFFF00000000000000000000000000000000000000000000000000FF00
        FF00FF00FF00FF00FF0000FFFF0000FFFF00FF00FF00FF00FF00FF00FF0000FF
        FF0000FFFF00FF00FF00FF00FF00FF00FF00FF00FF0000FFFF0000FFFF00FF00
        FF00FF00FF00FF00FF00FF00FF0000FFFF0000FFFF00FF00FF0000FFFF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FFFF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0000FFFF00}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = btnStoricizzaClick
    end
    object dedtDecorrenza: TDBEdit
      Left = 68
      Top = 9
      Width = 73
      Height = 21
      DataField = 'DATADECORRENZA'
      DataSource = A002FAnagrafeDtM1.D430
      TabOrder = 0
      OnExit = dedtDecorrenzaExit
    end
    object chkStoriciPrec: TCheckBox
      Left = 152
      Top = 13
      Width = 77
      Height = 13
      Caption = 'Storici prec.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object chkStoriciSucc: TCheckBox
      Left = 232
      Top = 13
      Width = 77
      Height = 13
      Caption = 'Storici succ.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 518
    Top = 70
    object File1: TMenuItem
      Caption = '&File'
      object Ricerca1: TMenuItem
        Action = actRicerca
      end
      object Stampa1: TMenuItem
        Action = actStampa
      end
      object Stampavideata1: TMenuItem
        Caption = 'Stampa videata'
        OnClick = Stampavideata1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object AnagraficoStipendi1: TMenuItem
        Action = actAnagraficoStipendi
      end
      object Centridicostopercentualizzati1: TMenuItem
        Action = actCdcPercent
      end
      object Fotodeldipendente1: TMenuItem
        Action = actFotoDipendente
      end
      object Modificaprimadecorrenza1: TMenuItem
        Action = actModificaPrimaDec
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object Cercadato1: TMenuItem
        Action = actCercaCampo
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Chiudi1: TMenuItem
        Action = actEsci
      end
    end
    object Strumenti1: TMenuItem
      Caption = 'Strumenti'
      object Primo1: TMenuItem
        Action = actPrimo
      end
      object Precedente1: TMenuItem
        Action = actPrecedente
      end
      object Successivo1: TMenuItem
        Action = actSuccessivo
      end
      object Ultimo1: TMenuItem
        Action = actUltimo
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Storicoprecedente1: TMenuItem
        Action = actStoricoPrecedente
      end
      object Storicosuccessivo1: TMenuItem
        Action = actStoricoSuccessivo
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Inserisci1: TMenuItem
        Action = actInserisci
      end
      object Modifica1: TMenuItem
        Action = actModifica
      end
      object Cancella1: TMenuItem
        Action = actCancella
      end
      object Annulla1: TMenuItem
        Action = actAnnulla
      end
      object Conferma1: TMenuItem
        Action = actConferma
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Puliscicampo1: TMenuItem
        Action = actGomma
      end
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 614
    Top = 70
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 554
    Top = 70
    object Nuovamatricola1: TMenuItem
      Caption = 'Nuova matricola'
      OnClick = Nuovamatricola1Click
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Tutto: TMenuItem
      Caption = 'Storia del dipendente'
      OnClick = TuttoClick
    end
    object Storicizzati: TMenuItem
      Caption = 'Storicizzazione corrente'
      OnClick = TuttoClick
    end
    object Singolo: TMenuItem
      Caption = 'Storia del dato'
      OnClick = TuttoClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Nuovo: TMenuItem
      Caption = 'Accedi'
      Visible = False
      OnClick = NuovoClick
    end
    object Relazioni: TMenuItem
      Caption = 'Relazioni'
      Visible = False
      OnClick = RelazioniClick
    end
  end
  object ImageList1: TImageList
    Left = 488
    Top = 70
    Bitmap = {
      494C01011A001D00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000007000000001002000000000000070
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7B7B000000
      000000000000000000007B7B7B000000000000000000000000007B7B7B000000
      000000000000000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      00008484840000000000000000000000000000000000000000007B7B7B000000
      00007B7B7B00000000007B7B7B00000000007B7B7B00000000007B7B7B000000
      00007B7B7B00000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000084000000FFFF00008400000000000000000000000000000000FFFF0000FF
      FF00000000000000000000000000000000007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000084000000FFFF000084000000000000008484840000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000840000000000000084000000000000000000000000000000000000008484
      840000000000000000000000000084848400000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084008400
      0000840000008400000084000000000084000000000000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      000000000000FFFF000084000000840000000000000000000000000000008484
      8400000000000000000000000000848484007B7B7B007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000FFFF0000FFFF000084000000840000000000000000000000000000000000
      0000848484000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000FF000000FFFF00008400000084000000000000000000000000000000C6C6
      C600C6C6C600C6C6C6000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FFFF
      0000FF000000FFFF0000FFFF0000840000000000000000000000000000000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000FFFF00840000008400000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C60000000000000000007B7B7B007B7B7B00000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      000000FFFF0000FFFF000000000000000000000000007B7B7B00000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      840000FFFF008484840000000000000000000000000000000000000000000000
      0000000000000000000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B00000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000008400
      0000FFFF00008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000008400
      0000FFFF00008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000008400
      0000848484008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      0000000000000000000000000000000000000000000000008400840000008400
      0000840000008400000000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      0000000000000000000000000000000000000000000084000000840000008484
      8400FFFF00008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400000000000000000084848400848484008484840084848400000000000000
      00008484840084848400000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000008400000084000000FFFF
      0000FFFF00008400000084000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000848484008484
      8400000000008484840084848400848484008484840084848400848484000000
      0000848484008484840000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      000000000000000000000000000000000000000000008400000084000000FF00
      0000FFFF000084000000000000000000000000000000FF000000000000000000
      0000FF00000000000000FF000000000000000000000000000000848484008484
      84000000000084848400C6C6C600848484008484840084848400848484000000
      0000848484008484840000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000084000000FFFF0000FF00
      0000FFFF0000FFFF000000000000000000000000000000000000FF0000000000
      000000000000FF00000000000000000000000000000000000000848484008484
      84000000000084848400FFFF0000C6C6C6008484840084848400848484000000
      0000848484008484840000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000FF00000000FF
      FF0084000000840000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000084848400848484008484840084848400000000000000
      0000FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF0000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6000000000000000000000000000000000000000000FF000000000000000000
      0000FF0000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF00000000000000000000000000FF00000000000000FF0000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      00000000000000000000000000000000000000000000000000000000840000FF
      FF00C6C6C60000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000FFFFFF00FFFFFF0000000000848484000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000084848400000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000008400000084000000FF000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000084
      000000FF000000FF00000000000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000000000000000FF
      000000FF0000000000000000000000FF000000FF000000840000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00000000000000000000000000FFFFFF00000000007B7B7B000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000007B7B7B000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000840084848400848484000000000000000000000000000000
      0000000000008484840084848400000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000008400000000000000
      0000000000000000840000008400848484008484840000000000000000000000
      0000000000000000840000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      0000000000008484840000008400000084008484840000000000000000000000
      0000848484000000840000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000008400000084008484840084848400000000000000
      8400000084008484840000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000000084000000840000008400
      0000840000008400000084000000000000000000000000000000000084000000
      84000000840000008400000000000000000000000000C6C6C60000FFFF008484
      8400000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000000084848400000084000000840084848400848484000000
      8400000084000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000C6C6C60000FF
      FF00848484000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000840000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      84000000840000000000000000000000000000000000000000000000000000FF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000000000000000848484000000840000008400000084008484
      8400000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      840000000000000000000000000000000000000000000000000000000000C6C6
      C60000FFFF00848484000000000000000000000000000000000000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000008484840084848400000084000000840000008400000084008484
      8400848484000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C60000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      0000848484000000840000008400000000000000000084848400000084000000
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      8400000084008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      000000000000848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      00000000FF00848484008484840084848400BDBD000084848400BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008400000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C600000000000000000000000000000000000000BD000000
      BD000000FF000000FF008484840084848400BDBD000084848400BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFFFF008400
      0000840000008400000084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C6000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF0084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000FFFFFF008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF00848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000084000000840000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFF0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400FFFF0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400FFFF0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000008400000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000084000000FF0000008400000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      000000000000000084000000FF000000FF000000000000000000000000000000
      00000000FF000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      84000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000FF00000084000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF00000084000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      84000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF00000084000000FF00000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008484000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000084848400000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF0000000000840000000000000000000000000000000000
      0000840000008484840084000000000000000000000000000000000000000000
      00000000FF00000084000000FF00000084000000000000000000000000000000
      0000000084000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000848484008400000084000000000000000000000000000000000000000000
      84000000FF00000084000000FF00000000000000000000000000000000000000
      000000000000000084000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000700000000100010000000000800300000000000000000000
      000000000000000000000000FFFFFF00FFFFDDDD00000000FF07D55500000000
      E147000000000000E107DF5F00000000E5E09FBF00000000C0E8DB5F00000000
      C8E011FD00000000C0C1DBFD00000000C0C19BFA00000000C0C1DFFF00000000
      E1C1101D00000000F3C1D01000000000E1D1901D00000000E1C1DFFF00000000
      F3FF000000000000FFFFFFFF00000000FF7EFFFDFFFFFFFF9001FFF8FFFFFFFF
      C003FFF1C3FFFFFFE003FFE3C3FFFFFFE003FFC7C3FFFC3FE003E08F81FF8001
      E003C01F81FF80010001803F81FB80018000001F83B58001E007001F83DB8001
      E00F001FC3EF8001E00F001FE7B78001E027001FC35B8001C073803FC3BFC813
      9E79C07FE7FFFC3F7EFEE0FFFFFFFFFFFFFFFFFFFFFF8003FFFFFFFFFFFF8003
      FFFFFFFFFFFF8003FCFFFF3FFFFF8003F8FFFC3FFCFF8003F07FF03FFC3F8003
      E27FC000FC0F8003E63F000000038003FF3FC00000008003FF9FF03F00038003
      FFCFFC3FFC0F8003FFCFFF3FFC3F8003FFE7FFFFFCFF8003FFF3FFFFFFFF8007
      FFFFFFFFFFFF800FFFFFFFFFFFFF801FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFCFF07C1FFFFDFFFDF7F07C1F8F9CFF7CF3F07C1B879C7D5C71F01019873
      C3E3C30F00018C23C181C38F00018407C3E3C3C70001820FC7D5C7C38003860F
      CFF7CFE3C1078807DFFFDFF1C1079183FFFFFFF0E38FBFC1FFFFFFF9E38FFFF3
      FFFFFFFFE38FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFC007FE1FFFFF
      FFFF8003FE07FC01FFFF00010600FC01FCFF0001FE01FC01FC3F0001F8010001
      FC0F0000F801000100030000F001000100008000C00100010003C000C0010003
      FC0FE001C0010007FC3FE007F001000FFCFFF007F80100FFFFFFF003F80101FF
      FFFFF803F80103FFFFFFFFFFF801FFFFF807FFFE847FFFFFF807FBFF00EFFFFF
      F807F1FD31BFFFFFF807F1FB39FFFF3FF807F8F3993FFC3FF807FC67CA1FF03F
      F803FE0FF40FC000FFF3FF1F9C070000FFF1FE0F9603C000F9F1FC6FCB01F03F
      F0F1F0F3FF80FC3FF0F1E1F9F7C0FF3FF9FBE7FCFFE0FFFFEFF3FFFFEFF0FFFF
      FFF7FFFFFFF8FFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF3EFFFEFF7FFF7CFF3CFFFCFF3FFF3CFF38FFF8FF1FFF1CF
      F30FFF0FF0FFF0CFF20FFE0FF07FF04FF30FFF0FF0FFF0CFF38FFF8FF1FFF1CF
      F3CFFFCFF3FFF3CFF3EFFFEFF7FFF7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 460
    Top = 70
    object actRicerca: TAction
      Caption = 'Ricerca'
      Hint = 'Ricerca'
      ImageIndex = 14
      ShortCut = 16454
      OnExecute = actlstExecute
    end
    object actPrimo: TAction
      Caption = 'Primo'
      Hint = 'Primo'
      ImageIndex = 0
      ShortCut = 16464
      OnExecute = actlstExecute
    end
    object actPrecedente: TAction
      Caption = 'Precedente'
      Hint = 'Precedente'
      ImageIndex = 1
      ShortCut = 16466
      OnExecute = actlstExecute
    end
    object actSuccessivo: TAction
      Caption = 'Successivo'
      Hint = 'Successivo'
      ImageIndex = 2
      ShortCut = 16453
      OnExecute = actlstExecute
    end
    object actUltimo: TAction
      Caption = 'Ultimo'
      Hint = 'Ultimo'
      ImageIndex = 3
      ShortCut = 16469
      OnExecute = actlstExecute
    end
    object actInserisci: TAction
      Caption = 'Inserisci'
      Hint = 'Inserisci'
      ImageIndex = 12
      ShortCut = 16457
      OnExecute = actlstExecute
    end
    object actModifica: TAction
      Caption = 'Modifica'
      Hint = 'Modifica'
      ImageIndex = 13
      ShortCut = 16461
      OnExecute = actlstExecute
    end
    object actCancella: TAction
      Caption = 'Cancella'
      Hint = 'Cancella'
      ImageIndex = 15
      ShortCut = 16452
      OnExecute = actlstExecute
    end
    object actConferma: TAction
      Caption = 'Conferma'
      Hint = 'Conferma'
      ImageIndex = 16
      ShortCut = 16463
      OnExecute = actlstExecute
    end
    object actAnnulla: TAction
      Caption = 'Annulla'
      Hint = 'Annulla'
      ImageIndex = 5
      ShortCut = 16462
      OnExecute = actlstExecute
    end
    object actStampa: TAction
      Caption = 'Stampa'
      Hint = 'Stampa'
      ImageIndex = 9
      OnExecute = actlstExecute
    end
    object actEsci: TAction
      Caption = 'Esci'
      Hint = 'Esci'
      ImageIndex = 10
      OnExecute = actlstExecute
    end
    object actStoricoPrecedente: TAction
      Caption = 'Storico precedente'
      Hint = 'Storico precedente'
      ImageIndex = 7
      ShortCut = 49232
      OnExecute = actlstExecute
    end
    object actStoricoSuccessivo: TAction
      Caption = 'Storico successivo'
      Hint = 'Storico successivo'
      ImageIndex = 8
      ShortCut = 49237
      OnExecute = actlstExecute
    end
    object actGomma: TAction
      Caption = 'Pulisci campo'
      Hint = 'Pulisci campo'
      ImageIndex = 6
      OnExecute = actlstExecute
    end
    object actModificaPrimaDec: TAction
      Caption = 'Modifica prima decorrenza'
      Visible = False
      OnExecute = actModificaPrimaDecExecute
    end
    object actCdcPercent: TAction
      Caption = 'Centri di costo percentualizzati'
      Hint = 'Centri di costo percentualizzati'
      ImageIndex = 22
      OnExecute = actCdcPercentExecute
    end
    object actFotoDipendente: TAction
      Tag = 67
      Caption = 'Foto del dipendente'
      Hint = 'Foto del dipendente'
      ImageIndex = 23
      OnExecute = actFotoDipendenteExecute
    end
    object actAnagraficoStipendi: TAction
      Caption = 'Anagrafico Stipendi'
      Hint = 'Anagrafico Stipendi'
      ImageIndex = 24
      OnExecute = actAnagraficoStipendiExecute
    end
    object actCercaCampo: TAction
      Caption = 'Cerca campo'
      Hint = 'Cerca campo'
      ImageIndex = 25
      ShortCut = 24646
      OnExecute = actCercaCampoExecute
    end
  end
end
