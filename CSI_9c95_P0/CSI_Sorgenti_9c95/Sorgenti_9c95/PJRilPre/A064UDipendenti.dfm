object A064FDipendenti: TA064FDipendenti
  Left = 0
  Top = 0
  Caption = '<A064> Elenco dipendenti selezionati'
  ClientHeight = 286
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object dgrdRiepilogoAnagr: TDBGrid
    Left = 0
    Top = 0
    Width = 562
    Height = 245
    Align = alClient
    DataSource = A064FBudgetStraordinarioDtM.dsrV430
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgMultiSelect]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'MATRICOLA'
        Title.Caption = 'Matricola'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COGNOME'
        Title.Caption = 'Cognome'
        Width = 220
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Width = 220
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 245
    Width = 562
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BChiudi: TBitBtn
      Left = 241
      Top = 8
      Width = 85
      Height = 25
      Caption = '&Chiudi'
      TabOrder = 0
      Kind = bkClose
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 57
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
    object MenuItem1: TMenuItem
      Caption = '-'
    end
    object Copia2: TMenuItem
      Caption = 'Copia'
      OnClick = Copia2Click
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = Copia2Click
    end
  end
end
