object A038FVociVariabiliDtM1: TA038FVociVariabiliDtM1
  OldCreateOrder = True
  OnCreate = A033FStampaAnomalieDtM1Create
  OnDestroy = A033FStampaAnomalieDtM1Destroy
  Height = 139
  Width = 315
  object QI010_: TOracleDataSet
    SQL.Strings = (
      
        'SELECT * FROM I010_CAMPIANAGRAFICI ORDER BY POSIZIONE,NOME_LOGIC' +
        'O')
    ReadBuffer = 100
    Optimize = False
    Left = 148
    Top = 12
  end
  object scrDecodeVoci: TOracleQuery
    SQL.Strings = (
      'declare'
      '  cursor c1 is '
      '    select vocepaghe,rowid '
      '    from t195_vocivariabili where '
      
        '    progressivo in (select t030.progressivo from :C700SelAnagraf' +
        'e) and'
      '    vocepaghe in (:vocipaghe) and'
      '    data_cassa between :dal and :al;'
      'begin'
      '  for t1 in c1 loop'
      
        '    update t195_vocivariabili set vocepaghe = decode(t1.vocepagh' +
        'e,:decodevoci,t1.vocepaghe) where rowid = t1.rowid;'
      '    commit;'
      '  end loop;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000005000000140000003A0056004F004300490050004100470048004500
      010000000000000000000000160000003A004400450043004F00440045005600
      4F0043004900010000000000000000000000080000003A00440041004C000800
      00000000000000000000060000003A0041004C000C0000000000000000000000
      200000003A004300370030003000530045004C0041004E004100470052004100
      46004500010000000000000000000000}
    Left = 148
    Top = 64
  end
end
