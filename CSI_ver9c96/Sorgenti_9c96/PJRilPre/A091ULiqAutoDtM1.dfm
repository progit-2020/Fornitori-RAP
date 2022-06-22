object A091FLiqAutoDtM1: TA091FLiqAutoDtM1
  OnCreate = A049FStampaPastiDtM1Create
  OnDestroy = A049FStampaPastiDtM1Destroy
  Left = 92
  Top = 167
  Height = 145
  Width = 383
  object Commit: TQuery
    DatabaseName = 'DbIris049'
    SQL.Strings = (
      'COMMIT')
    Left = 125
    Top = 10
  end
  object QAnagra: TQuery
    Filtered = True
    OnFilterRecord = QAnagraFilterRecord
    DatabaseName = 'dbiris049'
    SQL.Strings = (
      'SELECT PROGRESSIVO,T430BADGE,COGNOME,NOME,MATRICOLA,'
      'T430INIZIO,T430FINE '
      'FROM T030_ANAGRAFICO,V430_STORICO'
      'WHERE PROGRESSIVO = T430PROGRESSIVO AND'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'T430DATADECORRENZA <= :DATALAVORO AND'
      'T430DATAFINE >= :DATALAVORO'
      '')
    Params.Data = {
      010003000B50524F475245535349564F000000000A444154414C41564F524F00
      0000000A444154414C41564F524F00000000}
    Left = 9
    Top = 10
  end
  object TabellaStampa: TTable
    DatabaseName = 'Parametri'
    Left = 186
    Top = 10
  end
  object QDrop: TQuery
    DatabaseName = 'Parametri'
    Left = 242
    Top = 9
  end
  object Upd071: TQuery
    SQL.Strings = (
      'UPDATE T071_SCHEDAFASCE '
      'SET LIQUIDNELMESE = :LIQUIDNELMESE'
      'WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA AND'
      'CODFASCIA = :CODFASCIA')
    Params.Data = {
      010004000D4C49515549444E454C4D45534500010200300000000B50524F4752
      45535349564F000304000000000000000444415441000B080000002C845D40CB
      42000009434F444641534349410001020030000000}
    Left = 60
    Top = 10
  end
end
