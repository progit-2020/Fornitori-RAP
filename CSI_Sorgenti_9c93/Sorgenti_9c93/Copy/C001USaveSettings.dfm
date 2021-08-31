object C001FSaveForm: TC001FSaveForm
  Left = 264
  Top = 243
  HelpContext = 1001000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<C001> Salva impostazioni'
  ClientHeight = 180
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LblNomeStampa: TLabel
    Left = 4
    Top = 129
    Width = 65
    Height = 13
    Caption = 'Nome stampa'
  end
  object LblDescr: TLabel
    Left = 112
    Top = 129
    Width = 55
    Height = 13
    Caption = 'Descrizione'
  end
  object BitBtn1: TBitBtn
    Left = 348
    Top = 145
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 426
    Top = 145
    Width = 75
    Height = 25
    Caption = '&Annulla'
    TabOrder = 1
    Kind = bkCancel
  end
  object EdtNomeStampa: TEdit
    Left = 2
    Top = 148
    Width = 102
    Height = 21
    MaxLength = 10
    TabOrder = 2
  end
  object EdtDescr: TEdit
    Left = 110
    Top = 148
    Width = 229
    Height = 21
    MaxLength = 40
    TabOrder = 3
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 505
    Height = 125
    Align = alTop
    DataSource = C001FFiltroTabelleDTM.D900
    Options = [dgTitles, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = PopupMenu1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NOMESTAMPA'
        Title.Caption = 'NOME STAMPA                         '
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIZIONE'
        Title.Caption = 
          'DESCRIZIONE                                                     ' +
          '                             '
        Visible = True
      end>
  end
  object DBMemo1: TDBMemo
    Left = 0
    Top = 179
    Width = 505
    Height = 1
    Align = alBottom
    DataSource = C001FFiltroTabelleDTM.D900
    ScrollBars = ssBoth
    TabOrder = 5
    Visible = False
    WordWrap = False
  end
  object PopupMenu1: TPopupMenu
    Left = 208
    Top = 136
    object Delete1: TMenuItem
      Caption = 'Delete'
      OnClick = Delete1Click
    end
  end
end
