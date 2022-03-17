object B005FInvioEMail: TB005FInvioEMail
  Left = 376
  Top = 247
  BorderStyle = bsSingle
  Caption = '<B005> Invio log per E-mail'
  ClientHeight = 179
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 19
    Top = 41
    Width = 81
    Height = 13
    Caption = 'Indirizzo mittente:'
  end
  object Label2: TLabel
    Left = 19
    Top = 69
    Width = 107
    Height = 13
    Caption = 'Server di posta SMTP:'
  end
  object Label3: TLabel
    Left = 19
    Top = 97
    Width = 68
    Height = 13
    Caption = 'Utente SMTP:'
  end
  object Label4: TLabel
    Left = 19
    Top = 121
    Width = 82
    Height = 13
    Caption = 'Password SMTP:'
  end
  object edtindirizzo: TEdit
    Left = 157
    Top = 37
    Width = 168
    Height = 21
    TabOrder = 0
    OnChange = edtindirizzoChange
  end
  object edtServer: TEdit
    Left = 157
    Top = 65
    Width = 168
    Height = 21
    TabOrder = 1
    OnChange = edtindirizzoChange
  end
  object btnInvia: TBitBtn
    Left = 19
    Top = 147
    Width = 75
    Height = 25
    Caption = 'Invia'
    TabOrder = 2
    OnClick = btnInviaClick
  end
  object btnChiudi: TBitBtn
    Left = 251
    Top = 147
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 3
  end
  object edtUtente: TEdit
    Left = 157
    Top = 93
    Width = 168
    Height = 21
    TabOrder = 4
    OnChange = edtindirizzoChange
  end
  object edtPassword: TEdit
    Left = 157
    Top = 117
    Width = 168
    Height = 21
    PasswordChar = '*'
    TabOrder = 5
    OnChange = edtindirizzoChange
  end
  object btnDatiAziendali: TButton
    Left = 157
    Top = 6
    Width = 169
    Height = 25
    Caption = 'Leggi dati aziendali'
    TabOrder = 6
    OnClick = btnDatiAziendaliClick
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 139
    Top = 139
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 175
    Top = 139
  end
end
