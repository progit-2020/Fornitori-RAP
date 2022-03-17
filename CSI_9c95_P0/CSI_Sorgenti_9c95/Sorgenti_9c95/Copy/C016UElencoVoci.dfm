object C016FElencoVoci: TC016FElencoVoci
  Left = 285
  Top = 246
  HelpContext = 3201100
  Caption = '<C016> Elenco voci'
  ClientHeight = 257
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object dgrdElencoVoci: TDBGrid
    Left = 0
    Top = 25
    Width = 443
    Height = 200
    Align = alClient
    DataSource = Dsel200
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
    PopupMenu = pmnRicerca
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dgrdElencoVociDblClick
    OnTitleClick = dgrdElencoVociTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'COD_VOCE'
        Title.Alignment = taCenter
        Title.Caption = 'Cod. voce'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_VOCE_SPECIALE'
        Title.Alignment = taCenter
        Title.Caption = 'Speciale'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIZIONE'
        Width = 298
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 225
    Width = 443
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 142
      Top = 4
      Width = 75
      Height = 25
      Kind = bkOK
      TabOrder = 0
      OnClick = dgrdElencoVociDblClick
    end
    object BitBtn2: TBitBtn
      Left = 226
      Top = 4
      Width = 75
      Height = 25
      Kind = bkCancel
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 443
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 2
      Top = 5
      Width = 69
      Height = 13
      Caption = 'Contratto voci:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodContratto: TLabel
      Left = 80
      Top = 6
      Width = 3
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Dsel200: TDataSource
    DataSet = sel200
    Left = 44
    Top = 192
  end
  object pmnRicerca: TPopupMenu
    Left = 156
    Top = 192
    object Testocontenuto1: TMenuItem
      Action = actRicercaTestoContenuto
    end
    object Successivo1: TMenuItem
      Action = actSuccessivo
    end
  end
  object sel200: TOracleDataSet
    SQL.Strings = (
      'SELECT COD_VOCE, COD_VOCE_SPECIALE, DESCRIZIONE'
      'FROM P200_VOCI T1'
      'WHERE COD_CONTRATTO = :CodContratto'
      '  AND DECORRENZA = '
      '  (SELECT MAX(DECORRENZA) FROM P200_VOCI WHERE'
      '    DECORRENZA <= :Decorrenza AND'
      '    COD_CONTRATTO = T1.COD_CONTRATTO AND'
      '    COD_VOCE = T1.COD_VOCE AND'
      '    COD_VOCE_SPECIALE = T1.COD_VOCE_SPECIALE)   ')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000030000001000000043004F0044005F0056004F004300450001000000
      00002200000043004F0044005F0056004F00430045005F005300500045004300
      490041004C004500010000000000160000004400450053004300520049005A00
      49004F004E004500010000000000}
    Left = 15
    Top = 192
    object sel200COD_VOCE: TStringField
      DisplayLabel = 'Cod. Voce'
      DisplayWidth = 7
      FieldName = 'COD_VOCE'
      Required = True
      Size = 5
    end
    object sel200COD_VOCE_SPECIALE: TStringField
      DisplayLabel = 'Cod. Voce Speciale'
      DisplayWidth = 7
      FieldName = 'COD_VOCE_SPECIALE'
      Required = True
      Size = 5
    end
    object sel200DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object ActionList1: TActionList
    Left = 188
    Top = 192
    object actRicercaTestoContenuto: TAction
      Caption = 'Ricerca testo contenuto'
      Hint = 'Ricerca testo contenuto'
      ShortCut = 16454
      OnExecute = actRicercaTestoContenutoExecute
    end
    object actSuccessivo: TAction
      Caption = 'Successivo'
      Hint = 'Elemento successivo'
      ShortCut = 16462
      OnExecute = actRicercaTestoContenutoExecute
    end
  end
end
