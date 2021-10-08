object A123FVisualizzazione: TA123FVisualizzazione
  Left = 194
  Top = 170
  HelpContext = 123100
  Caption = '<A123> Visualizzazione'
  ClientHeight = 370
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 615
    Height = 84
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 180
      Top = 35
      Width = 51
      Height = 13
      Caption = 'Sindacato:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblOrganizzazione: TLabel
      Left = 178
      Top = 10
      Width = 53
      Height = 13
      Caption = 'Organismo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 204
      Top = 60
      Width = 26
      Height = 13
      Caption = 'Data:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dTxtSindacato: TDBText
      Left = 329
      Top = 35
      Width = 69
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
    end
    object dTxtOrganismo: TDBText
      Left = 329
      Top = 10
      Width = 71
      Height = 13
      AutoSize = True
      DataField = 'DESCRIZIONE'
    end
    object Label3: TLabel
      Left = 89
      Top = 10
      Width = 52
      Height = 13
      Caption = 'Ordina per:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 89
      Top = 35
      Width = 52
      Height = 13
      Caption = 'Ordina per:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 89
      Top = 60
      Width = 52
      Height = 13
      Caption = 'Ordina per:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dtpData: TDateTimePicker
      Left = 235
      Top = 56
      Width = 90
      Height = 21
      Date = 37897.474367743050000000
      Time = 37897.474367743050000000
      TabOrder = 5
      OnCloseUp = dtpDataCloseUp
      OnKeyUp = dtpDataKeyUp
    end
    object dCmbSindacato: TDBLookupComboBox
      Left = 236
      Top = 31
      Width = 90
      Height = 21
      DropDownWidth = 200
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      TabOrder = 3
      OnCloseUp = dCmbSindacatoCloseUp
      OnKeyDown = dCmbOrganismoKeyDown
      OnKeyUp = dCmbSindacatoKeyUp
    end
    object dCmbOrganismo: TDBLookupComboBox
      Left = 236
      Top = 6
      Width = 90
      Height = 21
      DropDownWidth = 200
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      TabOrder = 1
      OnCloseUp = dCmbOrganismoCloseUp
      OnKeyDown = dCmbOrganismoKeyDown
      OnKeyUp = dCmbOrganismoKeyUp
    end
    object edtOrdina1: TEdit
      Left = 145
      Top = 8
      Width = 20
      Height = 21
      MaxLength = 1
      TabOrder = 0
      Text = '1'
      OnChange = edtOrdina1Change
    end
    object edtOrdina2: TEdit
      Left = 145
      Top = 31
      Width = 20
      Height = 21
      MaxLength = 1
      TabOrder = 2
      Text = '2'
      OnChange = edtOrdina2Change
    end
    object edtOrdina3: TEdit
      Left = 145
      Top = 56
      Width = 20
      Height = 21
      MaxLength = 1
      TabOrder = 4
      Text = '3'
      OnChange = edtOrdina3Change
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 84
    Width = 615
    Height = 286
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clMaroon
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object PopupMenu1: TPopupMenu
    Left = 496
    Top = 32
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
