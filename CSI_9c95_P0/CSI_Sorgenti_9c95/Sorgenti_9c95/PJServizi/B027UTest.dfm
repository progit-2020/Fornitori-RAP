object B027FTest: TB027FTest
  Left = 0
  Top = 0
  Caption = 'B027FTest'
  ClientHeight = 311
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 128
    Top = 28
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 184
    Top = 28
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
    Left = 248
    Top = 28
  end
  object selCSI002: TOracleDataSet
    SQL.Strings = (
      
        'select CSI002.*,I090.UTENTE I090UTENTE,I090.PAROLACHIAVE I090PAR' +
        'OLACHIAVE '
      
        'from MONDOEDP.CSI002_SCHEDULAZIONI_B027 CSI002, MONDOEDP.I090_EN' +
        'TI I090'
      'where sysdate between CSI002.DAL and CSI002.AL'
      'and CSI002.AZIENDA = I090.AZIENDA'
      'order by ORDINE')
    Optimize = False
    Session = SessioneMondoEDP
    Left = 480
    Top = 24
  end
  object SessioneMondoEDP: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 384
    Top = 24
  end
end
