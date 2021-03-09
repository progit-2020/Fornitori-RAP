﻿object Bc06FMonitorB006: TBc06FMonitorB006
  Left = 0
  Top = 0
  HelpContext = 9906000
  Caption = '<Bc06> Monitor B006'
  ClientHeight = 537
  ClientWidth = 1059
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 1059
    Height = 42
    ButtonHeight = 36
    ButtonWidth = 79
    EdgeBorders = [ebBottom]
    Flat = False
    Images = ImageList1
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    object ToolButton3: TToolButton
      Left = 0
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton1: TToolButton
      Left = 8
      Top = 0
      Action = actStartMonitoraggio
      Caption = 'Start'
    end
    object ToolButton2: TToolButton
      Left = 87
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 95
      Top = 0
      Action = actStopMonitoraggio
      Caption = 'Stop'
    end
    object ToolButton10: TToolButton
      Left = 174
      Top = 0
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object ToolButton9: TToolButton
      Left = 182
      Top = 0
      Action = actControllaOra
    end
    object ToolButton5: TToolButton
      Left = 261
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton6: TToolButton
      Left = 269
      Top = 0
      Action = actConfigurazione
      ImageIndex = 6
    end
    object ToolButton7: TToolButton
      Left = 348
      Top = 0
      Width = 8
      Caption = 'ToolButton7'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton11: TToolButton
      Left = 356
      Top = 0
      Action = actLogAttività
    end
    object ToolButton12: TToolButton
      Left = 435
      Top = 0
      Width = 8
      Caption = 'ToolButton12'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object ToolButton8: TToolButton
      Left = 443
      Top = 0
      Action = actChiudi
    end
    object ToolButton14: TToolButton
      Left = 522
      Top = 0
      Width = 8
      Caption = 'ToolButton14'
      ImageIndex = 7
      Style = tbsSeparator
    end
    object actServizio: TToolButton
      Left = 530
      Top = 0
      Caption = 'Servizio'
      DropdownMenu = popmnuServizio
      ImageIndex = 2
    end
  end
  object grpUltimoControllo: TGroupBox
    Left = 0
    Top = 73
    Width = 1059
    Height = 464
    Align = alClient
    Caption = 'Ultimo controllo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object splSplitter: TSplitter
      Left = 2
      Top = 144
      Width = 1055
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 219
    end
    object dgrdInfoControllo: TDBGrid
      Left = 2
      Top = 15
      Width = 1055
      Height = 129
      Align = alTop
      DataSource = Bc06FMonitorB006DtM.dsrInfoControlli
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      PopupMenu = ppmDG
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dgrdInfoControlloDrawColumnCell
    end
    object pnlLog: TPanel
      Left = 2
      Top = 147
      Width = 1055
      Height = 315
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Splitter2: TSplitter
        Left = 361
        Top = 0
        Width = 2
        Height = 315
        ExplicitLeft = 346
      end
      object grpLogControllo: TGroupBox
        Left = 0
        Top = 0
        Width = 361
        Height = 315
        Align = alLeft
        Caption = 'Log controllo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object memLogControllo: TMemo
          Left = 2
          Top = 15
          Width = 357
          Height = 279
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object pnlPulsantiLog: TPanel
          Left = 2
          Top = 294
          Width = 357
          Height = 19
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnSvuotaLog: TButton
            Left = 295
            Top = 0
            Width = 62
            Height = 19
            Align = alRight
            Caption = 'Svuota'
            TabOrder = 0
            OnClick = btnSvuotaLogClick
          end
        end
      end
      object pnlMsg: TPanel
        Left = 363
        Top = 0
        Width = 692
        Height = 315
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object pgcMsgControllo: TPageControl
          Left = 0
          Top = 41
          Width = 692
          Height = 274
          ActivePage = tbsMsg1
          Align = alClient
          TabOrder = 0
          object tbsMsg1: TTabSheet
            Caption = 'Messaggi elaborazione (1)'
            object memMsg1: TMemo
              Left = 0
              Top = 0
              Width = 684
              Height = 246
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              ScrollBars = ssBoth
              TabOrder = 0
            end
          end
          object tbsMsg2: TTabSheet
            Caption = 'Messaggi elaborazione (2)'
            ImageIndex = 1
            object memMsg2: TMemo
              Left = 0
              Top = 0
              Width = 684
              Height = 246
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ReadOnly = True
              ScrollBars = ssBoth
              TabOrder = 0
            end
          end
        end
        object pnlFiltroUtente: TPanel
          Left = 0
          Top = 0
          Width = 692
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 1
          object lblTipo: TLabel
            Left = 302
            Top = 12
            Width = 20
            Height = 13
            Caption = 'Tipo'
          end
          object Label1: TLabel
            Left = 402
            Top = 12
            Width = 38
            Height = 13
            Caption = 'Azienda'
          end
          inline frmInputPeriodo: TfrmInputPeriodo
            Left = 0
            Top = 0
            Width = 298
            Height = 41
            Align = alLeft
            Color = clBtnFace
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentBackground = False
            ParentColor = False
            ParentFont = False
            TabOrder = 0
            ExplicitWidth = 298
            ExplicitHeight = 41
            inherited lblFine: TLabel
              Left = 134
              ExplicitLeft = 134
            end
            inherited edtInizio: TMaskEdit
              OnEnter = frmInputPeriodoedtInizioEnter
              OnExit = frmInputPeriodoedtInizioExit
            end
            inherited edtFine: TMaskEdit
              Left = 149
              OnEnter = frmInputPeriodoedtFineEnter
              OnExit = frmInputPeriodoedtFineExit
              ExplicitLeft = 149
            end
            inherited btnIndietro: TBitBtn
              Left = 251
              OnClick = frmInputPeriodobtnIndietroClick
              ExplicitLeft = 251
            end
            inherited btnAvanti: TBitBtn
              Left = 273
              OnClick = frmInputPeriodobtnAvantiClick
              ExplicitLeft = 273
            end
            inherited btnDataInizio: TBitBtn
              OnClick = frmInputPeriodobtnDataInizioClick
            end
            inherited btnDataFine: TBitBtn
              Left = 220
              OnClick = frmInputPeriodobtnDataFineClick
              ExplicitLeft = 220
            end
          end
          object cmbTipo: TComboBox
            Left = 324
            Top = 9
            Width = 68
            Height = 21
            ItemIndex = 0
            TabOrder = 1
            Text = '<TUTTI>'
            OnChange = cmbTipoChange
            Items.Strings = (
              '<TUTTI>'
              'I'
              'A')
          end
          object btnAnnullaFiltro: TButton
            Left = 612
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Annulla filtro'
            TabOrder = 2
            OnClick = btnControllaOraDB
          end
          object cmbAzienda: TComboBox
            Left = 442
            Top = 9
            Width = 80
            Height = 21
            TabOrder = 3
            OnChange = cmbTipoChange
          end
          object btnApplicaFiltro: TButton
            Left = 531
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Applica filtro'
            TabOrder = 4
            OnClick = btnApplicaFiltroClick
          end
        end
      end
    end
  end
  object pnlToolbar2: TPanel
    Left = 0
    Top = 42
    Width = 1059
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object pnlStato: TPanel
      Left = 0
      Top = 0
      Width = 313
      Height = 31
      Align = alLeft
      TabOrder = 0
      object lblTitStato: TLabel
        Left = 16
        Top = 8
        Width = 30
        Height = 13
        Caption = 'Stato:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblStato: TLabel
        Left = 95
        Top = 8
        Width = 4
        Height = 13
        Caption = '-'
      end
    end
    object pnlDBLst: TPanel
      Left = 313
      Top = 0
      Width = 746
      Height = 31
      Align = alClient
      TabOrder = 1
      DesignSize = (
        746
        31)
      object lblDBLst: TLabel
        Left = 16
        Top = 8
        Width = 93
        Height = 13
        Caption = 'Database in analisi:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btnDBLst: TButton
        Left = 717
        Top = 3
        Width = 21
        Height = 22
        Anchors = [akTop, akRight]
        Caption = '...'
        TabOrder = 0
        OnClick = btnDBLstClick
      end
      object edtLstDB: TEdit
        Left = 115
        Top = 4
        Width = 600
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Color = cl3DLight
        ReadOnly = True
        TabOrder = 1
        Text = 'edtLstDB'
      end
    end
  end
  object MainMenu: TMainMenu
    Images = ImageList1
    Left = 800
    Top = 120
    object File1: TMenuItem
      Caption = 'File'
      object Configurazione1: TMenuItem
        Action = actConfigurazione
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Chiudi1: TMenuItem
        Action = actChiudi
      end
    end
  end
  object ActionList: TActionList
    Images = ImageList1
    Left = 772
    Top = 120
    object actStartMonitoraggio: TAction
      Caption = 'Start monitoraggio'
      ImageIndex = 0
      OnExecute = actStartMonitoraggioExecute
    end
    object actStopMonitoraggio: TAction
      Caption = 'Stop monitoraggio'
      ImageIndex = 1
      OnExecute = actStopMonitoraggioExecute
    end
    object actConfigurazione: TAction
      Caption = 'Configurazione'
      ImageIndex = 2
      OnExecute = actConfigurazioneExecute
    end
    object actControllaOra: TAction
      Caption = 'Controlla ora'
      ImageIndex = 3
      OnExecute = actControllaOraExecute
    end
    object actLogAttività: TAction
      Caption = 'Log attivit'#224
      ImageIndex = 4
      OnExecute = actLogAttivitàExecute
    end
    object actChiudi: TAction
      Caption = 'Chiudi'
      ImageIndex = 5
      OnExecute = actChiudiExecute
    end
  end
  object ImageList1: TImageList
    Left = 828
    Top = 120
    Bitmap = {
      494C010107000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C60000000000C6C6C60000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      000084000000FF00FF00840084000000000000000000C6C6C600000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF00008400000000000000000000000000000000000000000080000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF00000000000000000000000000FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000080000000
      8000000080000000000000000000000000000000000000FFFF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF00008400000000000000000000000000000000000000000080000000
      8000000080000000800000000000000000000000000000FFFF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF000000000000FFFF0000FFFF00000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000080000000
      80000000800000008000000000000000000000000000C0C0C00000FFFF008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF00008400000000000000000000000000000000000000000080000000
      8000000080000000800000000000000000000000000000000000C0C0C00000FF
      FF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF0000000000FFFF000000000000FFFF
      0000000000008400000000000000000000000000000000000000000080000000
      80000000800000000000000000000000000000000000000000000000000000FF
      FF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF00008400000000000000000000000000000000000000000080000000
      800000000000000000000000000000000000000000000000000000000000C0C0
      C00000FFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000BDBDBD00FFFFFF0000000000FFFFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF0000000000FFFF000000000000FFFF
      0000000000008400000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C00000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      00000000000000000000000000000000000000FFFF0000848400008484000084
      8400008484000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000FFFF00000000000000
      00000000000000000000000000000000000000FFFF0000FFFF00848484008484
      84000084840000000000848484008484840000000000000000000000FF000000
      FF0000000000000000007B7B7B00000000007B7B7B00000000000000FF000000
      FF000000FF0000000000000000000000000000FFFF0000000000000000000000
      00000000000000FFFF00000000000000000000FFFF0000000000008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000008484
      840000848400008484000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000FFFF0000FFFF000000
      000000FFFF000000000000FFFF0000FFFF000000000000FFFF00008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840000FFFF0000FF
      FF000000000000000000000000000000000000FFFF0000000000000000000000
      000000848400000000008484840084848400000000000000FF00000000000000
      FF000000FF000000FF007B7B7B00000000007B7B7B0000000000000000000000
      00000000FF000000FF00000000000000000000000000000000000000000000FF
      FF0000848400008484000000000000FFFF0000FFFF0000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000000084848400848484008484840000FF
      FF0000FFFF0000000000000000000000000000FFFF0000FFFF000084840000FF
      FF0000FFFF000000000000000000000000000000FF000000FF00000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000FFFF0000FFFF000084
      840000FFFF000084840000848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000FFFF0000000000000000000084
      84000000000000FFFF00008484000000000000FFFF000000000000FFFF000084
      840000848400008484000084840000000000000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000008484840000FFFF0000FFFF0000FF
      FF00000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000007B7B7B00000000007B7B7B0000000000000000000000
      0000000000000000FF000000FF00000000000000000000FFFF0000FFFF000084
      8400000000000000000000848400000000000000000000FFFF00000000000084
      8400008484000084840000848400000000007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000008484840000FFFF0000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000000000840000000000000084000000FF00000000000000
      0000000000000000FF000000FF00000000000084840000000000000000000084
      84000000000000848400008484000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      00000000000000000000000000000000000000000000000000008484840000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000FF000000FF00000000000084840000FFFF0000FFFF000000
      000000848400008484000000000000FFFF000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      840000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000FF00000000000000000000FFFF00000000000000000000FF
      FF000000000000FFFF000000000000FFFF0000FFFF0000000000008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000008484840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000FFFF00000000000000000000FFFF00008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF000000000000000000000000000000000000000000000000008484840000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF00000000007B7B7B00000000007B7B7B0000000000000000000000
      FF000000FF000000000000000000000000000084840000848400008484000000
      00000084840000FFFF0000000000008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000000000000000000000000000008484
      840000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000008484000000000000FFFF00008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      00008484840000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FF7E7FCAFFFF0000900101F8FFFF0000
      C003F03BFCFF0000E003F07BDF7F0000E003F053CF3F0000E003F07BC71F0000
      E003F053C30F00000001F07BC38F00008000F053C3C70000E007F02BC7C30000
      E00FF053CFE30000E00FF02BDFF10000E027FFFFFFF00000C073FC0FFFF90000
      9E79FC0FFFFF00007EFEFC0FFFFF0000FF87FFFFF83FFFFF7F03F83FF21FFFFF
      3E01E00F0403F9FF1E00CC476241F0FF8C2084639481F0FF8600A0736003E07F
      020131F90081C07F010338F96040843F00CF3C7984A01E3F83FF3C396801FE1F
      C1FF3C191083FF1F00FF9C0B6A41FF8F807F8C438481FFC7C03FC4670203FFE3
      E0FFE00FF41FFFF8F07FF83FF83FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ppmDG: TPopupMenu
    Images = ImageList1
    Left = 927
    Top = 120
    object Controllaora1: TMenuItem
      Caption = 'Controlla DB'
      ImageIndex = 3
      OnClick = btnControllaOraDB
    end
  end
  object popmnuServizio: TPopupMenu
    Left = 856
    Top = 120
    object Installa: TMenuItem
      Caption = 'Installa'
      OnClick = InstallaClick
    end
    object Disinstalla: TMenuItem
      Caption = 'Disinstalla'
      OnClick = DisinstallaClick
    end
    object MenuItem1: TMenuItem
      Caption = '-'
    end
    object Avvia: TMenuItem
      Caption = 'Avvia'
      OnClick = AvviaClick
    end
    object Arresta: TMenuItem
      Caption = 'Arresta'
      OnClick = ArrestaClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mnuPriority: TMenuItem
      Caption = 'Priorit'#224
      object mnuLowest: TMenuItem
        Tag = 1
        Caption = 'Lowest'
        OnClick = mnuPrioritaClick
      end
      object mnuLower: TMenuItem
        Tag = 2
        Caption = 'Lower'
        OnClick = mnuPrioritaClick
      end
      object mnuNormal: TMenuItem
        Tag = 3
        Caption = 'Normal'
        OnClick = mnuPrioritaClick
      end
      object mnuHigher: TMenuItem
        Tag = 4
        Caption = 'Higher'
        OnClick = mnuPrioritaClick
      end
      object mnuHighest: TMenuItem
        Tag = 5
        Caption = 'Highest'
        OnClick = mnuPrioritaClick
      end
    end
  end
end