object B007FManipolazioneDati: TB007FManipolazioneDati
  Left = 322
  Top = 109
  HelpContext = 9007000
  Caption = '<B007> Utility manipolazione dati'
  ClientHeight = 504
  ClientWidth = 605
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
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar: TProgressBar
    Left = 0
    Top = 469
    Width = 605
    Height = 16
    Align = alBottom
    TabOrder = 0
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 485
    Width = 605
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 59
    Width = 605
    Height = 377
    ActivePage = tabAllegatiIter
    Align = alClient
    MultiLine = True
    TabOrder = 2
    OnChange = PageControl1Change
    object tabStoricizzazione: TTabSheet
      Caption = 'Storicizzazione/Aggiornamento dati'
      ImageIndex = 3
      object dGrdValori: TDBGrid
        Left = 0
        Top = 91
        Width = 597
        Height = 222
        Align = alClient
        DataSource = B007FManipolazioneDatiDtM1.dsrValori
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnExit = dGrdValoriExit
        Columns = <
          item
            Expanded = False
            FieldName = 'VALOREOLD'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALORENEW'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Width = 250
            Visible = True
          end>
      end
      object rgpPeriodi: TRadioGroup
        Left = 0
        Top = 0
        Width = 597
        Height = 40
        Align = alTop
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Considera il periodo indicato'
          'Considera tutti i periodi dalla data indicata')
        ParentFont = False
        TabOrder = 0
        OnClick = rgpPeriodiClick
      end
      object Panel5: TPanel
        Left = 0
        Top = 40
        Width = 597
        Height = 51
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label5: TLabel
          Left = 4
          Top = 6
          Width = 94
          Height = 13
          Caption = 'Dato da aggiornare:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object dCmbDatoAgg: TDBLookupComboBox
          Left = 4
          Top = 24
          Width = 249
          Height = 21
          KeyField = 'NOME_CAMPO'
          ListField = 'NOME_LOGICO'
          ListSource = B007FManipolazioneDatiDtM1.dsrI010
          TabOrder = 0
          OnCloseUp = dCmbDatoAggCloseUp
          OnKeyDown = dcmbKeyDown
          OnKeyUp = dCmbDatoAggKeyUp
        end
        object chkStorico: TCheckBox
          Left = 304
          Top = 6
          Width = 105
          Height = 20
          Caption = 'Storicizzazione'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          State = cbChecked
          TabOrder = 1
        end
        object chkStoriciSuccessivi: TCheckBox
          Left = 304
          Top = 26
          Width = 266
          Height = 20
          Caption = 'Non aggiornare storici successivi se diversi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
      end
    end
    object tabCancellazioneDati: TTabSheet
      Caption = 'Cancellazione dati'
      object rgpCancDati: TRadioGroup
        Left = 0
        Top = 0
        Width = 597
        Height = 55
        Align = alTop
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Cancellazione dati del dipendente'
          'Cancellazione schede anagrafiche'
          'Cancellazione periodica totale'
          'Cancellazione periodica per dipendente')
        ParentFont = False
        TabOrder = 0
        OnClick = rgpCancDatiClick
      end
      object gpbTabelle: TGroupBox
        Left = 0
        Top = 55
        Width = 597
        Height = 258
        Align = alClient
        Caption = 'Elenco tabelle'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object chkLstTabelle: TCheckListBox
          Left = 2
          Top = 49
          Width = 593
          Height = 207
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ItemHeight = 14
          ParentFont = False
          PopupMenu = PopupMenu1
          Sorted = True
          TabOrder = 0
        end
        object dGrdSchedeAnag: TDBGrid
          Left = 2
          Top = 49
          Width = 593
          Height = 207
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          ParentFont = False
          PopupMenu = PopupMenu1
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
        object pnlSchedeAnag: TPanel
          Left = 2
          Top = 15
          Width = 593
          Height = 34
          Align = alTop
          TabOrder = 2
          object chkLogSchedeAnag: TCheckBox
            Left = 203
            Top = 9
            Width = 204
            Height = 17
            Caption = 'Registra log di elenco tabelle con dati'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object btnAggiornaSchedeAnag: TBitBtn
            Left = 10
            Top = 4
            Width = 157
            Height = 25
            Caption = 'Aggiorna elenco matricole'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
              FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
              2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
              FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
              FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
            ParentFont = False
            TabOrder = 1
            OnClick = btnAggiornaSchedeAnagClick
          end
        end
      end
    end
    object tabCancellazioneGiustif: TTabSheet
      Caption = 'Cancellazione giustificativi'
      object rgpCancGiust: TRadioGroup
        Left = 0
        Top = 0
        Width = 597
        Height = 40
        Align = alTop
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Cancellazione periodica totale'
          'Cancellazione periodica per dipendente')
        ParentFont = False
        TabOrder = 0
        OnClick = rgpCancGiustClick
      end
      object grpElencoCaus: TGroupBox
        Left = 0
        Top = 40
        Width = 597
        Height = 273
        Align = alClient
        Caption = 'Elenco causali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object chklstCausGiust: TCheckListBox
          Left = 2
          Top = 15
          Width = 593
          Height = 256
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          PopupMenu = PopupMenu1
          Sorted = True
          TabOrder = 0
        end
      end
    end
    object tabRicodificaGiustif: TTabSheet
      Caption = 'Ricodifica giustif. Assenza/Presenza'
      object rgpRicodificaGiust: TRadioGroup
        Left = 0
        Top = 0
        Width = 597
        Height = 40
        Align = alTop
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 1
        Items.Strings = (
          'Ricodifica periodica totale'
          'Ricodifica periodica per dipendente')
        ParentFont = False
        TabOrder = 0
        OnClick = rgpRicodificaGiustClick
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 40
        Width = 597
        Height = 273
        Align = alClient
        Caption = 'Dati di ricodifica'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label2: TLabel
          Left = 24
          Top = 82
          Width = 117
          Height = 13
          Caption = 'Vecchio codice causale:'
        end
        object Label3: TLabel
          Left = 24
          Top = 118
          Width = 110
          Height = 13
          Caption = 'Nuovo codice causale:'
        end
        object Label7: TLabel
          Left = 24
          Top = 40
          Width = 82
          Height = 13
          Caption = 'Tipologia causali:'
        end
        object DBText1: TDBText
          Left = 236
          Top = 118
          Width = 193
          Height = 17
          DataField = 'DESCRIZIONE'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtOldCausale: TEdit
          Left = 160
          Top = 79
          Width = 70
          Height = 21
          AutoSize = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          TabOrder = 0
        end
        object dCmbCausali: TDBLookupComboBox
          Left = 160
          Top = 114
          Width = 70
          Height = 21
          DropDownWidth = 200
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          KeyField = 'CODICE'
          ListField = 'CODICE;descrizione'
          ParentFont = False
          TabOrder = 1
          OnKeyDown = dcmbKeyDown
        end
        object rgpTipoCaus: TRadioGroup
          Left = 160
          Top = 26
          Width = 162
          Height = 37
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Assenza'
            'Presenza')
          TabOrder = 2
          OnClick = rgpTipoCausClick
        end
      end
    end
    object tabRiallineaGiust: TTabSheet
      Caption = 'Riallineamento giustificativi'
      ImageIndex = 7
      DesignSize = (
        597
        313)
      object Label1: TLabel
        Left = 8
        Top = 49
        Width = 90
        Height = 13
        Caption = 'Causali di assenza:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtCausali: TEdit
        Left = 104
        Top = 46
        Width = 453
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 0
      end
      object btnScegliCaus: TButton
        Left = 563
        Top = 46
        Width = 20
        Height = 21
        Hint = 'Scelta causali'
        Anchors = [akTop, akRight]
        Caption = '...'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnScegliCausClick
      end
    end
    object tabAllineamento: TTabSheet
      Caption = 'Allineamento dati liberi collegati'
      ImageIndex = 4
      object RadioGroup5: TRadioGroup
        Left = 0
        Top = 0
        Width = 597
        Height = 40
        Align = alTop
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Considera tutti i periodi storici'
          'Considera il periodo indicato')
        ParentFont = False
        TabOrder = 0
        OnClick = RadioGroup5Click
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 40
        Width = 597
        Height = 273
        Align = alClient
        Caption = 'Elenco dati liberi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object clbDatiLiberi: TCheckListBox
          Left = 2
          Top = 15
          Width = 593
          Height = 256
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ParentFont = False
          PopupMenu = PopupMenu1
          TabOrder = 0
        end
      end
    end
    object tabUnioneProgressivi: TTabSheet
      Caption = 'Unificazione matricole'
      ImageIndex = 5
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 597
        Height = 65
        Align = alTop
        TabOrder = 0
        DesignSize = (
          597
          65)
        object Label8: TLabel
          Left = 7
          Top = 11
          Width = 100
          Height = 13
          Caption = 'Dati per cui unificare:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object btnAggiornaMatr: TBitBtn
          Left = 7
          Top = 35
          Width = 157
          Height = 25
          Caption = 'Aggiorna elenco matricole'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
            2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
            FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
            FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
          TabOrder = 2
          OnClick = btnAggiornaMatrClick
        end
        object btnDatiAnag: TBitBtn
          Left = 573
          Top = 8
          Width = 20
          Height = 21
          Anchors = [akTop, akRight]
          Caption = '...'
          TabOrder = 1
          OnClick = btnDatiAnagClick
        end
        object edtDatiAnag: TEdit
          Left = 112
          Top = 8
          Width = 460
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          ReadOnly = True
          TabOrder = 0
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 65
        Width = 597
        Height = 248
        Align = alClient
        Caption = 'Elenco matricole da unificare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object dGrdMatricole: TDBGrid
          Left = 2
          Top = 15
          Width = 593
          Height = 231
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
          ParentFont = False
          PopupMenu = PopupMenu1
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
    object tabEsecuzioneScript: TTabSheet
      Caption = 'Esecuzione Script'
      ImageIndex = 6
      object Panel3: TPanel
        Left = 0
        Top = 280
        Width = 597
        Height = 33
        Align = alBottom
        TabOrder = 0
        DesignSize = (
          597
          33)
        object BtnEseguiScript: TButton
          Left = 573
          Top = 6
          Width = 20
          Height = 21
          Hint = 'Selezione file'
          Anchors = [akTop, akRight]
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = BtnEseguiScriptClick
        end
        object EdtPathFile: TEdit
          Left = 5
          Top = 6
          Width = 563
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
      end
      object MemoLog: TMemo
        Left = 0
        Top = 0
        Width = 597
        Height = 280
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
        WordWrap = False
      end
    end
    object tabMigrazioneDomicilio: TTabSheet
      Caption = 'Migrazione dati domicilio'
      ImageIndex = 8
      object grpDatiDomicilio: TGroupBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 591
        Height = 307
        Align = alClient
        Caption = 'Dati liberi domicilio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object grpIndirizzoDomicilio: TGroupBox
          Left = 11
          Top = 24
          Width = 558
          Height = 80
          TabOrder = 0
          object pnlIndirizzoDomicilio: TPanel
            Left = 2
            Top = 15
            Width = 554
            Height = 63
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object lblDescIndirizzoDomicilio: TLabel
              Left = 23
              Top = 44
              Width = 115
              Height = 13
              Caption = 'lblDescIndirizzoDomicilio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblIndirizzoSorg: TLabel
              Left = 20
              Top = 0
              Width = 114
              Height = 13
              Caption = 'Selezionare il dato libero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object cmbIndirizzoDomicilio: TComboBox
              Left = 20
              Top = 18
              Width = 203
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = cmbIndirizzoDomicilioChange
              OnKeyDown = cmbIndirizzoDomicilioKeyDown
            end
            object chkSovrascriviIndirizzo: TCheckBox
              Left = 236
              Top = 20
              Width = 197
              Height = 17
              Caption = 'Sovrascrivi anche se gi'#224' impostato'
              TabOrder = 1
            end
          end
        end
        object grpCapDomicilio: TGroupBox
          Left = 11
          Top = 112
          Width = 558
          Height = 80
          TabOrder = 1
          object pnlCapDomicilio: TPanel
            Left = 2
            Top = 15
            Width = 554
            Height = 63
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object lblCapSorg: TLabel
              Left = 20
              Top = 0
              Width = 114
              Height = 13
              Caption = 'Selezionare il dato libero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblDescCapDomicilio: TLabel
              Left = 23
              Top = 44
              Width = 96
              Height = 13
              Caption = 'lblDescCapDomicilio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object cmbCapDomicilio: TComboBox
              Left = 22
              Top = 18
              Width = 203
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = cmbCapDomicilioChange
              OnKeyDown = cmbIndirizzoDomicilioKeyDown
            end
            object chkSovrascriviCap: TCheckBox
              Left = 236
              Top = 20
              Width = 197
              Height = 17
              Caption = 'Sovrascrivi anche se gi'#224' impostato'
              TabOrder = 1
            end
          end
        end
        object grpComuneDomicilio: TGroupBox
          Left = 11
          Top = 201
          Width = 558
          Height = 100
          TabOrder = 2
          object pnlComuneDomicilio: TPanel
            Left = 2
            Top = 15
            Width = 554
            Height = 83
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object lblComuneSorg: TLabel
              Left = 20
              Top = 0
              Width = 114
              Height = 13
              Caption = 'Selezionare il dato libero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblDescComuneDomicilio: TLabel
              Left = 20
              Top = 44
              Width = 116
              Height = 13
              Caption = 'lblDescComuneDomicilio'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object lblInfoMigrazioneComune: TLabel
              Left = 20
              Top = 65
              Width = 177
              Height = 13
              Caption = 'Importante: il comune verr'#224' codificato'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object cmbComuneDomicilio: TComboBox
              Left = 20
              Top = 18
              Width = 203
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = cmbComuneDomicilioChange
              OnKeyDown = cmbIndirizzoDomicilioKeyDown
            end
            object chkSovrascriviComune: TCheckBox
              Left = 236
              Top = 20
              Width = 197
              Height = 17
              Caption = 'Sovrascrivi anche se gi'#224' impostato'
              TabOrder = 1
            end
          end
        end
        object chkIndirizzoDomicilio: TCheckBox
          Left = 20
          Top = 22
          Width = 60
          Height = 17
          Caption = 'Indirizzo'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = chkIndirizzoDomicilioClick
        end
        object chkCapDomicilio: TCheckBox
          Left = 20
          Top = 109
          Width = 45
          Height = 17
          Caption = 'CAP'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = chkCapDomicilioClick
        end
        object chkComuneDomicilio: TCheckBox
          Left = 20
          Top = 199
          Width = 60
          Height = 17
          Caption = 'Comune'
          Checked = True
          State = cbChecked
          TabOrder = 5
          OnClick = chkComuneDomicilioClick
        end
      end
    end
    object tabCestino: TTabSheet
      Caption = 'Cestino'
      ImageIndex = 9
      DesignSize = (
        597
        313)
      object lblFunzione: TLabel
        Left = 3
        Top = 6
        Width = 46
        Height = 13
        Caption = 'Funzione:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object cmbFiltrotabelle: TComboBox
        Left = 55
        Top = 3
        Width = 259
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = cmbFiltrotabelleChange
      end
      object dGrdCestino: TDBGrid
        Left = 3
        Top = 30
        Width = 591
        Height = 281
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dsrI025
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        PopupMenu = ppMnuCestino
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object tabAllineaTimb: TTabSheet
      Caption = 'Allineamento timbrature'
      ImageIndex = 10
      object dgrdTimbUguali: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 37
        Width = 591
        Height = 273
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'AUTOMATICO'
            Title.Alignment = taCenter
            Title.Caption = 'Automatico'
            Title.Color = clBlue
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'D_NOMINATIVO'
            Title.Caption = 'Nominativo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MATRICOLA'
            Title.Caption = 'Matricola'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DATA'
            Title.Alignment = taCenter
            Title.Caption = 'Data'
            Title.Color = clBlue
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'D_ORA1'
            Title.Alignment = taCenter
            Title.Caption = 'Timbratura 1'
            Title.Color = clBlue
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'D_ORA2'
            Title.Alignment = taCenter
            Title.Caption = 'Timbratura 2'
            Title.Color = clBlue
            Width = 100
            Visible = True
          end>
      end
      object pnlAllineaTimbTop: TPanel
        Left = 0
        Top = 0
        Width = 597
        Height = 34
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object btnRefreshAllTimb: TBitBtn
          Left = 3
          Top = 5
          Width = 93
          Height = 25
          Caption = 'Aggiorna'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFF2FFFFFFFFFFFFFF22FFFFFFFFFFFFF222222FFFFFFFFFFF22FFF
            2FFFFFFFFFFF2FFF2FFFFFFFFFFFFFFF2FFFFFFFFFFFFFFF2FFFFFFF2FFFFFFF
            FFFFFFFF2FFFFFFFFFFFFFFF2FFF2FFFFFFFFFFF2FFF22FFFFFFFFFFF222222F
            FFFFFFFFFFFF22FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFFFFFFFFF}
          TabOrder = 0
          OnClick = btnRefreshAllTimbClick
        end
      end
    end
    object tabAllegatiIter: TTabSheet
      Caption = 'Download allegati iter'
      ImageIndex = 11
      object pnlFiltro: TPanel
        Left = 0
        Top = 0
        Width = 597
        Height = 30
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        object btnFiltro: TButton
          Left = 486
          Top = 3
          Width = 99
          Height = 23
          Caption = 'Aggiorna filtro'
          TabOrder = 0
          Visible = False
          OnClick = btnFiltroClick
        end
        object chkFiltroAnagrafe: TCheckBox
          Left = 10
          Top = 6
          Width = 213
          Height = 17
          Caption = 'Filtra sulla selezione anagrafica corrente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = chkFiltroAnagrafeClick
        end
      end
      object dbgT960: TDBGrid
        Left = 0
        Top = 30
        Width = 597
        Height = 251
        Align = alClient
        DataSource = B022FUtilityGestDocumentaleDM.dsrT960
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Panel4: TPanel
        Left = 0
        Top = 281
        Width = 597
        Height = 32
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 2
        DesignSize = (
          597
          32)
        object lblNuovoPathStorage: TLabel
          Left = 10
          Top = 8
          Width = 98
          Height = 13
          Caption = 'Cartella di download:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtNuovoPath: TEdit
          Left = 118
          Top = 5
          Width = 427
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          Text = 'C:\TEMP\'
        end
        object btnNuovoPath: TButton
          Left = 565
          Top = 5
          Width = 20
          Height = 21
          Hint = 'Scelta causali'
          Anchors = [akTop, akRight]
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnNuovoPathClick
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 436
    Width = 605
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object BitVideo: TBitBtn
      Left = 32
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Esegui'
      Default = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
        8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
        3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
        FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
        FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
      TabOrder = 0
      OnClick = BtnEseguiClick
    end
    object BtnClose: TBitBtn
      Left = 490
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 1
    end
    object btnAnomalie: TBitBtn
      Left = 336
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Anomalie'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000333333333933333333333333333833333333000033333BFB999BFB333333
        333F3F080F3F333300003333BFBF393FBFB33333337F7F383F7F73330000333B
        FBFBFBFBFBFB33333FFFFFF7FFF7FF3300003333BFBFB9BFBFB33333337F7F78
        7F7FF3330000333BFBFBF98BFBFB333337FFF7F887FFF733000033BFBFBFB99F
        BFBFB333FF7FFFF08FFF7FF3000033FBFBFBFB99FBFB3333F7FFF7F780F7FF33
        000033BFBF88BF899FBFB333FFFF88FF808F7F730000333BFB99FB899BFB3333
        37F7087F8887FF3300003333BF998F899FB3333333FF888F880F73330000333B
        FBF99999FBFB33333FF7F08080FFFF3300003333BFBF999FBFB33333337FFF80
        8F7F7333000033333B3BFBFB3B333333333F37FFF73F3333000033333333BFB3
        33333333333333FF733333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnAnomalieClick
    end
    object btnLog: TBitBtn
      Left = 181
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Log'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C000FFFFC0C0C000FFFF00FFFFC0C0C07F7F7F7F7F7F7F7F7F00
        FFFF00FFFF7F7F7F7F7F7F7F7F7F7F7F7F00FFFF00FFFFC0C0C0C0C0C0C0C0C0
        00FFFF0000000000000000000000000000000000000000000000000000000000
        0000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000FFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C000FFFF00FFFF00FFFF000000FFFFFF00000000000000
        0000000000FFFFFF000000FFFFFF00000000FFFF00FFFFC0C0C0C0C0C000FFFF
        00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        0000FFFF00FFFF00FFFFC0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000BFBFBFFF
        FFFF000000FFFFFF00000000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000C0C0C000FFFF00FF
        FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF00000000000000000000000000
        0000000000C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C000FFFF
        00FFFFC0C0C0C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C0C0C0
        C000FFFF00FFFFC0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
        FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF}
      TabOrder = 3
      OnClick = btnLogClick
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 605
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 605
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 605
      Height = 24
      ExplicitWidth = 605
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
  object Panel2: TPanel
    Left = 0
    Top = 24
    Width = 605
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object LblDaData: TLabel
      Left = 164
      Top = 11
      Width = 51
      Height = 13
      Caption = 'LblDaData'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblAData: TLabel
      Left = 409
      Top = 11
      Width = 44
      Height = 13
      Caption = 'LblAData'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object TBBDaData: TBitBtn
      Left = 68
      Top = 6
      Width = 90
      Height = 25
      HelpContext = 83001
      Caption = 'Dalla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7F37F3709F79F79F7FF7FF077F77F77F7FF7FF7077777777777
        777077777777777777770FF7FF7FF7FF7FF07FF7FF7FF7FF7FF709F79F79F79F
        79F077F77F77F77F77F7077777777777777077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7FF7FF709F79F79F79F79F077F77F77F77F77F7077777777777
        777077777777777777770FFFFF7FF7FF7FF07F33337FF7FF7FF70FFFFF79F79F
        79F07FFFFF77F77F77F700000000000000007777777777777777CCCCCC8888CC
        CCCC777777FFFF777777CCCCCCCCCCCCCCCC7777777777777777}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = TBBDaDataClick
    end
    object TBBAData: TBitBtn
      Left = 313
      Top = 6
      Width = 90
      Height = 25
      HelpContext = 83001
      Caption = 'Alla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333FFFFFFFFFFFFFFF000000000000000077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7F37F3709F79F79F7FF7FF077F77F77F7FF7FF7077777777777
        777077777777777777770FF7FF7FF7FF7FF07FF7FF7FF7FF7FF709F79F79F79F
        79F077F77F77F77F77F7077777777777777077777777777777770FF7FF7FF7FF
        7FF07FF7FF7FF7FF7FF709F79F79F79F79F077F77F77F77F77F7077777777777
        777077777777777777770FFFFF7FF7FF7FF07F33337FF7FF7FF70FFFFF79F79F
        79F07FFFFF77F77F77F700000000000000007777777777777777CCCCCC8888CC
        CCCC777777FFFF777777CCCCCCCCCCCCCCCC7777777777777777}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = BtnADataClick
    end
  end
  object rgTest: TRadioGroup
    Left = 472
    Top = 8
    Width = 129
    Height = 45
    Caption = 'Funzioni complete'
    Color = clGradientInactiveCaption
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'SI'
      'NO')
    ParentBackground = False
    ParentColor = False
    TabOrder = 6
    Visible = False
    OnClick = rgTestClick
  end
  object PopupMenu1: TPopupMenu
    Left = 484
    Top = 1
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
  end
  object DlgApriScript: TOpenDialog
    Filter = 'SQL|*.sql|Tutti i file|*.*'
    Left = 552
    Top = 1
  end
  object dsrI025: TDataSource
    OnDataChange = dsrI025DataChange
    Left = 400
    Top = 32
  end
  object ppMnuCestino: TPopupMenu
    OnPopup = ppMnuCestinoPopup
    Left = 464
    Top = 16
    object Ripristina1: TMenuItem
      Caption = 'Ripristina'
      OnClick = Ripristina1Click
    end
    object Cancella1: TMenuItem
      Caption = 'Cancella'
      OnClick = Cancella1Click
    end
  end
end
