inherited A117FOreLiquidateAnniPrec: TA117FOreLiquidateAnniPrec
  Left = 215
  Top = 134
  HelpContext = 117000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A117> Assestamento ore anni precedenti'
  ClientHeight = 386
  ClientWidth = 726
  ExplicitWidth = 734
  ExplicitHeight = 440
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 368
    Width = 726
    ExplicitTop = 368
    ExplicitWidth = 726
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 726
    ExplicitTop = 24
    ExplicitWidth = 726
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 726
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 726
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 726
      Height = 24
      ExplicitWidth = 726
      ExplicitHeight = 24
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
    Top = 53
    Width = 726
    Height = 315
    Align = alClient
    TabOrder = 3
    object dgrdOreLiquidate: TDBGrid
      Left = 1
      Top = 1
      Width = 724
      Height = 313
      Align = alClient
      DataSource = DButton
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = dgrdOreLiquidateDrawColumnCell
      OnEditButtonClick = dgrdOreLiquidateEditButtonClick
      Columns = <
        item
          Expanded = False
          FieldName = 'ANNO'
          Title.Caption = 'Anno ore residue'
          Width = 85
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'DATA'
          Title.Caption = 'Mese liq.'
          Width = 58
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ORE_LIQUIDATE'
          Title.Caption = 'Ore liquidate'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VARIAZIONE_ORE'
          Title.Caption = 'Variazione saldo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OREPERSE'
          PickList.Strings = (
            'N'
            'S')
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OREPERSE_TOT'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OREPERSE_RES'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOTE'
          Title.Caption = 'Note'
          Visible = True
        end>
    end
  end
  inherited MainMenu1: TMainMenu [4]
    Left = 318
    Top = 65532
  end
  inherited DButton: TDataSource [5]
    Left = 346
    Top = 65532
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [6]
    Left = 374
    Top = 65532
  end
  inherited ImageList1: TImageList [7]
    Left = 260
    Top = 65534
  end
  inherited ActionList1: TActionList
    Left = 288
    Top = 65534
  end
end
