object C009FCopiaSu: TC009FCopiaSu
  Left = 306
  Top = 163
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Duplica elemento'
  ClientHeight = 241
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 200
    Width = 425
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnEsegui: TBitBtn
      Left = 104
      Top = 8
      Width = 100
      Height = 25
      Caption = '&Esegui'
      Default = True
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777808
        87770777777700300077B0777770B33330078B077770BB88308878B0770BB0F8
        330078BB0770B0003088888BB070BB3BB007BBBBBB0700B000778BBB00887700
        777778BBB07777777777778BBB07777777778888BBB07777777778BBBBBB0777
        7777778BBB00007777777778BBB07777777777778BBB07777777}
      TabOrder = 0
      OnClick = btnEseguiClick
    end
    object btnChiudi: TBitBtn
      Left = 220
      Top = 8
      Width = 100
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object grdChiaveElemento: TStringGrid
    Left = 0
    Top = 0
    Width = 425
    Height = 200
    Align = alClient
    ColCount = 2
    DefaultColWidth = 200
    DefaultRowHeight = 16
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goAlwaysShowEditor]
    TabOrder = 1
    OnDrawCell = grdChiaveElementoDrawCell
    OnSelectCell = grdChiaveElementoSelectCell
  end
  object selDati: TOracleDataSet
    Optimize = False
    ReadOnly = True
    Left = 76
    Top = 148
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = selDati
    Left = 116
    Top = 148
  end
  object InsRec: TOracleQuery
    Optimize = False
    Left = 164
    Top = 148
  end
  object selID: TOracleDataSet
    Optimize = False
    ReadOnly = True
    Left = 204
    Top = 148
  end
end
