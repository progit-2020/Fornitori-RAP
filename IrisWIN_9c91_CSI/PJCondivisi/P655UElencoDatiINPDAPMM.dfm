object P655FElencoDatiINPDAPMM: TP655FElencoDatiINPDAPMM
  Left = 366
  Top = 195
  Width = 487
  Height = 290
  Caption = '<P655> Elenco Dati'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object dgrdElencoCampi: TDBGrid
    Left = 0
    Top = 17
    Width = 479
    Height = 207
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dgrdElencoCampiDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PARTE'
        Title.Caption = 'Parte'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMERO'
        Title.Caption = 'Numero'
        Width = 42
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIZIONE'
        Title.Caption = 'Descrizione'
        Width = 386
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 224
    Width = 479
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 142
      Top = 4
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 226
      Top = 4
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 479
    Height = 17
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
  end
end
