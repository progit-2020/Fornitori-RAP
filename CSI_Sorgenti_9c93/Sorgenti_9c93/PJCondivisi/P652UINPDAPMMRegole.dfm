inherited P652FINPDAPMMRegole: TP652FINPDAPMMRegole
  Left = 141
  Top = 158
  HelpContext = 3652000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<P652> Regole fornitura'
  ClientHeight = 542
  ClientWidth = 635
  OnActivate = FormActivate
  ExplicitWidth = 651
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 524
    Width = 635
    ExplicitTop = 524
    ExplicitWidth = 635
  end
  inherited grbDecorrenza: TGroupBox
    Width = 635
    ExplicitWidth = 635
  end
  inherited ToolBar1: TToolBar
    Width = 635
    ExplicitWidth = 635
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 63
    Width = 635
    Height = 461
    Align = alClient
    TabOrder = 3
    object PnlRegole: TPanel
      Left = 1
      Top = 1
      Width = 633
      Height = 251
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object PnlINPDAP: TPanel
        Left = 0
        Top = 0
        Width = 633
        Height = 251
        Align = alClient
        BevelOuter = bvNone
        Color = clYellow
        TabOrder = 1
        Visible = False
        object lblParteCUD: TLabel
          Left = 9
          Top = 5
          Width = 73
          Height = 13
          Caption = 'Parte o sezione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblNumeroCUD: TLabel
          Left = 96
          Top = 5
          Width = 61
          Height = 13
          Caption = 'Numero dato'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDescrizione: TLabel
          Left = 185
          Top = 5
          Width = 55
          Height = 13
          Caption = 'Descrizione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblCodArrotondamento: TLabel
          Left = 149
          Top = 102
          Width = 75
          Height = 13
          Caption = 'Arrotondamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblFormato: TLabel
          Left = 323
          Top = 102
          Width = 86
          Height = 13
          Caption = 'Formato di stampa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblIdCausaleF24: TLabel
          Left = 9
          Top = 161
          Width = 121
          Height = 13
          Caption = 'Identificativo causale F24'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dchkRegolaModificabile: TDBCheckBox
          Left = 229
          Top = 128
          Width = 128
          Height = 17
          Caption = 'Regola modificabile'
          DataField = 'REGOLA_MODIFICABILE'
          DataSource = DButton
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkOmettiVuoto: TDBCheckBox
          Left = 9
          Top = 128
          Width = 165
          Height = 17
          Caption = 'Ometti se dato non significativo'
          DataField = 'OMETTI_VUOTO'
          DataSource = DButton
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkNumerico: TDBCheckBox
          Left = 9
          Top = 102
          Width = 100
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = 'Dato numerico'
          DataField = 'NUMERICO'
          DataSource = DButton
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 2
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object gpbDatiEsportazione: TGroupBox
          Left = 9
          Top = 45
          Width = 621
          Height = 47
          Caption = 'Esportazione su file'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object lblTipoRecord: TLabel
            Left = 5
            Top = 20
            Width = 54
            Height = 13
            Caption = 'Tipo record'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblSezione: TLabel
            Left = 117
            Top = 20
            Width = 83
            Height = 13
            Caption = 'Sezione o quadro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblFormatoFile: TLabel
            Left = 389
            Top = 20
            Width = 38
            Height = 13
            Caption = 'Formato'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblNumeroFile: TLabel
            Left = 260
            Top = 20
            Width = 61
            Height = 13
            Caption = 'Numero dato'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dedtTipoRecord: TDBEdit
            Left = 68
            Top = 16
            Width = 40
            Height = 21
            Color = cl3DLight
            DataField = 'TIPO_RECORD'
            DataSource = DButton
            Enabled = False
            TabOrder = 0
          end
          object dedtSezioneFile: TDBEdit
            Left = 209
            Top = 16
            Width = 40
            Height = 21
            Color = cl3DLight
            DataField = 'SEZIONE_FILE'
            DataSource = DButton
            Enabled = False
            TabOrder = 1
          end
          object dedtFormatoFile: TDBEdit
            Left = 435
            Top = 16
            Width = 59
            Height = 21
            Color = cl3DLight
            DataField = 'FORMATO_FILE'
            DataSource = DButton
            Enabled = False
            TabOrder = 2
          end
          object dchkFormatoAnnoMese: TDBCheckBox
            Left = 503
            Top = 20
            Width = 108
            Height = 17
            Alignment = taLeftJustify
            BiDiMode = bdLeftToRight
            Caption = 'Formato aaaa/mm'
            DataField = 'FORMATO_ANNOMESE'
            DataSource = DButton
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBiDiMode = False
            ParentFont = False
            TabOrder = 3
            ValueChecked = 'S'
            ValueUnchecked = 'N'
          end
          object dedtNumeroFile: TDBEdit
            Left = 328
            Top = 16
            Width = 50
            Height = 21
            Color = cl3DLight
            DataField = 'NUMERO_FILE'
            DataSource = DButton
            Enabled = False
            TabOrder = 4
          end
        end
        object dedtParteCUD: TDBEdit
          Left = 9
          Top = 19
          Width = 50
          Height = 21
          Color = cl3DLight
          DataField = 'PARTE'
          DataSource = DButton
          Enabled = False
          TabOrder = 4
        end
        object dedtNumeroCUD: TDBEdit
          Left = 96
          Top = 19
          Width = 50
          Height = 21
          Color = cl3DLight
          DataField = 'NUMERO'
          DataSource = DButton
          Enabled = False
          TabOrder = 5
        end
        object dedtDescrizione: TDBEdit
          Left = 185
          Top = 19
          Width = 445
          Height = 21
          Color = cl3DLight
          DataField = 'DESCRIZIONE'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object dcmbCodArrotondamento: TDBLookupComboBox
          Left = 229
          Top = 98
          Width = 87
          Height = 21
          Color = cl3DLight
          DataField = 'COD_ARROTONDAMENTO'
          DataSource = DButton
          Enabled = False
          KeyField = 'COD_ARROTONDAMENTO'
          ListField = 'COD_ARROTONDAMENTO'
          ListSource = P652FINPDAPMMRegoleDtM.D050
          TabOrder = 7
          OnKeyDown = dCmbNumeroTredicesimaFLUPERKeyDown
        end
        object dedtFormato: TDBEdit
          Left = 413
          Top = 98
          Width = 86
          Height = 21
          Color = cl3DLight
          DataField = 'FORMATO'
          DataSource = DButton
          Enabled = False
          TabOrder = 8
        end
        object drgpTipoDato: TDBRadioGroup
          Left = 229
          Top = 148
          Width = 195
          Height = 31
          Caption = 'Tipo dato'
          Columns = 2
          DataField = 'TIPO_DATO'
          DataSource = DButton
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Individuale'
            'Riepilogativo')
          ParentFont = False
          TabOrder = 9
          Values.Strings = (
            'I'
            'R')
        end
        object btnFiltroVoci: TBitBtn
          Left = 517
          Top = 126
          Width = 110
          Height = 24
          Caption = '&Filtro Voci          '
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000120B0000120B00001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF0660FFFFFFFFFFFF0660FF
            FFFFFFFFFF0F70FFFFFFFFFFFF0F70FFFFFFFFFFF077760FFFFFFFFF06777660
            FFFFFFF067F777660FFFFF067F77777660FFF067FFF77776660FF00000000000
            000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          TabOrder = 10
          OnClick = btnFiltroVociClick
        end
        object btnRipristinaAutomatica: TBitBtn
          Left = 517
          Top = 98
          Width = 110
          Height = 24
          Caption = '&Ripristina regola'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF0000000000000000000000000000000000000000
            00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF000000FFFFFF000000000000FFFFFF0000000000
            00C0C0C0FFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF000000FFFFFF000000000000000000000000FFFF
            FF000000FFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF000000FFFFFF000000000000FFFFFF0000000000
            FF00000000000000000000000000000080808000000080808080808000000000
            0000FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF000000FF00FF000000000000
            808080000000808080808080000000000000000000C0C0C00000FF0000FF0000
            FF0000FF0000FFFF00FF000000000000C0C0C0000000C0C0C0C0C0C000000000
            0000FFFFFF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000000000000
            C0C0C0C0C0C0C0C0C0C0C0C0000000000000FF00FFFF00FFFF00FF0000FF0000
            FF0000FFFF00FFFF00FF00000000000000000000000000000000000000000000
            0000FF00FFFF00FFFF00FF0000FF0000FF0000FFFF00FFFF00FF000000000000
            000000000000000000000000000000000000FF00FFFF00FFFF00FF0000FF0000
            FF0000FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000FF00FFFF00FF8080800000FF0000FF0000FFFF00FFFF00FF000000FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000FF0000FF0000FF0000FF0000
            FFFF00FFFF00FFFF00FF000000FF0000FF0000FF00000000FFFF0000FF000000
            0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 11
          OnClick = btnRipristinaAutomaticaClick
        end
        object dedtIdCausaleF24: TDBEdit
          Left = 139
          Top = 157
          Width = 50
          Height = 21
          Color = cl3DLight
          DataField = 'CODICI_CAUSALI'
          DataSource = DButton
          Enabled = False
          MaxLength = 5
          TabOrder = 12
        end
      end
      object PnlFLUPER: TPanel
        Left = 0
        Top = 200
        Width = 633
        Height = 250
        BevelOuter = bvNone
        Color = clRed
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          Left = 48
          Top = 6
          Width = 73
          Height = 13
          Caption = 'Parte o sezione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 164
          Top = 6
          Width = 61
          Height = 13
          Caption = 'Numero dato'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 270
          Top = 6
          Width = 55
          Height = 13
          Caption = 'Descrizione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 149
          Top = 194
          Width = 75
          Height = 13
          Caption = 'Arrotondamento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 323
          Top = 194
          Width = 86
          Height = 13
          Caption = 'Formato di stampa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 9
          Top = 71
          Width = 234
          Height = 13
          Caption = 'Numero dato in caso di tredicesima anno corrente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 9
          Top = 109
          Width = 216
          Height = 13
          Caption = 'Numero dato in caso di arretrati anno corrente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 328
          Top = 109
          Width = 231
          Height = 13
          Caption = 'Numero dato in caso di arretrati anno precedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dLblDescrizioneTredicesimaFLUPER: TDBText
          Left = 79
          Top = 83
          Width = 245
          Height = 26
          DataField = 'descFL_NUMERO_TREDICESIMA'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object dLblDescrizioneArretratiACFLUPER: TDBText
          Left = 79
          Top = 122
          Width = 245
          Height = 26
          DataField = 'desc_FL_NUMERO_ARRCORR'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object dLblDescrizioneArretratiAPFLUPER: TDBText
          Left = 399
          Top = 122
          Width = 230
          Height = 26
          DataField = 'desc_FL_NUMERO_ARRPREC'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label15: TLabel
          Left = 9
          Top = 29
          Width = 112
          Height = 13
          Caption = 'Dato anagr./Accor.voci'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label13: TLabel
          Left = 87
          Top = 52
          Width = 34
          Height = 13
          Caption = 'Causali'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblNumeroTredPrec: TLabel
          Left = 328
          Top = 71
          Width = 249
          Height = 13
          Caption = 'Numero dato in caso di tredicesima anno precedente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dLblDescrizioneTredPrecFLUPER: TDBText
          Left = 399
          Top = 83
          Width = 230
          Height = 26
          DataField = 'descFL_NUMERO_TREDPREC'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object dchkRegolaModificabileFLUPER: TDBCheckBox
          Left = 9
          Top = 224
          Width = 128
          Height = 17
          Caption = 'Regola modificabile'
          DataField = 'REGOLA_MODIFICABILE'
          DataSource = DButton
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object dchkNumericoFLUPER: TDBCheckBox
          Left = 9
          Top = 194
          Width = 100
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = 'Dato numerico'
          DataField = 'NUMERICO'
          DataSource = DButton
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentBiDiMode = False
          ParentFont = False
          TabOrder = 11
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
        object gpbEsportazioneFile: TGroupBox
          Left = 9
          Top = 146
          Width = 621
          Height = 42
          Caption = 'Esportazione su file'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          object Label6: TLabel
            Left = 5
            Top = 18
            Width = 54
            Height = 13
            Caption = 'Tipo record'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 115
            Top = 18
            Width = 83
            Height = 13
            Caption = 'Sezione o quadro'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 383
            Top = 18
            Width = 38
            Height = 13
            Caption = 'Formato'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label9: TLabel
            Left = 256
            Top = 18
            Width = 61
            Height = 13
            Caption = 'Numero dato'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 498
            Top = 18
            Width = 52
            Height = 13
            Caption = 'Lunghezza'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clHighlight
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object dEdtTipoRecordFLUPER: TDBEdit
            Left = 64
            Top = 14
            Width = 40
            Height = 21
            Color = cl3DLight
            DataField = 'TIPO_RECORD'
            DataSource = DButton
            Enabled = False
            TabOrder = 0
          end
          object dedtSezioneFileFLUPER: TDBEdit
            Left = 203
            Top = 14
            Width = 40
            Height = 21
            Color = cl3DLight
            DataField = 'SEZIONE_FILE'
            DataSource = DButton
            Enabled = False
            TabOrder = 1
          end
          object dedtFormatoFileFLUPER: TDBEdit
            Left = 425
            Top = 14
            Width = 59
            Height = 21
            Color = cl3DLight
            DataField = 'FORMATO_FILE'
            DataSource = DButton
            Enabled = False
            TabOrder = 3
          end
          object dedtNumeroFileFLUPER: TDBEdit
            Left = 320
            Top = 14
            Width = 50
            Height = 21
            Color = cl3DLight
            DataField = 'NUMERO_FILE'
            DataSource = DButton
            Enabled = False
            TabOrder = 2
          end
          object dEdtLunghezza: TDBEdit
            Left = 555
            Top = 13
            Width = 59
            Height = 21
            Color = cl3DLight
            DataField = 'LUNGHEZZA_FILE'
            DataSource = DButton
            Enabled = False
            TabOrder = 4
          end
        end
        object dEdtParteFLUPER: TDBEdit
          Left = 125
          Top = 3
          Width = 28
          Height = 21
          Color = cl3DLight
          DataField = 'PARTE'
          DataSource = DButton
          Enabled = False
          TabOrder = 0
        end
        object dEdtNumeroFLUPER: TDBEdit
          Left = 230
          Top = 3
          Width = 31
          Height = 21
          Color = cl3DLight
          DataField = 'NUMERO'
          DataSource = DButton
          Enabled = False
          TabOrder = 1
        end
        object dEdtDescrizioneFLUPER: TDBEdit
          Left = 328
          Top = 3
          Width = 298
          Height = 21
          Color = cl3DLight
          DataField = 'DESCRIZIONE'
          DataSource = DButton
          Enabled = False
          TabOrder = 2
        end
        object dcmbCodArrotondamentoFLUPER: TDBLookupComboBox
          Left = 229
          Top = 190
          Width = 87
          Height = 21
          Color = cl3DLight
          DataField = 'COD_ARROTONDAMENTO'
          DataSource = DButton
          DropDownWidth = 200
          Enabled = False
          KeyField = 'COD_ARROTONDAMENTO'
          ListField = 'COD_ARROTONDAMENTO;VALORE'
          ListSource = P652FINPDAPMMRegoleDtM.D050
          TabOrder = 12
          OnKeyDown = dCmbNumeroTredicesimaFLUPERKeyDown
        end
        object dedtFormatoFLUPER: TDBEdit
          Left = 413
          Top = 190
          Width = 86
          Height = 21
          Color = cl3DLight
          DataField = 'FORMATO'
          DataSource = DButton
          Enabled = False
          TabOrder = 13
        end
        object drgpTipoDatoFLUPER: TDBRadioGroup
          Left = 229
          Top = 213
          Width = 195
          Height = 34
          Caption = 'Tipo dato'
          Columns = 2
          DataField = 'TIPO_DATO'
          DataSource = DButton
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Individuale'
            'Riepilogativo')
          ParentFont = False
          TabOrder = 15
          Values.Strings = (
            'I'
            'R')
          Visible = False
        end
        object btnFiltroVociFLUPER: TBitBtn
          Left = 517
          Top = 224
          Width = 110
          Height = 24
          Caption = '&Filtro Voci          '
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000120B0000120B00001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF0660FFFFFFFFFFFF0660FF
            FFFFFFFFFF0F70FFFFFFFFFFFF0F70FFFFFFFFFFF077760FFFFFFFFF06777660
            FFFFFFF067F777660FFFFF067F77777660FFF067FFF77776660FF00000000000
            000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          TabOrder = 17
          OnClick = btnFiltroVociClick
        end
        object btnRipristinaAutomaticaFLUPER: TBitBtn
          Left = 517
          Top = 198
          Width = 110
          Height = 24
          Caption = '&Ripristina regola'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF0000000000000000000000000000000000000000
            00000000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF000000FFFFFF000000000000FFFFFF0000000000
            00C0C0C0FFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF000000FFFFFF000000000000000000000000FFFF
            FF000000FFFFFF000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF000000FFFFFF000000000000FFFFFF0000000000
            FF00000000000000000000000000000080808000000080808080808000000000
            0000FFFFFFFFFFFFFFFFFF0000FF0000FF0000FF000000FF00FF000000000000
            808080000000808080808080000000000000000000C0C0C00000FF0000FF0000
            FF0000FF0000FFFF00FF000000000000C0C0C0000000C0C0C0C0C0C000000000
            0000FFFFFF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000000000000
            C0C0C0C0C0C0C0C0C0C0C0C0000000000000FF00FFFF00FFFF00FF0000FF0000
            FF0000FFFF00FFFF00FF00000000000000000000000000000000000000000000
            0000FF00FFFF00FFFF00FF0000FF0000FF0000FFFF00FFFF00FF000000000000
            000000000000000000000000000000000000FF00FFFF00FFFF00FF0000FF0000
            FF0000FFFF00FFFF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
            0000FF00FFFF00FF8080800000FF0000FF0000FFFF00FFFF00FF000000FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000FF0000FF0000FF0000FF0000
            FFFF00FFFF00FFFF00FF000000FF0000FF0000FF00000000FFFF0000FF000000
            0000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 16
          OnClick = btnRipristinaAutomaticaClick
        end
        object BtnCausaliFLUPER: TButton
          Left = 610
          Top = 49
          Width = 16
          Height = 22
          Caption = '...'
          TabOrder = 5
          OnClick = BtnCausaliFLUPERClick
        end
        object dEdtCausaliFLUPER: TDBEdit
          Left = 125
          Top = 49
          Width = 485
          Height = 21
          Color = cl3DLight
          DataField = 'CODICI_CAUSALI'
          DataSource = DButton
          Enabled = False
          TabOrder = 4
        end
        object dCmbNomeDato: TDBComboBox
          Left = 125
          Top = 26
          Width = 501
          Height = 21
          Color = cl3DLight
          DataField = 'NOME_DATO'
          DataSource = DButton
          Enabled = False
          TabOrder = 3
        end
        object dCmbNumeroTredicesimaFLUPER: TDBLookupComboBox
          Left = 9
          Top = 84
          Width = 67
          Height = 21
          Color = cl3DLight
          DataField = 'FL_NUMERO_TREDICESIMA'
          DataSource = DButton
          DropDownWidth = 380
          KeyField = 'NUMERO'
          ListField = 'NUMERO;DESCRIZIONE'
          ListSource = P652FINPDAPMMRegoleDtM.D660B
          TabOrder = 6
          OnKeyDown = dCmbNumeroTredicesimaFLUPERKeyDown
        end
        object dCmbNumeroArretratiACFLUPER: TDBLookupComboBox
          Left = 9
          Top = 121
          Width = 67
          Height = 21
          Color = cl3DLight
          DataField = 'FL_NUMERO_ARRCORR'
          DataSource = DButton
          DropDownWidth = 380
          KeyField = 'NUMERO'
          ListField = 'NUMERO;DESCRIZIONE'
          ListSource = P652FINPDAPMMRegoleDtM.D660B
          TabOrder = 8
          OnKeyDown = dCmbNumeroTredicesimaFLUPERKeyDown
        end
        object dCmbNumeroArretratiAPFLUPER: TDBLookupComboBox
          Left = 328
          Top = 121
          Width = 67
          Height = 21
          Color = cl3DLight
          DataField = 'FL_NUMERO_ARRPREC'
          DataSource = DButton
          DropDownWidth = 380
          KeyField = 'NUMERO'
          ListField = 'NUMERO;DESCRIZIONE'
          ListSource = P652FINPDAPMMRegoleDtM.D660B
          TabOrder = 9
          OnKeyDown = dCmbNumeroTredicesimaFLUPERKeyDown
        end
        object dCmbNumeroTredPrecFLUPER: TDBLookupComboBox
          Left = 328
          Top = 84
          Width = 67
          Height = 21
          Color = cl3DLight
          DataField = 'FL_NUMERO_TREDPREC'
          DataSource = DButton
          DropDownWidth = 380
          KeyField = 'NUMERO'
          ListField = 'NUMERO;DESCRIZIONE'
          ListSource = P652FINPDAPMMRegoleDtM.D660B
          TabOrder = 7
          OnKeyDown = dCmbNumeroTredicesimaFLUPERKeyDown
        end
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 252
      Width = 633
      Height = 36
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object lblCommento: TLabel
        Left = 9
        Top = 1
        Width = 50
        Height = 13
        Caption = 'Commento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dmemCommento: TDBMemo
        Left = 9
        Top = 14
        Width = 618
        Height = 20
        Color = cl3DLight
        DataField = 'COMMENTO'
        DataSource = DButton
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 288
      Width = 633
      Height = 172
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object dmemRegolaCalcoloManuale: TDBMemo
        Left = 0
        Top = 14
        Width = 633
        Height = 158
        Align = alClient
        DataField = 'REGOLA_CALCOLO_MANUALE'
        DataSource = DButton
        TabOrder = 0
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 633
        Height = 14
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lblRegolaCalcoloManuale: TLabel
          Left = 9
          Top = 1
          Width = 125
          Height = 13
          Caption = 'Regola di calcolo manuale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 228
    Top = 16
  end
  inherited DButton: TDataSource
    Left = 256
    Top = 16
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 284
    Top = 16
  end
  inherited ImageList1: TImageList
    Left = 172
    Top = 16
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
    Left = 200
    Top = 25
  end
end
