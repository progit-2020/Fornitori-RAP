inherited B019FSchedulazione: TB019FSchedulazione
  Left = 217
  Top = 57
  HelpContext = 9019100
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<B019> Schedulazione'
  ClientHeight = 381
  ClientWidth = 792
  ExplicitWidth = 802
  ExplicitHeight = 431
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 131
    Width = 792
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 129
    ExplicitWidth = 114
  end
  inherited StatusBar: TStatusBar
    Top = 363
    Width = 792
    ExplicitTop = 363
    ExplicitWidth = 792
  end
  inherited Panel1: TToolBar
    Width = 792
    Height = 24
    ExplicitWidth = 792
    ExplicitHeight = 24
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 134
    Width = 792
    Height = 229
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    inline frmToolbarFiglio: TfrmToolbarFiglio
      Left = 0
      Top = 0
      Width = 792
      Height = 23
      Align = alTop
      TabOrder = 0
      TabStop = True
      ExplicitWidth = 792
      inherited tlbarFiglio: TToolBar
        Width = 792
        ExplicitWidth = 792
      end
      inherited actlstToolbarFiglio: TActionList
        inherited actTFGenerica1: TAction
          Caption = 'Esegui ora'
          Hint = 'Esegui ora'
          Visible = True
          OnExecute = frmToolbarFiglioactTFGenerica1Execute
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 23
      Width = 792
      Height = 206
      Align = alClient
      Caption = 'Elaborazioni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object dgrdT926: TDBGrid
        Left = 2
        Top = 15
        Width = 788
        Height = 189
        Align = alClient
        DataSource = dsrT926
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = popmnuStampeSchedulate
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnEditButtonClick = dgrdT926EditButtonClick
        Columns = <
          item
            Expanded = False
            FieldName = 'ORDINE'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CODICE_STAMPA'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SELEZIONE'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'DAL'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'AL'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ROTTURA'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'NOME_FILE'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'NOME_LOG'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'SEMAFORO'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'INTESTAZIONE_LOG'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'DETTAGLIO_LOG'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'SQL_AFTER'
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'CMD_AFTER'
            Visible = True
          end>
      end
    end
  end
  object GroupBox1: TGroupBox [4]
    Left = 0
    Top = 24
    Width = 792
    Height = 107
    Align = alTop
    Caption = 'Schedulazioni'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object dGrdSchedulazione: TDBGrid
      Left = 2
      Top = 15
      Width = 788
      Height = 90
      Align = alClient
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
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
          FieldName = 'DESCRIZIONE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAHH'
          Title.Caption = 'Ora'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAYY'
          Title.Caption = 'Anno'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAMM'
          Title.Caption = 'Mese'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATADD'
          Title.Caption = 'Giorno'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'GIORNO'
          PickList.Strings = (
            '1-luned'#236
            '2-marted'#236
            '3-mercoled'#236
            '4-gioved'#236
            '5-venerd'#236
            '6-sabato'
            '7-domenica')
          Title.Caption = 'Giorno Sett.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'D_GIORNO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FUNZIONE_GG'
          Title.Caption = 'Funzione sql'
          Width = 200
          Visible = True
        end>
    end
  end
  inherited DButton: TDataSource
    AutoEdit = True
  end
  object dsrT926: TDataSource
    Left = 8
    Top = 208
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'pdf'
    Filter = 'File pdf (*.pdf)|*.pdf|Tutti i file (*.*)|*.*'
    Left = 40
    Top = 208
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = 'log'
    Filter = 
      'File log (*.log)|*.log|File di testo (*.txt)|*.txt|File di trace' +
      ' (*.trc)|*.trc|Tutti i file (*.*)|*.*'
    Left = 72
    Top = 208
  end
  object SaveDialog3: TSaveDialog
    Filter = 'Tutti i file (*.*)|*.*'
    Left = 104
    Top = 208
  end
  object popmnuStampeSchedulate: TPopupMenu
    Left = 136
    Top = 208
    object Eseguiora1: TMenuItem
      Action = frmToolbarFiglio.actTFGenerica1
    end
  end
end
