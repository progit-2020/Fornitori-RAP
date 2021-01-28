inherited A123FPartecipazioniSindacati: TA123FPartecipazioniSindacati
  Left = 68
  Top = 114
  HelpContext = 123000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A123> Partecipazioni ai sindacati'
  ClientHeight = 346
  ClientWidth = 612
  ExplicitWidth = 628
  ExplicitHeight = 404
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 328
    Width = 612
    ExplicitTop = 328
    ExplicitWidth = 612
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 612
    ExplicitTop = 24
    ExplicitWidth = 612
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 612
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 612
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 612
      Height = 24
      ExplicitWidth = 612
      ExplicitHeight = 24
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object grdIscrizioni: TDBGrid [3]
    Left = 0
    Top = 53
    Width = 612
    Height = 275
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clMaroon
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'DADATA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ADATA'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_SINDACATO'
        PopupMenu = PopupMenu1
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESC_SINDACATO'
        PopupMenu = PopupMenu1
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_ORGANISMO'
        PopupMenu = PopupMenu1
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESC_ORGANISMO'
        PopupMenu = PopupMenu1
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu [4]
    Left = 478
    Top = 25
    inherited File1: TMenuItem
      object Visualizzazione1: TMenuItem [0]
        Caption = 'Visualizzazione'
        OnClick = Visualizzazione1Click
      end
    end
  end
  inherited DButton: TDataSource [5]
    Left = 534
    Top = 25
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [6]
    Left = 506
    Top = 25
  end
  inherited ImageList1: TImageList [7]
    Left = 412
  end
  inherited ActionList1: TActionList
    Left = 440
  end
  object PopupMenu1: TPopupMenu
    Left = 562
    Top = 25
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
