inherited A016FCausAssenzeStorico: TA016FCausAssenzeStorico
  HelpContext = 16800
  BorderStyle = bsSingle
  Caption = '<A016> Causali di assenza - Parametri storicizzati'
  ClientHeight = 562
  ClientWidth = 590
  ExplicitWidth = 596
  ExplicitHeight = 611
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 544
    Width = 590
    ExplicitTop = 544
    ExplicitWidth = 590
  end
  inherited grbDecorrenza: TGroupBox
    Width = 590
    ExplicitWidth = 590
  end
  inherited ToolBar1: TToolBar
    Width = 590
    TabOrder = 0
    ExplicitWidth = 590
    inherited ToolButton2: TToolButton
      Visible = False
    end
    inherited ToolButton6: TToolButton
      Visible = False
    end
  end
  object PageControl1: TPageControl [3]
    Left = 0
    Top = 122
    Width = 590
    Height = 422
    ActivePage = tabCartellino
    Align = alClient
    TabOrder = 3
    object tabCartellino: TTabSheet
      Caption = 'Cartellino'
      ExplicitTop = 22
      object lblValorGiorOre: TLabel
        Left = 8
        Top = 152
        Width = 140
        Height = 13
        Caption = 'Ore valorizzazione giornaliera:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblValorGiorOreComp: TLabel
        Left = 8
        Top = 343
        Width = 140
        Height = 13
        Caption = 'Ore valorizzazione giornaliera:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblHMAssenza: TLabel
        Left = 313
        Top = 4
        Width = 140
        Height = 13
        Caption = 'HH:MM per giorno di assenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object drgpValorGior: TDBRadioGroup
        Left = 8
        Top = 4
        Width = 293
        Height = 143
        Caption = 'Valorizzazione giornaliera'
        DataField = 'VALORGIOR'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Monte ore sett./gg. lav.'
          'Ore teoriche dell'#39'orario'
          'Monte ore sett./6'
          'Ore teoriche da anagrafico'
          'Ore del debito giornaliero'
          'Ore fisse')
        ParentFont = False
        TabOrder = 0
        Values.Strings = (
          'A'
          'B'
          'C'
          'D'
          'E'
          'F')
        OnChange = drgpValorGiorChange
      end
      object dedtValorGiorOre: TDBEdit
        Left = 259
        Top = 149
        Width = 43
        Height = 21
        DataField = 'VALORGIOR_ORE'
        DataSource = DButton
        TabOrder = 1
        OnChange = OnDBEditOraChange
      end
      object drgpValorGiorComp: TDBRadioGroup
        Left = 8
        Top = 171
        Width = 293
        Height = 167
        Caption = 'Valorizz. giorn. per competenze'
        DataField = 'VALORGIOR_COMP'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Come Valorizzazione giornaliera'
          'Monte ore sett./gg. lav.'
          'Ore teoriche dell'#39'orario'
          'Monte ore sett./6'
          'Ore teoriche da anagrafico'
          'Ore del debito giornaliero'
          'Ore fisse')
        ParentFont = False
        TabOrder = 2
        Values.Strings = (
          '-'
          'A'
          'B'
          'C'
          'D'
          'E'
          'F')
        OnChange = drgpValorGiorCompChange
      end
      object dedtValorGiorOreComp: TDBEdit
        Left = 259
        Top = 340
        Width = 43
        Height = 21
        DataField = 'VALORGIOR_ORECOMP'
        DataSource = DButton
        TabOrder = 3
        OnChange = OnDBEditOraChange
      end
      object dchkValorGiorOrePropPT: TDBCheckBox
        Left = 8
        Top = 362
        Width = 293
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Proporziona se part-time'
        DataField = 'VALORGIOR_ORE_PROPPT'
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
      object dchkHMAssenzaPropPT: TDBCheckBox
        Left = 313
        Top = 27
        Width = 261
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Proporziona se part-time'
        DataField = 'HMASSENZA_PROPPT'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dedtHMAssenza: TDBEdit
        Left = 531
        Top = 4
        Width = 43
        Height = 21
        DataField = 'HMASSENZA'
        DataSource = DButton
        TabOrder = 6
        OnChange = OnDBEditOraChange
      end
      object dchkSceltaOrario: TDBCheckBox
        Left = 313
        Top = 96
        Width = 261
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Considera il giustif. dalle..alle nella scelta dell'#39'orario'
        DataField = 'SCELTA_ORARIO'
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
      object dchkAbbatteStrInd: TDBCheckBox
        Left = 313
        Top = 119
        Width = 261
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Abbatte la maturazione di straordinario e indennit'#224
        DataField = 'ABBATTE_STRIND'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dchkRendicontaProgetti: TDBCheckBox
        Left = 313
        Top = 73
        Width = 261
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Considera per rendicontazione progetti'
        DataField = 'RENDICONTA_PROGETTI'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object tabRegoleInserimento: TTabSheet
      Caption = 'Regole inserimento'
      ImageIndex = 1
      object lblCausaleFruizOre: TLabel
        Left = 8
        Top = 36
        Width = 174
        Height = 13
        Caption = 'Causale da inserire se fruizione oraria'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCausaliCompatibili: TLabel
        Left = 8
        Top = 81
        Width = 86
        Height = 13
        Caption = 'Causali compatibili'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCausaliCheckComp: TLabel
        Left = 8
        Top = 165
        Width = 154
        Height = 13
        Caption = 'Controllo aggiuntivo competenze'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblVisualComp: TLabel
        Left = 8
        Top = 208
        Width = 129
        Height = 13
        Caption = 'Visualizza le competenze di'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCausaleHMAssenza: TLabel
        Left = 8
        Top = 4
        Width = 177
        Height = 26
        AutoSize = False
        Caption = 'Causale cumulativa giornaliera delle fruizioni orarie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object dcmbCausaleHMAssenza: TDBLookupComboBox
        Left = 194
        Top = 5
        Width = 117
        Height = 21
        DataField = 'CAUSALE_HMASSENZA'
        DataSource = DButton
        TabOrder = 0
      end
      object dcmbCausaleFruizOre: TDBLookupComboBox
        Left = 194
        Top = 32
        Width = 117
        Height = 21
        DataField = 'CAUSALE_FRUIZORE'
        DataSource = DButton
        TabOrder = 1
      end
      object dchkCheckSoloCompetenze: TDBCheckBox
        Left = 8
        Top = 58
        Width = 303
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Esclusione dei controlli utente'
        DataField = 'CHECK_SOLOCOMPETENZE'
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
      object dedtCausaliCompatibili: TDBEdit
        Left = 8
        Top = 96
        Width = 282
        Height = 21
        Color = clBtnFace
        DataField = 'CAUSALI_COMPATIBILI'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 3
      end
      object btnCausaliCompatibili: TButton
        Left = 292
        Top = 96
        Width = 19
        Height = 21
        Caption = '...'
        TabOrder = 4
        OnClick = SelezioneCausali
      end
      object drgpStatoCompatibilta: TDBRadioGroup
        Left = 8
        Top = 122
        Width = 303
        Height = 40
        Caption = 'Stato compatibilit'#224
        Columns = 3
        DataField = 'STATO_COMPATIBILITA'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Disattivato'
          'Compatibile'
          'Incompatibile')
        ParentFont = False
        TabOrder = 5
        Values.Strings = (
          'D'
          'C'
          'I')
      end
      object dedtCausaliCheckComp: TDBEdit
        Left = 8
        Top = 180
        Width = 282
        Height = 21
        Color = clBtnFace
        DataField = 'CAUSALI_CHECKCOMPETENZE'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 6
      end
      object btnCausaliCheckComp: TButton
        Left = 292
        Top = 180
        Width = 19
        Height = 21
        Caption = '...'
        TabOrder = 7
        OnClick = SelezioneCausali
      end
      object dcmbVisualCompetenze: TDBComboBox
        Left = 194
        Top = 205
        Width = 117
        Height = 21
        Style = csDropDownList
        DataField = 'CAUSALE_VISUALCOMPETENZE'
        DataSource = DButton
        TabOrder = 8
      end
      object grpFruizAbilSP: TGroupBox
        Left = 8
        Top = 232
        Width = 303
        Height = 59
        Caption = 'Fruizioni abilitate allo scarico paghe'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        object dchkFruizAbilSPGiorni: TDBCheckBox
          Left = 8
          Top = 17
          Width = 89
          Height = 17
          Caption = 'Giorni'
          DataField = 'SCARICOPAGHE_FRUIZ_GG'
          DataSource = DButton
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkFruizAbilSPOre: TDBCheckBox
          Left = 8
          Top = 35
          Width = 66
          Height = 17
          Caption = 'Ore'
          DataField = 'SCARICOPAGHE_FRUIZ_ORE'
          DataSource = DButton
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
      object drgpCondizioneAllegati: TDBRadioGroup
        Left = 323
        Top = 3
        Width = 251
        Height = 66
        Caption = 'Condizione allegati'
        Columns = 2
        DataField = 'CONDIZIONE_ALLEGATI'
        DataSource = DButton
        Items.Strings = (
          'Da Iter'
          'No'
          'Obbligatori'
          'Facoltativi')
        TabOrder = 10
        Values.Strings = (
          'I'
          'N'
          'O'
          'F')
      end
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 63
    Width = 590
    Height = 59
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object lblCodice: TLabel
      Left = 8
      Top = 8
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
    object lblDescCausale: TLabel
      Left = 130
      Top = 8
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
    object lblDescrizione: TLabel
      Left = 8
      Top = 35
      Width = 99
      Height = 13
      Caption = 'Descrizione periodo :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dedtCodice: TDBEdit
      Left = 48
      Top = 5
      Width = 56
      Height = 21
      Color = clBtnFace
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object dedtDescCausale: TDBEdit
      Left = 189
      Top = 5
      Width = 389
      Height = 21
      Color = clBtnFace
      DataField = 'DESC_CAUSALE'
      DataSource = DButton
      TabOrder = 1
    end
    object dedtDescrizione: TDBEdit
      Left = 113
      Top = 32
      Width = 465
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 2
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 360
    Top = 32
  end
  inherited DButton: TDataSource
    Left = 388
    Top = 32
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 416
    Top = 32
  end
  inherited ImageList1: TImageList
    Left = 444
    Top = 32
  end
  inherited ActionList1: TActionList
    Left = 472
    Top = 32
    inherited actRicerca: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actPrimo: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actPrecedente: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actSuccessivo: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actUltimo: TAction
      ShortCut = 0
      Visible = False
    end
    inherited actInserisci: TAction
      ShortCut = 0
      Visible = False
      OnExecute = nil
    end
  end
end
