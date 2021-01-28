object A022FMaggiorazioni: TA022FMaggiorazioni
  Left = 192
  Top = 214
  HelpContext = 2134
  BorderStyle = bsDialog
  Caption = '<A022> Fasce di maggiorazione'
  ClientHeight = 257
  ClientWidth = 604
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 604
    Height = 233
    Align = alClient
    DataSource = A022FContrattiDtM1.D210
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyDown = DBGrid1KeyDown
  end
  object Panel1: TPanel
    Left = 0
    Top = 233
    Width = 604
    Height = 24
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 250
      Top = 0
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 332
      Top = 0
      Width = 75
      Height = 25
      Caption = 'Annulla'
      TabOrder = 1
      Kind = bkCancel
    end
    object EMaggiorazioni: TDBLookupComboBox
      Left = 0
      Top = 2
      Width = 215
      Height = 21
      DropDownWidth = 300
      KeyField = 'Codice'
      ListField = 'Codice;Descrizione'
      ListSource = A022FContrattiDtM1.D210
      TabOrder = 2
      OnKeyDown = EMaggiorazioniKeyDown
    end
  end
end
