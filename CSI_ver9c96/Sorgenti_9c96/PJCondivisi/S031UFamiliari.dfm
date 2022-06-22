inherited S031FFamiliari: TS031FFamiliari
  Left = 0
  Top = 165
  HelpContext = 2031000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<S031> Familiari'
  ClientHeight = 579
  ClientWidth = 787
  DoubleBuffered = True
  ExplicitWidth = 803
  ExplicitHeight = 638
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 429
    Height = 132
    ExplicitLeft = 504
    ExplicitTop = 472
    ExplicitHeight = 100
  end
  inherited StatusBar: TStatusBar
    Top = 561
    Width = 787
    ExplicitTop = 561
    ExplicitWidth = 787
  end
  inherited grbDecorrenza: TGroupBox
    Top = 48
    Width = 787
    Height = 33
    ExplicitTop = 48
    ExplicitWidth = 787
    ExplicitHeight = 33
    inherited lblDecorrenza: TLabel
      Top = 11
      ExplicitTop = 11
    end
    inherited btnStoricizza: TSpeedButton
      Top = 6
      ExplicitTop = 6
    end
    inherited dedtDecorrenza: TDBEdit
      Top = 7
      ExplicitTop = 7
    end
    inherited chkStoriciPrec: TCheckBox
      Top = 11
      ExplicitTop = 11
    end
    inherited chkStoriciSucc: TCheckBox
      Top = 11
      ExplicitTop = 11
    end
    object btnCarica: TBitBtn
      Left = 657
      Top = 6
      Width = 107
      Height = 24
      Caption = 'Carica s'#232' stesso'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000007B7D7B0000007B7D
        7B7B7D7B000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000BDBEBD000000BDBEBDBDBEBD000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000BDBEBDBDBEBDBDBE
        BDBDBEBD000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFF000000000000FFFFFF000000000000BD
        BEBD000000FF0000FF0000FF00000000FFFF0000FF0000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFF0000FF0000
        FF0000FFFFFFFFFFFFFF000000FFFFFF000000000000000000000000FFFFFF00
        0000FFFFFF0000000000FF0000FF0000FF0000FF0000FFFFFFFF000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000FF0000FF0000
        FF0000FF0000FF0000FF000000FFFFFF000000000000FFFFFF00000000000000
        0000000000000000FFFFFF0000FF0000FF0000FFFFFFFFFFFFFF000000FFFFFF
        FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000FFFFFFFFFFFF0000FF0000
        FF0000FFFFFFFFFFFFFF000000FFFFFF000000BDBEBDFFFFFF000000FFFFFF00
        0000FFFFFFFFFFFF7B7D7B0000FF0000FF0000FFFFFFFFFFFFFF000000FFFFFF
        FFFFFFFFFFFFFFFFFF000000000000FFFFFF0000FF0000FF0000FF0000FF0000
        FFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 3
      OnClick = btnCaricaClick
    end
  end
  inherited ToolBar1: TToolBar
    Top = 24
    Width = 787
    DoubleBuffered = True
    ParentDoubleBuffered = False
    ExplicitTop = 24
    ExplicitWidth = 787
  end
  object dgrdDATIBASE: TDBGrid [4]
    Left = 3
    Top = 429
    Width = 784
    Height = 132
    TabStop = False
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = MnuCopia
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = dgrdDATIBASEDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'DECORRENZA'
        Title.Caption = 'Decorrenza'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMORD'
        Title.Caption = 'N.ord.'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Desc_Grado'
        Title.Caption = 'Parentela'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COGNOME'
        Title.Caption = 'Cognome'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATANAS'
        Title.Caption = 'Data nascita'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Desc_Detrazione'
        Title.Caption = 'Tipo detr.'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERC_CARICO'
        Title.Caption = '% carico'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Desc_ANF'
        Title.Caption = 'Comp.nucleo'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Desc_Inabile'
        Title.Caption = 'Inabile'
        Width = 35
        Visible = True
      end>
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [5]
    Left = 0
    Top = 0
    Width = 787
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 787
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 787
      Height = 24
      ExplicitWidth = 787
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
  object PageControl1: TPageControl [6]
    Left = 0
    Top = 81
    Width = 787
    Height = 328
    ActivePage = tabDatiAnagrafici
    Align = alTop
    TabOrder = 5
    object tabDatiAnagrafici: TTabSheet
      Caption = 'Dati anagrafici'
      object lblNUMORD: TLabel
        Left = 5
        Top = 12
        Width = 40
        Height = 13
        Caption = 'N.ordine'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCOGNOME: TLabel
        Left = 115
        Top = 53
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
      object lblDataNas: TLabel
        Left = 303
        Top = 93
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
      object lblComNas: TLabel
        Left = 5
        Top = 133
        Width = 76
        Height = 13
        Caption = 'Comune nascita'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblProvNas: TLabel
        Tag = 6
        Left = 331
        Top = 133
        Width = 25
        Height = 13
        Caption = 'Prov.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDATAMAT: TLabel
        Left = 482
        Top = 172
        Width = 76
        Height = 13
        Caption = 'Data matrimonio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDATASEP: TLabel
        Left = 371
        Top = 172
        Width = 76
        Height = 13
        Caption = 'Data esclusione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblNOME: TLabel
        Left = 303
        Top = 53
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
      object lblMatricola: TLabel
        Tag = 6
        Left = 5
        Top = 53
        Width = 43
        Height = 13
        Caption = 'Matricola'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDataAdoz: TLabel
        Left = 115
        Top = 172
        Width = 69
        Height = 13
        Caption = 'Data adozione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCodFiscale: TLabel
        Left = 371
        Top = 133
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
      object lblDataNasPresunta: TLabel
        Left = 5
        Top = 93
        Width = 67
        Height = 13
        Caption = 'Data presunta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblCapNas: TLabel
        Tag = 6
        Left = 286
        Top = 133
        Width = 21
        Height = 13
        Caption = 'CAP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTipoAdoz: TLabel
        Tag = 6
        Left = 223
        Top = 172
        Width = 127
        Height = 13
        Caption = 'Tipo adozione/affidamento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDataPreAdoz: TLabel
        Left = 5
        Top = 172
        Width = 87
        Height = 13
        Caption = 'Data pre-adozione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblNumGrado: TLabel
        Tag = 6
        Left = 303
        Top = 12
        Width = 29
        Height = 13
        Caption = 'Grado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblTipoPar: TLabel
        Tag = 6
        Left = 216
        Top = 12
        Width = 21
        Height = 13
        Caption = 'Tipo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblParentela: TLabel
        Tag = 6
        Left = 65
        Top = 12
        Width = 45
        Height = 13
        Caption = 'Parentela'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblMotivoTerzoGrado: TLabel
        Tag = 6
        Left = 338
        Top = 12
        Width = 75
        Height = 13
        Caption = 'Motivo 3'#176' grado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblNoteIndividuali: TLabel
        Left = 5
        Top = 214
        Width = 72
        Height = 13
        Caption = 'Note individuali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblPartFruizMaternita: TLabel
        Left = 419
        Top = 93
        Width = 130
        Height = 13
        Caption = 'Tipo particolare di maternit'#224
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtDataNasDummy: TEdit
        Left = 313
        Top = 106
        Width = 100
        Height = 21
        Enabled = False
        TabOrder = 12
        Text = 'campo fittizio'
      end
      object dedtNUMORD: TDBEdit
        Left = 5
        Top = 28
        Width = 46
        Height = 21
        DataField = 'NUMORD'
        DataSource = DButton
        MaxLength = 2
        TabOrder = 0
      end
      object dedtCOGNOME: TDBEdit
        Left = 115
        Top = 68
        Width = 175
        Height = 21
        DataField = 'COGNOME'
        DataSource = DButton
        MaxLength = 30
        TabOrder = 6
      end
      object dcmbComNas: TDBLookupComboBox
        Tag = 1
        Left = 5
        Top = 148
        Width = 210
        Height = 21
        DataField = 'D_DESCOMNAS'
        DataSource = DButton
        DropDownWidth = 400
        ListField = 'Citta;Provincia;Codice'
        PopupMenu = PopupMenu1
        TabOrder = 14
        OnKeyDown = dcmbMatricolaKeyDown
      end
      object dedtProvNas: TDBEdit
        Tag = 6
        Left = 331
        Top = 148
        Width = 30
        Height = 21
        DataField = 'D_Provincia'
        DataSource = DButton
        MaxLength = 2
        ReadOnly = True
        TabOrder = 17
      end
      object dedtDATAMAT: TDBEdit
        Left = 482
        Top = 188
        Width = 80
        Height = 21
        DataField = 'DATAMAT'
        DataSource = DButton
        TabOrder = 23
        OnChange = dedtDataPreAdozChange
      end
      object dedtDATASEP: TDBEdit
        Left = 371
        Top = 188
        Width = 80
        Height = 21
        DataField = 'DATASEP'
        DataSource = DButton
        TabOrder = 22
        OnChange = dedtDataPreAdozChange
      end
      object dedtNOME: TDBEdit
        Left = 303
        Top = 68
        Width = 198
        Height = 21
        DataField = 'NOME'
        DataSource = DButton
        MaxLength = 30
        TabOrder = 7
      end
      object dedtCOMNAS: TDBEdit
        Tag = 5
        Left = 224
        Top = 148
        Width = 57
        Height = 21
        DataField = 'COMNAS'
        DataSource = DButton
        TabOrder = 15
      end
      object dedtDataNas: TDBEdit
        Left = 303
        Top = 108
        Width = 100
        Height = 21
        DataField = 'DATANAS'
        DataSource = DButton
        TabOrder = 11
      end
      object dcmbMatricola: TDBLookupComboBox
        Left = 5
        Top = 68
        Width = 100
        Height = 21
        Hint = 'Matricola: da indicare se il coniuge lavora in azienda'
        DataField = 'MATRICOLA'
        DataSource = DButton
        DropDownWidth = 250
        KeyField = 'MATRICOLA'
        ListField = 'MATRICOLA;NOMINATIVO'
        ListSource = S031FFamiliariDtM.dsrT030
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnCloseUp = dcmbMatricolaCloseUp
        OnKeyDown = dcmbMatricolaKeyDown
        OnKeyUp = dcmbMatricolaKeyUp
      end
      object dedtDataAdoz: TDBEdit
        Left = 115
        Top = 188
        Width = 100
        Height = 21
        DataField = 'DATAADOZ'
        DataSource = DButton
        TabOrder = 20
      end
      object drgpSesso: TDBRadioGroup
        Left = 505
        Top = 54
        Width = 137
        Height = 35
        HelpContext = 2003
        Caption = 'Sesso'
        Columns = 2
        DataField = 'SESSO'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Maschio'
          'Femmina')
        ParentFont = False
        TabOrder = 8
        TabStop = True
        Values.Strings = (
          'M'
          'F')
      end
      object dedtCodFiscale: TDBEdit
        Left = 371
        Top = 148
        Width = 137
        Height = 21
        DataField = 'CODFISCALE'
        DataSource = DButton
        MaxLength = 16
        TabOrder = 18
        OnEnter = dedtCodFiscaleEnter
        OnKeyDown = dedtCodFiscaleKeyDown
      end
      object dedtDataNasPresunta: TDBEdit
        Left = 5
        Top = 108
        Width = 100
        Height = 21
        DataField = 'DATANAS_PRESUNTA'
        DataSource = DButton
        TabOrder = 9
      end
      object dedtCAPNas: TDBEdit
        Tag = 6
        Left = 286
        Top = 148
        Width = 40
        Height = 21
        DataField = 'CAPNAS'
        DataSource = DButton
        TabOrder = 16
        OnDblClick = dedtCAPNasDblClick
        OnKeyDown = dedtCAPNasKeyDown
      end
      object gpbCausali: TGroupBox
        Left = 5
        Top = 253
        Width = 767
        Height = 43
        Caption = 'Causali fruibili per questo familiare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 24
        object dedtCausaliAbilitate: TDBEdit
          Left = 9
          Top = 17
          Width = 728
          Height = 21
          Color = clInactiveBorder
          DataField = 'CAUSALI_ABILITATE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 30
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object btnCausali: TButton
          Left = 739
          Top = 17
          Width = 17
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnCausaliClick
        end
      end
      object cmbTipoAdoz: TComboBox
        Left = 223
        Top = 188
        Width = 138
        Height = 21
        Style = csDropDownList
        TabOrder = 21
        OnClick = cmbTipoAdozClick
        OnCloseUp = cmbTipoAdozCloseUp
        OnKeyDown = cmbTipoParKeyDown
        Items.Strings = (
          'Adozione nazionale'
          'Adozione internazionale'
          'Affido residenziale'
          'Affidamento')
      end
      object dedtDataPreAdoz: TDBEdit
        Left = 5
        Top = 188
        Width = 80
        Height = 21
        DataField = 'DATA_PREADOZ'
        DataSource = DButton
        TabOrder = 19
        OnChange = dedtDataPreAdozChange
      end
      object dedtNumGrado: TDBEdit
        Tag = 6
        Left = 303
        Top = 28
        Width = 30
        Height = 21
        DataField = 'NUMGRADO'
        DataSource = DButton
        TabOrder = 3
        OnChange = dedtNumGradoChange
      end
      object cmbParentela: TComboBox
        Left = 65
        Top = 28
        Width = 140
        Height = 21
        Style = csDropDownList
        TabOrder = 1
        OnCloseUp = cmbParentelaCloseUp
        OnKeyUp = cmbParentelaKeyUp
        Items.Strings = (
          'Nessuno/S'#232' stesso'
          'Coniuge'
          'Figlio/Figlia'
          'Genitore'
          'Fratello/Sorella'
          'Nipote'
          'Nipote equiparato Figlio'
          'Altro'
          'Affidato')
      end
      object cmbTipoPar: TComboBox
        Left = 216
        Top = 28
        Width = 74
        Height = 21
        Style = csDropDownList
        TabOrder = 2
        OnKeyDown = cmbTipoParKeyDown
        Items.Strings = (
          'Parente'
          'Affine')
      end
      object cmbMotivoTerzoGrado: TComboBox
        Left = 338
        Top = 28
        Width = 304
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnKeyDown = cmbTipoParKeyDown
        Items.Strings = (
          'Coniuge della persona disabile con et'#224' superiore ai 65 anni'
          'Genitore della persona disabile con et'#224' superiore ai 65 anni'
          'Coniuge affetto da patologia invalidante'
          'Genitori affetti da patologia invalidante'
          'Coniuge deceduto o mancante'
          'Genitori deceduti o mancanti'
          'Regime precedente Legge 183/2010')
      end
      object gpbGravidanza: TGroupBox
        Left = 648
        Top = 0
        Width = 124
        Height = 178
        Caption = 'Gravidanza / adozione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
        object lblGravInizioTeorico: TLabel
          Left = 8
          Top = 14
          Width = 59
          Height = 13
          Caption = 'Inizio teorico'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblGravInizioScelto: TLabel
          Left = 8
          Top = 53
          Width = 92
          Height = 13
          Caption = 'Inizio scelto dal dip.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblGravInizioEffettivo: TLabel
          Left = 8
          Top = 93
          Width = 65
          Height = 13
          Caption = 'Inizio effettivo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblGravFine: TLabel
          Left = 8
          Top = 133
          Width = 61
          Height = 13
          Caption = 'Fine effettiva'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedtGravInizioTeorico: TDBEdit
          Left = 8
          Top = 28
          Width = 80
          Height = 21
          DataField = 'GRAV_INIZIO_TEOR'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = dedtDataPreAdozChange
        end
        object dedtGravInizioScelto: TDBEdit
          Left = 8
          Top = 68
          Width = 80
          Height = 21
          DataField = 'GRAV_INIZIO_SCELTA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = dedtDataPreAdozChange
        end
        object dedtGravInizioEffettivo: TDBEdit
          Left = 8
          Top = 108
          Width = 80
          Height = 21
          DataField = 'GRAV_INIZIO_EFF'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnChange = dedtDataPreAdozChange
        end
        object dedtGravFine: TDBEdit
          Left = 8
          Top = 148
          Width = 80
          Height = 21
          DataField = 'GRAV_FINE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnChange = dedtDataPreAdozChange
        end
        object btnGravInizioTeorico: TButton
          Left = 91
          Top = 28
          Width = 17
          Height = 21
          Caption = '...'
          TabOrder = 4
          OnClick = btnGravInizioTeoricoClick
        end
        object btnGravInizioScelto: TButton
          Left = 91
          Top = 68
          Width = 17
          Height = 21
          Caption = '...'
          TabOrder = 5
          OnClick = btnGravInizioSceltoClick
        end
        object btnGravInizioEffettivo: TButton
          Left = 91
          Top = 108
          Width = 17
          Height = 21
          Caption = '...'
          TabOrder = 6
          OnClick = btnGravInizioEffettivoClick
        end
        object btnGravFine: TButton
          Left = 91
          Top = 148
          Width = 17
          Height = 21
          Caption = '...'
          TabOrder = 7
          OnClick = btnGravFineClick
        end
      end
      object btnDataPreAdoz: TButton
        Left = 86
        Top = 188
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 26
        OnClick = btnDataPreAdozClick
      end
      object btnDataSep: TButton
        Left = 453
        Top = 188
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 27
        OnClick = btnDataSepClick
      end
      object btnDataMat: TButton
        Left = 564
        Top = 188
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 28
        OnClick = btnDataMatClick
      end
      object chkRegDatanas: TDBCheckBox
        Left = 115
        Top = 110
        Width = 184
        Height = 17
        Caption = 'Registrazione evento data nascita'
        DataField = 'REG_DATANAS'
        DataSource = DButton
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = chkRegDatanasClick
      end
      object dedtNoteIndividuali: TDBEdit
        Left = 5
        Top = 229
        Width = 767
        Height = 21
        DataField = 'NOTE_INDIVIDUALI'
        DataSource = DButton
        MaxLength = 300
        TabOrder = 29
      end
      object cmbPartFruizMaternita: TComboBox
        Left = 419
        Top = 107
        Width = 145
        Height = 21
        Style = csDropDownList
        TabOrder = 13
        Items.Strings = (
          'Nessuno'
          'Genitore unico')
      end
    end
    object tabLegge104: TTabSheet
      Caption = 'Legge 104/1992'
      ImageIndex = 1
      object gpbAnnoAvv: TGroupBox
        Left = 399
        Top = 6
        Width = 362
        Height = 43
        Caption = 'Anno di avvicinamento alla sede di lavoro pi'#249' vicina '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lblAnnoAvv: TLabel
          Left = 7
          Top = 19
          Width = 87
          Height = 13
          Caption = 'Al proprio domicilio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblAnnoAvvFam: TLabel
          Left = 190
          Top = 19
          Width = 110
          Height = 13
          Caption = 'Al domicilio del familiare'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dedtAnnoAvv: TDBEdit
          Left = 106
          Top = 16
          Width = 42
          Height = 21
          DataField = 'ANNO_AVV'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
        end
        object dedtAnnoAvvFam: TDBEdit
          Left = 309
          Top = 16
          Width = 42
          Height = 21
          Hint = 
            'Il dato verr'#224' automaticamente impostato su tutti i familiari dis' +
            'abili'
          DataField = 'ANNO_AVV_FAM'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
      object gpbDisabilita: TGroupBox
        Left = 12
        Top = 6
        Width = 367
        Height = 43
        Caption = 'Disabilit'#224
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblAnnoRevisione: TLabel
          Left = 183
          Top = 19
          Width = 68
          Height = 13
          Caption = 'Data revisione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblTipoDisabilita: TLabel
          Tag = 6
          Left = 8
          Top = 19
          Width = 21
          Height = 13
          Caption = 'Tipo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object cmbTipoDisabilita: TComboBox
          Left = 36
          Top = 16
          Width = 135
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnCloseUp = cmbTipoDisabilitaCloseUp
          OnKeyDown = cmbTipoParKeyDown
          OnKeyUp = cmbTipoDisabilitaKeyUp
          Items.Strings = (
            'Rivedibile'
            'Non rivedibile'
            'Provvisorio')
        end
        object dedtAnnoRevisione: TDBEdit
          Left = 255
          Top = 16
          Width = 80
          Height = 21
          DataField = 'ANNO_REVISIONE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnChange = dedtDataPreAdozChange
        end
        object btnAnnoRevisione: TButton
          Left = 338
          Top = 16
          Width = 17
          Height = 21
          Caption = '...'
          TabOrder = 2
          OnClick = btnAnnoRevisioneClick
        end
      end
      object gpbFamiliare: TGroupBox
        Left = 12
        Top = 115
        Width = 749
        Height = 43
        Caption = 'P.A. familiare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object lblDurataContratto: TLabel
          Tag = 6
          Left = 507
          Top = 19
          Width = 77
          Height = 13
          Caption = 'Durata contratto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblNomePA: TLabel
          Left = 8
          Top = 19
          Width = 96
          Height = 13
          Caption = 'Denominazione P.A.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object cmbDurataContratto: TComboBox
          Left = 590
          Top = 16
          Width = 148
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnKeyDown = cmbTipoParKeyDown
          Items.Strings = (
            'Tempo indeterminato'
            'Tempo determinato')
        end
        object cmbNomePA: TComboBox
          Left = 108
          Top = 16
          Width = 380
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = cmbNomePAChange
        end
      end
      object gpbAlternativa: TGroupBox
        Left = 12
        Top = 160
        Width = 749
        Height = 70
        Caption = 'Alternativa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        object lblAlternativaNomePA: TLabel
          Left = 9
          Top = 46
          Width = 96
          Height = 13
          Caption = 'Denominazione P.A.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblAlternativaMotivoTerzoGrado: TLabel
          Tag = 6
          Left = 353
          Top = 19
          Width = 75
          Height = 13
          Caption = 'Motivo 3'#176' grado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblAlternativa: TLabel
          Tag = 6
          Left = 9
          Top = 19
          Width = 65
          Height = 13
          Caption = 'Tipo soggetto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object cmbAlternativaMotivoTerzoGrado: TComboBox
          Left = 434
          Top = 16
          Width = 304
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnKeyDown = cmbTipoParKeyDown
          Items.Strings = (
            'Coniuge della persona disabile con et'#224' superiore ai 65 anni'
            'Genitore della persona disabile con et'#224' superiore ai 65 anni'
            'Coniuge affetto da patologia invalidante'
            'Genitori affetti da patologia invalidante'
            'Coniuge deceduto o mancante'
            'Genitori deceduti o mancanti'
            'Regime precedente Legge 183/2010')
        end
        object cmbAlternativa: TComboBox
          Left = 108
          Top = 16
          Width = 221
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnCloseUp = cmbAlternativaCloseUp
          OnKeyDown = cmbTipoParKeyDown
          OnKeyUp = cmbAlternativaKeyUp
          Items.Strings = (
            'Genitore '
            'Coniuge'
            'Figlio'
            'Parente o affine fino al 2'#176' grado'
            'Parente o affine fino al 3'#176' grado'
            'Nessuno'
            'Affidatario')
        end
        object cmbAlternativaNomePA: TComboBox
          Left = 108
          Top = 43
          Width = 380
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
      end
      object gpbResidenza: TGroupBox
        Left = 12
        Top = 52
        Width = 749
        Height = 59
        Caption = 'Residenza familiare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object lblIndirizzo: TLabel
          Left = 8
          Top = 16
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
          Left = 338
          Top = 16
          Width = 39
          Height = 13
          Caption = 'Comune'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblCap: TLabel
          Tag = 6
          Left = 544
          Top = 16
          Width = 21
          Height = 13
          Caption = 'CAP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblProvincia: TLabel
          Tag = 6
          Left = 590
          Top = 16
          Width = 25
          Height = 13
          Caption = 'Prov.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblTelefono: TLabel
          Left = 639
          Top = 16
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
        object dedtIndirizzo: TDBEdit
          Left = 9
          Top = 30
          Width = 321
          Height = 21
          DataField = 'INDIRIZZO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 40
          ParentFont = False
          TabOrder = 0
        end
        object dcmbComune: TDBLookupComboBox
          Tag = 1
          Left = 338
          Top = 30
          Width = 150
          Height = 21
          DataField = 'Desc_Comune'
          DataSource = DButton
          DropDownWidth = 400
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ListField = 'Citta;Provincia;Codice'
          ParentFont = False
          PopupMenu = PopupMenu1
          TabOrder = 1
          OnKeyDown = dcmbMatricolaKeyDown
        end
        object dedtComune: TDBEdit
          Tag = 5
          Left = 491
          Top = 30
          Width = 50
          Height = 21
          DataField = 'COMUNE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object dedtCAP: TDBEdit
          Tag = 6
          Left = 544
          Top = 30
          Width = 40
          Height = 21
          DataField = 'CAP'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnDblClick = dedtCAPNasDblClick
          OnKeyDown = dedtCAPNasKeyDown
        end
        object dedtProvincia: TDBEdit
          Tag = 6
          Left = 590
          Top = 30
          Width = 30
          Height = 21
          DataField = 'Prov_Comune'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object dedtTelefono: TDBEdit
          Left = 639
          Top = 30
          Width = 100
          Height = 21
          DataField = 'TELEFONO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 15
          ParentFont = False
          TabOrder = 5
        end
      end
    end
    object tabDatiStipendiali: TTabSheet
      Caption = 'Dati stipendiali'
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 452
        Top = 11
        Width = 309
        Height = 151
        Caption = 'Assegno nucleo familiare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblRedditoANF: TLabel
          Left = 19
          Top = 78
          Width = 74
          Height = 13
          Caption = 'Reddito lav.dip.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblRedditoAltroANF: TLabel
          Left = 110
          Top = 78
          Width = 48
          Height = 13
          Caption = 'Altri redditi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblTotaleANF: TLabel
          Left = 202
          Top = 78
          Width = 30
          Height = 13
          Caption = 'Totale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dchkANFSpeciale: TDBCheckBox
          Left = 19
          Top = 35
          Width = 253
          Height = 18
          HelpContext = 2003
          Alignment = taLeftJustify
          Caption = 'Studente/apprendista'
          DataField = 'SPECIALE_ANF'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkANF: TDBCheckBox
          Left = 19
          Top = 17
          Width = 253
          Height = 18
          HelpContext = 2003
          Alignment = taLeftJustify
          Caption = 'Componente nucleo'
          DataField = 'COMPONENTE_ANF'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkANFInabile: TDBCheckBox
          Left = 19
          Top = 53
          Width = 253
          Height = 18
          HelpContext = 2003
          Alignment = taLeftJustify
          Caption = 'Inabile'
          DataField = 'INABILE_ANF'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dedtREDDITOANF: TDBEdit
          Left = 19
          Top = 93
          Width = 70
          Height = 21
          DataField = 'REDDITO_ANF'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnExit = dedtREDDITOANFExit
        end
        object dedtRedditoAltroANF: TDBEdit
          Left = 110
          Top = 93
          Width = 70
          Height = 21
          DataField = 'REDDITO_ALTRO_ANF'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnExit = dedtREDDITOANFExit
        end
        object edtTotaleANF: TEdit
          Left = 202
          Top = 93
          Width = 70
          Height = 21
          TabStop = False
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
      end
      object gpbDetrazioniIRPEF: TGroupBox
        Left = 10
        Top = 11
        Width = 427
        Height = 151
        Caption = 'Detrazioni IRPEF familiari a carico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lblPERC_CARICO: TLabel
          Left = 8
          Top = 96
          Width = 98
          Height = 13
          Caption = 'Percentuale a carico'
        end
        object lblDATA_ULT_FAM_CAR: TLabel
          Left = 8
          Top = 20
          Width = 118
          Height = 13
          Caption = 'Data ultima dichiarazione'
        end
        object drgpTIPO_DETRAZIONE: TDBRadioGroup
          Left = 8
          Top = 37
          Width = 393
          Height = 48
          HelpContext = 2003
          Caption = 'Tipo'
          Columns = 2
          DataField = 'TIPO_DETRAZIONE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Nessuna'
            'Per coniuge a carico'
            'Per figlio a carico'
            'Per altri familiari a carico')
          ParentFont = False
          TabOrder = 1
          TabStop = True
          Values.Strings = (
            'ND'
            'DC'
            'DF'
            'DA')
          OnClick = drgpTIPO_DETRAZIONEClick
        end
        object dedtPERC_CARICO: TDBEdit
          Tag = 5
          Left = 133
          Top = 93
          Width = 70
          Height = 21
          DataField = 'PERC_CARICO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnExit = dedtPERC_CARICOExit
        end
        object dchkDetrFiglioHandicap: TDBCheckBox
          Left = 234
          Top = 95
          Width = 167
          Height = 18
          HelpContext = 2003
          Alignment = taLeftJustify
          Caption = 'Figlio portatore di handicap'
          DataField = 'DETR_FIGLIO_HANDICAP'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dedtDATA_ULT_FAM_CAR: TDBEdit
          Left = 133
          Top = 17
          Width = 70
          Height = 21
          DataField = 'DATA_ULT_FAM_CAR'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 15
          ParentFont = False
          TabOrder = 0
          OnChange = dedtDataPreAdozChange
        end
        object dchkDetr100Affid: TDBCheckBox
          Left = 8
          Top = 120
          Width = 195
          Height = 18
          HelpContext = 2003
          Alignment = taLeftJustify
          Caption = 'Detrazione 100% affidamento figli'
          DataField = 'DETR_FIGLIO_100_AFFID'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object btnDATA_ULT_FAM_CAR: TButton
          Left = 206
          Top = 17
          Width = 17
          Height = 21
          Caption = '...'
          TabOrder = 5
          OnClick = btnDATA_ULT_FAM_CARClick
        end
      end
    end
    object tabNote: TTabSheet
      Caption = 'Note'
      ImageIndex = 3
      object dmemNote: TDBMemo
        Left = 0
        Top = 0
        Width = 779
        Height = 300
        Align = alClient
        DataField = 'NOTE'
        DataSource = DButton
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel [7]
    Left = 0
    Top = 409
    Width = 787
    Height = 20
    Align = alTop
    Caption = 'Situazione riepilogativa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  inherited MainMenu1: TMainMenu [8]
    Left = 708
    Top = 13
  end
  inherited DButton: TDataSource [9]
    Left = 537
    Top = 21
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [10]
    Left = 511
    Top = 21
  end
  inherited ImageList1: TImageList [11]
    Left = 596
    Top = 21
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
    Left = 567
    Top = 21
  end
  object PopupMenu1: TPopupMenu
    Left = 677
    Top = 13
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
  object MnuCopia: TPopupMenu
    Left = 552
    Top = 418
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Annullatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Copia1: TMenuItem
      Caption = 'Copia'
      OnClick = Copia1Click
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = Copia1Click
    end
  end
end
