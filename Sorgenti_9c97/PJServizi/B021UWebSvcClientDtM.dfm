object B021FWebSvcClientDtM: TB021FWebSvcClientDtM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 194
  Width = 277
  object scrGetDati: TOracleQuery
    Optimize = False
    Left = 32
    Top = 72
  end
  object insUSR_T040_TRACE_FALLIMENTI: TOracleQuery
    SQL.Strings = (
      'insert into USR_T040_TRACE_FALLIMENTI '
      
        '  (OPERAZIONE,DATA_OPERAZIONE,PROGRESSIVO,CAUSALE,DATA,DALLE,ALL' +
        'E,TIPOGIUST,DATAFAMILIARE,ANOMALIA,RICHIESTA)'
      'values'
      
        '  (:OPERAZIONE,sysdate,:PROGRESSIVO,:CAUSALE,:DATA,:DALLE,:ALLE,' +
        ':TIPOGIUST,:DATAFAMILIARE,:ANOMALIA, :RICHIESTA)')
    Optimize = False
    Variables.Data = {
      040000000A000000160000003A004F0050004500520041005A0049004F004E00
      4500050000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F00030000000000000000000000100000003A0043004100
      5500530041004C0045000500000000000000000000000A0000003A0044004100
      540041000C00000000000000000000000C0000003A00440041004C004C004500
      0500000000000000000000000A0000003A0041004C004C004500050000000000
      000000000000140000003A005400490050004F00470049005500530054000500
      000000000000000000001C0000003A004400410054004100460041004D004900
      4C0049004100520045000C0000000000000000000000120000003A0041004E00
      4F004D0041004C0049004100050000000000000000000000140000003A005200
      49004300480049004500530054004100050000000000000000000000}
    Left = 152
    Top = 72
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'select distinct '#39'x'#39' '
      'from T430_STORICO T430 '
      'where T430.PROGRESSIVO = :PROGRESSIVO '
      ':FILTRO')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A00460049004C0054005200
      4F00010000000000000000000000}
    Left = 32
    Top = 130
  end
  object selT265Richiesta: TOracleDataSet
    SQL.Strings = (
      'select t.codice, t.codice_richiesta'
      'from   t265_cauassenze t265, usr_t265_decod_richieste t'
      'where  t.codice = t265.codice'
      'order by t.codice')
    ReadBuffer = 50
    Optimize = False
    Left = 152
    Top = 130
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 32
    Top = 16
  end
end
