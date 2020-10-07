inherited A072FBuoniMese: TA072FBuoniMese
  Left = 195
  Top = 233
  HelpContext = 72000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A072> Riepilogo buoni pasto/ticket'
  ClientWidth = 538
  ExplicitWidth = 554
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Width = 538
    ExplicitWidth = 476
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 538
    ExplicitTop = 24
    ExplicitWidth = 476
  end
  object DBGrid1: TDBGrid [2]
    Left = 0
    Top = 53
    Width = 538
    Height = 362
    Align = alClient
    DataSource = DButton
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = DBGrid1EditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ANNO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MESE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CALCMESE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BUONIPASTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VARBUONIPASTO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TICKET'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VARTICKET'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'NOTE'
        Visible = True
      end>
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [3]
    Left = 0
    Top = 0
    Width = 538
    Height = 24
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitWidth = 476
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 538
      Height = 24
      ExplicitWidth = 476
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      Left = 212
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  inherited MainMenu1: TMainMenu [4]
  end
  inherited DButton: TDataSource [5]
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [6]
  end
  inherited ImageList1: TImageList [7]
  end
end
