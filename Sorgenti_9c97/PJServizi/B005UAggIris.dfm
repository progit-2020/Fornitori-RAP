object B005FAggIris: TB005FAggIris
  Left = 320
  Top = 288
  HelpContext = 9005000
  Caption = '<B005> Aggiornamento base dati'
  ClientHeight = 766
  ClientWidth = 596
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
  object Splitter1: TSplitter
    Left = 0
    Top = 209
    Width = 596
    Height = 5
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    OnMoved = Splitter1Moved
    ExplicitWidth = 606
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 747
    Width = 596
    Height = 19
    Panels = <
      item
        Width = 260
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 214
    Width = 596
    Height = 358
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblFileMedp: TLabel
      Left = 238
      Top = 5
      Width = 63
      Height = 13
      Alignment = taRightJustify
      Caption = 'File MEDP.ini'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblRagSoc: TLabel
      Left = 307
      Top = 26
      Width = 3
      Height = 13
    end
    object lblTablespaceTabelle: TLabel
      Left = 2
      Top = 5
      Width = 93
      Height = 13
      Caption = 'Tablespace tabelle:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTablespaceIndici: TLabel
      Left = 2
      Top = 26
      Width = 86
      Height = 13
      Caption = 'Tablespace indici:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAddIrpef: TLabel
      Left = 3
      Top = 254
      Width = 474
      Height = 13
      Caption = 
        'Attenzione! P042_ENTIIRPEF valorizzata. Verranno eseguiti gli sc' +
        'ripts "AddIRPEF"'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblModuliDB: TLabel
      Left = 4
      Top = 45
      Width = 72
      Height = 13
      Caption = 'Moduli esistenti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblModuliFile: TLabel
      Left = 294
      Top = 44
      Width = 90
      Height = 13
      Caption = 'Moduli da installare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 222
      Top = 24
      Width = 79
      Height = 13
      Caption = 'Ragione sociale:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnDBMenoFile: TSpeedButton
      Left = 271
      Top = 61
      Width = 23
      Height = 22
      Hint = 'Moduli esistenti che verranno disinstallati'
      AllowAllUp = True
      GroupIndex = 1
      Caption = '-'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnDBMenoFileClick
    end
    object btnFileMenoDB: TSpeedButton
      Left = 271
      Top = 89
      Width = 23
      Height = 22
      Hint = 'Nuovi moduli che verranno installati'
      AllowAllUp = True
      GroupIndex = 2
      Caption = '+'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnFileMenoDBClick
    end
    object lblScriptSQLCustom: TLabel
      Left = 4
      Top = 271
      Width = 571
      Height = 13
      Caption = 
        'Attenzione! La tabella I051_SQL_CUSTOM contiene script personali' +
        'zzati attivi che saranno eseguiti.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object BitBtn1: TBitBtn
      Left = 483
      Top = 330
      Width = 101
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 10
    end
    object btnEseguiScript: TBitBtn
      Left = 145
      Top = 330
      Width = 107
      Height = 25
      Hint = 'Esegue solo gli scripts'
      Caption = 'Esegui scripts'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnEseguiScriptClick
    end
    object btnCreazioneProcedure: TBitBtn
      Left = 260
      Top = 330
      Width = 107
      Height = 25
      Hint = 'Esegue solo la creazione delle procedure'
      Caption = 'Creazione procedure'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = btnCreazioneProcedureClick
    end
    object btnInvioLog: TBitBtn
      Left = 375
      Top = 330
      Width = 101
      Height = 25
      Caption = 'Invio log per E-mail'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      OnClick = btnInvioLogClick
    end
    object chkRegistra: TCheckBox
      Left = 257
      Top = 197
      Width = 88
      Height = 17
      Caption = 'Registra su file'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
    end
    object chkNoStorage: TCheckBox
      Left = 3
      Top = 235
      Width = 248
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Esegui scripts senza parametri di STORAGE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkNoStorageClick
    end
    object CmbMEdp: TComboBox
      Left = 307
      Top = 2
      Width = 278
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = CmbMEdpChange
    end
    object ChkRagioneSociale: TCheckBox
      Left = 4
      Top = 202
      Width = 247
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Aggiorna ragione sociale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object chkRegistraSuDB: TCheckBox
      Left = 3
      Top = 219
      Width = 248
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Registra log di aggiornamento su DB'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object btnScriptsProcedure: TBitBtn
      Left = 2
      Top = 330
      Width = 135
      Height = 25
      Hint = 'Esegue in sequenza gli scripts e la creazione delle procedure'
      Caption = 'Esegui scripts e procedure'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = btnScriptsProcedureClick
    end
    object lstStringModuliDB: TListBox
      Left = 2
      Top = 60
      Width = 268
      Height = 139
      ItemHeight = 13
      Sorted = True
      TabOrder = 11
    end
    object lststringModuliFile: TListBox
      Left = 294
      Top = 60
      Width = 290
      Height = 139
      ItemHeight = 13
      Sorted = True
      TabOrder = 12
    end
    object btnAggVersioneDB: TBitBtn
      Left = 483
      Top = 211
      Width = 101
      Height = 25
      Caption = 'Agg.to versione DB'
      TabOrder = 13
      OnClick = btnAggVersioneDBClick
    end
    object btnAccessoA008: TBitBtn
      Left = 294
      Top = 211
      Width = 183
      Height = 25
      Caption = 'Abilita accesso aziende/operatori'
      TabOrder = 14
      OnClick = btnAccessoA008Click
    end
    object rgpTipoAggiornamento: TRadioGroup
      Left = 2
      Top = 288
      Width = 273
      Height = 40
      Caption = 'Tipologia aggiornamento'
      Color = clBtnFace
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Azienda selezionata'
        'Tutte le aziende')
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 5
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 572
    Width = 596
    Height = 175
    Align = alClient
    Caption = 'Messaggi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Messaggi: TMemo
      Left = 2
      Top = 15
      Width = 389
      Height = 158
      Align = alClient
      Color = cl3DLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object memoTrace: TMemo
      Left = 391
      Top = 15
      Width = 203
      Height = 158
      Align = alRight
      Color = cl3DLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 1
      WordWrap = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 596
    Height = 209
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    DesignSize = (
      596
      209)
    object Label1: TLabel
      Left = 2
      Top = 30
      Width = 120
      Height = 13
      Caption = 'Cartella degli scripts SQL:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 196
      Top = 51
      Width = 131
      Height = 13
      Caption = 'Scripts ignorati (gi'#224' eseguiti)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 407
      Top = 51
      Width = 90
      Height = 13
      Caption = 'Scripts da eseguire'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 2
      Top = 51
      Width = 38
      Height = 13
      Caption = 'Aziende'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDatabasename: TLabel
      Left = 3
      Top = 3
      Width = 124
      Height = 16
      Caption = 'lblDatabasename'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 128
      Top = 26
      Width = 441
      Height = 21
      ReadOnly = True
      TabOrder = 0
      Text = 'Edit1'
    end
    object Button1: TButton
      Left = 570
      Top = 26
      Width = 14
      Height = 22
      Caption = '...'
      TabOrder = 1
      OnClick = Button1Click
    end
    object ListBox1: TListBox
      Left = 196
      Top = 65
      Width = 177
      Height = 139
      Anchors = [akLeft, akTop, akBottom]
      ItemHeight = 13
      Sorted = True
      TabOrder = 2
      OnDblClick = ListBox1DblClick
    end
    object ListBox2: TListBox
      Left = 407
      Top = 65
      Width = 177
      Height = 139
      Anchors = [akLeft, akTop, akBottom]
      ItemHeight = 13
      Sorted = True
      TabOrder = 3
      OnDblClick = ListBox2DblClick
    end
    object Button2: TButton
      Left = 376
      Top = 102
      Width = 29
      Height = 25
      Caption = '>'
      Enabled = False
      TabOrder = 4
      OnClick = ListBox1DblClick
    end
    object Button3: TButton
      Left = 376
      Top = 138
      Width = 29
      Height = 25
      Caption = '<'
      TabOrder = 5
      OnClick = ListBox2DblClick
    end
    object DBGrid1: TDBGrid
      Left = 2
      Top = 65
      Width = 189
      Height = 139
      Anchors = [akLeft, akTop, akBottom]
      DataSource = B005FAggIrisDtM1.D090
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.SQL'
    Filter = 'SQL file (*.SQL)|*.SQL'
    Left = 360
    Top = 4
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.SQL'
    Left = 392
    Top = 8
  end
end
