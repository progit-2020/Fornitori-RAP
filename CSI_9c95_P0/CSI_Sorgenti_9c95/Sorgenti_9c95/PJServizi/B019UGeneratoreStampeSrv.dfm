object B019FGeneratoreStampeSrv: TB019FGeneratoreStampeSrv
  OldCreateOrder = False
  DisplayName = 'B019FGeneratoreStampeSrv'
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 200
  Width = 400
  object SessioneMondoEDP: TOracleSession
    LogonUsername = 'MONDOEDP'
    Preferences.ConvertUTF = cuUTF8ToUTF16
    Left = 40
    Top = 24
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'select AZIENDA,UTENTE from I090_ENTI order by AZIENDA')
    Optimize = False
    Session = SessioneMondoEDP
    Left = 136
    Top = 24
  end
end
