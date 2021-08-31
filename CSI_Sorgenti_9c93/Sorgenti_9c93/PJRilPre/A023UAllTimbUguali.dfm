object A023FAllTimbUguali: TA023FAllTimbUguali
  Left = 0
  Top = 0
  HelpContext = 23500
  Caption = '<A023> Allineamento timbrature uguali'
  ClientHeight = 283
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grpTimbrature: TGroupBox
    Left = 0
    Top = 62
    Width = 441
    Height = 221
    Align = alClient
    Caption = 'Timbrature da allineare'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object dgrdTimbUguali: TDBGrid
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 431
      Height = 198
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      PopupMenu = pmnAzioniTabella
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
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 441
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object grpPeriodo: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 286
      Height = 56
      Align = alLeft
      Caption = 'Periodo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblMese: TLabel
        Left = 152
        Top = 28
        Width = 35
        Height = 13
        Caption = 'lblMese'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblDal: TLabel
        Left = 11
        Top = 28
        Width = 15
        Height = 13
        Caption = 'Dal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblAl: TLabel
        Left = 88
        Top = 28
        Width = 8
        Height = 13
        Caption = 'al'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object sedtDal: TSpinEdit
        Left = 36
        Top = 25
        Width = 41
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 2
        MaxValue = 31
        MinValue = 1
        ParentFont = False
        TabOrder = 0
        Value = 1
        OnChange = sedtDalChange
      end
      object sedtAl: TSpinEdit
        Left = 105
        Top = 25
        Width = 41
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 2
        MaxValue = 31
        MinValue = 1
        ParentFont = False
        TabOrder = 1
        Value = 1
        OnChange = sedtAlChange
      end
    end
    object btnOk: TBitBtn
      Left = 302
      Top = 6
      Width = 131
      Height = 25
      Caption = 'Scambio automatico'
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
      TabOrder = 1
    end
    object btnCancel: TBitBtn
      Left = 302
      Top = 34
      Width = 132
      Height = 25
      Caption = 'Chiudi'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  object ActionList1: TActionList
    Left = 259
    object actScambiaTimb: TAction
      Caption = 'Scambia timbrature'
      Hint = 'Scambia timbrature'
      OnExecute = actScambiaTimbExecute
    end
  end
  object pmnAzioniTabella: TPopupMenu
    Left = 136
    Top = 136
    object mnuScambiaTimbrature: TMenuItem
      Action = actScambiaTimb
    end
  end
end
