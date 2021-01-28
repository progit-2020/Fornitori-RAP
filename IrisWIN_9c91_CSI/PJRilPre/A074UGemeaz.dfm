object A074FGemeaz: TA074FGemeaz
  Left = 392
  Top = 241
  HelpContext = 74000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = '<A074> Dati per Gemeaz'
  ClientHeight = 273
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 56
    Height = 13
    Caption = 'Cod.cliente:'
  end
  object Label2: TLabel
    Left = 12
    Top = 37
    Width = 95
    Height = 13
    Caption = 'Valore buono pasto:'
  end
  object lblFormatoMatricola: TLabel
    Left = 12
    Top = 63
    Width = 86
    Height = 13
    Caption = 'Formato matricola:'
  end
  object Label4: TLabel
    Left = 12
    Top = 195
    Width = 47
    Height = 13
    Caption = 'Nome file:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 12
    Top = 87
    Width = 58
    Height = 13
    Caption = 'Sigla testata'
  end
  object edtCodCliente: TEdit
    Left = 112
    Top = 8
    Width = 110
    Height = 21
    TabOrder = 0
  end
  object edtValoreBuono: TEdit
    Left = 112
    Top = 33
    Width = 110
    Height = 21
    TabOrder = 1
  end
  object rgpTipoFile: TRadioGroup
    Left = 12
    Top = 153
    Width = 211
    Height = 37
    Caption = 'Tipo file sequenziale'
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'Completo'
      'Solo corpo')
    TabOrder = 5
  end
  object BitBtn1: TBitBtn
    Left = 14
    Top = 240
    Width = 75
    Height = 25
    Kind = bkOK
    TabOrder = 6
  end
  object cmbFormatoMatricola: TComboBox
    Left = 112
    Top = 58
    Width = 110
    Height = 21
    DropDownCount = 12
    TabOrder = 2
    Items.Strings = (
      'LA=5,PS=1,LF=5'
      'LA=7,PS=1,LF=5')
  end
  object GroupBox1: TGroupBox
    Left = 12
    Top = 111
    Width = 210
    Height = 37
    Caption = 'Dati da considerare'
    TabOrder = 4
    object chkTicket: TCheckBox
      Left = 3
      Top = 17
      Width = 69
      Height = 17
      Caption = 'Ticket'
      TabOrder = 0
    end
    object chkBuoniPasto: TCheckBox
      Left = 108
      Top = 14
      Width = 81
      Height = 17
      Caption = 'Buoni pasto'
      TabOrder = 1
    end
  end
  object EdtNomeFile: TEdit
    Left = 12
    Top = 210
    Width = 214
    Height = 21
    ReadOnly = True
    TabOrder = 7
  end
  object edtSiglaTestata: TEdit
    Left = 112
    Top = 83
    Width = 110
    Height = 21
    TabOrder = 3
  end
end
