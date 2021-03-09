inherited A125FBadgeServizio: TA125FBadgeServizio
  Left = 215
  Top = 134
  Width = 450
  Height = 318
  HelpContext = 125000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A125> Badge di servizio'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 254
    Width = 442
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 442
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 442
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    inherited pnlSelAnagrafe: TPanel
      Width = 442
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 78
    Width = 442
    Height = 176
    Align = alClient
    TabOrder = 3
    object dgrdOreLiquidate: TDBGrid
      Left = 1
      Top = 1
      Width = 440
      Height = 174
      Align = alClient
      DataSource = DButton
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnEditButtonClick = dgrdOreLiquidateEditButtonClick
      Columns = <
        item
          Expanded = False
          FieldName = 'BADGESERV'
          Title.Caption = 'Numero di badge'
          Width = 100
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'DECORRENZA'
          Title.Caption = 'Decorrenza (data ed ora)'
          Width = 125
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'SCADENZA'
          Title.Caption = 'Scadenza (data ed ora)'
          Width = 125
          Visible = True
        end>
    end
  end
  object pnlTitolo: TPanel [4]
    Left = 0
    Top = 53
    Width = 442
    Height = 25
    Align = alTop
    Alignment = taLeftJustify
    Caption = 
      '                                           Assegnazione dei badg' +
      'e di servizio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  inherited MainMenu1: TMainMenu [5]
    Left = 318
    Top = 65532
  end
  inherited DButton: TDataSource [6]
    Left = 346
    Top = 65532
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [7]
    Left = 374
    Top = 65532
  end
  inherited ImageList1: TImageList [8]
    Left = 260
    Top = 65534
  end
  inherited ActionList1: TActionList
    Left = 288
    Top = 65534
  end
end
