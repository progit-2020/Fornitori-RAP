inherited A101FRaggrInterrogazioniMW: TA101FRaggrInterrogazioniMW
  OldCreateOrder = True
  Height = 228
  Width = 307
  object seqT005: TOracleQuery
    SQL.Strings = (
      'begin'
      '  --:T005ID:=T005_ID.nextval;'
      '  select T005_ID.nextval into :T005ID from dual;'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00540030003000350049004400030000000400
      00001400000000000000}
    Left = 88
    Top = 16
  end
  object selT002: TOracleDataSet
    SQL.Strings = (
      'select distinct T002.NOME as NOME'
      '  from T002_QUERYPERSONALIZZATE T002'
      ' order by T002.NOME')
    Optimize = False
    Filtered = True
    OnFilterRecord = selT002FilterRecord
    Left = 88
    Top = 72
  end
end
