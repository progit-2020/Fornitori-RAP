object A100FDistanzeChilometriche: TA100FDistanzeChilometriche
  Left = 0
  Top = 0
  Caption = '<A100> Distanze chilometriche'
  ClientHeight = 343
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object dGrdDistanze: TDBGrid
    Left = 0
    Top = 0
    Width = 414
    Height = 281
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick]
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnColEnter = dGrdDistanzeColEnter
    OnTitleClick = dGrdDistanzeTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PARTENZA'
        Title.Caption = 'Partenza'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESTINAZIONE'
        Title.Caption = 'Destinazione'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHILOMETRI'
        Title.Caption = 'Km'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO1'
        Title.Caption = 'Tipo Part.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOCALITA1'
        Title.Caption = 'Cod.Partenza'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO2'
        Title.Caption = 'Tipo Dest.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOCALITA2'
        Title.Caption = 'Cod.Destinazione'
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 281
    Width = 414
    Height = 62
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOk: TBitBtn
      Left = 122
      Top = 31
      Width = 75
      Height = 25
      Caption = 'Ok'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnOkClick
    end
    object BtnAnnulla: TBitBtn
      Left = 214
      Top = 31
      Width = 75
      Height = 25
      Caption = 'Annulla'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object chkAndataRitorno: TCheckBox
      Left = 8
      Top = 8
      Width = 177
      Height = 17
      Caption = 'Inserisci il tragitto andata-ritorno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 224
    Top = 160
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Ricercatestocontenuto1: TMenuItem
      Action = actRicercaTestoContenuto
    end
    object Successivo2: TMenuItem
      Action = actSuccessivo
    end
  end
  object ActionList1: TActionList
    Left = 228
    Top = 192
    object actRicercaTestoContenuto: TAction
      Caption = 'Ricerca testo contenuto'
      Hint = 'Ricerca testo contenuto'
      ShortCut = 16454
      OnExecute = Ricercatestocontenuto1Click
    end
    object actSuccessivo: TAction
      Caption = 'Successivo'
      Hint = 'Elemento successivo'
      ShortCut = 16462
      OnExecute = Ricercatestocontenuto1Click
    end
  end
end
