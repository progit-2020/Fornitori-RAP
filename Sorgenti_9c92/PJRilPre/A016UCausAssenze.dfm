inherited A016FCausAssenze: TA016FCausAssenze
  Left = 354
  Top = 173
  HelpContext = 16000
  BorderStyle = bsSingle
  Caption = '<A016> Causali di assenza'
  ClientHeight = 534
  ClientWidth = 636
  ExplicitWidth = 642
  ExplicitHeight = 583
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 516
    Width = 636
    ExplicitTop = 516
    ExplicitWidth = 636
  end
  inherited Panel1: TToolBar
    Width = 636
    Height = 28
    ExplicitWidth = 636
    ExplicitHeight = 28
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 28
    Width = 636
    Height = 77
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 6
      Top = 6
      Width = 36
      Height = 13
      Caption = 'Codice:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 124
      Top = 6
      Width = 58
      Height = 13
      Caption = 'Descrizione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 6
      Top = 56
      Width = 85
      Height = 13
      Caption = 'Raggruppamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 165
      Top = 56
      Width = 270
      Height = 17
      DataField = 'D_Raggruppamento'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDescrizioneEstesa1: TLabel
      Left = 124
      Top = 24
      Width = 56
      Height = 26
      AutoSize = False
      Caption = 'Descrizione estesa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Label24: TLabel
      Left = 6
      Top = 24
      Width = 52
      Height = 26
      AutoSize = False
      Caption = 'Sigla per prospetto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object DBEdit1: TDBEdit
      Left = 58
      Top = 3
      Width = 55
      Height = 21
      DataField = 'Codice'
      DataSource = DButton
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 184
      Top = 3
      Width = 336
      Height = 21
      DataField = 'Descrizione'
      DataSource = DButton
      TabOrder = 1
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 95
      Top = 52
      Width = 67
      Height = 21
      DataField = 'CodRaggr'
      DataSource = DButton
      DropDownWidth = 200
      KeyField = 'Codice'
      ListField = 'Codice;Descrizione'
      PopupMenu = PopupMenu1
      TabOrder = 4
      OnKeyDown = dcmbKeyDown
    end
    object DBCheckBox4: TDBCheckBox
      Left = 438
      Top = 55
      Width = 82
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Anno solare'
      DataField = 'ContASolare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dedtDescrizioneEstesa: TDBEdit
      Left = 184
      Top = 28
      Width = 336
      Height = 21
      DataField = 'DESCRIZIONE_ESTESA'
      DataSource = DButton
      TabOrder = 3
    end
    object dedtSiglaCausale: TDBEdit
      Left = 58
      Top = 28
      Width = 55
      Height = 21
      DataField = 'SIGLA_CAUSALE'
      DataSource = DButton
      TabOrder = 2
    end
  end
  object PageControl1: TPageControl [3]
    Left = 0
    Top = 105
    Width = 636
    Height = 411
    ActivePage = TabSheet7
    Align = alClient
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Cartellino'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      object Label4: TLabel
        Left = 220
        Top = 262
        Width = 143
        Height = 13
        Caption = 'HH:MM per giorno di assenza:'
        Enabled = False
      end
      object Label18: TLabel
        Left = 220
        Top = 1
        Width = 106
        Height = 13
        Caption = 'Influenza sui conteggi:'
      end
      object Label19: TLabel
        Left = 220
        Top = 39
        Width = 99
        Height = 13
        Caption = 'Modalit'#224' di recupero:'
      end
      object lblDetReperib: TLabel
        Left = 220
        Top = 159
        Width = 128
        Height = 13
        Caption = 'Escl. dal turno di reperibilit'#224
      end
      object DBRadioGroup1: TDBRadioGroup
        Left = 1
        Top = 2
        Width = 194
        Height = 65
        Caption = 'Giorno non lavorativo'
        DataField = 'GNonLav'
        DataSource = DButton
        Items.Strings = (
          'Ininfluente'
          'Influente per conteggi e assenze'
          'Influente solo per assenze')
        TabOrder = 0
        Values.Strings = (
          'A'
          'B'
          'C')
      end
      object DBRadioGroup3: TDBRadioGroup
        Left = 1
        Top = 68
        Width = 194
        Height = 106
        Hint = 'Valorizzazione tramite i Parametri storicizzati'
        Caption = 'Valorizzazione giornaliera'
        DataField = 'ValorGior'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Monte ore sett./gg. lav.'
          'Ore teoriche dell'#39'orario'
          'Monte ore sett./6'
          'Ore teoriche da anagrafico'
          'Ore del debito giornaliero')
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 1
        Values.Strings = (
          'A'
          'B'
          'C'
          'D'
          'E')
      end
      object DBRadioGroup4: TDBRadioGroup
        Left = 1
        Top = 241
        Width = 194
        Height = 65
        Caption = 'Influenza debito aggiuntivo'
        DataField = 'InfluenzaPO'
        DataSource = DButton
        Items.Strings = (
          'Aumenta le ore del debito'
          'Ininfluente ai fini del debito'
          'Annulla debito')
        TabOrder = 3
        Values.Strings = (
          'A'
          'B'
          'C')
      end
      object DBCheckBox1: TDBCheckBox
        Left = 218
        Top = 77
        Width = 295
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Compensazione da eccedenza liquidabile'
        DataField = 'EccedLiq'
        DataSource = DButton
        TabOrder = 7
        ValueChecked = 'A'
        ValueUnchecked = 'B'
      end
      object DBCheckBox2: TDBCheckBox
        Left = 218
        Top = 122
        Width = 295
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Matura indennit'#224' di presenza'
        DataField = 'Indpres'
        DataSource = DButton
        TabOrder = 10
        ValueChecked = 'A'
        ValueUnchecked = 'B'
      end
      object DBEdit3: TDBEdit
        Left = 470
        Top = 259
        Width = 43
        Height = 21
        Hint = 'Valorizzazione tramite i Parametri storicizzati'
        Color = clBtnFace
        DataField = 'HMAssenza'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ShowHint = True
        TabOrder = 15
      end
      object DBRadioGroup5: TDBRadioGroup
        Left = 220
        Top = 278
        Width = 295
        Height = 93
        Caption = 'Raggruppamento statistica assenze'
        Columns = 2
        DataField = 'RaggrStat'
        DataSource = DButton
        Items.Strings = (
          'Nessuno'
          'Ferie'
          'Permessi retribuiti'
          'Malattia'
          'Sciopero'
          'Assenze non retribuite'
          'Legge 104/1992'
          'Maternit'#224
          'Formazione'
          'Art.42 c.5 dlgs 151/2001')
        TabOrder = 16
        Values.Strings = (
          'Z'
          'A'
          'B'
          'C'
          'D'
          'E'
          'F'
          'G'
          'H'
          'I')
      end
      object DBRadioGroup6: TDBRadioGroup
        Left = 1
        Top = 176
        Width = 194
        Height = 65
        Caption = 'Stampa su cartellino'
        DataField = 'Stampa'
        DataSource = DButton
        Items.Strings = (
          'No stampa'
          'Riepilogo'
          'Riepilogo e competenze')
        TabOrder = 2
        Values.Strings = (
          'B'
          'A'
          'C')
      end
      object DBComboBox1: TDBComboBox
        Left = 220
        Top = 15
        Width = 295
        Height = 22
        Style = csOwnerDrawFixed
        DataField = 'InfluCont'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'A'
          'G'
          'I'
          'B'
          'C'
          'D'
          'H')
        ParentFont = False
        TabOrder = 5
        OnChange = DBComboBox1Change
        OnDrawItem = DBComboBox1DrawItem
      end
      object DBCheckBox6: TDBCheckBox
        Left = 218
        Top = 92
        Width = 295
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Valorizzazione solo in presenza di timbrature'
        DataField = 'VALSETIMB'
        DataSource = DButton
        TabOrder = 8
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox7: TDBCheckBox
        Left = 218
        Top = 137
        Width = 295
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Recupero indennit'#224' festiva'
        DataField = 'RecuperoFestivo'
        DataSource = DButton
        TabOrder = 11
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox8: TDBCheckBox
        Left = 218
        Top = 107
        Width = 295
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Esclusione dalle ore rese da assenza'
        DataField = 'ESCLUSIONE'
        DataSource = DButton
        TabOrder = 9
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBComboBox2: TDBComboBox
        Left = 220
        Top = 53
        Width = 295
        Height = 22
        Style = csOwnerDrawFixed
        DataField = 'TipoRecupero'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          '0'
          'PC'
          'PL'
          'AC'
          'AL'
          'BO')
        ParentFont = False
        TabOrder = 6
        OnDrawItem = DBComboBox1DrawItem
      end
      object dchkFlessibilitaOrario: TDBCheckBox
        Left = 218
        Top = 195
        Width = 295
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Altera la flessibilit'#224' degli orari flessibili'
        DataField = 'FLESSIBILITA_ORARIO'
        DataSource = DButton
        TabOrder = 13
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object drgpIntersezioneTimbrature: TDBRadioGroup
        Left = 1
        Top = 306
        Width = 194
        Height = 65
        Caption = 'Sovrapposizione su timbrature'
        DataField = 'INTERSEZIONE_TIMBRATURE'
        DataSource = DButton
        Items.Strings = (
          'Conteggia entrambi'
          'Conteggia timbrature'
          'Conteggia giustificativi')
        TabOrder = 4
        Values.Strings = (
          'E'
          'T'
          'G')
        OnChange = EUMisuraChange
        OnClick = EUMisuraClick
      end
      object dchkTimbPM: TDBCheckBox
        Left = 218
        Top = 227
        Width = 295
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Considera nella pausa mensa timbrata'
        DataField = 'TIMB_PM'
        DataSource = DButton
        TabOrder = 14
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dchkTimbPMClick
      end
      object dchkTimbPMDetraz: TDBCheckBox
        Left = 218
        Top = 242
        Width = 295
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Ore rese conteggiate al netto della pausa mensa'
        DataField = 'TIMB_PM_DETRAZ'
        DataSource = DButton
        TabOrder = 17
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkDetReperibIntera: TDBCheckBox
        Left = 218
        Top = 180
        Width = 295
        Height = 17
        Alignment = taLeftJustify
        Caption = 'La fruizione a giornata intera esclude tutto il turno'
        DataField = 'DETREPERIB_TOTALE'
        DataSource = DButton
        Enabled = False
        TabOrder = 12
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dcmbDetReperib: TDBComboBox
        Left = 354
        Top = 156
        Width = 159
        Height = 22
        Style = csOwnerDrawFixed
        DataField = 'DETREPERIB'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          '0'
          '1'
          '4'
          '5'
          '2'
          '3')
        ParentFont = False
        TabOrder = 18
        OnChange = dcmbDetReperibChange
        OnDrawItem = DBComboBox1DrawItem
      end
      object dchkCopriFasciaObb: TDBCheckBox
        Left = 218
        Top = 211
        Width = 295
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Copre la fascia obbligatoria'
        DataField = 'COPRE_FASCIA_OBB'
        DataSource = DButton
        TabOrder = 19
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Regole inserimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      object Label23: TLabel
        Left = 5
        Top = 301
        Width = 123
        Height = 13
        Caption = '% abbattimento ore INAIL:'
      end
      object lblCausaleSuccessiva: TLabel
        Left = 6
        Top = 325
        Width = 164
        Height = 13
        Caption = 'Se esaurite le competenze inserire:'
      end
      object dlblCausaleSuccessiva: TDBText
        Left = 278
        Top = 325
        Width = 109
        Height = 13
        AutoSize = True
        DataField = 'D_CAUSALE_SUCCESSIVA'
        DataSource = DButton
      end
      object lblCausale10Giorni: TLabel
        Left = 5
        Top = 348
        Width = 193
        Height = 13
        Caption = 'Nei primi 10 gg del periodo sostituire con:'
      end
      object dlblCodCaus3: TDBText
        Left = 278
        Top = 348
        Width = 65
        Height = 13
        AutoSize = True
        DataField = 'D_CODCAU3'
        DataSource = DButton
      end
      object Label25: TLabel
        Left = 330
        Top = 160
        Width = 130
        Height = 13
        Caption = 'Copre i giorni non lavorativi:'
      end
      object EGSignific: TDBRadioGroup
        Left = 1
        Top = 2
        Width = 138
        Height = 247
        Caption = 'Giorni di significativit'#224
        DataField = 'GSignific'
        DataSource = DButton
        Items.Strings = (
          'Giorni di Calendario'
          'Giorni Lavorativi'
          'Giorni Lav. Turnisti'
          'Giorni da LUN. a SAB.'
          'Esclusi festivi infrasett.'
          'DOM.+festivi infrasett.')
        TabOrder = 0
        Values.Strings = (
          'GC'
          'GL'
          'GT'
          'G6'
          'EF'
          'DF')
        OnChange = EGSignificChange
      end
      object EFruibile: TDBCheckBox
        Left = 330
        Top = 3
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Fruibile da tutti'
        DataField = 'Fruibile'
        DataSource = DButton
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = EFruibileClick
      end
      object EMaturFerie: TDBCheckBox
        Left = 330
        Top = 20
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Maturazione ferie'
        DataField = 'MaturFerie'
        DataSource = DButton
        TabOrder = 4
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox3: TDBCheckBox
        Left = 330
        Top = 139
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Inserimento automatico'
        DataField = 'RICORSIONE'
        DataSource = DButton
        TabOrder = 10
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox9: TDBCheckBox
        Left = 330
        Top = 83
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Prolunga il periodo di prova'
        DataField = 'ALLUNGA_PROVA'
        DataSource = DButton
        TabOrder = 7
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object DBCheckBox10: TDBCheckBox
        Left = 330
        Top = 101
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Registra nello storico'
        DataField = 'REGISTRA_STORICO'
        DataSource = DButton
        TabOrder = 8
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = DBCheckBox10Click
      end
      object dchkNoSuperoCompetenze: TDBCheckBox
        Left = 330
        Top = 39
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Supero competenze impedito'
        DataField = 'NO_SUPERO_COMPETENZE'
        DataSource = DButton
        TabOrder = 5
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dchkNoSuperoCompetenzeClick
      end
      object grpVincoliFruizione: TGroupBox
        Left = 145
        Top = 66
        Width = 179
        Height = 183
        Caption = 'Vincoli di fruizione oraria'
        TabOrder = 2
        object Label20: TLabel
          Left = 8
          Top = 20
          Width = 36
          Height = 13
          Caption = 'Minimo:'
        end
        object Label22: TLabel
          Left = 8
          Top = 68
          Width = 78
          Height = 13
          Caption = 'Arrotondamento:'
        end
        object lblFruizMax: TLabel
          Left = 8
          Top = 44
          Width = 44
          Height = 13
          Caption = 'Massimo:'
        end
        object lblOreGGMaxInf6: TLabel
          Left = 8
          Top = 131
          Width = 103
          Height = 13
          Caption = 'Max per lavorato < 6h'
        end
        object lblOreGGMaxSup6: TLabel
          Left = 8
          Top = 155
          Width = 103
          Height = 13
          Caption = 'Max per lavorato > 6h'
        end
        object dedtFruizMin: TDBEdit
          Left = 126
          Top = 17
          Width = 39
          Height = 21
          DataField = 'FRUIZ_MIN'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = EHMaxUnitarioChange
        end
        object dedtFruizArr: TDBEdit
          Left = 126
          Top = 65
          Width = 39
          Height = 21
          DataField = 'FRUIZ_ARR'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = EHMaxUnitarioChange
        end
        object dchkFruizMaxDebito: TDBCheckBox
          Left = 6
          Top = 108
          Width = 159
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Massimo debito giornaliero'
          DataField = 'FRUIZ_MAX_DEBITO'
          DataSource = DButton
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkFruizCompetenzeArr: TDBCheckBox
          Left = 6
          Top = 89
          Width = 159
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Arrotondamento nei conteggi'
          DataField = 'FRUIZCOMPETENZE_ARR'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dedtFruizMax: TDBEdit
          Left = 126
          Top = 41
          Width = 39
          Height = 21
          DataField = 'FRUIZ_MAX'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = EHMaxUnitarioChange
        end
        object dedtOreGGMaxInf6: TDBEdit
          Left = 126
          Top = 128
          Width = 39
          Height = 21
          DataField = 'OREGG_MAX_INF6'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnChange = EHMaxUnitarioChange
        end
        object dedtOreGGMaxSup6: TDBEdit
          Left = 126
          Top = 152
          Width = 39
          Height = 21
          DataField = 'OREGG_MAX_SUP6'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = EHMaxUnitarioChange
        end
      end
      object gbxUnInserimento: TGroupBox
        Left = 145
        Top = 2
        Width = 179
        Height = 63
        Caption = 'Modalit'#224' di fruizione'
        TabOrder = 1
        object dchkUnInserimento: TDBCheckBox
          Left = 6
          Top = 20
          Width = 78
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Giornate'
          DataField = 'UM_INSERIMENTO'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkUnInserimentoMg: TDBCheckBox
          Left = 6
          Top = 39
          Width = 78
          Height = 17
          Alignment = taLeftJustify
          Caption = '1/2 giornate'
          DataField = 'UM_INSERIMENTO_MG'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dchkUnInserimentoMgClick
        end
        object dchkUnInserimentoH: TDBCheckBox
          Left = 92
          Top = 20
          Width = 78
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Num. ore'
          DataField = 'UM_INSERIMENTO_H'
          DataSource = DButton
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dchkUnInserimentoHClick
        end
        object dchkUnInserimentoD: TDBCheckBox
          Left = 92
          Top = 39
          Width = 78
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Da ore a ore'
          DataField = 'UM_INSERIMENTO_D'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = dchkUnInserimentoHClick
        end
      end
      object DBEdit4: TDBEdit
        Left = 203
        Top = 298
        Width = 39
        Height = 21
        DataField = 'PERC_INAIL'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        OnChange = EHMaxUnitarioChange
      end
      object dedtCausaleSuccessiva: TDBLookupComboBox
        Left = 203
        Top = 321
        Width = 69
        Height = 21
        DataField = 'CAUSALE_SUCCESSIVA'
        DataSource = DButton
        DropDownWidth = 200
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        ParentFont = False
        TabOrder = 18
        OnKeyDown = dcmbKeyDown
      end
      object DBCheckBox15: TDBCheckBox
        Left = 330
        Top = 120
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Richiedi validazione'
        DataField = 'VALIDAZIONE'
        DataSource = DButton
        TabOrder = 9
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = DBCheckBox15Click
      end
      object dedtCausale10Giorni: TDBLookupComboBox
        Left = 203
        Top = 344
        Width = 69
        Height = 21
        DataField = 'CODCAU3'
        DataSource = DButton
        DropDownWidth = 200
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'Codice'
        ListField = 'Codice;Descrizione'
        ParentFont = False
        TabOrder = 19
        OnKeyDown = dcmbKeyDown
      end
      object dchkVisitaFiscale: TDBCheckBox
        Left = 330
        Top = 197
        Width = 187
        Height = 18
        Alignment = taLeftJustify
        Caption = 'Gestione visite fiscali'
        DataField = 'VISITA_FISCALE'
        DataSource = DButton
        TabOrder = 12
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkPeriodoLungo: TDBCheckBox
        Left = 330
        Top = 212
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Identifica lunghi periodi'
        DataField = 'PERIODO_LUNGO'
        DataSource = DButton
        TabOrder = 13
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkMaternitaObbl: TDBCheckBox
        Left = 330
        Top = 230
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Maternit'#224' obbligatoria'
        DataField = 'MATERNITA_OBBL'
        DataSource = DButton
        TabOrder = 14
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkNoSuperoCompWeb: TDBCheckBox
        Left = 330
        Top = 60
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Supero competenze impedito in Iter autorizzativo'
        DataField = 'NO_SUPERO_COMPETENZE_WEB'
        DataSource = DButton
        TabOrder = 6
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        WordWrap = True
      end
      object dchkAbbatteGGSerTempoDet: TDBCheckBox
        Left = 330
        Top = 248
        Width = 187
        Height = 26
        Alignment = taLeftJustify
        Caption = 'Abbatte gg servizio nei tempi determinati per comp.malattia'
        DataField = 'ABBATTE_GGSERV_TEMPODET'
        DataSource = DButton
        TabOrder = 15
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        WordWrap = True
      end
      object dchkAbbatteGgValutazione: TDBCheckBox
        Left = 330
        Top = 273
        Width = 187
        Height = 22
        Alignment = taLeftJustify
        Caption = 'Abbatte il periodo di valutazione'
        DataField = 'ABBATTE_GGVALUTAZIONE'
        DataSource = DButton
        TabOrder = 16
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dcmbggnnlav: TDBComboBox
        Left = 330
        Top = 174
        Width = 187
        Height = 22
        Style = csOwnerDrawFixed
        DataField = 'COPRI_GGNONLAV'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'N'
          'S'
          'E')
        ParentFont = False
        TabOrder = 11
        OnDrawItem = DBComboBox1DrawItem
      end
    end
    object TabSheet3: TTabSheet
      HelpContext = 16300
      Caption = 'Regole cumulo/fruizione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      object GroupBox1: TGroupBox
        Left = 0
        Top = 41
        Width = 628
        Height = 257
        Align = alClient
        Caption = 'Caratteristiche di cumulo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object pnlCausaliCollegate: TPanel
          Left = 2
          Top = 15
          Width = 624
          Height = 54
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label21: TLabel
            Left = 6
            Top = 3
            Width = 104
            Height = 13
            Caption = 'Considera nel cumulo:'
          end
          object lblCodCau2: TLabel
            Left = 296
            Top = 3
            Width = 132
            Height = 13
            Caption = 'Considera per inizio periodo:'
          end
          object dedtCausaliCollegate: TDBEdit
            Left = 116
            Top = 0
            Width = 162
            Height = 21
            Color = cl3DLight
            DataField = 'CODCAU1'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object btnCausaliCollegate: TButton
            Left = 278
            Top = 0
            Width = 16
            Height = 21
            Caption = '...'
            TabOrder = 1
            OnClick = btnCausaliCollegateClick
          end
          object dedtCodCau2: TDBEdit
            Left = 431
            Top = 0
            Width = 63
            Height = 21
            Color = cl3DLight
            DataField = 'CODCAU2'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object btnCodCau2: TButton
            Left = 495
            Top = 0
            Width = 16
            Height = 21
            Caption = '...'
            TabOrder = 3
            OnClick = btnCodCau2Click
          end
          object drgpCumulaRichiesteWeb: TDBRadioGroup
            Left = 6
            Top = 21
            Width = 369
            Height = 33
            Caption = 'Considera nel cumulo le richieste del dipendente'
            Columns = 3
            DataField = 'CUMULA_RICHIESTE_WEB'
            DataSource = DButton
            Items.Strings = (
              'No'
              'Si'
              'Solo se autorizzate')
            TabOrder = 4
            Values.Strings = (
              'N'
              'R'
              'A')
          end
        end
        object pnlAssenzeTollerate: TPanel
          Left = 2
          Top = 157
          Width = 624
          Height = 26
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 5
          object LAssenze: TLabel
            Left = 6
            Top = 7
            Width = 77
            Height = 13
            Caption = 'Causali tollerate:'
          end
          object EAssenze: TDBEdit
            Left = 96
            Top = 3
            Width = 225
            Height = 21
            Color = cl3DLight
            DataField = 'ASSTOLL'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object BAssenze: TButton
            Left = 323
            Top = 3
            Width = 16
            Height = 21
            Caption = '...'
            TabOrder = 1
            OnClick = BAssenzeClick
          end
        end
        object pnlInizioCumulo: TPanel
          Left = 2
          Top = 133
          Width = 624
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 4
          object LDCausale: TDBText
            Left = 385
            Top = 5
            Width = 126
            Height = 13
            DataField = 'D_CodCauInizio'
            DataSource = DButton
          end
          object LCausale: TLabel
            Left = 212
            Top = 5
            Width = 93
            Height = 13
            Caption = 'Caus. inizio cumulo:'
          end
          object Label6: TLabel
            Left = 6
            Top = 5
            Width = 86
            Height = 13
            Caption = 'Riferim. ai familiari:'
          end
          object ECodCauInizio: TDBLookupComboBox
            Left = 308
            Top = 2
            Width = 73
            Height = 21
            DataField = 'CodCauInizio'
            DataSource = DButton
            DropDownWidth = 200
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyField = 'Codice'
            ListField = 'Codice;Descrizione'
            ListSource = A016FCausAssenzeMW.D265A
            ParentFont = False
            TabOrder = 1
            OnKeyDown = dcmbKeyDown
          end
          object dcmbCumuloFamiliari: TDBComboBox
            Left = 96
            Top = 2
            Width = 111
            Height = 22
            Style = csOwnerDrawFixed
            DataField = 'CUMULO_FAMILIARI'
            DataSource = DButton
            DropDownCount = 10
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'N'
              'S'
              'D')
            ParentFont = False
            TabOrder = 0
            OnDrawItem = DBComboBox1DrawItem
          end
        end
        object pnlEUMCumulo: TPanel
          Left = 2
          Top = 100
          Width = 624
          Height = 33
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object LData: TLabel
            Left = 248
            Top = 11
            Width = 80
            Height = 13
            Caption = 'gg/mm partenza:'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object LDurata: TLabel
            Left = 137
            Top = 11
            Width = 39
            Height = 13
            Caption = 'Periodo:'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object EGMCumulo: TDBEdit
            Left = 353
            Top = 6
            Width = 43
            Height = 21
            DataField = 'GMCumulo'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = EHMaxUnitarioChange
          end
          object EDurataCumulo: TDBEdit
            Left = 183
            Top = 8
            Width = 43
            Height = 21
            DataField = 'DurataCumulo'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object EUMCumulo: TDBRadioGroup
            Left = 6
            Top = 0
            Width = 120
            Height = 32
            Caption = 'Unit'#224' di misura'
            Color = clBtnFace
            Columns = 2
            DataField = 'UMCumulo'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'Anni'
              'Mesi')
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            Values.Strings = (
              'A'
              'M')
          end
          object dchkCumuloFamGGDopo: TDBCheckBox
            Left = 240
            Top = 10
            Width = 107
            Height = 17
            Caption = 'Giorno successivo'
            DataField = 'CUMULO_FAM_GGDOPO'
            DataSource = DButton
            TabOrder = 3
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
        object pnlCumuloCollettivo: TPanel
          Left = 2
          Top = 69
          Width = 624
          Height = 31
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object LRaggruppamento: TLabel
            Left = 384
            Top = 12
            Width = 35
            Height = 13
            Caption = 'Raggr.:'
          end
          object ERaggruppamento: TDBLookupComboBox
            Left = 427
            Top = 7
            Width = 82
            Height = 21
            DataField = 'CAMPOGLOBALE'
            DataSource = DButton
            DropDownWidth = 200
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyField = 'COLUMN_NAME'
            ListField = 'COLUMN_NAME'
            ParentFont = False
            TabOrder = 2
            OnKeyDown = dcmbKeyDown
          end
          object dgrpCumuloGlobale: TDBRadioGroup
            Left = 137
            Top = -1
            Width = 238
            Height = 32
            Caption = 'Cumulo collettivo'
            Columns = 3
            DataField = 'CUMULOGLOBALE'
            DataSource = DButton
            Items.Strings = (
              'Nessuno'
              'Coniuge'
              'Anagrafico')
            TabOrder = 1
            Values.Strings = (
              'N'
              'C'
              'S')
            OnChange = CBCumuloCollettivoClick
          end
          object dgrpCumuloTipoOre: TDBRadioGroup
            Left = 6
            Top = -1
            Width = 120
            Height = 32
            Caption = 'Cumulo tipo ore'
            Columns = 2
            DataField = 'CUMULO_TIPO_ORE'
            DataSource = DButton
            Items.Strings = (
              'Fruite'
              'Rese')
            TabOrder = 0
            Values.Strings = (
              '0'
              '1')
          end
        end
        object pnlRiposi: TPanel
          Left = 2
          Top = 201
          Width = 624
          Height = 31
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 3
          object chkMaturazioneProgressiva: TDBCheckBox
            Left = 6
            Top = -1
            Width = 122
            Height = 17
            Caption = 'Maturaz.progressiva'
            DataField = 'CQ_PROGRESSIVO'
            DataSource = DButton
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object chkFestiviInfrasettimanali: TDBCheckBox
            Left = 134
            Top = -1
            Width = 93
            Height = 17
            Caption = 'Festivi infraset.'
            DataField = 'CQ_FESTIVI'
            DataSource = DButton
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dgrpGiorniNonLav: TDBRadioGroup
            Left = 240
            Top = -1
            Width = 271
            Height = 32
            Caption = 'Giorni non lavorativi '
            Columns = 3
            DataField = 'CQ_GGNONLAV'
            DataSource = DButton
            Items.Strings = (
              'No'
              'Esclusi festivi'
              'Inclusi festivi')
            TabOrder = 2
            Values.Strings = (
              'N'
              'S'
              'F'
              '')
          end
        end
        object pnlFestivita: TPanel
          Left = 2
          Top = 183
          Width = 624
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 6
          object DBCheckBox12: TDBCheckBox
            Left = 173
            Top = 0
            Width = 165
            Height = 17
            Caption = 'Considera domeniche lavorate'
            DataField = 'CP_DOMENICHE'
            DataSource = DButton
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object DBCheckBox14: TDBCheckBox
            Left = 6
            Top = 0
            Width = 160
            Height = 17
            Caption = 'Considera festivit'#224' giustificate'
            DataField = 'CP_FESTGIUSTIF'
            DataSource = DButton
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object DBCheckBox13: TDBCheckBox
            Left = 349
            Top = 0
            Width = 165
            Height = 17
            Caption = 'Considera turno di reperibilit'#224
            DataField = 'CP_PIANIFREPER'
            DataSource = DButton
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
        end
        object pnlTipoCumuloM: TPanel
          Left = 3
          Top = 211
          Width = 312
          Height = 73
          BevelOuter = bvNone
          TabOrder = 7
          object pnlTipoCumuloM2: TPanel
            Left = 0
            Top = 0
            Width = 312
            Height = 21
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object lblCMDebSett: TLabel
              Left = 157
              Top = 4
              Width = 90
              Height = 13
              Caption = 'Debito settimanale:'
            end
            object dedtCMDebSett: TDBEdit
              Left = 253
              Top = 0
              Width = 43
              Height = 21
              DataField = 'CM_DEBSETT'
              DataSource = DButton
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
          end
          object grpCausaliTollerate: TGroupBox
            Left = 0
            Top = 21
            Width = 312
            Height = 52
            Align = alClient
            Caption = 'Causali tollerate'
            TabOrder = 1
            object dgrdT266: TDBGrid
              Left = 2
              Top = 15
              Width = 308
              Height = 35
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = clTeal
              TitleFont.Height = -11
              TitleFont.Name = 'MS Sans Serif'
              TitleFont.Style = []
              OnEditButtonClick = dgrdT266EditButtonClick
              Columns = <
                item
                  Expanded = False
                  FieldName = 'NUMGG'
                  Visible = True
                end
                item
                  ButtonStyle = cbsEllipsis
                  Expanded = False
                  FieldName = 'CAUSALI'
                  ReadOnly = True
                  Visible = True
                end>
            end
          end
        end
        object pnlCongParentali: TPanel
          Left = 2
          Top = 232
          Width = 624
          Height = 63
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 8
          object lbl1: TLabel
            Left = 6
            Top = 45
            Width = 217
            Height = 13
            Caption = 'Comp. aggiuntive per il padre se esiste fruiz. di'
          end
          object lbl2: TLabel
            Left = 262
            Top = 45
            Width = 24
            Height = 13
            Caption = 'mesi:'
          end
          object lbl3: TLabel
            Left = 6
            Top = 23
            Width = 218
            Height = 13
            Caption = 'Competenze individuali max se esiste coniuge:'
          end
          object dchkVarCompFruizMMInteri: TDBCheckBox
            Left = 6
            Top = 1
            Width = 258
            Height = 17
            Caption = 'Variazione competenze per fruizione mesi interi'
            DataField = 'VARCOMP_FRUIZMMINTERI'
            DataSource = DButton
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dedtMMContVarComp: TDBEdit
            Left = 227
            Top = 42
            Width = 32
            Height = 21
            DataField = 'MMCONT_VARCOMP'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 2
          end
          object dedtVarCompFruizMMCont: TDBEdit
            Left = 288
            Top = 42
            Width = 37
            Height = 21
            DataField = 'VARCOMP_FRUIZMMCONT'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 3
          end
          object dedtCompIndivConiugeEsistente: TDBEdit
            Left = 288
            Top = 20
            Width = 37
            Height = 21
            DataField = 'COMPINDIV_CONIUGE_ESISTENTE'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 3
            ParentFont = False
            TabOrder = 1
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 628
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label17: TLabel
          Left = 8
          Top = 1
          Width = 72
          Height = 13
          Caption = 'Tipo di cumulo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ETipoCumulo: TDBComboBox
          Left = 8
          Top = 16
          Width = 453
          Height = 22
          Style = csOwnerDrawFixed
          DataField = 'TipoCumulo'
          DataSource = DButton
          DropDownCount = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'H'
            'A'
            'B'
            'C'
            'D'
            'E'
            'F'
            'G'
            'I'
            'L'
            'M'
            'N'
            'O'
            'P'
            'Q'
            'R'
            'S'
            'T'
            'U'
            'V'
            'Z')
          ParentFont = False
          PopupMenu = ppmnuProcPers
          TabOrder = 0
          OnChange = ETipoCumuloChange
          OnDrawItem = DBComboBox1DrawItem
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 298
        Width = 628
        Height = 85
        Align = alBottom
        TabOrder = 2
        object lblFruizioneDurata: TLabel
          Left = 7
          Top = 21
          Width = 35
          Height = 13
          Caption = 'Durata:'
        end
        object lblFruizioneDopo: TLabel
          Left = 7
          Top = 43
          Width = 29
          Height = 13
          Caption = 'Dopo:'
        end
        object EFruizione: TDBCheckBox
          Left = 4
          Top = -2
          Width = 109
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Periodo di fruizione'
          DataField = 'Fruizione'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
          OnClick = EFruizioneClick
        end
        object EDurata: TDBEdit
          Left = 53
          Top = 18
          Width = 43
          Height = 21
          DataField = 'DurataFruizione'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 1
        end
        object EUMFruizione: TDBRadioGroup
          Left = 119
          Top = 13
          Width = 84
          Height = 69
          Caption = 'Unit'#224' di misura'
          DataField = 'UMFruizione'
          DataSource = DButton
          Items.Strings = (
            'Anni'
            'Mesi'
            'Giorni')
          TabOrder = 4
          Values.Strings = (
            'A'
            'M'
            'G')
        end
        object DBEdit5: TDBEdit
          Left = 53
          Top = 39
          Width = 43
          Height = 21
          DataField = 'OFFSET_FRUIZIONE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 2
        end
        object GroupBox2: TGroupBox
          Left = 209
          Top = 13
          Width = 306
          Height = 69
          Caption = 'Riferimento'
          TabOrder = 5
          object lblFruizioneCausale: TLabel
            Left = 7
            Top = 46
            Width = 41
            Height = 13
            Caption = 'Causale:'
          end
          object DBText10: TDBText
            Left = 124
            Top = 46
            Width = 177
            Height = 16
            DataField = 'D_CodCauFruizione'
            DataSource = DButton
          end
          object lblFruizioneFamiliari: TLabel
            Left = 7
            Top = 18
            Width = 86
            Height = 13
            Caption = 'Riferim. ai familiari:'
          end
          object ECauFruizione: TDBLookupComboBox
            Left = 52
            Top = 43
            Width = 66
            Height = 21
            DataField = 'CodCauFruizione'
            DataSource = DButton
            DropDownWidth = 200
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyField = 'Codice'
            ListField = 'Codice;Descrizione'
            ParentFont = False
            TabOrder = 1
            OnKeyDown = dcmbKeyDown
          end
          object dcmbFruizioneFamiliari: TDBComboBox
            Left = 97
            Top = 15
            Width = 111
            Height = 22
            Style = csOwnerDrawFixed
            DataField = 'FRUIZIONE_FAMILIARI'
            DataSource = DButton
            DropDownCount = 10
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Items.Strings = (
              'N'
              'S'
              'D')
            ParentFont = False
            TabOrder = 0
            OnDrawItem = DBComboBox1DrawItem
          end
        end
        object dchkFruizioneFamGGDopo: TDBCheckBox
          Left = 7
          Top = 66
          Width = 115
          Height = 17
          Caption = 'Giorno successivo'
          DataField = 'FRUIZIONE_FAM_GGDOPO'
          DataSource = DButton
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Competenze'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ImageIndex = 3
      ParentFont = False
      object Label7: TLabel
        Left = 314
        Top = 86
        Width = 100
        Height = 13
        Caption = 'Numero max fruizioni:'
      end
      object lblAllarme: TLabel
        Left = 311
        Top = 106
        Width = 108
        Height = 26
        Caption = 'Allarme se il periodo continuativo raggiunge'
        WordWrap = True
      end
      object lblAllarmegg: TLabel
        Left = 492
        Top = 119
        Width = 25
        Height = 13
        Caption = 'giorni'
      end
      object lblCSIMaxMGMat: TLabel
        Left = 314
        Top = 39
        Width = 99
        Height = 13
        Caption = 'Numero max mattine:'
      end
      object lblCSIMaxMGPom: TLabel
        Left = 314
        Top = 64
        Width = 110
        Height = 13
        Caption = 'Numero max pomeriggi:'
      end
      object lblCSIMaxMG: TLabel
        Left = 314
        Top = 14
        Width = 136
        Height = 13
        Caption = 'Numero max mezze giornate:'
      end
      object gbxProporzioneCompetenze: TGroupBox
        Left = 1
        Top = 252
        Width = 515
        Height = 66
        Caption = 'Proporzione competenze'
        TabOrder = 10
        object dchkPropozionaPerServ: TDBCheckBox
          Left = 9
          Top = 13
          Width = 137
          Height = 17
          Caption = 'Giorni di servizio effettivi'
          DataField = 'PROPORZIONA_PERSERV'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object drgpTipoProporzione: TDBRadioGroup
          Left = 393
          Top = 9
          Width = 110
          Height = 53
          Caption = 'Tipo proporzione'
          DataField = 'TIPO_PROPORZIONE'
          DataSource = DButton
          Items.Strings = (
            'Competenze'
            'Residui')
          TabOrder = 3
          Values.Strings = (
            'C'
            'R')
        end
        object dchkTempoDeterminato: TDBCheckBox
          Left = 9
          Top = 29
          Width = 117
          Height = 17
          Caption = 'Tempo determinato'
          DataField = 'TEMPO_DETERMINATO'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dChkPropAbilitazione: TDBCheckBox
          Left = 9
          Top = 45
          Width = 131
          Height = 17
          Caption = 'Abilitazione anagrafica'
          DataField = 'PROPORZIONA_ABILITAZIONE'
          DataSource = DButton
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object grpPartTime: TGroupBox
          Left = 167
          Top = 9
          Width = 220
          Height = 53
          Caption = 'Part time'
          TabOrder = 4
          object chkPartTimeO: TCheckBox
            Left = 7
            Top = 20
            Width = 73
            Height = 17
            Caption = 'Orizzontale'
            TabOrder = 0
            OnClick = chkPartTimeOClick
          end
          object chkPartTimeV: TCheckBox
            Left = 93
            Top = 20
            Width = 67
            Height = 17
            Caption = 'Verticale'
            TabOrder = 1
            OnClick = chkPartTimeOClick
          end
          object chkPartTimeC: TCheckBox
            Left = 166
            Top = 20
            Width = 51
            Height = 17
            Caption = 'Ciclico'
            TabOrder = 2
            OnClick = chkPartTimeOClick
          end
        end
      end
      object EUMisura: TDBRadioGroup
        Left = 1
        Top = 2
        Width = 87
        Height = 64
        Caption = 'Unit'#224' di misura'
        DataField = 'UMisura'
        DataSource = DButton
        Items.Strings = (
          'Ore'
          'Giorni')
        TabOrder = 0
        Values.Strings = (
          'O'
          'G')
        OnChange = EUMisuraChange
        OnClick = EUMisuraClick
      end
      object grpMaxUnitario: TGroupBox
        Left = 146
        Top = 66
        Width = 107
        Height = 64
        Caption = 'Massimo unitario'
        TabOrder = 3
        object Label8: TLabel
          Left = 16
          Top = 18
          Width = 17
          Height = 13
          Caption = 'Ore'
        end
        object Label29: TLabel
          Left = 6
          Top = 43
          Width = 27
          Height = 13
          Caption = 'Giorni'
        end
        object EHMaxUnitario: TDBEdit
          Left = 43
          Top = 15
          Width = 49
          Height = 21
          DataField = 'HMaxUnitario'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = EHMaxUnitarioChange
        end
        object EGMaxUnitario: TDBEdit
          Left = 43
          Top = 40
          Width = 49
          Height = 21
          DataField = 'GMaxUnitario'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = EHMaxUnitarioChange
        end
      end
      object drdgRapportiUniti: TDBRadioGroup
        Left = 1
        Top = 66
        Width = 140
        Height = 64
        Caption = 'Rapporti di lavoro unificati'
        DataField = 'RAPPORTI_UNITI'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'da Anagrafico'
          'Si'
          'No')
        ParentFont = False
        TabOrder = 2
        Values.Strings = (
          'A'
          'S'
          'N')
      end
      object grpFasce: TGroupBox
        Left = 1
        Top = 140
        Width = 515
        Height = 110
        TabOrder = 9
        object Label9: TLabel
          Left = 15
          Top = 27
          Width = 59
          Height = 13
          Caption = 'Competenze'
        end
        object Label10: TLabel
          Left = 3
          Top = 45
          Width = 71
          Height = 26
          Alignment = taRightJustify
          Caption = 'Percentuale di retribuzione'
          WordWrap = True
        end
        object Label11: TLabel
          Left = 89
          Top = 9
          Width = 40
          Height = 13
          Caption = 'Fascia 1'
        end
        object Label12: TLabel
          Left = 162
          Top = 9
          Width = 40
          Height = 13
          Caption = 'Fascia 2'
        end
        object Label13: TLabel
          Left = 235
          Top = 9
          Width = 40
          Height = 13
          Caption = 'Fascia 3'
        end
        object Label14: TLabel
          Left = 308
          Top = 9
          Width = 40
          Height = 13
          Caption = 'Fascia 4'
        end
        object Label15: TLabel
          Left = 381
          Top = 9
          Width = 40
          Height = 13
          Caption = 'Fascia 5'
        end
        object Label16: TLabel
          Left = 454
          Top = 9
          Width = 40
          Height = 13
          Caption = 'Fascia 6'
        end
        object DBEdit8: TDBEdit
          Left = 89
          Top = 25
          Width = 49
          Height = 21
          DataField = 'Competenza1'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = EHMaxUnitarioChange
        end
        object DBEdit9: TDBEdit
          Left = 89
          Top = 49
          Width = 49
          Height = 21
          DataField = 'Retribuzione1'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object DBEdit10: TDBEdit
          Left = 162
          Top = 25
          Width = 49
          Height = 21
          DataField = 'Competenza2'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = EHMaxUnitarioChange
        end
        object DBEdit11: TDBEdit
          Left = 162
          Top = 49
          Width = 49
          Height = 21
          DataField = 'Retribuzione2'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object DBEdit12: TDBEdit
          Left = 235
          Top = 25
          Width = 49
          Height = 21
          DataField = 'Competenza3'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnChange = EHMaxUnitarioChange
        end
        object DBEdit13: TDBEdit
          Left = 235
          Top = 49
          Width = 49
          Height = 21
          DataField = 'Retribuzione3'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object DBEdit14: TDBEdit
          Left = 308
          Top = 25
          Width = 49
          Height = 21
          DataField = 'Competenza4'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = EHMaxUnitarioChange
        end
        object DBEdit15: TDBEdit
          Left = 308
          Top = 49
          Width = 49
          Height = 21
          DataField = 'Retribuzione4'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object DBEdit16: TDBEdit
          Left = 381
          Top = 25
          Width = 49
          Height = 21
          DataField = 'Competenza5'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnChange = EHMaxUnitarioChange
        end
        object DBEdit17: TDBEdit
          Left = 381
          Top = 49
          Width = 49
          Height = 21
          DataField = 'Retribuzione5'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object DBEdit18: TDBEdit
          Left = 454
          Top = 25
          Width = 47
          Height = 21
          DataField = 'Competenza6'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          OnChange = EHMaxUnitarioChange
        end
        object DBEdit19: TDBEdit
          Left = 454
          Top = 49
          Width = 47
          Height = 21
          DataField = 'Retribuzione6'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
        object dchkCompetenzePersonalizzate: TDBCheckBox
          Left = 7
          Top = 71
          Width = 169
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Competenze personalizzate'
          DataField = 'COMPETENZE_PERSONALIZZATE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = ppmnuProcPers
          TabOrder = 12
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkArrotCompetenze: TDBCheckBox
          Left = 7
          Top = 89
          Width = 169
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Arrotondamento personalizzato'
          DataField = 'ARROT_COMPETENZE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          PopupMenu = ppmnuProcPers
          TabOrder = 13
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object dedtFruizMaxNum: TDBEdit
        Left = 456
        Top = 86
        Width = 29
        Height = 21
        DataField = 'FRUIZ_MAX_NUM'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnChange = EHMaxUnitarioChange
      end
      object dedtAllarmeFruizCont: TDBEdit
        Left = 457
        Top = 111
        Width = 29
        Height = 21
        DataField = 'ALLARME_FRUIZIONE_CONTINUATIVA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object drgpArrotOre2GG: TDBRadioGroup
        Left = 92
        Top = 2
        Width = 161
        Height = 64
        Caption = 'Arrotondamento da ore a giorni'
        DataField = 'ARROT_ORE2GG'
        DataSource = DButton
        Items.Strings = (
          'Nessuno'
          'Giornata'
          'Mezza giornata')
        TabOrder = 1
        Values.Strings = (
          'N'
          'I'
          'M')
        OnChange = EUMisuraChange
        OnClick = EUMisuraClick
      end
      object dedtCSIMaxMGMat: TDBEdit
        Left = 456
        Top = 36
        Width = 29
        Height = 21
        DataField = 'CSI_MAX_MGMAT'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnChange = EHMaxUnitarioChange
      end
      object dedtCSIMaxMGPom: TDBEdit
        Left = 456
        Top = 61
        Width = 29
        Height = 21
        DataField = 'CSI_MAX_MGPOM'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnChange = EHMaxUnitarioChange
      end
      object dedtCSIMaxMG: TDBEdit
        Left = 456
        Top = 11
        Width = 29
        Height = 21
        DataField = 'CSI_MAX_MG'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnChange = EHMaxUnitarioChange
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Fini economici'
      ImageIndex = 4
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 628
        Height = 157
        Align = alTop
        TabOrder = 0
        object LblDescVoce: TLabel
          Left = 184
          Top = 21
          Width = 317
          Height = 13
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 9
          Top = 21
          Width = 60
          Height = 13
          Caption = 'Codice voce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedtVocePaghe: TDBEdit
          Left = 77
          Top = 18
          Width = 79
          Height = 21
          DataField = 'VocePaghe'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = dedtVocePagheChange
          OnExit = dedtVocePagheExit
        end
        object BtnVocePaghe: TButton
          Left = 158
          Top = 18
          Width = 16
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = BtnVocePagheClick
        end
        object dchkScaricoPagheUMProp: TDBCheckBox
          Left = 9
          Top = 46
          Width = 263
          Height = 17
          Caption = 'Proporziona in base a percentuale di retribuzione'
          DataField = 'SCARICOPAGHE_UM_PROP'
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
        object drgpUmScaricoPaghe: TDBRadioGroup
          Left = 9
          Top = 71
          Width = 239
          Height = 57
          Caption = 'Unit'#224' di misura scarico'
          Columns = 2
          DataField = 'UM_SCARICOPAGHE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Fruizione'
            'Competenze'
            'Giorni'
            'Ore')
          ParentFont = False
          TabOrder = 3
          Values.Strings = (
            'F'
            'C'
            'G'
            'O')
        end
        object DBCheckBox11: TDBCheckBox
          Left = 9
          Top = 134
          Width = 263
          Height = 17
          Caption = 'Giorno lavorativo ai fini INPS'
          DataField = 'GLAVINPS'
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
    end
    object TabSheet6: TTabSheet
      Caption = 'Caus. incomp.'
      ImageIndex = 5
      object dGrdCausIncomp: TDBGrid
        Left = 0
        Top = 0
        Width = 628
        Height = 383
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'TIPO_CONTROLLO'
            Title.Caption = 'Tipo'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SEX_FRUITORE'
            Title.Caption = 'Genere'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CAU_INCOMPATIBILE'
            Title.Caption = 'Caus. incomp.'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SEX_CAU_INCOMP'
            Title.Caption = 'Genere incomp.'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'INCLUDI_FAM'
            Title.Caption = 'Incl. fam.'
            Width = 80
            Visible = True
          end>
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Param. storiciz.'
      ImageIndex = 6
      object pnlParStorOpzioni: TPanel
        Left = 0
        Top = 0
        Width = 628
        Height = 27
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object btnDecParStorPrec: TSpeedButton
          Left = 2
          Top = 1
          Width = 23
          Height = 22
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            1000030000000002000000000000000000000000000000000000007C0000E003
            00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000007C00001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000007C007C007C00001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C00000000007C007C007C007C007C0000000000000000
            00000000000000000000007C007C007C007C007C007C007C007C007C007C007C
            007C007C00001F7C1F7C00000000007C007C007C007C007C0000000000000000
            0000000000001F7C1F7C1F7C1F7C00000000007C007C007C00001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00000000007C00001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C}
          OnClick = btnDecParStorPrecClick
        end
        object btnDecParStorSucc: TSpeedButton
          Left = 111
          Top = 1
          Width = 23
          Height = 22
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            1000030000000002000000000000000000000000000000000000007C0000E003
            00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C007C007C000000001F7C
            1F7C1F7C1F7C0000000000000000000000000000007C007C007C007C007C0000
            00001F7C1F7C0000007C007C007C007C007C007C007C007C007C007C007C007C
            007C000000000000000000000000000000000000007C007C007C007C007C0000
            00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C007C007C000000001F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000007C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C}
          OnClick = btnDecParStorSuccClick
        end
        object chkVistaPeriodoCorr: TCheckBox
          Left = 141
          Top = 4
          Width = 106
          Height = 17
          Caption = 'Visione corrente'
          TabOrder = 1
          OnClick = chkVistaPeriodoCorrClick
        end
        object btnModificaParStor: TButton
          Left = 454
          Top = 2
          Width = 171
          Height = 21
          Caption = 'Accedi ai parametri storicizzati'
          TabOrder = 2
          OnClick = btnModificaParStorClick
        end
        object cmbDecParStor: TComboBox
          Left = 26
          Top = 2
          Width = 85
          Height = 21
          Style = csDropDownList
          TabOrder = 0
          OnChange = cmbDecParStorChange
        end
      end
      object pnlParStorGrid: TPanel
        Left = 0
        Top = 27
        Width = 628
        Height = 356
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object grdParamStoriciz: TStringGrid
          Left = 0
          Top = 0
          Width = 628
          Height = 356
          Align = alClient
          ColCount = 1
          FixedCols = 0
          RowCount = 1
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goRowSelect]
          TabOrder = 0
          OnDrawCell = grdParamStoricizDrawCell
        end
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 380
    Top = 65534
    inherited File1: TMenuItem
      object Ricercaduplicati1: TMenuItem [2]
        Action = actRicercaDuplicati
      end
    end
  end
  inherited DButton: TDataSource
    OnDataChange = DButtonDataChange
    Left = 436
    Top = 65534
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 408
    Top = 65534
  end
  inherited ImageList1: TImageList
    Left = 332
    Top = 54
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
    Left = 360
    Top = 54
    object actRicercaDuplicati: TAction
      Caption = 'Ricerca duplicati'
      Hint = 'Ricerca duplicati'
      OnExecute = actRicercaDuplicatiExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 464
    Top = 65534
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
  object ppmnuProcPers: TPopupMenu
    OnPopup = ppmnuProcPersPopup
    Left = 496
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      OnClick = Accedi1Click
    end
  end
end
