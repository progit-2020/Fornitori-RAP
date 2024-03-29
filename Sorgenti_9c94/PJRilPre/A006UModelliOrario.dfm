inherited A006FModelliOrario: TA006FModelliOrario
  Left = 192
  Top = 164
  HelpContext = 6000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A006> Modelli orario'
  ClientHeight = 506
  ClientWidth = 612
  ExplicitWidth = 622
  ExplicitHeight = 556
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 488
    Width = 612
    ExplicitTop = 488
    ExplicitWidth = 612
  end
  inherited grbDecorrenza: TGroupBox
    Width = 612
    TabOrder = 2
    ExplicitWidth = 612
  end
  inherited ToolBar1: TToolBar
    Width = 612
    TabOrder = 1
    ExplicitWidth = 612
  end
  object PageControl: TPageControl [3]
    Left = 0
    Top = 88
    Width = 612
    Height = 400
    ActivePage = tabCausAuto
    Align = alClient
    TabOrder = 4
    object tabTimbrature: TTabSheet
      Caption = 'Punti timbratura'
      ImageIndex = 1
      object dgrdTimbrature: TDBGrid
        Left = 0
        Top = 232
        Width = 604
        Height = 140
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
        ParentFont = False
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clTeal
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = dgrdTimbratureDrawColumnCell
        OnExit = dgrdSelT021Exit
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 604
        Height = 20
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label6: TLabel
          Left = 4
          Top = 4
          Width = 53
          Height = 13
          Caption = 'Tipo orario:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 288
          Top = 4
          Width = 88
          Height = 13
          Caption = 'Periodo lavorativo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dcmbTipoOra: TDBComboBox
          Left = 60
          Top = 1
          Width = 215
          Height = 19
          Style = csOwnerDrawFixed
          DataField = 'TipoOra'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          Items.Strings = (
            'A'
            'B'
            'C'
            'D'
            'E')
          ParentFont = False
          TabOrder = 0
          OnChange = dcmbTipoOraChange
          OnDrawItem = dcmbTipoOraDrawItem
        end
        object dcmbPerLav: TDBComboBox
          Left = 380
          Top = 1
          Width = 215
          Height = 19
          Style = csOwnerDrawFixed
          DataField = 'PerLav'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          Items.Strings = (
            'C'
            'S'
            'L '
            'EU'
            'T1'
            'T2')
          ParentFont = False
          TabOrder = 1
          OnChange = dcmbPerLavChange
          OnDrawItem = dcmbTipoOraDrawItem
        end
      end
      object GParametri: TGroupBox
        Left = 0
        Top = 20
        Width = 604
        Height = 212
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object lblOreTeor: TLabel
          Left = 119
          Top = 12
          Width = 112
          Height = 13
          Caption = 'Ore teoriche giornaliere:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblOreMin: TLabel
          Left = 119
          Top = 34
          Width = 126
          Height = 13
          Caption = 'Ore minime in fascia oraria:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblOreMax: TLabel
          Left = 119
          Top = 56
          Width = 134
          Height = 13
          Caption = 'Ore massime in fascia oraria:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblTipoFle: TLabel
          Left = 119
          Top = 78
          Width = 71
          Height = 13
          Caption = 'Tipo flessibilit'#224':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object pnlTurni: TPanel
          Left = 379
          Top = 38
          Width = 217
          Height = 89
          BevelOuter = bvNone
          Ctl3D = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clPurple
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 8
          object lblMinUscitaNotte: TLabel
            Left = 4
            Top = 69
            Width = 152
            Height = 13
            Caption = 'Uscita minima per turno notturno'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dchkFrazDeb: TDBCheckBox
            Left = 2
            Top = 19
            Width = 212
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Frazionamento debito sul turno notturno'
            DataField = 'FrazDeb'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkFrazDebClick
          end
          object dchkNotteEntrata: TDBCheckBox
            Left = 2
            Top = 34
            Width = 212
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Conteggio turno notturno su entrata'
            DataField = 'NotteEntrata'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkNotteEntrataClick
          end
          object dedtMinUscitaNotte: TDBEdit
            Left = 176
            Top = 66
            Width = 39
            Height = 21
            Ctl3D = True
            DataField = 'MIN_USCITA_NOTTE'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentCtl3D = False
            ParentFont = False
            TabOrder = 4
            OnChange = PulisciValore
          end
          object dchkRegoleProfilo: TDBCheckBox
            Left = 2
            Top = 4
            Width = 212
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Usa regole del profilo nella scelta turni'
            DataField = 'Regole_Profilo'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dchkFlexDopoMezanotte: TDBCheckBox
            Left = 2
            Top = 49
            Width = 212
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Gestione flessibilit'#224' del turno notturno'
            DataField = 'FLEXDOPOMEZZANOTTE'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkNotteEntrataClick
          end
        end
        object dcmbTipoFle: TDBComboBox
          Left = 255
          Top = 75
          Width = 127
          Height = 19
          Hint = 
            'A=Unica  B=con recup.distinto  C=con recup.pomerid.  D=con recup' +
            '.misto'
          Style = csOwnerDrawFixed
          DataField = 'TipoFle'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          Items.Strings = (
            'A'
            'B'
            'C'
            'D')
          ParentFont = False
          TabOrder = 5
          Visible = False
          OnDrawItem = dcmbTipoOraDrawItem
        end
        object dchkCompDetr: TDBCheckBox
          Left = 117
          Top = 77
          Width = 151
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Compensabile (S/N)'
          DataField = 'CompDetr'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dedtOreMin: TDBEdit
          Left = 255
          Top = 31
          Width = 39
          Height = 21
          Ctl3D = True
          DataField = 'OreMin'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 2
          OnChange = PulisciValore
        end
        object dedtOreTeor: TDBEdit
          Left = 255
          Top = 9
          Width = 39
          Height = 21
          Ctl3D = True
          DataField = 'Oreteor'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 1
          OnChange = PulisciValore
        end
        object dedtOreMax: TDBEdit
          Left = 255
          Top = 53
          Width = 39
          Height = 21
          Ctl3D = True
          DataField = 'OreMax'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 3
          OnChange = PulisciValore
        end
        object drgpObblFac: TDBRadioGroup
          Left = 2
          Top = 8
          Width = 111
          Height = 102
          Caption = 'Timbrature richieste'
          DataField = 'OBBLFAC'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Obbligatorie'
            'Facoltative')
          ParentFont = False
          TabOrder = 0
          Values.Strings = (
            'O'
            'F')
        end
        object GroupBox4: TGroupBox
          Left = 3
          Top = 125
          Width = 598
          Height = 83
          TabOrder = 9
          object lblRicalcoloMin: TLabel
            Left = 258
            Top = 13
            Width = 70
            Height = 13
            Caption = 'Ore utili minime'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblRicalcoloMax: TLabel
            Left = 258
            Top = 36
            Width = 78
            Height = 13
            Caption = 'Ore utili massime'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblRicalcoloDebMin: TLabel
            Left = 457
            Top = 13
            Width = 92
            Height = 13
            Caption = 'Diminuzione minima'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblRicalcoloDebMax: TLabel
            Left = 457
            Top = 36
            Width = 85
            Height = 13
            Caption = 'Aumento massimo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblRicalcoloCausNeg: TLabel
            Left = 14
            Top = 61
            Width = 286
            Height = 13
            Caption = 'Causali per quadratura settimanale: compensazione negativo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblRicalcoloCausPos: TLabel
            Left = 394
            Top = 61
            Width = 117
            Height = 13
            Caption = 'abbattimento eccedenza'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dchkRicalcoloDebitoGG: TDBCheckBox
            Left = 3
            Top = 0
            Width = 164
            Height = 14
            Alignment = taLeftJustify
            Caption = 'Ricalcolo del debito giornaliero'
            DataField = 'RICALCOLO_DEBITO_GG'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkRicalcoloDebitoGGClick
          end
          object dedtRicalcoloMin: TDBEdit
            Left = 340
            Top = 10
            Width = 40
            Height = 21
            DataField = 'RICALCOLO_MIN'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = PulisciValore
          end
          object dedtRicalcoloMax: TDBEdit
            Left = 340
            Top = 33
            Width = 40
            Height = 21
            DataField = 'RICALCOLO_MAX'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = PulisciValore
          end
          object dchkRicalcoloSpostaPN: TDBCheckBox
            Left = 14
            Top = 16
            Width = 184
            Height = 14
            Alignment = taLeftJustify
            Caption = 'Modifica il punto di uscita'
            DataField = 'RICALCOLO_SPOSTA_PN'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkRicalcoloDebitoGGClick
          end
          object dchkRicalcoloOffNoTimb: TDBCheckBox
            Left = 14
            Top = 32
            Width = 184
            Height = 14
            Alignment = taLeftJustify
            Caption = 'Disattivo se non ci sono timbrature'
            DataField = 'RICALCOLO_OFF_NOTIMB'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkRicalcoloDebitoGGClick
          end
          object dedtRicalcoloDebMin: TDBEdit
            Left = 552
            Top = 10
            Width = 40
            Height = 21
            DataField = 'RICALCOLO_DEB_MIN'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = PulisciValore
          end
          object dedtRicalcoloDebMax: TDBEdit
            Left = 552
            Top = 33
            Width = 40
            Height = 21
            DataField = 'RICALCOLO_DEB_MAX'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnChange = PulisciValore
          end
          object dlckRicalcoloCausNeg: TDBLookupComboBox
            Left = 304
            Top = 57
            Width = 76
            Height = 21
            DataField = 'RICALCOLO_CAUS_NEG'
            DataSource = DButton
            DropDownWidth = 300
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyField = 'CODICE'
            ListField = 'CODICE;DESCRIZIONE'
            NullValueKey = 46
            ParentFont = False
            TabOrder = 7
          end
          object dlckRicalcoloCausPos: TDBLookupComboBox
            Left = 516
            Top = 57
            Width = 76
            Height = 21
            DataField = 'RICALCOLO_CAUS_POS'
            DataSource = DButton
            DropDownWidth = 300
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyField = 'CODICE'
            ListField = 'CODICE;DESCRIZIONE'
            NullValueKey = 46
            ParentFont = False
            TabOrder = 8
          end
        end
        object dchkCoperturaCarenza: TDBCheckBox
          Left = 381
          Top = 12
          Width = 212
          Height = 14
          Alignment = taLeftJustify
          Caption = 'Copertura della carenza oraria '
          DataField = 'COPERTURA_CARENZA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dchkRicalcoloDebitoGGClick
        end
        object dchkCausaleDisabilBloccante: TDBCheckBox
          Left = 381
          Top = 28
          Width = 212
          Height = 14
          Alignment = taLeftJustify
          Caption = 'Anom. bloccante se causale non abilitata'
          DataField = 'CAUSALE_DISABIL_BLOCCANTE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
    end
    object tabOpzioni: TTabSheet
      Caption = 'Indennit'#224'/Arrotondamenti'
      ImageIndex = 2
      object grdIndennitaPres: TGroupBox
        Left = 2
        Top = 3
        Width = 250
        Height = 196
        Caption = 'Indennit'#224' di presenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label47: TLabel
          Left = 13
          Top = 19
          Width = 52
          Height = 13
          Alignment = taRightJustify
          Caption = 'Tolleranza:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object P2E05: TDBEdit
          Left = 170
          Top = 16
          Width = 39
          Height = 21
          DataField = 'TollPres'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = PulisciValore
        end
        object drgpCompNot: TDBRadioGroup
          Left = 2
          Top = 55
          Width = 246
          Height = 31
          Align = alBottom
          Caption = 'Competenza turno notturno'
          Columns = 3
          DataField = 'CompNot'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Entrata'
            'Uscita'
            'Entrambi')
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'E'
            'U'
            ' ')
        end
        object GroupBox6: TGroupBox
          Left = 2
          Top = 86
          Width = 246
          Height = 68
          Align = alBottom
          Caption = 'Indennit'#224' intera'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object Label48: TLabel
            Left = 11
            Top = 16
            Width = 133
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ore minime per maturazione:'
          end
          object dedtMMIndPres: TDBEdit
            Left = 168
            Top = 12
            Width = 39
            Height = 21
            DataField = 'MmIndPres'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = PulisciValore
          end
          object drgpFlagPres: TDBRadioGroup
            Left = 2
            Top = 33
            Width = 242
            Height = 33
            Align = alBottom
            Caption = 'Turno'
            Columns = 3
            Ctl3D = True
            DataField = 'FlagPres'
            DataSource = DButton
            Items.Strings = (
              'Intero'
              'Met'#224
              'Nessuna')
            ParentCtl3D = False
            TabOrder = 1
            Values.Strings = (
              'I'
              'M'
              'N')
          end
        end
        object GroupBox7: TGroupBox
          Left = 2
          Top = 154
          Width = 246
          Height = 40
          Align = alBottom
          Caption = 'Mezza indennit'#224
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object dchkFlagMPres: TDBCheckBox
            Left = 11
            Top = 16
            Width = 149
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Ore minime per maturazione'
            DataField = 'FLAGMPRES'
            DataSource = DButton
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkFlagMPresClick
          end
          object dedtMMIndMPres: TDBEdit
            Left = 168
            Top = 13
            Width = 39
            Height = 21
            DataField = 'MmIndMPres'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = PulisciValore
          end
        end
      end
      object grpAltreIndennita: TGroupBox
        Left = 256
        Top = 38
        Width = 344
        Height = 80
        Caption = 'Indennit'#224' festiva'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        TabOrder = 4
        object lblOreIndFest: TLabel
          Left = 284
          Top = 13
          Width = 52
          Height = 13
          Alignment = taRightJustify
          Caption = 'Ore minime'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedtOreIndFest: TDBEdit
          Left = 298
          Top = 29
          Width = 38
          Height = 21
          DataField = 'OREINDFEST'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = PulisciValore
        end
        object drgpIndFestiva: TDBRadioGroup
          Left = 9
          Top = 11
          Width = 246
          Height = 46
          Columns = 2
          DataField = 'INDFESTIVA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'No'
            'Domeniche+Festivi'
            'Domeniche'
            'Festivi infrasett.')
          ParentFont = False
          TabOrder = 0
          Values.Strings = (
            'N'
            'S'
            'D'
            'F')
          OnChange = drgpIndFestivaChange
        end
        object dchkIndFestivaUsaNotteCompleta: TDBCheckBox
          Left = 9
          Top = 57
          Width = 246
          Height = 21
          Alignment = taLeftJustify
          Caption = 'Estensione notte festiva (CCNL 2018)'
          DataField = 'INDFESTIVA_USA_NOTTE_COMPLETA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object grpArrotFuoriOrario: TGroupBox
        Left = 2
        Top = 227
        Width = 250
        Height = 42
        Caption = 'Arrotond. timbrature fuori orario'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        object Label64: TLabel
          Left = 15
          Top = 19
          Width = 51
          Height = 13
          Alignment = taRightJustify
          Caption = 'su Entrata:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label65: TLabel
          Left = 130
          Top = 19
          Width = 47
          Height = 13
          Alignment = taRightJustify
          Caption = 'su Uscita:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object P2E01: TDBEdit
          Left = 70
          Top = 15
          Width = 39
          Height = 21
          DataField = 'ArrFuoEnt'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = PulisciValore
        end
        object P2E02: TDBEdit
          Left = 182
          Top = 15
          Width = 39
          Height = 21
          DataField = 'ArrFuoUsc'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = PulisciValore
        end
      end
      object grpArrotGiornaliero: TGroupBox
        Left = 256
        Top = 202
        Width = 344
        Height = 67
        Caption = 'Arrotond. giornaliero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        object Label41: TLabel
          Left = 17
          Top = 19
          Width = 40
          Height = 13
          Alignment = taRightJustify
          Caption = 'Positivo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label42: TLabel
          Left = 107
          Top = 19
          Width = 46
          Height = 13
          Alignment = taRightJustify
          Caption = 'Negativo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 201
          Top = 19
          Width = 38
          Height = 13
          Alignment = taRightJustify
          Caption = 'Ecc.liq.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 6
          Top = 43
          Width = 51
          Height = 13
          Alignment = taRightJustify
          Caption = 'Ecc.fasce:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object P2E03: TDBEdit
          Left = 59
          Top = 15
          Width = 39
          Height = 21
          DataField = 'ArrPos'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = PulisciValore
        end
        object P2E04: TDBEdit
          Left = 155
          Top = 15
          Width = 39
          Height = 21
          DataField = 'ArrNeg'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = PulisciValore
        end
        object dedtArrEccedLiq: TDBEdit
          Left = 241
          Top = 15
          Width = 39
          Height = 21
          DataField = 'ARR_ECCED_LIQ'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = PulisciValore
        end
        object dedtArrEccedFasce: TDBEdit
          Left = 59
          Top = 39
          Width = 39
          Height = 21
          DataField = 'ARR_ECCED_FASCE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = PulisciValore
        end
        object dchkArrEccFasceComp: TDBCheckBox
          Left = 127
          Top = 42
          Width = 153
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Arrotond. nel compensabile'
          DataField = 'ARR_ECC_FASCE_COMP'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object drgpIndPresStr: TDBRadioGroup
        Left = 2
        Top = 272
        Width = 190
        Height = 61
        Caption = 'Detrazioni indennit'#224' di presenza'
        DataField = 'INDPRESSTR'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Nessuna'
          'Straordinario non causalizzato'
          'Eccedenza debito')
        ParentFont = False
        TabOrder = 9
        Values.Strings = (
          '0'
          '1'
          '2')
      end
      object drgpIndFestStr: TDBRadioGroup
        Left = 206
        Top = 272
        Width = 190
        Height = 61
        Caption = 'Detrazioni indennit'#224' festiva'
        DataField = 'INDFESTSTR'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Nessuna'
          'Straordinario non causalizzato'
          'Eccedenza debito')
        ParentFont = False
        TabOrder = 10
        Values.Strings = (
          '0'
          '1'
          '2')
      end
      object drgpIndNotStr: TDBRadioGroup
        Left = 410
        Top = 272
        Width = 190
        Height = 61
        Caption = 'Detrazioni indennit'#224' notturna'
        DataField = 'INDNOTSTR'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Nessuna'
          'Straordinario non causalizzato'
          'Eccedenza debito')
        ParentFont = False
        TabOrder = 11
        Values.Strings = (
          '0'
          '1'
          '2')
      end
      object dchkArrTimbInterne: TDBCheckBox
        Left = 2
        Top = 202
        Width = 250
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Arrotonda tutte le timbrature interne all'#39'orario'
        DataField = 'ARR_TIMB_INTERNE'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object GroupBox1: TGroupBox
        Left = 256
        Top = 120
        Width = 344
        Height = 79
        Caption = 'Riposo compensativo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        object lblDebitoRipCom: TLabel
          Left = 277
          Top = 9
          Width = 60
          Height = 13
          Alignment = taRightJustify
          Caption = 'Ore massime'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object drgpRiposoCompensativo: TDBRadioGroup
          Left = 9
          Top = 13
          Width = 246
          Height = 45
          Columns = 2
          DataField = 'MATURA_RIPCOM'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'No'
            'Debito teorico'
            'Ore rese')
          ParentFont = False
          TabOrder = 0
          Values.Strings = (
            'N'
            'S'
            'R')
          OnChange = drgpRiposoCompensativoChange
        end
        object dedtDebitoRipCom: TDBEdit
          Left = 297
          Top = 28
          Width = 39
          Height = 21
          DataField = 'DEBITO_RIPCOM'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = PulisciValore
        end
        object dchkRipcomGGNonLav: TDBCheckBox
          Left = 9
          Top = 59
          Width = 246
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Maturazione nei gg non lavorativi'
          DataField = 'RIPCOM_GGNONLAV'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object P2E12: TDBCheckBox
        Left = 262
        Top = 1
        Width = 128
        Height = 21
        Alignment = taLeftJustify
        Caption = 'Ind. notturna/turno'
        DataField = 'IndTurno'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkIntersezAutoGiust: TDBCheckBox
        Left = 2
        Top = 337
        Width = 344
        Height = 17
        Alignment = taLeftJustify
        Caption = 
          'Elimina le intersezioni tra autogiustificativi e spezzoni estern' +
          'i all'#39'orario'
        DataField = 'INTERSEZ_AUTOGIUST'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 12
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkRientroPomeridiano: TDBCheckBox
        Left = 262
        Top = 18
        Width = 338
        Height = 21
        Alignment = taLeftJustify
        Caption = 'Conteggio rientri pomeridiani'
        DataField = 'RIENTRO_POMERIDIANO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkFasciaNotteFestCompleta: TDBCheckBox
        Left = 399
        Top = 1
        Width = 201
        Height = 21
        Alignment = taLeftJustify
        Caption = 'Estensione notte festiva (CCNL 2018)'
        DataField = 'FASCIA_NOTTFEST_COMPLETA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object tabPausaMensa: TTabSheet
      Caption = 'Pausa mensa'
      ImageIndex = 3
      object dgrdPausaMensa: TDBGrid
        Left = 0
        Top = 310
        Width = 551
        Height = 62
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clTeal
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnExit = dgrdSelT021Exit
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 604
        Height = 310
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lblTipoMensa: TLabel
          Left = 8
          Top = 4
          Width = 90
          Height = 13
          Caption = 'Tipo pausa mensa:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblMMMinimi: TLabel
          Left = 8
          Top = 26
          Width = 97
          Height = 13
          Caption = 'Minuti pausa mensa:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblMinPercorr: TLabel
          Left = 160
          Top = 26
          Width = 60
          Height = 13
          Caption = 'Percorrenza:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblPMTTolleranza: TLabel
          Left = 266
          Top = 26
          Width = 52
          Height = 13
          Caption = 'Tolleranza:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedtMMMinimi: TDBEdit
          Left = 107
          Top = 23
          Width = 39
          Height = 21
          DataField = 'MmMinimi'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = PulisciValore
        end
        object dedtMinPercorr: TDBEdit
          Left = 222
          Top = 23
          Width = 39
          Height = 21
          DataField = 'MinPercorr'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = PulisciValore
        end
        object dcmbTipoMensa: TDBComboBox
          Left = 107
          Top = 1
          Width = 251
          Height = 19
          Style = csOwnerDrawFixed
          DataField = 'TipoMensa'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          Items.Strings = (
            'Z'
            'A'
            'B'
            'C'
            'D'
            'E'
            'F')
          ParentFont = False
          TabOrder = 0
          OnChange = dcmbTipoMensaChange
          OnDrawItem = dcmbTipoOraDrawItem
        end
        object grpPausaMensaTimbrata: TGroupBox
          Left = 8
          Top = 54
          Width = 288
          Height = 167
          Caption = 'Intervallo di mensa timbrato'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          object Label4: TLabel
            Left = 7
            Top = 122
            Width = 104
            Height = 13
            Caption = 'Tolleranza fuori orario:'
          end
          object lblPMRecupUscita: TLabel
            Left = 7
            Top = 145
            Width = 193
            Height = 13
            Caption = 'Intervallo minimo per il recupero in uscita:'
          end
          object DBCheckBox3: TDBCheckBox
            Left = 7
            Top = 27
            Width = 271
            Height = 16
            Alignment = taLeftJustify
            Caption = 'Timbrature U/E intersecanti'
            DataField = 'IntersezioneMensa'
            DataSource = DButton
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object DBCheckBox1: TDBCheckBox
            Left = 7
            Top = 12
            Width = 271
            Height = 16
            Alignment = taLeftJustify
            Caption = 'Causale obbligatoria'
            DataField = 'CauObFac'
            DataSource = DButton
            TabOrder = 0
            ValueChecked = 'O'
            ValueUnchecked = 'F'
          end
          object DBEdit1: TDBEdit
            Left = 239
            Top = 119
            Width = 39
            Height = 21
            DataField = 'PAUSAMENSA_ESTERNA'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 7
            OnChange = PulisciValore
          end
          object dedtPMRecupUscita: TDBEdit
            Left = 239
            Top = 142
            Width = 39
            Height = 21
            DataField = 'PM_RECUP_USCITA'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 8
            OnChange = PulisciValore
          end
          object dchkPMT_TIMB_AUTORIZZATE: TDBCheckBox
            Left = 7
            Top = 42
            Width = 271
            Height = 16
            Alignment = taLeftJustify
            Caption = 'Considera solo timbrature autorizzate'
            DataField = 'PMT_TIMB_AUTORIZZATE'
            DataSource = DButton
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dchkPMTTimbMaturaMensa: TDBCheckBox
            Left = 7
            Top = 57
            Width = 271
            Height = 16
            Alignment = taLeftJustify
            Caption = 'Esclude timbrature che non maturano pausa mensa'
            DataField = 'PMT_TIMB_MATURAMENSA'
            DataSource = DButton
            TabOrder = 3
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dchkPMTLimiteFlex: TDBCheckBox
            Left = 7
            Top = 72
            Width = 271
            Height = 16
            Alignment = taLeftJustify
            Caption = 'Flex. max. solo per pausa mensa'
            DataField = 'PMT_LIMITE_FLEX'
            DataSource = DButton
            TabOrder = 4
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dchkPMTNoTimbConsecutive: TDBCheckBox
            Left = 7
            Top = 87
            Width = 271
            Height = 16
            Alignment = taLeftJustify
            Caption = 'Non considera timbrature consecutive'
            DataField = 'PMT_NOTIMBCONSECUTIVE'
            DataSource = DButton
            TabOrder = 5
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dchkPMTUscitaRit: TDBCheckBox
            Left = 7
            Top = 101
            Width = 271
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Attiva solo se uscita dopo ora max.'
            DataField = 'PMT_USCITARIT'
            DataSource = DButton
            TabOrder = 6
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkPMAutoURitClick
          end
        end
        object grpMensaAutomatica: TGroupBox
          Left = 300
          Top = 54
          Width = 287
          Height = 167
          Caption = 'Parametri per detrazione automatica'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          object lblRientroMinimo: TLabel
            Left = 7
            Top = 109
            Width = 114
            Height = 13
            Caption = 'Rientro minimo richiesto:'
          end
          object lblPausaMensaAutomatica: TLabel
            Left = 7
            Top = 84
            Width = 134
            Height = 13
            Caption = 'Min. di detrazione alternativi:'
          end
          object dchkDetrAutCont: TDBCheckBox
            Left = 7
            Top = 31
            Width = 271
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Ore continuative'
            DataField = 'DETRAUTCONT'
            DataSource = DButton
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dedtRientroMinimo: TDBEdit
            Left = 239
            Top = 106
            Width = 39
            Height = 21
            DataField = 'Rientro_Minimo'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = PulisciValore
          end
          object dedetPausaMensaAutomatica: TDBEdit
            Left = 239
            Top = 81
            Width = 39
            Height = 21
            DataField = 'PAUSAMENSA_AUTOMATICA'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = PulisciValore
          end
          object dchkPMAutoURit: TDBCheckBox
            Left = 7
            Top = 15
            Width = 271
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Forzata se uscita dopo ora max.'
            DataField = 'PM_AUTO_URIT'
            DataSource = DButton
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkPMAutoURitClick
          end
          object dchkPMAPreservaTimbInFascia: TDBCheckBox
            Left = 7
            Top = 47
            Width = 271
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Detrazione dalle sole timbrature intersecanti  la fascia '
            DataField = 'PMA_PRESERVA_TIMBINFASCIA'
            DataSource = DButton
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
        object dedtPMTTolleranza: TDBEdit
          Left = 321
          Top = 23
          Width = 39
          Height = 21
          DataField = 'PMT_TOLLERANZA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = PulisciValore
        end
        object grpTimbraturaMensa: TGroupBox
          Left = 8
          Top = 221
          Width = 579
          Height = 87
          Caption = 'Timbratura di mensa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          object lblTimbraturaMensaDetrazione: TLabel
            Left = 18
            Top = 66
            Width = 134
            Height = 13
            Caption = 'Min. di detrazione alternativi:'
          end
          object dedtTimbraturaMensaDetrazione: TDBEdit
            Left = 158
            Top = 62
            Width = 39
            Height = 21
            DataField = 'TIMBRATURAMENSA_DETRAZIONE'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = PulisciValore
          end
          object dchkTimbraturaMensaDetrTot: TDBCheckBox
            Left = 413
            Top = 46
            Width = 137
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Applica detrazione totale'
            DataField = 'TIMBRATURAMENSA_DETRTOT'
            DataSource = DButton
            TabOrder = 3
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object drgpTimbraturaMensaInterna: TDBRadioGroup
            Left = 18
            Top = 13
            Width = 532
            Height = 32
            Caption = 'Criterio di validit'#224
            Columns = 3
            DataField = 'TIMBRATURAMENSA_INTERNA'
            DataSource = DButton
            Items.Strings = (
              'Nella fascia di pausa mensa'
              'Tra prima E ed ultima U'
              'Tra E ed U')
            TabOrder = 0
            Values.Strings = (
              'N'
              'S'
              'I')
          end
          object dchkPmtSoloTimbMensa: TDBCheckBox
            Left = 15
            Top = 45
            Width = 202
            Height = 16
            Alignment = taLeftJustify
            Caption = 'Obbligatoria per interv. mensa timbrato'
            DataField = 'PMT_SOLO_TIMBMENSA'
            DataSource = DButton
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkTimbraturaMensaClick
          end
          object dchkTimbraturaMensa: TDBCheckBox
            Left = 240
            Top = 45
            Width = 164
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Forza la detrazione automatica'
            DataField = 'TIMBRATURAMENSA'
            DataSource = DButton
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkTimbraturaMensaClick
          end
          object dchkTimbraturaMensaFlex: TDBCheckBox
            Left = 315
            Top = 65
            Width = 235
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Applica flessibilit'#224' pari alla detrazione mensa'
            DataField = 'TIMBRATURAMENSA_FLEX'
            DataSource = DButton
            TabOrder = 5
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
        object grpPMIntermedia: TGroupBox
          Left = 401
          Top = -3
          Width = 186
          Height = 58
          TabOrder = 4
          object Label11: TLabel
            Left = 8
            Top = 12
            Width = 115
            Height = 13
            Caption = 'Pausa mensa intermedia'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 8
            Top = 34
            Width = 130
            Height = 13
            Caption = 'se si rendono le ore minime:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dedtPMStaccoInf: TDBEdit
            Left = 140
            Top = 9
            Width = 39
            Height = 21
            DataField = 'PM_STACCO_INF'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = PulisciValore
          end
          object dedtPMOreMinimeInf: TDBEdit
            Left = 140
            Top = 32
            Width = 39
            Height = 21
            DataField = 'PM_OREMINIME_INF'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = PulisciValore
          end
        end
      end
    end
    object tabStraordinario: TTabSheet
      Caption = 'Straordinario'
      ImageIndex = 4
      object Panel6: TPanel
        Left = 318
        Top = 0
        Width = 286
        Height = 372
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object dgrdStraordinario: TDBGrid
          Left = 0
          Top = 232
          Width = 286
          Height = 140
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
          ParentFont = False
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clTeal
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnExit = dgrdSelT021Exit
        end
        object GroupBox10: TGroupBox
          Left = 0
          Top = 178
          Width = 286
          Height = 54
          Align = alTop
          Caption = 'Vincoli di fruizione dello straordinario'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object Label58: TLabel
            Left = 33
            Top = 16
            Width = 160
            Height = 13
            Caption = 'Stacco tra ultima uscita e straord.:'
            WordWrap = True
          end
          object P4E07: TDBEdit
            Left = 208
            Top = 13
            Width = 39
            Height = 21
            DataField = 'InterUsc'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = PulisciValore
          end
          object chkDopoOreMax: TDBCheckBox
            Left = 32
            Top = 35
            Width = 216
            Height = 17
            Alignment = taLeftJustify
            BiDiMode = bdLeftToRight
            Caption = 'Dopo ore max'
            DataField = 'STR_DOPO_HHMAX'
            DataSource = DButton
            ParentBiDiMode = False
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
        object GroupBox9: TGroupBox
          Left = 0
          Top = 0
          Width = 286
          Height = 178
          Align = alTop
          Caption = 'Straordinario fuori fascia oraria'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label55: TLabel
            Left = 33
            Top = 77
            Width = 109
            Height = 13
            Caption = 'Minuti minimi giornalieri:'
          end
          object Label56: TLabel
            Left = 33
            Top = 100
            Width = 126
            Height = 13
            Caption = 'HH:MM massimi giornalieri:'
          end
          object Label57: TLabel
            Left = 33
            Top = 123
            Width = 173
            Height = 13
            Caption = 'Arrotondamento generale giornaliero:'
          end
          object Label53: TLabel
            Left = 33
            Top = 16
            Width = 151
            Height = 13
            Caption = 'Minuti minimi per ogni spezzone:'
          end
          object Label54: TLabel
            Left = 33
            Top = 54
            Width = 160
            Height = 13
            Caption = 'Arrotondamento di ogni spezzone:'
          end
          object P4E04: TDBEdit
            Left = 208
            Top = 73
            Width = 39
            Height = 21
            DataField = 'MinGioStr'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = PulisciValore
          end
          object P4E05: TDBEdit
            Left = 208
            Top = 96
            Width = 39
            Height = 21
            DataField = 'MaxGioStr'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = PulisciValore
          end
          object P4E06: TDBEdit
            Left = 208
            Top = 119
            Width = 39
            Height = 21
            DataField = 'ArrotGior'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = PulisciValore
          end
          object P4E01: TDBEdit
            Left = 208
            Top = 12
            Width = 39
            Height = 21
            DataField = 'MinimiStr'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = PulisciValore
          end
          object P4E03: TDBEdit
            Left = 208
            Top = 50
            Width = 39
            Height = 21
            DataField = 'ArrivRang'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = PulisciValore
          end
          object dchkArrotComp2: TDBCheckBox
            Left = 33
            Top = 141
            Width = 214
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Arrotondam. mantenuto nel compensabile'
            DataField = 'ARROT_COMP'
            DataSource = DButton
            TabOrder = 6
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dChkCompseInf: TDBCheckBox
            Left = 33
            Top = 33
            Width = 214
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Se inferiori mantenuti nel compensabile'
            DataField = 'MINIMISTR_COMP'
            DataSource = DButton
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dchkSpezzNonCaus_ScartoEcc: TDBCheckBox
            Left = 33
            Top = 158
            Width = 214
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Limite all'#39'ecced. giornaliera in gest.mensile'
            DataField = 'SPEZZNONCAUS_SCARTOECC'
            DataSource = DButton
            TabOrder = 7
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 318
        Height = 372
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object Label20: TLabel
          Left = 3
          Top = 8
          Width = 84
          Height = 13
          Caption = 'Tipo straordinario:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object GroupBox11: TGroupBox
          Left = 5
          Top = 43
          Width = 299
          Height = 284
          Caption = 'Eccedenza liquidabile/compensabile'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object Label5: TLabel
            Left = 21
            Top = 36
            Width = 161
            Height = 13
            Caption = 'Soglia per eccedenza oltre debito:'
          end
          object Label13: TLabel
            Left = 21
            Top = 148
            Width = 146
            Height = 13
            Caption = 'Arrotondamento dopo la soglia:'
          end
          object Label21: TLabel
            Left = 21
            Top = 80
            Width = 184
            Height = 13
            Caption = 'Ora max per eccedenza compensabile:'
          end
          object Label8: TLabel
            Left = 21
            Top = 261
            Width = 122
            Height = 13
            Caption = 'Ecc.comp. da mantenere:'
          end
          object Label10: TLabel
            Left = 21
            Top = 58
            Width = 147
            Height = 13
            Caption = 'Eccedenza minima oltre debito:'
          end
          object lblArrotondamentoSottoSoglia: TLabel
            Left = 21
            Top = 102
            Width = 145
            Height = 13
            Caption = 'Arrotondamento sotto la soglia:'
          end
          object Label12: TLabel
            Left = 21
            Top = 124
            Width = 143
            Height = 13
            Caption = 'Eccedenza max oltre la soglia:'
          end
          object EComp1: TDBRadioGroup
            Left = 21
            Top = 183
            Width = 250
            Height = 74
            Caption = 'Gestione eccedenza sotto la soglia'
            DataField = 'CompLiq'
            DataSource = DButton
            Items.Strings = (
              'Compensabile se scost.giorn. < soglia '
              'Persa se scost.giorn. < soglia'
              'Sempre compensabile'
              'Sempre persa')
            TabOrder = 8
            Values.Strings = (
              'S'
              'N'
              'C'
              'P')
          end
          object P4E13: TDBEdit
            Left = 233
            Top = 32
            Width = 39
            Height = 21
            DataField = 'MINSCOSTR'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = PulisciValore
          end
          object P4E14: TDBEdit
            Left = 233
            Top = 144
            Width = 39
            Height = 21
            DataField = 'ARRSCOSTR'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 6
            OnChange = PulisciValore
          end
          object dchkSoloComp: TDBCheckBox
            Left = 21
            Top = 15
            Width = 251
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Maturazione solo eccedenza compensabile'
            DataField = 'TUTTOCOMP'
            DataSource = DButton
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            OnClick = dchkSoloCompClick
          end
          object EComp2: TDBRadioGroup
            Left = 21
            Top = 185
            Width = 252
            Height = 62
            Caption = 'Gestione eccedenza sotto la soglia'
            DataField = 'CompLiq'
            DataSource = DButton
            Items.Strings = (
              'Persa se scost.giorn. < soglia'
              'Sempre persa')
            TabOrder = 9
            Values.Strings = (
              'N'
              'P')
            Visible = False
          end
          object dchkArrotComp: TDBCheckBox
            Left = 21
            Top = 168
            Width = 251
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Arrotondam. mantenuto nel compensabile'
            DataField = 'ARRSCOSTR_COMP'
            DataSource = DButton
            TabOrder = 7
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dedtOraMaxComp: TDBEdit
            Left = 233
            Top = 76
            Width = 39
            Height = 21
            DataField = 'ORAMAX_COMPENSABILE'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnChange = PulisciValore
          end
          object dcmbEccCompCausalizzata: TDBComboBox
            Left = 146
            Top = 258
            Width = 127
            Height = 19
            Style = csOwnerDrawFixed
            DataField = 'Ecc_Comp_Causalizzata'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemHeight = 13
            Items.Strings = (
              'N'
              'E'
              'C')
            ParentFont = False
            TabOrder = 10
            OnDrawItem = dcmbTipoOraDrawItem
          end
          object dedtScostGGMinSoglia: TDBEdit
            Left = 233
            Top = 54
            Width = 39
            Height = 21
            DataField = 'SCOSTGG_MIN_SOGLIA'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = PulisciValore
          end
          object dedtArrotondamentoSottoSoglia: TDBEdit
            Left = 233
            Top = 98
            Width = 39
            Height = 21
            DataField = 'ARRSCOSTR_SOTTOSOGLIA'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            OnChange = PulisciValore
          end
          object dedtMaxScoStr: TDBEdit
            Left = 233
            Top = 120
            Width = 39
            Height = 21
            DataField = 'MAXSCOSTR'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnChange = PulisciValore
          end
        end
        object dcmbTipoStraordinario: TDBComboBox
          Left = 91
          Top = 5
          Width = 195
          Height = 19
          Style = csOwnerDrawFixed
          DataField = 'COMPFASCIA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          Items.Strings = (
            '1'
            '2'
            '3'
            '4')
          ParentFont = False
          TabOrder = 0
          OnChange = dcmbTipoStraordinarioChange
          OnDrawItem = dcmbTipoOraDrawItem
        end
        object grpCarenzaObbNoLiq: TGroupBox
          Left = 5
          Top = 330
          Width = 299
          Height = 36
          Caption = 'Abbattimento eccedenza liquidabile'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object dchkCarenzaObbNoLiq: TDBCheckBox
            Left = 8
            Top = 15
            Width = 157
            Height = 17
            Caption = 'Fascia obbligatoria scoperta'
            DataField = 'CARENZA_OBB_NO_LIQ'
            DataSource = DButton
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
        object dchkStrRipFasce: TDBCheckBox
          Left = 3
          Top = 25
          Width = 282
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Ripartizione nelle fasce di maggiorazione'
          DataField = 'STRRIPFASCE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
    end
    object tabCausAuto: TTabSheet
      Caption = 'Causalizzazioni automatiche'
      ImageIndex = 4
      object lblCausaliEccedenza: TLabel
        Left = 3
        Top = 111
        Width = 190
        Height = 13
        Caption = 'Causalizzazione dello straord. liquidabile:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDistrOreOrdFasce: TLabel
        Left = 3
        Top = 166
        Width = 351
        Height = 13
        Caption = 
          'Distribuzione delle ore ordinarie nelle fasce a blocchi definite' +
          ' nella causale:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblAnomalieBloccanti: TLabel
        Left = 3
        Top = 213
        Width = 144
        Height = 13
        Caption = 'Anomalie bloccanti aggiuntive:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCausaliEccComp: TLabel
        Left = 3
        Top = 136
        Width = 182
        Height = 13
        Caption = 'Causalizzazione dell'#39'ecc.compensabile'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object grpFestLav: TGroupBox
        Left = 0
        Top = 0
        Width = 604
        Height = 102
        Align = alTop
        Caption = 'Festivo lavorato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblFestLavLiq: TLabel
          Left = 8
          Top = 20
          Width = 117
          Height = 13
          Caption = 'Causale per liquidazione:'
        end
        object lblFestLavCmpLiqTurn: TLabel
          Left = 8
          Top = 73
          Width = 210
          Height = 13
          Caption = 'Causale per liquidazione o recupero (turnisti):'
        end
        object lblFestLavCmpLiq: TLabel
          Left = 8
          Top = 46
          Width = 225
          Height = 13
          Caption = 'Causale per liquidazione o recupero (no turnisti):'
        end
        object dcmbFestLavLiq: TDBLookupComboBox
          Left = 237
          Top = 16
          Width = 83
          Height = 21
          DataField = 'FESTLAV_LIQ'
          DataSource = DButton
          DropDownWidth = 300
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyField = 'CODICE'
          ListField = 'CODICE;DESCRIZIONE'
          NullValueKey = 46
          ParentFont = False
          PopupMenu = pmnCausali
          TabOrder = 0
        end
        object dcmbFestLavCmpLiq: TDBLookupComboBox
          Left = 237
          Top = 43
          Width = 83
          Height = 21
          DataField = 'FESTLAV_CMP_LIQ'
          DataSource = DButton
          DropDownWidth = 300
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyField = 'CODICE'
          ListField = 'CODICE;DESCRIZIONE'
          NullValueKey = 46
          ParentFont = False
          PopupMenu = pmnCausali
          TabOrder = 1
        end
        object dcmbFestLavCmpLiqTurn: TDBLookupComboBox
          Left = 237
          Top = 70
          Width = 83
          Height = 21
          DataField = 'FESTLAV_CMP_LIQ_TURN'
          DataSource = DButton
          DropDownWidth = 300
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyField = 'CODICE'
          ListField = 'CODICE;DESCRIZIONE'
          NullValueKey = 46
          ParentFont = False
          PopupMenu = pmnCausali
          TabOrder = 2
        end
      end
      object btnCausaliEccedenza: TButton
        Left = 425
        Top = 108
        Width = 18
        Height = 21
        Caption = '...'
        TabOrder = 2
        OnClick = btnCausaliEccedenzaClick
      end
      object dedtCausaliEccedenza: TDBEdit
        Left = 196
        Top = 108
        Width = 228
        Height = 21
        DataField = 'CAUSALI_ECCEDENZA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmnCausali
        ReadOnly = True
        TabOrder = 1
      end
      object dcmbDistrOreOrdFasce: TDBLookupComboBox
        Left = 360
        Top = 163
        Width = 83
        Height = 21
        DataField = 'CAUSALE_FASCE'
        DataSource = DButton
        DropDownWidth = 300
        KeyField = 'CODICE'
        ListField = 'CODICE;DESCRIZIONE'
        NullValueKey = 46
        TabOrder = 5
      end
      object dchkPosticipaCausTimbIntersec: TDBCheckBox
        Left = 3
        Top = 190
        Width = 440
        Height = 17
        Alignment = taLeftJustify
        Caption = 
          'Posticipa la causalizzazione delle timbrature intersecanti i giu' +
          'stificativi e la lib.professione'
        DataField = 'POSTICIPA_CAUS_TIMB_INTERSEC'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dedtAnomalieBloccanti: TDBEdit
        Left = 196
        Top = 210
        Width = 228
        Height = 21
        DataField = 'ANOM_BLOCC_23LIV'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmnCausali
        ReadOnly = True
        TabOrder = 7
      end
      object btnAnomalieBloccanti: TButton
        Left = 425
        Top = 210
        Width = 18
        Height = 21
        Caption = '...'
        TabOrder = 8
        OnClick = btnAnomalieBloccantiClick
      end
      object btnCausaliEccComp: TButton
        Left = 425
        Top = 133
        Width = 18
        Height = 21
        Caption = '...'
        TabOrder = 4
        OnClick = btnCausaliEccedenzaClick
      end
      object dedtCausaliEccComp: TDBEdit
        Left = 196
        Top = 133
        Width = 228
        Height = 21
        DataField = 'CAUSALI_ECCCOMP'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = pmnCausali
        ReadOnly = True
        TabOrder = 3
      end
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 63
    Width = 612
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 5
      Width = 36
      Height = 13
      Caption = 'Codice:'
    end
    object Label3: TLabel
      Left = 120
      Top = 5
      Width = 58
      Height = 13
      Caption = 'Descrizione:'
    end
    object dedtCodice: TDBEdit
      Left = 48
      Top = 2
      Width = 49
      Height = 21
      DataField = 'Codice'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object dedtDescrizione: TDBEdit
      Left = 184
      Top = 2
      Width = 413
      Height = 21
      DataField = 'Descrizione'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 352
    Top = 32
    inherited File1: TMenuItem
      object N5: TMenuItem [5]
        Caption = '-'
      end
      object Ricercaduplicati1: TMenuItem [6]
        Action = actCercaDuplicati
      end
      object ModificaXPARAM1: TMenuItem [7]
        Action = actModificaXParam
      end
    end
  end
  inherited DButton: TDataSource
    Left = 380
    Top = 32
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 408
    Top = 32
  end
  inherited ImageList1: TImageList
    Left = 436
    Top = 32
    Bitmap = {
      494C010117001900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000006000000001002000000000000060
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
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000084000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF0000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      2800000040000000600000000100010000000000000300000000000000000000
      000000000000000000000000FFFFFF00FF7EFFFDFFFF00009001FFF8FF7F0000
      C003FFF1FE7F0000E003FFE3FC0F0000E003FFC7FE770000E003E08FFF770000
      E003C01FFFF700000001803FFFF700008000001FF7FF0000E007001FF7FF0000
      E00F001FF77F0000E00F001FF73F0000E027001FF81F0000C073803FFF3F0000
      9E79C07FFF7F00007EFEE0FFFFFF0000FFFFFFFFFFFF8003FFFFFFFFFFFF8003
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
  inherited ActionList1: TActionList
    Left = 464
    Top = 32
    object actCercaDuplicati: TAction
      Caption = 'Ricerca duplicati'
      OnExecute = actCercaDuplicatiExecute
    end
    object actModificaXParam: TAction
      Caption = 'Modifica XPARAM'
      OnExecute = actModificaXParamExecute
    end
  end
  object pmnCausali: TPopupMenu
    Left = 520
    Top = 176
    object mnuAccedi: TMenuItem
      Caption = 'Accedi'
      OnClick = mnuAccediClick
    end
  end
end
