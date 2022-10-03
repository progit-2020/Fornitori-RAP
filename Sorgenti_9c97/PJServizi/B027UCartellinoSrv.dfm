object B027FCartellinoSrv: TB027FCartellinoSrv
  OldCreateOrder = False
  DisplayName = 'B027FCartellinoSrv'
  StartType = stManual
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  Height = 152
  Width = 225
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 24
    Top = 4
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 80
    Top = 4
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
    Left = 144
    Top = 4
  end
  object SessioneMondoEDP: TOracleSession
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 48
    Top = 56
  end
  object selCSI002: TOracleDataSet
    SQL.Strings = (
      
        'select CSI002.*,I090.UTENTE I090UTENTE,I090.PAROLACHIAVE I090PAR' +
        'OLACHIAVE '
      
        'from MONDOEDP.CSI002_SCHEDULAZIONI_B027 CSI002, MONDOEDP.I090_EN' +
        'TI I090'
      'where trunc(sysdate) between CSI002.DAL and CSI002.AL'
      'and CSI002.AZIENDA = I090.AZIENDA'
      'order by ORDINE')
    Optimize = False
    Session = SessioneMondoEDP
    Left = 144
    Top = 56
  end
end
