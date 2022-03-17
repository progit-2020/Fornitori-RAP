object A176FGestioneIterAutorizzativi: TA176FGestioneIterAutorizzativi
  Left = 0
  Top = 0
  HelpContext = 176001
  BorderStyle = bsSizeToolWin
  Caption = '<A176> Gestione iter autorizzativi'
  ClientHeight = 291
  ClientWidth = 825
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlOpzioni: TPanel
    Left = 0
    Top = 160
    Width = 825
    Height = 131
    Align = alBottom
    TabOrder = 0
    object rgpAzioni: TRadioGroup
      Left = 1
      Top = 1
      Width = 142
      Height = 129
      Align = alLeft
      Caption = 'Azione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Applica autorizzazione'
        'Annulla autorizzazione'
        'Cancella richiesta'
        'Cambia struttura')
      ParentFont = False
      TabOrder = 0
      OnClick = rgpAzioniClick
    end
    object rgpAutorizzaNega: TRadioGroup
      Left = 143
      Top = 1
      Width = 80
      Height = 129
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Autorizza'
        'Nega')
      ParentFont = False
      TabOrder = 1
    end
    object pnlEsegui: TPanel
      Left = 223
      Top = 1
      Width = 601
      Height = 129
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      object lblLivello: TLabel
        Left = 6
        Top = 31
        Width = 64
        Height = 13
        Caption = 'Fino al livello:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblStruttura: TLabel
        Left = 6
        Top = 58
        Width = 85
        Height = 13
        Caption = 'Struttura attuale:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblNuovaStruttura: TLabel
        Left = 6
        Top = 81
        Width = 81
        Height = 13
        Caption = 'Nuova struttura:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object chkEliminaDato: TCheckBox
        Left = 4
        Top = 8
        Width = 104
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Elimina dato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object cmbLivello: TComboBox
        Left = 95
        Top = 28
        Width = 45
        Height = 22
        Style = csOwnerDrawFixed
        TabOrder = 1
      end
      object btnEsegui: TBitBtn
        Left = 6
        Top = 101
        Width = 81
        Height = 25
        Caption = 'Esegui'
        TabOrder = 2
        OnClick = btnEseguiClick
      end
      object edtStruttura: TEdit
        Left = 94
        Top = 55
        Width = 257
        Height = 21
        Color = clSilver
        ReadOnly = True
        TabOrder = 3
      end
      object cmbNuovaStruttura: TComboBox
        Left = 94
        Top = 77
        Width = 275
        Height = 21
        Style = csDropDownList
        DropDownCount = 10
        TabOrder = 4
      end
    end
  end
  object dGrdDettIter: TDBGrid
    Left = 0
    Top = 0
    Width = 825
    Height = 160
    Align = alClient
    DataSource = A176FRiepilogoIterAutorizzativiMW.dsrT851DettIter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'C_TITOLO_LIVELLO'
        Title.Caption = 'Livello'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBBLIGATORIO'
        Title.Caption = 'Obbligatorio'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO_LIVELLO'
        Title.Caption = 'Tipo'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'C_STATO'
        Title.Caption = 'Autorizzazione'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AUTORIZZ_AUTOMATICA'
        Title.Caption = 'Autorizz. automatica'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMINATIVO'
        Title.Caption = 'Autorizzatore'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA'
        Title.Caption = 'Data'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOTE'
        Title.Caption = 'Note'
        Width = 200
        Visible = True
      end>
  end
end
