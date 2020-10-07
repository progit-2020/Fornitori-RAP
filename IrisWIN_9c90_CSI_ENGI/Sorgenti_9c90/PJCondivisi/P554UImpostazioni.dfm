object P554FImpostazioni: TP554FImpostazioni
  Left = 0
  Top = 0
  Width = 502
  Height = 261
  HelpContext = 3554100
  Caption = '<P554> Impostazioni '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 44
    Height = 13
    Caption = 'Nome file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 112
    Width = 72
    Height = 13
    Caption = 'Codice azienda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 216
    Top = 112
    Width = 112
    Height = 13
    Caption = 'Codice istituto (tab.1C)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 144
    Width = 71
    Height = 13
    Caption = 'Codice regione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 216
    Top = 144
    Width = 100
    Height = 13
    Caption = 'Codice DSM (tab.1D)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 186
    Width = 494
    Height = 41
    Align = alBottom
    TabOrder = 8
    object btnOK: TBitBtn
      Left = 152
      Top = 8
      Width = 75
      Height = 25
      TabOrder = 0
      OnClick = btnOKClick
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 248
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Annulla'
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object edtNomeFile: TEdit
    Left = 64
    Top = 16
    Width = 398
    Height = 21
    TabOrder = 0
  end
  object edtAzienda: TEdit
    Left = 96
    Top = 108
    Width = 60
    Height = 21
    MaxLength = 3
    TabOrder = 4
  end
  object rdgComparto: TRadioGroup
    Left = 16
    Top = 48
    Width = 153
    Height = 33
    Caption = 'Comparto'
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'Sanit'#224
      'Enti locali')
    ParentFont = False
    TabOrder = 2
  end
  object rdgTipoOperazione: TRadioGroup
    Left = 176
    Top = 48
    Width = 302
    Height = 33
    Caption = 'Tipo di operazione'
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 1
    Items.Strings = (
      'Acquisizione'
      'Aggiornamento'
      'Cancellazione')
    ParentFont = False
    TabOrder = 3
  end
  object edtIstituto: TEdit
    Left = 336
    Top = 108
    Width = 60
    Height = 21
    MaxLength = 6
    TabOrder = 6
  end
  object edtDSM: TEdit
    Left = 336
    Top = 140
    Width = 60
    Height = 21
    MaxLength = 3
    TabOrder = 7
  end
  object btnNomeFile: TBitBtn
    Left = 463
    Top = 15
    Width = 15
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = btnNomeFileClick
  end
  object edtRegione: TEdit
    Left = 96
    Top = 140
    Width = 60
    Height = 21
    MaxLength = 3
    TabOrder = 5
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.TXT'
    Left = 384
    Top = 8
  end
end
