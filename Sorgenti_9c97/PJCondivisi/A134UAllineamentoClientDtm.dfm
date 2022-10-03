inherited A134FAllineamentoClientDtm: TA134FAllineamentoClientDtm
  Height = 120
  Width = 134
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.PATHALLCLIENT'
      'FROM MONDOEDP.I090_ENTI I090'
      'WHERE I090.AZIENDA=:PARAZIENDA')
    Variables.Data = {
      03000000010000000B0000003A504152415A49454E4441050000000000000000
      000000}
    Left = 24
    Top = 8
  end
end
