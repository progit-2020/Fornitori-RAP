object A023FGestTimbra: TA023FGestTimbra
  Left = 151
  Top = 103
  ActiveControl = EOra
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = '<A023> Dati timbratura'
  ClientHeight = 204
  ClientWidth = 353
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 45
    Width = 57
    Height = 13
    Caption = 'Ora:(hh:mm)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 6
    Top = 121
    Width = 41
    Height = 13
    Caption = 'Causale:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LCausale: TDBText
    Left = 82
    Top = 144
    Width = 263
    Height = 13
    DataField = 'Descrizione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 6
    Top = 76
    Width = 51
    Height = 13
    Caption = 'Rilevatore:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LData: TLabel
    Left = 138
    Top = 8
    Width = 29
    Height = 13
    Caption = 'LData'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 7
    Top = 9
    Width = 26
    Height = 13
    Caption = 'Data:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblDescOrologio: TLabel
    Left = 82
    Top = 96
    Width = 263
    Height = 13
    AutoSize = False
    Caption = 'lblDescOrologio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object BitBtn1: TBitBtn
    Left = 102
    Top = 169
    Width = 75
    Height = 25
    Caption = '&Registra'
    Default = True
    Glyph.Data = {
      BE060000424DBE06000000000000360400002800000024000000120000000100
      0800000000008802000000000000000000000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000B17A5800DCC3
      B400000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000EDE1DA00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00030303030303
      0303030303030303030303030303030303030303030303030303030303030303
      03030303030303030303030303030303030303030303FF030303030303030303
      03030303030303040403030303030303030303030303030303F8F8FF03030303
      03030303030303030303040202040303030303030303030303030303F80303F8
      FF030303030303030303030303040202020204030303030303030303030303F8
      03030303F8FF0303030303030303030304020202020202040303030303030303
      0303F8030303030303F8FF030303030303030304020202FA0202020204030303
      0303030303F8FF0303F8FF030303F8FF03030303030303020202FA03FA020202
      040303030303030303F8FF03F803F8FF0303F8FF03030303030303FA02FA0303
      03FA0202020403030303030303F8FFF8030303F8FF0303F8FF03030303030303
      FA0303030303FA0202020403030303030303F80303030303F8FF0303F8FF0303
      0303030303030303030303FA0202020403030303030303030303030303F8FF03
      03F8FF03030303030303030303030303FA020202040303030303030303030303
      0303F8FF0303F8FF03030303030303030303030303FA02020204030303030303
      03030303030303F8FF0303F8FF03030303030303030303030303FA0202020403
      030303030303030303030303F8FF0303F8FF03030303030303030303030303FA
      0202040303030303030303030303030303F8FF03F8FF03030303030303030303
      03030303FA0202030303030303030303030303030303F8FFF803030303030303
      030303030303030303FA0303030303030303030303030303030303F803030303
      0303030303030303030303030303030303030303030303030303030303030303
      0303}
    NumGlyphs = 2
    TabOrder = 6
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 186
    Top = 169
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Glyph.Data = {
      BE060000424DBE06000000000000360400002800000024000000120000000100
      0800000000008802000000000000000000000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000B17A5800DCC3
      B400000000000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000000000000000EDE1DA00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0003F8F8F8F8F8
      F8F8F8F80707FF07FF07F807FFF8F8F8F8F8F8F8F8F8F8030303030303FF0404
      0404040000F8F8F8FFFFFF0404040404F8F8F8F8F8F8F8F8F8F8FF030303FFFF
      F8FF0303030304FD05000007FFFFFF0403030303F8F8F8F8F8F8F8F8F8F80303
      03F8F8F8F8FF030303030405FD0500FFFFFFFF040303030303030303F8FFF8F8
      F8FF030303F8FF0303FF0303030304FD05FD00FFFFFFFF040303030303030303
      F8F807F8F8FF030303F8FF0303FF030303030405FD0500FFFEFFFE0403030303
      03030303F8FFF807F8FF030303F8FF0303FF0303030304FD05FD00FFFFFFFF04
      0303030303030303F8F807F8F8FF030303F8FF0303FF030303030405FD0500FF
      FEFFFE040303030303030303F8FFF807F8FF030303F8FF0303FF0303030304FD
      05FD00FFFFFFFF040303030303030303F8F807F8F8FF030303F8FF0303FF0303
      03030405FD0500FFFEFFFE040303030303030303F8FFF807F8FF030303F8FF03
      03FF0303030304FD05FD00FEFFFEFF040303030303030303F8F807F8F8FF0303
      03F8FF0303FF030303030405FD0500FFFEFFFE040303030303030303F8FFF807
      F8FF030303F8FF0303FF0303030304FD05FD00FEFFFEFF040303030303030303
      F8F807F8F8FF030303F8FF0303FF030303030404040404040404040403030303
      03030303F8FFF8FFF8FFFFFFFFF8FF0303FF0303030303030303030303030303
      0303030303030303F8F8F8F8F8F8F8F8F8F8030303FF03030303030300000000
      000003030303030303030303030303FFFFFFFFFFFF03030303FF030303030303
      00FAFAFAFA00030303030303030303030303F8F8F8F8F8F8FF03030303FF0303
      03030303000000000000030303030303030303030303F8FFFFFFFFF8FF030303
      03FF}
    NumGlyphs = 2
    TabOrder = 7
    OnClick = BitBtn2Click
  end
  object ECausale: TDBLookupComboBox
    Left = 81
    Top = 118
    Width = 75
    Height = 21
    DataField = 'Causale'
    DropDownWidth = 300
    KeyField = 'Codice'
    ListField = 'Codice;Descrizione'
    PopupMenu = PopupMenu1
    TabOrder = 4
    OnKeyDown = dcmbKeyDown
  end
  object RadioGroup2: TRadioGroup
    Left = 161
    Top = 108
    Width = 183
    Height = 31
    Caption = 'Tipo causale'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Presenza'
      'Giustificazione')
    ParentFont = False
    TabOrder = 5
    TabStop = True
    OnClick = RadioGroup2Click
  end
  object EOra: TDBEdit
    Left = 81
    Top = 40
    Width = 50
    Height = 21
    DataField = 'Ora'
    MaxLength = 8
    TabOrder = 1
  end
  object DBRadioGroup1: TDBRadioGroup
    Left = 161
    Top = 30
    Width = 183
    Height = 31
    Caption = 'Verso'
    Columns = 2
    DataField = 'Verso'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Items.Strings = (
      'Entrata'
      'Uscita')
    ParentFont = False
    TabOrder = 2
    Values.Strings = (
      'E'
      'U')
  end
  object EData: TSpinEdit
    Left = 81
    Top = 7
    Width = 50
    Height = 22
    MaxLength = 2
    MaxValue = 31
    MinValue = 1
    TabOrder = 0
    Value = 1
  end
  object DBLookupRilevatore: TDBLookupComboBox
    Left = 81
    Top = 71
    Width = 50
    Height = 21
    DataField = 'Rilevatore'
    DropDownWidth = 300
    KeyField = 'CODICE'
    ListField = 'CODICE;DESCRIZIONE'
    PopupMenu = PopupMenu1
    TabOrder = 3
    OnKeyDown = dcmbKeyDown
  end
  object PopupMenu1: TPopupMenu
    Left = 280
    Top = 65534
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
