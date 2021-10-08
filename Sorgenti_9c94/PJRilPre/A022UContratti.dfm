inherited A022FContratti: TA022FContratti
  Left = 193
  Top = 199
  HelpContext = 22000
  Caption = '<A022> Contratti'
  ClientHeight = 395
  ClientWidth = 560
  ExplicitWidth = 568
  ExplicitHeight = 441
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 377
    Width = 560
    ExplicitTop = 377
    ExplicitWidth = 560
  end
  inherited Panel1: TToolBar
    Width = 560
    ExplicitWidth = 560
  end
  object PageControl1: TPageControl [2]
    Left = 0
    Top = 86
    Width = 560
    Height = 291
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Parametri'
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 552
        Height = 263
        Align = alClient
        TabOrder = 0
        object Label3: TLabel
          Left = 15
          Top = 114
          Width = 112
          Height = 13
          Caption = 'Durata turno reperibilit'#224':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 209
          Top = 114
          Width = 258
          Height = 13
          Caption = 'Numero ore annuali massime di straordinario liquidabile:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 209
          Top = 138
          Width = 273
          Height = 13
          Caption = 'Numero ore annuali massime di eccedenza compensabile:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblArrIndTurnoPal: TLabel
          Left = 209
          Top = 162
          Width = 162
          Height = 13
          Caption = 'Arrotondamento indennit'#224' di turno:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ETipo: TDBRadioGroup
          Left = 6
          Top = 3
          Width = 185
          Height = 104
          Caption = 'Tipo contratto'
          DataField = 'Tipo'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Aziende private'
            'Pubbliche amministrazione locali'
            'Aziende sanitarie/ospedaliere')
          ParentBackground = True
          ParentFont = False
          TabOrder = 0
          Values.Strings = (
            'AZP'
            'PAL'
            'USL')
          OnChange = ETipoChange
          OnClick = ETipoClick
        end
        object EIndTurno: TDBRadioGroup
          Left = 192
          Top = 3
          Width = 351
          Height = 104
          Caption = 'Tipo indennit'#224' di turno'
          DataField = 'IndTurno'
          DataSource = DButton
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            
              'Numero di presenze pomeridiane raffrontato con quello delle mens' +
              'ili'
            'Numero di ore fatte in turno'
            
              'Numero di ore fatte in turno con controllo dei pomeriggi lavorat' +
              'i'
            'Numero di ore fatte in turno suddivise in fasce'
            'Numero di ore all'#39'interno del debito orario suddivise in fasce ')
          ParentBackground = True
          ParentFont = False
          TabOrder = 1
          Values.Strings = (
            'A'
            'B'
            'C'
            'D'
            'E')
        end
        object DBEdit3: TDBEdit
          Left = 130
          Top = 110
          Width = 54
          Height = 21
          DataField = 'Reperibilita'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object DBEdit5: TDBEdit
          Left = 485
          Top = 110
          Width = 53
          Height = 21
          DataField = 'MaxStraord'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object GroupBox1: TGroupBox
          Left = 4
          Top = 156
          Width = 177
          Height = 99
          Caption = 'Fascia indennit'#224' notturna'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          object Label6: TLabel
            Left = 14
            Top = 16
            Width = 25
            Height = 13
            Caption = 'dalle:'
          end
          object Label7: TLabel
            Left = 110
            Top = 16
            Width = 19
            Height = 13
            Caption = 'alle:'
          end
          object Label4: TLabel
            Left = 14
            Top = 54
            Width = 78
            Height = 13
            Caption = 'Arrotondamento:'
          end
          object Label8: TLabel
            Left = 110
            Top = 54
            Width = 52
            Height = 13
            Caption = 'Tolleranza:'
          end
          object DBEdit6: TDBEdit
            Left = 14
            Top = 30
            Width = 53
            Height = 21
            DataField = 'IndNotteDa'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object DBEdit7: TDBEdit
            Left = 110
            Top = 30
            Width = 53
            Height = 21
            DataField = 'IndNotteA'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object DBEdit4: TDBEdit
            Left = 14
            Top = 68
            Width = 53
            Height = 21
            DataField = 'ARRINDNOT'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 4
            ParentFont = False
            TabOrder = 2
          end
          object DBEdit8: TDBEdit
            Left = 110
            Top = 68
            Width = 53
            Height = 21
            DataField = 'TOLINDNOT'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 2
            ParentFont = False
            TabOrder = 3
          end
        end
        object dedtMaxResiduabile: TDBEdit
          Left = 485
          Top = 134
          Width = 53
          Height = 21
          DataField = 'MaxResiduabile'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object dedtArrIndTurnoPal: TDBEdit
          Left = 485
          Top = 158
          Width = 53
          Height = 21
          DataField = 'ARR_INDTURNO_PAL'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 6
        end
        object dchkOreLavFasceConAss: TDBCheckBox
          Left = 209
          Top = 183
          Width = 328
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Ore lavorate in fasce comprensive di ore rese da assenza'
          DataField = 'ORE_LAVFASCE_CONASS'
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
    object TabSheet2: TTabSheet
      Caption = 'Fasce di maggiorazione'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 552
        Height = 263
        Align = alClient
        DataSource = A022FContrattiDtM1.D201
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnEditButtonClick = DBGrid1EditButtonClick
        Columns = <
          item
            Expanded = False
            FieldName = 'D_Giorno'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FasciaDa1'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FasciaA1'
            Width = 64
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'Maggior1'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FasciaDa2'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FasciaA2'
            Width = 64
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'Maggior2'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FasciaDa3'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FasciaA3'
            Width = 64
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'Maggior3'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FasciaDa4'
            Width = 64
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FasciaA4'
            Width = 64
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'Maggior4'
            Width = 64
            Visible = True
          end>
      end
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 29
    Width = 560
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 3
    object Label1: TLabel
      Left = 6
      Top = 9
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
      Left = 98
      Top = 9
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
    object Label9: TLabel
      Left = 98
      Top = 33
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
    object DBEdit1: TDBEdit
      Left = 44
      Top = 5
      Width = 50
      Height = 21
      DataField = 'Codice'
      DataSource = DButton
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 158
      Top = 5
      Width = 337
      Height = 21
      DataField = 'Descrizione'
      DataSource = DButton
      TabOrder = 1
    end
    object DBEdit9: TDBEdit
      Left = 158
      Top = 29
      Width = 71
      Height = 21
      DataField = 'DATADECORRENZA'
      DataSource = DButton
      TabOrder = 2
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 470
    Top = 46
    inherited File1: TMenuItem
      object FasceMagg1: TMenuItem [3]
        Action = actFasceMagg
      end
    end
  end
  inherited DButton: TDataSource
    Left = 526
    Top = 46
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 498
    Top = 46
  end
  inherited ImageList1: TImageList
    Left = 436
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 464
    Top = 2
    object actFasceMagg: TAction
      Caption = 'Fasce di maggiorazione'
      OnExecute = actFasceMaggExecute
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 442
    Top = 46
    object Copiasurigaprecedente1: TMenuItem
      Caption = 'Copia su riga precedente'
      OnClick = Copiasurigasuccessiva1Click
    end
    object Copiasurigasuccessiva1: TMenuItem
      Caption = 'Copia su riga successiva'
      OnClick = Copiasurigasuccessiva1Click
    end
  end
end
