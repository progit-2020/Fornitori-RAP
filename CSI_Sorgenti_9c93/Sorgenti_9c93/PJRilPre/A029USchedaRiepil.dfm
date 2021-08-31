inherited A029FSchedaRiepil: TA029FSchedaRiepil
  Left = 124
  Top = 147
  HelpContext = 29000
  ActiveControl = PageControl1
  Caption = '<A029> Scheda riepilogativa'
  ClientHeight = 412
  ClientWidth = 736
  ExplicitWidth = 746
  ExplicitHeight = 462
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 394
    Width = 736
    Panels = <
      item
        Text = 'Data'
        Width = 130
      end
      item
        Text = 'Records'
        Width = 100
      end
      item
        Width = 150
      end
      item
        Width = 50
      end>
    ExplicitTop = 394
    ExplicitWidth = 736
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 736
    Height = 27
    ExplicitTop = 24
    ExplicitWidth = 736
    ExplicitHeight = 27
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 51
    Width = 736
    Height = 17
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 2
    object Label11: TLabel
      Left = 120
      Top = 2
      Width = 57
      Height = 13
      Caption = 'Contratto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LData: TLabel
      Left = 4
      Top = 2
      Width = 90
      Height = 13
      Caption = 'Novembre 2999'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label33: TLabel
      Left = 388
      Top = 2
      Width = 55
      Height = 13
      Caption = 'Part time:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LPartTime: TLabel
      Left = 444
      Top = 2
      Width = 9
      Height = 13
      Caption = 'pt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LContratto: TLabel
      Left = 180
      Top = 2
      Width = 9
      Height = 13
      Caption = 'ct'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object PageControl1: TPageControl [3]
    Left = 0
    Top = 68
    Width = 736
    Height = 326
    ActivePage = TabSheet4
    Align = alClient
    TabOrder = 3
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Saldi'
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 0
        Width = 728
        Height = 185
        HorzScrollBar.Visible = False
        VertScrollBar.Visible = False
        Align = alTop
        BorderStyle = bsNone
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 728
          Height = 121
          Align = alTop
          BevelOuter = bvNone
          Ctl3D = True
          ParentCtl3D = False
          TabOrder = 0
          object Label1: TLabel
            Left = 0
            Top = 0
            Width = 61
            Height = 13
            Caption = 'Debito.contr.'
            FocusControl = DBEdit1
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label21: TLabel
            Left = 144
            Top = 0
            Width = 58
            Height = 13
            Caption = 'Ore lavorate'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label17: TLabel
            Left = 73
            Top = 0
            Width = 59
            Height = 13
            Caption = 'Debito mese'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label18: TLabel
            Left = 448
            Top = 0
            Width = 55
            Height = 13
            Caption = 'Saldo mese'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label22: TLabel
            Left = 533
            Top = 38
            Width = 88
            Height = 13
            Caption = 'Saldo complessivo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label20: TLabel
            Left = 293
            Top = 0
            Width = 40
            Height = 13
            Caption = 'Assenza'
            FocusControl = DBEdit18
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 226
            Top = 0
            Width = 44
            Height = 13
            Caption = 'Presenza'
            FocusControl = DBEdit18
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label31: TLabel
            Left = 226
            Top = 38
            Width = 116
            Height = 13
            Caption = 'Recupero anno corrente'
            FocusControl = DBEdit4
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label32: TLabel
            Left = 73
            Top = 38
            Width = 131
            Height = 13
            Caption = 'Recupero anno precedente'
            FocusControl = DBEdit5
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label35: TLabel
            Left = 0
            Top = 38
            Width = 67
            Height = 13
            Caption = 'Scost.negativi'
            FocusControl = DBEdit8
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label36: TLabel
            Left = 362
            Top = 38
            Width = 81
            Height = 13
            Caption = 'Saldo anno prec.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label37: TLabel
            Left = 448
            Top = 38
            Width = 78
            Height = 13
            Caption = 'Saldo anno corr.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label38: TLabel
            Left = 533
            Top = 0
            Width = 82
            Height = 13
            Caption = 'Saldo mese prec.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label39: TLabel
            Left = 0
            Top = 76
            Width = 46
            Height = 13
            Caption = 'Ore perse'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label40: TLabel
            Left = 144
            Top = 76
            Width = 70
            Height = 13
            Caption = 'Ore addebitate'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label48: TLabel
            Left = 226
            Top = 76
            Width = 66
            Height = 13
            Caption = 'Comp.escluso'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label51: TLabel
            Left = 73
            Top = 76
            Width = 59
            Height = 13
            Caption = 'Ore troncate'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblLiqOreAnniPrec: TLabel
            Left = 448
            Top = 76
            Width = 69
            Height = 13
            Caption = 'Saldo liquidato'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblVariazioneSaldo: TLabel
            Left = 362
            Top = 76
            Width = 77
            Height = 13
            Caption = 'Variazione saldo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label67: TLabel
            Left = 363
            Top = 0
            Width = 70
            Height = 13
            Caption = 'Ore rese INAIL'
            FocusControl = dedtOreInail
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object DBEdit1: TDBEdit
            Left = 0
            Top = 16
            Width = 60
            Height = 21
            DataField = 'DEBITOORARIO'
            DataSource = DButton
            TabOrder = 0
          end
          object EOreLavorate: TEdit
            Left = 144
            Top = 16
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 2
          end
          object EDebitoCompl: TEdit
            Left = 73
            Top = 16
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 1
            Text = 'EOreLavorate'
          end
          object ESaldoMese: TEdit
            Left = 448
            Top = 16
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 6
            Text = 'EOreLavorate'
          end
          object ESaldoAnno: TEdit
            Left = 533
            Top = 52
            Width = 57
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 15
            Text = 'EOreLavorate'
          end
          object DBEdit18: TDBEdit
            Left = 292
            Top = 16
            Width = 60
            Height = 21
            TabStop = False
            Color = cl3DLight
            DataField = 'OREASSENZE'
            DataSource = DButton
            TabOrder = 4
          end
          object EOrePresenza: TEdit
            Left = 226
            Top = 16
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 3
          end
          object DBEdit4: TDBEdit
            Left = 226
            Top = 52
            Width = 60
            Height = 21
            Color = cl3DLight
            DataField = 'RECANNOCORR'
            DataSource = DButton
            TabOrder = 11
          end
          object DBEdit5: TDBEdit
            Left = 73
            Top = 52
            Width = 60
            Height = 21
            Color = cl3DLight
            DataField = 'RECANNOPREC'
            DataSource = DButton
            TabOrder = 9
          end
          object DBEdit8: TDBEdit
            Left = 0
            Top = 52
            Width = 60
            Height = 21
            DataField = 'SCOSTNEG'
            DataSource = DButton
            TabOrder = 8
          end
          object ESaldoAnnoPrec: TEdit
            Left = 362
            Top = 52
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 13
            Text = 'ESaldoAnnoPrec'
          end
          object ESaldoAnnoCorr: TEdit
            Left = 448
            Top = 52
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 14
            Text = 'Edit1'
          end
          object EMesePrec: TEdit
            Left = 533
            Top = 16
            Width = 57
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 7
            Text = 'EOreLavorate'
          end
          object EOrePerse: TEdit
            Left = 0
            Top = 90
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 16
          end
          object EOreAddebitate: TEdit
            Left = 144
            Top = 90
            Width = 73
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 18
          end
          object edtOreEsclComp: TEdit
            Left = 226
            Top = 90
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 19
          end
          object DBEdit9: TDBEdit
            Left = 144
            Top = 52
            Width = 60
            Height = 21
            Color = cl3DLight
            DataField = 'RECLIQPREC'
            DataSource = DButton
            TabOrder = 10
          end
          object DBEdit16: TDBEdit
            Left = 291
            Top = 52
            Width = 60
            Height = 21
            Color = cl3DLight
            DataField = 'RECLIQCORR'
            DataSource = DButton
            TabOrder = 12
          end
          object edtOreTroncate: TEdit
            Left = 73
            Top = 90
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 17
          end
          object edtlblLiqOreAnniPrec: TEdit
            Left = 448
            Top = 90
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 22
          end
          object edtlblVariazioneSaldo: TEdit
            Left = 362
            Top = 90
            Width = 60
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 20
          end
          object btnOreLiqAnniPrec: TBitBtn
            Left = 422
            Top = 90
            Width = 15
            Height = 21
            Hint = 'Accedi assestamento ore anni precedenti'
            Caption = '...'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 21
            OnClick = btnOreLiqAnniPrecClick
          end
          object BitBtn2: TBitBtn
            Left = 532
            Top = 88
            Width = 60
            Height = 25
            Action = actSaldiMobili
            Caption = 'Saldi mobili'
            TabOrder = 23
          end
          object dedtOreInail: TDBEdit
            Left = 363
            Top = 16
            Width = 60
            Height = 21
            DataField = 'ORE_INAIL'
            DataSource = DButton
            TabOrder = 5
          end
        end
        object GroupBox1: TGroupBox
          Left = 5
          Top = 113
          Width = 357
          Height = 57
          Caption = 'Dati in fasce'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          TabOrder = 1
          object Shape1: TShape
            Left = 13
            Top = 37
            Width = 78
            Height = 19
            Brush.Color = cl3DLight
            Pen.Color = clGray
          end
          object Shape2: TShape
            Left = 90
            Top = 37
            Width = 51
            Height = 19
            Brush.Color = cl3DLight
            Pen.Color = clGray
          end
          object Shape3: TShape
            Left = 282
            Top = 37
            Width = 54
            Height = 19
            Brush.Color = cl3DLight
            Pen.Color = clGray
          end
          object DBLookupComboBox1: TDBLookupComboBox
            Left = 139
            Top = 36
            Width = 73
            Height = 21
            DataField = 'CAUSALE1MINASS'
            DataSource = DButton
            DropDownWidth = 300
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyField = 'CODICE'
            ListField = 'CODICE;DESCRIZIONE'
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnKeyDown = DBLookupComboBox1KeyDown
            OnMouseMove = DBLookupComboBox1MouseMove
          end
          object HeaderControl1: THeaderControl
            Left = 2
            Top = 17
            Width = 334
            Height = 19
            Align = alNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Sections = <
              item
                AllowClick = False
                ImageIndex = -1
                MaxWidth = 12
                MinWidth = 12
                Width = 12
              end
              item
                AllowClick = False
                ImageIndex = -1
                MaxWidth = 77
                MinWidth = 77
                Text = 'Fascia (%)'
                Width = 77
              end
              item
                AllowClick = False
                ImageIndex = -1
                MaxWidth = 50
                MinWidth = 50
                Text = 'Ore lav.'
                Width = 50
              end
              item
                Alignment = taCenter
                AllowClick = False
                ImageIndex = -1
                MaxWidth = 141
                MinWidth = 141
                Text = 'Ore assestamento'
                Width = 141
              end
              item
                AllowClick = False
                ImageIndex = -1
                MaxWidth = 54
                MinWidth = 54
                Text = 'Totale'
                Width = 54
              end>
            ParentFont = False
          end
          object DBLookupComboBox2: TDBLookupComboBox
            Left = 210
            Top = 36
            Width = 73
            Height = 21
            DataField = 'CAUSALE2MINASS'
            DataSource = DButton
            DropDownWidth = 300
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            KeyField = 'CODICE'
            ListField = 'CODICE;DESCRIZIONE'
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnKeyDown = DBLookupComboBox1KeyDown
            OnMouseMove = DBLookupComboBox1MouseMove
          end
        end
      end
      object DBGFasce: TDBGrid
        Left = 5
        Top = 170
        Width = 357
        Height = 101
        Options = [dgEditing, dgIndicator, dgColLines, dgRowLines, dgTabs]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Color = cl3DLight
            Expanded = False
            FieldName = 'D_Fascia'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ORELAVORATE'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ORE1ASSEST'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ORE2ASSEST'
            Width = 70
            Visible = True
          end
          item
            Color = cl3DLight
            Expanded = False
            FieldName = 'Totale'
            Visible = True
          end>
      end
      object Panel4: TPanel
        Left = 0
        Top = 276
        Width = 728
        Height = 22
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object SGFasce: TStringGrid
          Left = 5
          Top = 0
          Width = 356
          Height = 22
          Color = cl3DLight
          ColCount = 6
          DefaultColWidth = 11
          DefaultRowHeight = 18
          RowCount = 1
          FixedRows = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
          ParentFont = False
          TabOrder = 0
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 185
        Width = 4
        Height = 91
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 3
      end
      object GroupBox4: TGroupBox
        Left = 365
        Top = 185
        Width = 256
        Height = 109
        Caption = 'Debito aggiuntivo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
        object Label2: TLabel
          Left = 8
          Top = 19
          Width = 44
          Height = 13
          Caption = 'Del mese'
          FocusControl = DBEdit2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label23: TLabel
          Left = 85
          Top = 20
          Width = 67
          Height = 13
          Caption = 'Da inizio anno'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 158
          Top = 20
          Width = 39
          Height = 13
          Caption = 'Residuo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label24: TLabel
          Left = 8
          Top = 57
          Width = 70
          Height = 13
          Caption = 'Reso nel mese'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label74: TLabel
          Left = 85
          Top = 57
          Width = 70
          Height = 13
          Caption = 'Reso nell'#39'anno'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DBEdit2: TDBEdit
          Left = 8
          Top = 33
          Width = 57
          Height = 21
          DataField = 'DEBITOPO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object DBCheckBox1: TDBCheckBox
          Left = 136
          Top = -2
          Width = 105
          Height = 17
          Caption = 'Gestione anticipo'
          Color = clBtnFace
          DataField = 'TIPOPO'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          ValueChecked = '1'
          ValueUnchecked = '0'
          Visible = False
        end
        object EDebPOAnno: TEdit
          Left = 85
          Top = 34
          Width = 57
          Height = 21
          TabStop = False
          AutoSize = False
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          Text = 'EDebPOAnno'
        end
        object EResiduoPOAnno: TEdit
          Left = 158
          Top = 34
          Width = 57
          Height = 21
          TabStop = False
          AutoSize = False
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          Text = 'EResiduoPOAnno'
        end
        object EResoPOMese: TEdit
          Left = 8
          Top = 71
          Width = 57
          Height = 21
          TabStop = False
          AutoSize = False
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
          Text = 'EResoPOMese'
        end
        object EResoPOAnno: TEdit
          Left = 85
          Top = 71
          Width = 57
          Height = 21
          TabStop = False
          AutoSize = False
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          Text = 'EResoPOAnno'
        end
      end
      object GroupBox12: TGroupBox
        Left = 365
        Top = 113
        Width = 256
        Height = 70
        Caption = 'Riposi compensativi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        object Label5: TLabel
          Left = 8
          Top = 14
          Width = 38
          Height = 13
          Caption = 'Maturati'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label56: TLabel
          Left = 142
          Top = 14
          Width = 42
          Height = 13
          Caption = 'Abbattuti'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 194
          Top = 14
          Width = 27
          Height = 13
          Caption = 'Saldo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label66: TLabel
          Left = 59
          Top = 14
          Width = 72
          Height = 13
          Caption = 'Riposi non fruiti'
          FocusControl = DBEdit17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblRipComFasce: TLabel
          Left = 10
          Top = 51
          Width = 134
          Height = 13
          Caption = 'Riposi compensativi in fasce'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Visible = False
        end
        object DBEdit22: TDBEdit
          Left = 10
          Top = 29
          Width = 47
          Height = 21
          Color = cl3DLight
          DataField = 'RIPCOM'
          DataSource = DButton
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edtSaldoRipCom: TEdit
          Left = 194
          Top = 29
          Width = 57
          Height = 21
          TabStop = False
          AutoSize = False
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object edtRiposiNonFruiti: TEdit
          Left = 59
          Top = 29
          Width = 78
          Height = 21
          TabStop = False
          AutoSize = False
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object edtAbbRipComMes: TEdit
          Left = 143
          Top = 29
          Width = 47
          Height = 21
          TabStop = False
          AutoSize = False
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Indennit'#224
      object ScrollBox3: TScrollBox
        Left = 0
        Top = 0
        Width = 728
        Height = 138
        Align = alTop
        BorderStyle = bsNone
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        object PIndennita: TGroupBox
          Left = 302
          Top = 0
          Width = 426
          Height = 138
          Align = alClient
          Caption = 'Ore lavorate in turno'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object GIndennita: TDBGrid
            Left = 2
            Top = 15
            Width = 422
            Height = 121
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
            ParentFont = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Color = cl3DLight
                Expanded = False
                FieldName = 'D_Fascia'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'OREINDTURNO'
                Visible = True
              end>
          end
        end
        object GroupBox2: TGroupBox
          Left = 187
          Top = 0
          Width = 115
          Height = 138
          Align = alLeft
          Caption = 'Riepilogo turni'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object Label13: TLabel
            Left = 6
            Top = 32
            Width = 10
            Height = 13
            Caption = '1'#176
            FocusControl = DBEdit11
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 62
            Top = 32
            Width = 10
            Height = 13
            Caption = '2'#176
            FocusControl = DBEdit12
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 7
            Top = 87
            Width = 10
            Height = 13
            Caption = '3'#176
            FocusControl = DBEdit13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label16: TLabel
            Left = 65
            Top = 87
            Width = 10
            Height = 13
            Caption = '4'#176
            FocusControl = DBEdit14
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object DBEdit11: TDBEdit
            Left = 22
            Top = 30
            Width = 30
            Height = 21
            DataField = 'TURNI1'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object DBEdit12: TDBEdit
            Left = 78
            Top = 30
            Width = 30
            Height = 21
            DataField = 'TURNI2'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object DBEdit13: TDBEdit
            Left = 23
            Top = 85
            Width = 30
            Height = 21
            DataField = 'TURNI3'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object DBEdit14: TDBEdit
            Left = 79
            Top = 85
            Width = 30
            Height = 21
            DataField = 'TURNI4'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
        end
        object Panel11: TPanel
          Left = 0
          Top = 0
          Width = 187
          Height = 138
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 2
          object GroupBox18: TGroupBox
            Left = 0
            Top = 82
            Width = 187
            Height = 56
            Align = alBottom
            TabOrder = 1
            object LIndennita: TLabel
              Left = 6
              Top = 0
              Width = 101
              Height = 13
              Caption = 'Indennit'#224' di turno'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label8: TLabel
              Left = 6
              Top = 16
              Width = 37
              Height = 13
              Caption = 'Numero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label70: TLabel
              Left = 48
              Top = 16
              Width = 37
              Height = 13
              Caption = '(variaz.)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label9: TLabel
              Left = 95
              Top = 16
              Width = 17
              Height = 13
              Caption = 'Ore'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label71: TLabel
              Left = 142
              Top = 16
              Width = 37
              Height = 13
              Caption = '(variaz.)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object dedtIndTurnoNum: TDBEdit
              Left = 6
              Top = 30
              Width = 40
              Height = 21
              DataField = 'INDTURNONUM'
              DataSource = DButton
              TabOrder = 0
            end
            object dedtIndTurnoNumVar: TDBEdit
              Left = 48
              Top = 30
              Width = 40
              Height = 21
              DataField = 'INDTURNONUM_VAR'
              DataSource = DButton
              TabOrder = 1
            end
            object dedIndTurnoOre: TDBEdit
              Left = 95
              Top = 30
              Width = 45
              Height = 21
              DataField = 'INDTURNOORE'
              DataSource = DButton
              TabOrder = 2
            end
            object dedIndTurnoOreVar: TDBEdit
              Left = 141
              Top = 30
              Width = 40
              Height = 21
              DataField = 'INDTURNOORE_VAR'
              DataSource = DButton
              TabOrder = 3
            end
          end
          object GroupBox17: TGroupBox
            Left = 0
            Top = 0
            Width = 187
            Height = 81
            Align = alTop
            TabOrder = 0
            object Label29: TLabel
              Left = 5
              Top = -1
              Width = 96
              Height = 13
              Caption = 'Indennit'#224' festive'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label27: TLabel
              Left = 6
              Top = 15
              Width = 27
              Height = 13
              Caption = 'Intere'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label68: TLabel
              Left = 48
              Top = 15
              Width = 37
              Height = 13
              Caption = '(variaz.)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label28: TLabel
              Left = 95
              Top = 15
              Width = 34
              Height = 13
              Caption = 'Ridotte'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label69: TLabel
              Left = 134
              Top = 15
              Width = 37
              Height = 13
              Caption = '(variaz.)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object Label77: TLabel
              Left = 6
              Top = 55
              Width = 96
              Height = 13
              Caption = 'Festivit'#224' non godute'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
            end
            object dedtFestivIntera: TDBEdit
              Left = 6
              Top = 31
              Width = 40
              Height = 21
              DataField = 'FESTIVINTERA'
              DataSource = DButton
              TabOrder = 0
            end
            object dedtFestivInteraVar: TDBEdit
              Left = 48
              Top = 31
              Width = 40
              Height = 21
              DataField = 'FESTIVINTERA_VAR'
              DataSource = DButton
              TabOrder = 1
            end
            object dedtFestivRidotta: TDBEdit
              Left = 95
              Top = 31
              Width = 40
              Height = 21
              DataField = 'FESTIVRIDOTTA'
              DataSource = DButton
              TabOrder = 2
            end
            object dedtFestivRidottaVar: TDBEdit
              Left = 141
              Top = 31
              Width = 40
              Height = 21
              DataField = 'FESTIVRIDOTTA_VAR'
              DataSource = DButton
              TabOrder = 3
            end
            object dedtRiposiNonFruiti: TDBEdit
              Left = 141
              Top = 53
              Width = 40
              Height = 21
              DataField = 'RIPOSI_NONFRUITI'
              DataSource = DButton
              TabOrder = 4
            end
          end
        end
      end
      object Panel10: TPanel
        Left = 0
        Top = 138
        Width = 728
        Height = 160
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Splitter1: TSplitter
          Left = 401
          Top = 0
          Height = 160
          ExplicitLeft = 448
          ExplicitTop = 104
          ExplicitHeight = 100
        end
        object GroupBox7: TGroupBox
          Left = 404
          Top = 0
          Width = 324
          Height = 160
          Align = alClient
          Caption = 'Dati accessori'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          object dgrdDatiScheda: TDBGrid
            Left = 2
            Top = 15
            Width = 320
            Height = 143
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs]
            ParentFont = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Color = cl3DLight
                Expanded = False
                FieldName = 'DESCRIZIONE'
                Visible = True
              end
              item
                Color = cl3DLight
                Expanded = False
                FieldName = 'VALORE_AUT'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'VALORE_MAN'
                Visible = True
              end>
          end
        end
        object GroupBox16: TGroupBox
          Left = 0
          Top = 0
          Width = 401
          Height = 160
          Align = alLeft
          Caption = 'Indennit'#224' di presenza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object DBGrid4: TDBGrid
            Left = 2
            Top = 15
            Width = 397
            Height = 143
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
            ParentFont = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnDblClick = DBGrid4DblClick
          end
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Straordinario'
      object DBGStraord: TDBGrid
        Left = 0
        Top = 176
        Width = 728
        Height = 101
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clRed
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Color = cl3DLight
            Expanded = False
            FieldName = 'D_Fascia'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OREECCEDGIORN'
            Visible = True
          end
          item
            Color = cl3DLight
            Expanded = False
            FieldName = 'StrMese'
            Visible = True
          end
          item
            Color = cl3DLight
            Expanded = False
            FieldName = 'ORESTRAORDLIQ'
            ReadOnly = True
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'LIQUIDNELMESE'
            Visible = True
          end
          item
            Color = cl3DLight
            Expanded = False
            FieldName = 'StrAnnoAut'
            Visible = True
          end
          item
            Color = cl3DLight
            Expanded = False
            FieldName = 'StrAnnoLiq'
            Visible = True
          end
          item
            Color = cl3DLight
            Expanded = False
            FieldName = 'StrDaLiq'
            Width = 59
            Visible = True
          end>
      end
      object ScrollBox2: TScrollBox
        Left = 0
        Top = 0
        Width = 728
        Height = 176
        HorzScrollBar.Visible = False
        Align = alTop
        BorderStyle = bsNone
        TabOrder = 1
        object Label19: TLabel
          Left = 6
          Top = 4
          Width = 212
          Height = 13
          Caption = 'Variazione manuale all'#39'eccedenza liquidabile:'
          FocusControl = DBEdit17
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label34: TLabel
          Left = 4
          Top = 32
          Width = 210
          Height = 13
          Caption = 'Liquidazioni fatte entro la disponibilit'#224' annua:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblLiquidStrBloccata: TLabel
          Left = 421
          Top = 147
          Width = 72
          Height = 26
          Caption = 'Liquidazione bloccata'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clTeal
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
          WordWrap = True
        end
        object Label52: TLabel
          Left = 380
          Top = 4
          Width = 163
          Height = 13
          Caption = 'Straordinario liquidato fuori budget:'
          FocusControl = DBEdit20
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label63: TLabel
          Left = 274
          Top = 4
          Width = 37
          Height = 13
          Caption = 'residua:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DBEdit17: TDBEdit
          Left = 220
          Top = 2
          Width = 46
          Height = 21
          DataField = 'OREVARIAZECC'
          DataSource = DButton
          TabOrder = 0
        end
        object BitBtn1: TBitBtn
          Left = 4
          Top = 146
          Width = 125
          Height = 27
          Caption = 'Liquidazione automatica'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnClick = BitBtn1Click
        end
        object GroupBox5: TGroupBox
          Left = 4
          Top = 49
          Width = 489
          Height = 44
          Caption = 'Limiti delle eccedenze orarie'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object Label44: TLabel
            Left = 7
            Top = 19
            Width = 86
            Height = 13
            Caption = 'Liquidabile annuo:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label45: TLabel
            Left = 146
            Top = 19
            Width = 91
            Height = 13
            Alignment = taRightJustify
            Caption = 'Liquidabile mensile:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label25: TLabel
            Left = 301
            Top = 19
            Width = 96
            Height = 13
            Caption = 'Residuabile mensile:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object EStrAutAnn: TEdit
            Left = 96
            Top = 16
            Width = 46
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Text = 'EOreLavorate'
          end
          object EStrAutMen: TEdit
            Left = 239
            Top = 16
            Width = 57
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            Text = 'EOreLavorate'
          end
          object EEccResAutMen: TEdit
            Left = 400
            Top = 16
            Width = 57
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            Text = 'EEccResAutMen'
          end
          object btnLimitiIndividuali: TButton
            Left = 462
            Top = 14
            Width = 22
            Height = 25
            Caption = '...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = btnLimitiIndividualiClick
          end
        end
        object edtLiquidazioniAnnue: TEdit
          Left = 220
          Top = 29
          Width = 46
          Height = 21
          TabStop = False
          AutoSize = False
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          Text = 'EOreLavorate'
        end
        object DBEdit20: TDBEdit
          Left = 546
          Top = 2
          Width = 46
          Height = 21
          Color = cl3DLight
          DataField = 'LIQ_FUORI_BUDGET'
          DataSource = DButton
          TabOrder = 2
        end
        object GroupBox3: TGroupBox
          Left = 496
          Top = 49
          Width = 128
          Height = 127
          Caption = 'Ecc.compensabile'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          object Label12: TLabel
            Left = 4
            Top = 20
            Width = 73
            Height = 13
            Caption = 'Maturata mese:'
            FocusControl = DBEdit10
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 4
            Top = 83
            Width = 72
            Height = 13
            Caption = 'Maturata anno:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label30: TLabel
            Left = 4
            Top = 106
            Width = 69
            Height = 13
            Caption = 'Residua anno:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label64: TLabel
            Left = 4
            Top = 42
            Width = 62
            Height = 13
            Caption = 'Causalizzata:'
            FocusControl = DBEdit25
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label72: TLabel
            Left = 5
            Top = 62
            Width = 70
            Height = 13
            Caption = 'Residua mese:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object DBEdit10: TDBEdit
            Left = 78
            Top = 17
            Width = 44
            Height = 21
            DataField = 'OREECCEDCOMP'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object EEccCompAnno: TEdit
            Left = 78
            Top = 82
            Width = 44
            Height = 20
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
            Text = 'EOreLavorate'
          end
          object EEccResidua: TEdit
            Left = 78
            Top = 103
            Width = 44
            Height = 20
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            Text = 'EOreLavorate'
          end
          object DBEdit25: TDBEdit
            Left = 78
            Top = 39
            Width = 44
            Height = 21
            DataField = 'OREECCEDCOMPOLTRESOGLIA'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object EEccCompMese: TEdit
            Left = 78
            Top = 61
            Width = 44
            Height = 20
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            Text = 'EOreLavorate'
          end
        end
        object GroupBox13: TGroupBox
          Left = 4
          Top = 98
          Width = 489
          Height = 44
          Caption = 'Liquidabile autorizzato oltre i limiti'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          object Label7: TLabel
            Left = 142
            Top = 19
            Width = 100
            Height = 13
            Alignment = taRightJustify
            Caption = 'Straordinario esterno:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label57: TLabel
            Left = 7
            Top = 19
            Width = 81
            Height = 13
            Alignment = taRightJustify
            Caption = 'Ore causalizzate:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object EStrEst: TEdit
            Left = 244
            Top = 16
            Width = 46
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            Text = 'EOreLavorate'
          end
          object edtOreCausalizzateEsterneLiq: TEdit
            Left = 90
            Top = 16
            Width = 46
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Text = 'EOreLavorate'
          end
        end
        object edtVarEccLiqAnno: TEdit
          Left = 315
          Top = 2
          Width = 46
          Height = 21
          TabStop = False
          AutoSize = False
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object btnLiquidazioniAnnue: TBitBtn
          Left = 268
          Top = 28
          Width = 15
          Height = 21
          Hint = 'Accedi assestamento ore anni precedenti'
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = btnLiquidazioniAnnueClick
        end
      end
      object Panel9: TPanel
        Left = 0
        Top = 277
        Width = 728
        Height = 21
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel9'
        TabOrder = 2
        object SGStraord: TStringGrid
          Left = 0
          Top = 0
          Width = 728
          Height = 21
          Align = alClient
          Color = cl3DLight
          ColCount = 9
          DefaultColWidth = 11
          DefaultRowHeight = 16
          RowCount = 1
          FixedRows = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
          ParentFont = False
          TabOrder = 0
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Straordinario esterno/Banca ore'
      object GroupBox10: TGroupBox
        Left = 0
        Top = 0
        Width = 728
        Height = 145
        Align = alTop
        Caption = 'Straordinario esterno'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clFuchsia
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object Label42: TLabel
          Left = 452
          Top = 13
          Width = 111
          Height = 13
          Caption = 'Straordinario liquidabile:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label41: TLabel
          Left = 452
          Top = 57
          Width = 131
          Height = 13
          Caption = 'Totale straordinario esterno:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DBGrid1: TDBGrid
          Left = 2
          Top = 15
          Width = 445
          Height = 128
          Align = alLeft
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
        object Edit2: TEdit
          Left = 453
          Top = 30
          Width = 60
          Height = 21
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'Edit1'
        end
        object Edit1: TEdit
          Left = 452
          Top = 73
          Width = 60
          Height = 21
          Color = cl3DLight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = 'Edit1'
        end
      end
      object GroupBox11: TGroupBox
        Left = 0
        Top = 145
        Width = 728
        Height = 153
        Align = alClient
        Caption = 'Banca delle ore'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object Panel7: TPanel
          Left = 2
          Top = 128
          Width = 724
          Height = 23
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object grdTotOreCompensabili: TStringGrid
            Left = 0
            Top = 0
            Width = 157
            Height = 23
            Align = alLeft
            ColCount = 2
            DefaultRowHeight = 17
            RowCount = 1
            FixedRows = 0
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            RowHeights = (
              17)
          end
        end
        object grdOreCompensabili: TStringGrid
          Left = 2
          Top = 15
          Width = 157
          Height = 113
          Align = alLeft
          ColCount = 2
          DefaultRowHeight = 17
          RowCount = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
          ParentFont = False
          TabOrder = 1
        end
        object GroupBox14: TGroupBox
          Left = 164
          Top = 10
          Width = 184
          Height = 140
          Caption = 'Dati mensili'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object Label55: TLabel
            Left = 6
            Top = 81
            Width = 46
            Height = 13
            Caption = 'Liquidata:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label58: TLabel
            Left = 6
            Top = 37
            Width = 99
            Height = 13
            Caption = 'Recup. con causale:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblLIquidCompBloccata: TLabel
            Left = 6
            Top = 122
            Width = 125
            Height = 13
            Caption = 'Liquidazione bloccata'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clTeal
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
            WordWrap = True
          end
          object Label73: TLabel
            Left = 6
            Top = 59
            Width = 99
            Height = 13
            Caption = 'Recup. con negativi:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label75: TLabel
            Left = 6
            Top = 15
            Width = 92
            Height = 13
            Caption = 'Da causali escluse:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblBancaOreLiqVar: TLabel
            Left = 7
            Top = 103
            Width = 94
            Height = 13
            Caption = 'Variazione liquidata:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object DBEdit19: TDBEdit
            Left = 117
            Top = 77
            Width = 60
            Height = 21
            DataField = 'ORECOMP_LIQUIDATE'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object DBEdit24: TDBEdit
            Left = 117
            Top = 33
            Width = 60
            Height = 21
            DataField = 'ORECOMP_RECUPERATE'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object edtBancaOreRecInterna: TEdit
            Left = 117
            Top = 55
            Width = 60
            Height = 21
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object edtBancaOreCausEsc: TEdit
            Left = 117
            Top = 11
            Width = 60
            Height = 21
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object dedtBancaOreLiqVar: TDBEdit
            Left = 117
            Top = 99
            Width = 60
            Height = 21
            DataField = 'BANCAORE_LIQ_VAR'
            DataSource = DButton
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
        end
        object GroupBox15: TGroupBox
          Left = 350
          Top = 10
          Width = 269
          Height = 140
          Caption = 'Dati annuali'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object Label53: TLabel
            Left = 6
            Top = 68
            Width = 46
            Height = 13
            Caption = 'Liquidata:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label54: TLabel
            Left = 131
            Top = 68
            Width = 42
            Height = 13
            Caption = 'Residua:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label59: TLabel
            Left = 6
            Top = 44
            Width = 59
            Height = 13
            Caption = 'Recuperata:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label60: TLabel
            Left = 6
            Top = 20
            Width = 45
            Height = 13
            Caption = 'Maturata:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label61: TLabel
            Left = 131
            Top = 20
            Width = 69
            Height = 13
            Caption = 'Residua prec.:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label62: TLabel
            Left = 131
            Top = 44
            Width = 66
            Height = 13
            Caption = 'Residua corr.:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label76: TLabel
            Left = 6
            Top = 99
            Width = 135
            Height = 13
            Caption = 'Maturata da causali escluse:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object edtBancaOreLiquidata: TEdit
            Left = 66
            Top = 64
            Width = 60
            Height = 21
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
          end
          object edtBancaOreResidua: TEdit
            Left = 201
            Top = 64
            Width = 60
            Height = 21
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
          end
          object edtBancaOreRecuperata: TEdit
            Left = 66
            Top = 41
            Width = 60
            Height = 21
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object edtBancaOreMaturata: TEdit
            Left = 66
            Top = 16
            Width = 60
            Height = 21
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
          end
          object edtBancaOreResiduaPrec: TEdit
            Left = 201
            Top = 16
            Width = 60
            Height = 21
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
          end
          object edtBancaOreResiduaCorr: TEdit
            Left = 201
            Top = 39
            Width = 60
            Height = 21
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
          end
          object edtBancaOreCausEscAnno: TEdit
            Left = 201
            Top = 95
            Width = 60
            Height = 21
            Color = cl3DLight
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
          end
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Riep.presenze'
      ImageIndex = 6
      object DBGrid3: TDBGrid
        Left = 0
        Top = 0
        Width = 514
        Height = 93
        Align = alClient
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object Panel5: TPanel
        Left = 0
        Top = 93
        Width = 728
        Height = 205
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 728
          Height = 24
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object Label46: TLabel
            Left = 0
            Top = 6
            Width = 52
            Height = 13
            Caption = 'Dettaglio'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblOreEscluseIncluse: TLabel
            Left = 515
            Top = 6
            Width = 142
            Height = 13
            Caption = 'Esclusa dalle ore normali'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cmbCausPresenza: TComboBox
            Left = 56
            Top = 2
            Width = 363
            Height = 22
            Style = csDropDownList
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cmbCausPresenzaChange
          end
          object btnSaldiMobiliCausale: TBitBtn
            Left = 424
            Top = 0
            Width = 60
            Height = 25
            Action = actSaldiMobiliCausale
            Caption = 'Saldi mobili'
            TabOrder = 1
          end
        end
        object GroupBox8: TGroupBox
          Left = 0
          Top = 24
          Width = 456
          Height = 181
          Align = alClient
          Caption = 'Anno'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object Label43: TLabel
            Left = 8
            Top = 14
            Width = 112
            Height = 13
            Caption = 'Compensabile registrato'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label49: TLabel
            Left = 126
            Top = 14
            Width = 38
            Height = 13
            Caption = 'effettivo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label65: TLabel
            Left = 189
            Top = 14
            Width = 152
            Height = 13
            Caption = 'Recupero da assenza/rip.comp.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGreen
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object grdPresAnnueTot: TStringGrid
            Left = 2
            Top = 156
            Width = 452
            Height = 23
            Align = alBottom
            Color = cl3DLight
            ColCount = 8
            DefaultColWidth = 11
            RowCount = 1
            FixedRows = 0
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            ParentFont = False
            TabOrder = 0
          end
          object edtOreEsclCompAnno: TEdit
            Left = 8
            Top = 28
            Width = 48
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 1
          end
          object edtOreEsclCompAnnoEff: TEdit
            Left = 126
            Top = 28
            Width = 48
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 2
          end
          object grdPresAnnue: TStringGrid
            Left = 2
            Top = 52
            Width = 452
            Height = 104
            Align = alBottom
            Color = cl3DLight
            ColCount = 7
            DefaultColWidth = 11
            DefaultRowHeight = 17
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            ParentFont = False
            TabOrder = 4
          end
          object edtRecuperoAnno: TEdit
            Left = 190
            Top = 28
            Width = 48
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 3
          end
        end
        object GroupBox9: TGroupBox
          Left = 456
          Top = 24
          Width = 272
          Height = 181
          Align = alRight
          Caption = 'Mese'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clTeal
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          object Label47: TLabel
            Left = 4
            Top = 14
            Width = 112
            Height = 13
            AutoSize = False
            Caption = 'Compensabile registrato'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clTeal
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblLiquidazioneBloccata: TLabel
            Left = 4
            Top = 63
            Width = 72
            Height = 26
            Caption = 'Liquidazione bloccata'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clTeal
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object Label50: TLabel
            Left = 119
            Top = 14
            Width = 38
            Height = 13
            Caption = 'effettivo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clTeal
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 176
            Top = 14
            Width = 93
            Height = 13
            Caption = 'Ore gettone residue'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clTeal
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object grdPresLiqTot: TStringGrid
            Left = 119
            Top = 157
            Width = 150
            Height = 22
            Color = cl3DLight
            ColCount = 8
            DefaultColWidth = 11
            RowCount = 1
            FixedRows = 0
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            ParentFont = False
            TabOrder = 0
          end
          object grdPresLiq: TDBGrid
            Left = 119
            Top = 52
            Width = 150
            Height = 104
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
            ParentFont = False
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Color = cl3DLight
                Expanded = False
                FieldName = 'FASCIA'
                Width = 66
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'LIQUIDATO'
                Visible = True
              end>
          end
          object dedtOreEsclCompMese: TDBEdit
            Left = 4
            Top = 28
            Width = 48
            Height = 21
            DataField = 'COMPENSABILE'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnExit = dedtOreEsclCompMeseExit
          end
          object btnAttivaLiquidazione: TBitBtn
            Left = 4
            Top = 91
            Width = 94
            Height = 25
            Caption = 'Attiva liquidazione'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clTeal
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = Creasituazionemensile1Click
          end
          object edtOreEsclCompMeseEff: TEdit
            Left = 119
            Top = 28
            Width = 48
            Height = 21
            TabStop = False
            AutoSize = False
            Color = cl3DLight
            ReadOnly = True
            TabOrder = 4
          end
          object DBEdit23: TDBEdit
            Left = 221
            Top = 28
            Width = 48
            Height = 21
            Color = cl3DLight
            DataField = 'GETTONE_RESIDUO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
            OnExit = dedtOreEsclCompMeseExit
          end
        end
      end
      object DBGrid2: TDBGrid
        Left = 514
        Top = 0
        Width = 214
        Height = 93
        Align = alRight
        Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'VOCEPAGHE'
            Visible = True
          end
          item
            ButtonStyle = cbsNone
            Expanded = False
            FieldName = 'Causale'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ORE'
            Visible = True
          end>
      end
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [4]
    Left = 0
    Top = 0
    Width = 736
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 736
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 736
      Height = 24
      ExplicitWidth = 736
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = TfrmSelAnagrafe1btnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  inherited MainMenu1: TMainMenu [5]
    Left = 411
    Top = 5
    inherited File1: TMenuItem
      object Residuiannoprecedente1: TMenuItem [1]
        Caption = '&Residui anno precedente'
        OnClick = Residuiannoprecedente1Click
      end
      object Situazionebudgetstraordinario1: TMenuItem [2]
        Caption = 'Situazione budget straordinario'
        OnClick = Situazionebudgetstraordinario1Click
      end
      object Parametridiconteggio1: TMenuItem [3]
        Caption = 'Parametri di conteggio'
        OnClick = Parametridiconteggio1Click
      end
      object Recuperimobili1: TMenuItem [4]
        Action = actSaldiMobili
      end
    end
  end
  inherited DButton: TDataSource [6]
    OnDataChange = DButtonDataChange
    Left = 439
    Top = 5
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [7]
    Left = 483
    Top = 5
  end
  inherited ImageList1: TImageList [8]
    Bitmap = {
      494C010117001900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000006000000001002000000000000060
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      00007B7B7B007B7B7B007B7B7B0000FFFF0000FFFF007B7B7B007B7B7B007B7B
      7B007B7B7B0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008400000084000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000FFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000007B7B7B0000000000000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B00000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000FFFF0000FFFF0000FFFF007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000007B7B7B00FFFFFF000000
      FF000000FF000000FF000000FF000000FF00FFFFFF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000000000FF
      FF0000000000000000000000000000000000000000007B7B7B00BDBDBD00FFFF
      FF00BDBDBD000000FF00BDBDBD00FFFFFF00BDBDBD007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008400000000000000000000000000000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF000000000000000000000000007B7B7B007B7B7B00FFFFFF00BDBD
      BD00FFFFFF000000FF00FFFFFF00BDBDBD00FFFFFF007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000084000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF00000000000000000000000000000000007B7B7B00FFFF
      FF00BDBDBD00FFFFFF00BDBDBD00FFFFFF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      00000000000000FFFF0000FFFF00000000000000000000000000000000007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000007B7B
      7B000000000000000000000000007B7B7B000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000008400000084000000FF000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000084
      000000FF000000FF00000000000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000000000000000FF
      000000FF0000000000000000000000FF000000FF000000840000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00000000000000000000000000FFFFFF00000000007B7B7B000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000007B7B7B000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000840084848400848484000000000000000000000000000000
      0000000000008484840084848400000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000008400000000000000
      0000000000000000840000008400848484008484840000000000000000000000
      0000000000000000840000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      0000000000008484840000008400000084008484840000000000000000000000
      0000848484000000840000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000008400000084008484840084848400000000000000
      8400000084008484840000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000000084000000840000008400
      0000840000008400000084000000000000000000000000000000000084000000
      84000000840000008400000000000000000000000000C6C6C60000FFFF008484
      8400000000000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000000084848400000084000000840084848400848484000000
      8400000084000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000C6C6C60000FF
      FF00848484000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000FFFFFF000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000840000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000084000000
      84000000840000000000000000000000000000000000000000000000000000FF
      FF00848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000000000000000848484000000840000008400000084008484
      8400000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000084000000
      840000000000000000000000000000000000000000000000000000000000C6C6
      C60000FFFF00848484000000000000000000000000000000000000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000008484840084848400000084000000840000008400000084008484
      8400848484000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C60000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      0000848484000000840000008400000000000000000084848400000084000000
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      8400000084008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
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
      000000000000000000000000000084848400BDBD0000BDBD0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C60000000000000000000000000000000000000000000000
      000000000000848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      000000000000848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000000000000000
      000000000000FFFFFF0084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000000000000000000000000000000000
      00000000FF00848484008484840084848400BDBD000084848400BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008400000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C600000000000000000000000000000000000000BD000000
      BD000000FF000000FF008484840084848400BDBD000084848400BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF000000000000000000FFFFFF008400
      0000840000008400000084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C6000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF0084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000000000000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000FFFFFF008400000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF008400
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000FF00848484008484840084848400BDBD0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000084000000840000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000848484008484840084848400FFFF0000BDBD0000BDBD0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400FFFF0000BDBD
      0000BDBD0000BDBD0000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400FFFF0000BDBD000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400848484008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000008400000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000084000000FF0000008400000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      000000000000000084000000FF000000FF000000000000000000000000000000
      00000000FF000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      84000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000FF00000084000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF00000084000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      84000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF00000084000000FF00000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008484000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000084848400000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF0000000000840000000000000000000000000000000000
      0000840000008484840084000000000000000000000000000000000000000000
      00000000FF00000084000000FF00000084000000000000000000000000000000
      0000000084000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000848484008400000084000000000000000000000000000000000000000000
      84000000FF00000084000000FF00000000000000000000000000000000000000
      000000000000000084000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000848400008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
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
      0000840000008400000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000840000008400
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000600000000100010000000000000300000000000000000000
      000000000000000000000000FFFFFF00FF7EFFFDFFFF00009001FFF8FF7F0000
      C003FFF1FE7F0000E003FFE3FC0F0000E003FFC7FE770000E003E08FFF770000
      E003C01FFFF700000001803FFFF700008000001FF7FF0000E007001FF7FF0000
      E00F001FF77F0000E00F001FF73F0000E027001FF81F0000C073803FFF3F0000
      9E79C07FFF7F00007EFEE0FFFFFF0000FFFFFFFFFFFF8003FFFFFFFFFFFF8003
      FFFFFFFFFFFF8003FCFFFF3FFFFF8003F8FFFC3FFCFF8003F07FF03FFC3F8003
      E27FC000FC0F8003E63F000000038003FF3FC00000008003FF9FF03F00038003
      FFCFFC3FFC0F8003FFCFFF3FFC3F8003FFE7FFFFFCFF8003FFF3FFFFFFFF8007
      FFFFFFFFFFFF800FFFFFFFFFFFFF801FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFCFF07C1FFFFDFFFDF7F07C1F8F9CFF7CF3F07C1B879C7D5C71F01019873
      C3E3C30F00018C23C181C38F00018407C3E3C3C70001820FC7D5C7C38003860F
      CFF7CFE3C1078807DFFFDFF1C1079183FFFFFFF0E38FBFC1FFFFFFF9E38FFFF3
      FFFFFFFFE38FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFC007FE1FFFFF
      FFFF8003FE07FC01FFFF00010600FC01FCFF0001FE01FC01FC3F0001F8010001
      FC0F0000F801000100030000F001000100008000C00100010003C000C0010003
      FC0FE001C0010007FC3FE007F001000FFCFFF007F80100FFFFFFF003F80101FF
      FFFFF803F80103FFFFFFFFFFF801FFFFF807FFFE847FFFFFF807FBFF00EFFFFF
      F807F1FD31BFFFFFF807F1FB39FFFF3FF807F8F3993FFC3FF807FC67CA1FF03F
      F803FE0FF40FC000FFF3FF1F9C070000FFF1FE0F9603C000F9F1FC6FCB01F03F
      F0F1F0F3FF80FC3FF0F1E1F9F7C0FF3FF9FBE7FCFFE0FFFFEFF3FFFFEFF0FFFF
      FFF7FFFFFFF8FFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF3EFFFEFF7FFF7CFF3CFFFCFF3FFF3CFF38FFF8FF1FFF1CF
      F30FFF0FF0FFF0CFF20FFE0FF07FF04FF30FFF0FF0FFF0CFF38FFF8FF1FFF1CF
      F3CFFFCFF3FFF3CFF3EFFFEFF7FFF7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  inherited ActionList1: TActionList
    object actSaldiMobili: TAction
      Caption = 'Riepilogo saldi mobili'
      OnExecute = actSaldiMobiliExecute
    end
    object actSaldiMobiliCausale: TAction
      Caption = 'Saldi mobili'
      OnExecute = actSaldiMobiliCausaleExecute
    end
  end
end
