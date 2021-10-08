object A136FComposizioneRelazione: TA136FComposizioneRelazione
  Left = 221
  Top = 140
  HelpContext = 136100
  Caption = '<A136> Composizione relazione tra dati anagrafici'
  ClientHeight = 547
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCampiRelazioni: TPanel
    Left = 0
    Top = 0
    Width = 639
    Height = 105
    Align = alTop
    TabOrder = 0
    object sbtnColonnaPilota: TSpeedButton
      Left = 587
      Top = 74
      Width = 20
      Height = 22
      Caption = '...'
      OnClick = sbtnColonnaPilotaClick
    end
    object lblColonnaPilotata: TLabel
      Left = 16
      Top = 79
      Width = 78
      Height = 13
      Caption = 'Colonna pilotata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblColonnaPilota: TLabel
      Left = 320
      Top = 79
      Width = 68
      Height = 13
      Caption = 'Colonna pilota'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTabellaPilotata: TLabel
      Left = 16
      Top = 46
      Width = 73
      Height = 13
      Caption = 'Tabella pilotata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTabellaPilota: TLabel
      Left = 320
      Top = 46
      Width = 63
      Height = 13
      Caption = 'Tabella pilota'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblDecorrenza: TLabel
      Left = 16
      Top = 12
      Width = 55
      Height = 13
      Caption = 'Decorrenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTipo: TLabel
      Left = 320
      Top = 12
      Width = 20
      Height = 13
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblDTipo: TLabel
      Left = 438
      Top = 12
      Width = 97
      Height = 13
      Caption = 'D_Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtColonnaPilotata: TEdit
      Left = 100
      Top = 75
      Width = 177
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object edtColonnaPilota: TEdit
      Left = 404
      Top = 75
      Width = 177
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object edtTabellaPilotata: TEdit
      Left = 100
      Top = 42
      Width = 177
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object edtTabellaPilota: TEdit
      Left = 404
      Top = 42
      Width = 177
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object edtDecorrenza: TEdit
      Left = 100
      Top = 9
      Width = 177
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
    object edtTipo: TEdit
      Left = 404
      Top = 9
      Width = 26
      Height = 21
      ReadOnly = True
      TabOrder = 5
    end
  end
  object dgrdValoriColonne: TDBGrid
    Left = 0
    Top = 121
    Width = 639
    Height = 366
    Align = alClient
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgCancelOnExit, dgMultiSelect]
    PopupMenu = PopupMenu3
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'VALOREPILOTATO'
        Title.Caption = 'Valore colonna pilotata'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_DESC_PILOTATO'
        ReadOnly = True
        Title.Caption = 'Descrizione'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 185
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALOREPILOTA'
        Title.Caption = 'Valore colonna pilota'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 115
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_DESC_PILOTA'
        ReadOnly = True
        Title.Caption = 'Descrizione'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = []
        Width = 185
        Visible = True
      end>
  end
  object pnlAzioni: TPanel
    Left = 0
    Top = 487
    Width = 639
    Height = 41
    Align = alBottom
    TabOrder = 2
    object btnConferma: TBitBtn
      Left = 218
      Top = 8
      Width = 85
      Height = 25
      Caption = 'Conferma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfermaClick
    end
    object btnAnnulla: TBitBtn
      Left = 340
      Top = 8
      Width = 85
      Height = 25
      Caption = 'Annulla'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnAnnullaClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 528
    Width = 639
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 'Records'
  end
  object pnlTitoloAbbinamenti: TPanel
    Left = 0
    Top = 105
    Width = 639
    Height = 16
    Align = alTop
    Caption = 'Abbinamenti'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    ExplicitTop = 81
  end
  object PopupMenu3: TPopupMenu
    Left = 24
    Top = 145
    object Ricercatestocontenuto1: TMenuItem
      Action = actRicercaTestoContenuto
    end
    object Successivo1: TMenuItem
      Action = actSuccessivo
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Copia2: TMenuItem
      Caption = 'Copia'
      OnClick = Copia2Click
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = Copia2Click
    end
  end
  object ActionList1: TActionList
    Left = 60
    Top = 144
    object actRicercaTestoContenuto: TAction
      Caption = 'Ricerca testo contenuto'
      Hint = 'Ricerca testo contenuto'
      ShortCut = 16454
      OnExecute = actRicercaTestoContenutoExecute
    end
    object actSuccessivo: TAction
      Caption = 'Successivo'
      Hint = 'Elemento successivo'
      ShortCut = 114
      OnExecute = actRicercaTestoContenutoExecute
    end
  end
end
