inherited P501FCudSetupDtM: TP501FCudSetupDtM
  OldCreateOrder = True
  Height = 103
  Width = 180
  object selP500: TOracleDataSet
    SQL.Strings = (
      'SELECT P500.*,P500.ROWID FROM P500_CUDSETUP P500 ORDER BY ANNO')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000005F0000000800000041004E004E004F00010000000000140000004300
      4F0044005F00560041004C005500540041000100000000001600000043004F00
      44005F00460049005300430041004C0045000100000000001A00000044004500
      4E004F004D0049004E0041005A0049004F004E0045000100000000000C000000
      43004F004D0055004E00450001000000000012000000500052004F0056004900
      4E00430049004100010000000000060000004300410050000100000000001200
      000049004E0044004900520049005A005A004F00010000000000180000005400
      45004C00450046004F004E004F005F004600410058000100000000000C000000
      45005F004D00410049004C000100000000001C0000004D004100540052004900
      43004F004C0041005F0049004E00500053000100000000001400000046004900
      52004D00410054004100520049004F000100000000001C000000540049005000
      4F005F0046004F0052004E00490054004F00520045000100000000001E000000
      43004F0044004900430045005F00410054005400490056004900540041000100
      0000000010000000540045004C00450046004F004E004F000100000000000600
      00004600410058000100000000001400000053005400410054004F005F004500
      4E0054004500010000000000200000004E00410054005500520041005F004700
      490055005200490044004900430041000100000000001E000000530049005400
      550041005A0049004F004E0045005F0045004E00540045000100000000002A00
      000043004F0044005F00460049005300430041004C0045005F00440049004300
      410053005400450052004F000100000000002200000043004F0044005F004600
      49005300430041004C0045005F004600490052004D0041000100000000002600
      000043004F0044004900430045005F004300410052004900430041005F004600
      490052004D0041000100000000001A00000043004F0047004E004F004D004500
      5F004600490052004D004100010000000000140000004E004F004D0045005F00
      4600490052004D0041000100000000001600000053004500530053004F005F00
      4600490052004D0041000100000000002400000044004100540041005F004E00
      4100530043004900540041005F004600490052004D0041000100000000002800
      000043004F004D0055004E0045005F004E004100530043004900540041005F00
      4600490052004D0041000100000000002E000000500052004F00560049004E00
      4300490041005F004E004100530043004900540041005F004600490052004D00
      41000100000000002C00000043004F004D0055004E0045005F00520045005300
      4900440045004E005A0041005F004600490052004D0041000100000000003200
      0000500052004F00560049004E004300490041005F0052004500530049004400
      45004E005A0041005F004600490052004D004100010000000000260000004300
      410050005F005200450053004900440045004E005A0041005F00460049005200
      4D0041000100000000001E00000049004E0044004900520049005A005A004F00
      5F004600490052004D0041000100000000001C000000540045004C0045004600
      4F004E004F005F004600490052004D0041000100000000002C00000046004900
      52004D0041005F004F005200470041004E004F005F0043004F004E0054005200
      4F004C004C004F000100000000000E00000043004F0044005F00530049004100
      0100000000000E00000043004F0044005F004100420049000100000000000E00
      000043004F0044005F004300410042000100000000001C00000043004F004E00
      54004F005F0043004F005200520045004E005400450001000000000014000000
      43004F0044005F0043004F004D0055004E004500010000000000280000004300
      4F0044004900430045005F0046004F0052004E00490054005500520041005F00
      44004D004100010000000000240000005400490050004F005F0046004F005200
      4E00490054004F00520045005F0044004D004100010000000000220000004300
      4F0044004900430045005F0049004E0050004400410050005F0044004D004100
      0100000000001C00000043004F0044004900430045005F004D00450046005F00
      44004D0041000100000000002000000043004F0044004900430045005F004100
      5400450043004F005F0044004D0041000100000000002A00000043004F004400
      4900430045005F0046004F0052004D0041005F0047004900550052005F004400
      4D0041000100000000002400000043004F0044005F0046004900530043004100
      4C0045005F00530057005F0044004D0041000100000000002400000046004900
      52004D0041005F00440045004E0055004E004300490041005F0044004D004100
      0100000000001200000053004500440045005F0049004E005000530001000000
      00002C00000043004F0044005F00460049005300430041004C0045005F004D00
      4900540054005F0045004D0045004E0053000100000000002400000043004F00
      44004900430045005F00490053005400410054005F0045004D0045004E005300
      01000000000024000000490044005F004100420042004F004E00410054004F00
      5F0050004F005300540045004C000100000000002C0000005400490050004F00
      4C004F004700490041005F0049004E00560049004F005F0050004F0053005400
      45004C000100000000001A00000043004F004C004F00520045005F0050004F00
      5300540045004C00010000000000240000005400520041005400540041004D00
      45004E0054004F005F0050004F005300540045004C0001000000000026000000
      430045004E00540052004F005F0043004F00530054004F005F0050004F005300
      540045004C0001000000000020000000500052004F0043004500440055005200
      41005F0050004F005300540045004C000100000000002E000000440045004300
      4F005200520045004E005A0041005F004300410052004900430041005F004600
      490052004D0041000100000000001C00000049004E0044005F0044004F004D00
      5F0050004F005300540045004C000100000000001C0000004300410050005F00
      44004F004D005F0050004F005300540045004C000100000000001C0000004300
      4F004D005F0044004F004D005F0050004F005300540045004C00010000000000
      1C0000005000520056005F0044004F004D005F0050004F005300540045004C00
      0100000000002200000053004500440045005F00530045005200560049005A00
      49004F005F004300450044000100000000001800000055004E00490054004100
      5F004F0050005F004300450044000100000000001A0000005100550041004C00
      490046004900430041005F004300450044000100000000001400000057004500
      42005F005300540041004D00500041000100000000001E000000570045004200
      5F0041004E004E004F00540041005A0049004F004E0049000100000000002600
      00005700450042005F0050004100540048005F00490053005400520055005A00
      49004F004E0049000100000000001E0000005700450042005F00440041005400
      41005F005300540041004D00500041000100000000001E000000440041005400
      41005F0049004E0049005A0049004F005F004300450044000100000000001600
      0000460041004D005F0044004100540041005F00440041000100000000001400
      0000460041004D005F0044004100540041005F00410001000000000020000000
      460041004D005F0053005400410054004F005F0043004900560049004C004500
      01000000000026000000460041004D005F0050004100540048005F0049005300
      5400520055005A0049004F004E00490001000000000010000000460041004D00
      5F004E004F00540045000100000000002600000043004F004400490043004500
      5F0043004F004D0050004100520054004F005F0044004D004100010000000000
      3000000043004F0044004900430045005F0053004F00540054004F0043004F00
      4D0050004100520054004F005F0044004D004100010000000000100000005000
      4900560041005F004300450044000100000000002800000043004F0044004900
      430045005F0041005A00490045004E00440041005F0049004E00500047004900
      0100000000002C00000043004F0044004900430045005F0046004F0052004D00
      41005F0047004900550052005F0044004D004100320001000000000024000000
      43004F0044005F0043004F004E00540052004100540054004F005F0044004D00
      410032000100000000002000000050004100540048005F00460049004C004500
      5000440046005F004300450044000100000000002800000043004F0044004900
      430045005F0041005A00490045004E00440041005F0045004E00500041004D00
      0100000000002200000044004100540041005F0056004500520053005F004900
      5200500045004600300031000100000000002200000044004100540041005F00
      56004500520053005F0049005200500045004600300032000100000000002200
      000044004100540041005F0056004500520053005F0049005200500045004600
      300033000100000000002200000044004100540041005F005600450052005300
      5F00490052005000450046003000340001000000000022000000440041005400
      41005F0056004500520053005F00490052005000450046003000350001000000
      00002200000044004100540041005F0056004500520053005F00490052005000
      45004600300036000100000000002200000044004100540041005F0056004500
      520053005F004900520050004500460030003700010000000000220000004400
      4100540041005F0056004500520053005F004900520050004500460030003800
      0100000000002200000044004100540041005F0056004500520053005F004900
      5200500045004600300039000100000000002200000044004100540041005F00
      56004500520053005F0049005200500045004600310030000100000000002200
      000044004100540041005F0056004500520053005F0049005200500045004600
      310031000100000000002200000044004100540041005F005600450052005300
      5F0049005200500045004600310032000100000000001000000043004F004400
      5F004900420041004E00010000000000}
    BeforePost = BeforePostNoStorico
    OnNewRecord = selP500NewRecord
    Left = 12
    Top = 8
    object selP500ANNO: TIntegerField
      DisplayLabel = 'Anno'
      FieldName = 'ANNO'
      Required = True
      OnChange = selP500ANNOChange
    end
    object selP500COD_FISCALE: TStringField
      DisplayLabel = 'Codice fiscale'
      FieldName = 'COD_FISCALE'
    end
    object selP500DENOMINAZIONE: TStringField
      DisplayLabel = 'Denominazione'
      FieldName = 'DENOMINAZIONE'
      Size = 60
    end
    object selP500COMUNE: TStringField
      DisplayLabel = 'Comune'
      FieldName = 'COMUNE'
      Size = 40
    end
    object selP500COD_COMUNE: TStringField
      DisplayLabel = 'Codice comune'
      FieldName = 'COD_COMUNE'
      Size = 4
    end
    object selP500PROVINCIA: TStringField
      DisplayLabel = 'Provincia'
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object selP500CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object selP500INDIRIZZO: TStringField
      DisplayLabel = 'Indirizzo'
      FieldName = 'INDIRIZZO'
      Size = 60
    end
    object selP500TELEFONO: TStringField
      DisplayLabel = 'Telefono'
      FieldName = 'TELEFONO'
      Size = 12
    end
    object selP500FAX: TStringField
      DisplayLabel = 'Fax'
      FieldName = 'FAX'
      Size = 12
    end
    object selP500E_MAIL: TStringField
      DisplayLabel = 'E-mail'
      FieldName = 'E_MAIL'
      Size = 50
    end
    object selP500COD_VALUTA: TStringField
      DisplayLabel = 'Valuta'
      FieldName = 'COD_VALUTA'
      Size = 10
    end
    object selP500D_VALUTA: TStringField
      DisplayLabel = 'Descr. valuta'
      FieldKind = fkLookup
      FieldName = 'D_VALUTA'
      LookupKeyFields = 'COD_VALUTA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VALUTA'
      Size = 40
      Lookup = True
    end
    object selP500CODICE_ATTIVITA: TStringField
      DisplayLabel = 'Codice ATECO'
      DisplayWidth = 6
      FieldName = 'CODICE_ATTIVITA'
      Size = 6
    end
    object selP500FIRMATARIO: TStringField
      DisplayLabel = 'Firmatario'
      FieldName = 'FIRMATARIO'
      Size = 60
    end
    object selP500WEB_STAMPA: TStringField
      DisplayLabel = 'Stampa da Web'
      FieldName = 'WEB_STAMPA'
      Size = 1
    end
    object selP500WEB_DATA_STAMPA: TDateTimeField
      DisplayLabel = 'Data di stampa'
      DisplayWidth = 10
      FieldName = 'WEB_DATA_STAMPA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500WEB_PATH_ISTRUZIONI: TStringField
      DisplayLabel = 'Nome file allegato istruzioni'
      DisplayWidth = 20
      FieldName = 'WEB_PATH_ISTRUZIONI'
      Size = 1000
    end
    object selP500WEB_ANNOTAZIONI: TStringField
      DisplayLabel = 'Annotazione aggiuntiva'
      DisplayWidth = 20
      FieldName = 'WEB_ANNOTAZIONI'
      Size = 2000
    end
    object selP500TIPO_FORNITORE: TStringField
      DisplayLabel = 'Tipo fornitore'
      FieldName = 'TIPO_FORNITORE'
      Size = 2
    end
    object selP500STATO_ENTE: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO_ENTE'
      Size = 1
    end
    object selP500NATURA_GIURIDICA: TStringField
      DisplayLabel = 'Natura giuridica'
      FieldName = 'NATURA_GIURIDICA'
      Size = 2
    end
    object selP500SITUAZIONE_ENTE: TStringField
      DisplayLabel = 'Situazione'
      FieldName = 'SITUAZIONE_ENTE'
      Size = 1
    end
    object selP500COD_FISCALE_DICASTERO: TStringField
      DisplayLabel = 'Codice fiscale dicastero'
      FieldName = 'COD_FISCALE_DICASTERO'
      Size = 11
    end
    object selP500COD_FISCALE_SW_DMA: TStringField
      DisplayLabel = 'Codice fiscale software'
      FieldName = 'COD_FISCALE_SW_DMA'
      Size = 11
    end
    object selP500DATA_VERS_IRPEF01: TDateTimeField
      DisplayLabel = 'Data vers. gennaio'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF01'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF02: TDateTimeField
      DisplayLabel = 'Data vers. febbraio'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF02'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF03: TDateTimeField
      DisplayLabel = 'Data vers. marzo'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF03'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF04: TDateTimeField
      DisplayLabel = 'Data vers. aprile'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF04'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF05: TDateTimeField
      DisplayLabel = 'Data vers. maggio'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF05'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF06: TDateTimeField
      DisplayLabel = 'Data vers. giugno'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF06'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF07: TDateTimeField
      DisplayLabel = 'Data vers. luglio'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF07'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF08: TDateTimeField
      DisplayLabel = 'Data vers. agosto'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF08'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF09: TDateTimeField
      DisplayLabel = 'Data vers. settembre'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF09'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF10: TDateTimeField
      DisplayLabel = 'Data vers. ottobre'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF10'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF11: TDateTimeField
      DisplayLabel = 'Data vers. novembre'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF11'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500DATA_VERS_IRPEF12: TDateTimeField
      DisplayLabel = 'Data vers. dicembre'
      DisplayWidth = 10
      FieldName = 'DATA_VERS_IRPEF12'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500CODICE_FORNITURA_DMA: TStringField
      DisplayLabel = 'Codice fornitura D.M.A.'
      FieldName = 'CODICE_FORNITURA_DMA'
      Size = 5
    end
    object selP500TIPO_FORNITORE_DMA: TStringField
      DisplayLabel = 'Tipo fornitore D.M.A.'
      FieldName = 'TIPO_FORNITORE_DMA'
      Size = 2
    end
    object selP500CODICE_ATECO_DMA: TStringField
      DisplayLabel = 'Codice ISTAT D.M.A.'
      FieldName = 'CODICE_ATECO_DMA'
      Size = 6
    end
    object selP500CODICE_FORMA_GIUR_DMA: TStringField
      DisplayLabel = 'Codice forma giuridica D.M.A.'
      FieldName = 'CODICE_FORMA_GIUR_DMA'
      Size = 4
    end
    object selP500CODICE_COMPARTO_DMA: TStringField
      DisplayLabel = 'Codice comparto D.M.A.'
      FieldName = 'CODICE_COMPARTO_DMA'
      Size = 2
    end
    object selP500CODICE_SOTTOCOMPARTO_DMA: TStringField
      DisplayLabel = 'Codice sottocomparto D.M.A.'
      FieldName = 'CODICE_SOTTOCOMPARTO_DMA'
      Size = 4
    end
    object selP500FIRMA_DENUNCIA_DMA: TStringField
      DisplayLabel = 'Firma della denuncia D.M.A.'
      FieldName = 'FIRMA_DENUNCIA_DMA'
      Required = True
      Size = 1
    end
    object selP500MATRICOLA_INPS: TStringField
      DisplayLabel = 'Matricola INPS'
      FieldName = 'MATRICOLA_INPS'
    end
    object selP500SEDE_INPS: TStringField
      DisplayLabel = 'Sede INPS'
      FieldName = 'SEDE_INPS'
      Size = 6
    end
    object selP500COD_FISCALE_MITT_EMENS: TStringField
      DisplayLabel = 'Codice fiscale mittente'
      FieldName = 'COD_FISCALE_MITT_EMENS'
      Size = 16
    end
    object selP500CODICE_ISTAT_EMENS: TStringField
      DisplayLabel = 'Codice ISTAT'
      DisplayWidth = 6
      FieldName = 'CODICE_ISTAT_EMENS'
      Size = 6
    end
    object selP500CODICE_INPDAP_DMA: TStringField
      DisplayLabel = 'Porgressivo azienda D.M.A. 2'
      FieldName = 'CODICE_INPDAP_DMA'
      Size = 5
    end
    object selP500CODICE_FORMA_GIUR_DMA2: TStringField
      DisplayLabel = 'Codice forma giuridica D.M.A. 2'
      FieldName = 'CODICE_FORMA_GIUR_DMA2'
      Size = 4
    end
    object selP500COD_CONTRATTO_DMA2: TStringField
      DisplayLabel = 'Codice contratto D.M.A. 2'
      FieldName = 'COD_CONTRATTO_DMA2'
      Size = 4
    end
    object selP500CODICE_AZIENDA_INPGI: TStringField
      DisplayLabel = 'Codice azienda INPGI'
      FieldName = 'CODICE_AZIENDA_INPGI'
      Size = 5
    end
    object selP500CODICE_AZIENDA_ENPAM: TStringField
      DisplayLabel = 'Codice azienda ENPAM'
      FieldName = 'CODICE_AZIENDA_ENPAM'
      Size = 5
    end
    object selP500COD_FISCALE_FIRMA: TStringField
      DisplayLabel = 'Codice fiscale firmatario'
      FieldName = 'COD_FISCALE_FIRMA'
      Size = 16
    end
    object selP500SESSO_FIRMA: TStringField
      DisplayLabel = 'Sesso firmatario'
      FieldName = 'SESSO_FIRMA'
      Size = 1
    end
    object selP500COGNOME_FIRMA: TStringField
      DisplayLabel = 'Cognome firmatario'
      FieldName = 'COGNOME_FIRMA'
      Size = 24
    end
    object selP500NOME_FIRMA: TStringField
      DisplayLabel = 'Nome firmatario'
      FieldName = 'NOME_FIRMA'
    end
    object selP500COMUNE_NASCITA_FIRMA: TStringField
      DisplayLabel = 'Comune nascita firmatario'
      FieldName = 'COMUNE_NASCITA_FIRMA'
      Size = 40
    end
    object selP500PROVINCIA_NASCITA_FIRMA: TStringField
      DisplayLabel = 'Provincia nascita firmatario'
      FieldName = 'PROVINCIA_NASCITA_FIRMA'
      Size = 2
    end
    object selP500DATA_NASCITA_FIRMA: TDateTimeField
      DisplayLabel = 'Data nascita firmatario'
      DisplayWidth = 10
      FieldName = 'DATA_NASCITA_FIRMA'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500COMUNE_RESIDENZA_FIRMA: TStringField
      DisplayLabel = 'Comune residenza firmatario'
      FieldName = 'COMUNE_RESIDENZA_FIRMA'
      Size = 40
    end
    object selP500PROVINCIA_RESIDENZA_FIRMA: TStringField
      DisplayLabel = 'Provincia residenza firmatario'
      FieldName = 'PROVINCIA_RESIDENZA_FIRMA'
      Size = 2
    end
    object selP500CAP_RESIDENZA_FIRMA: TStringField
      DisplayLabel = 'CAP residenza firmatario'
      FieldName = 'CAP_RESIDENZA_FIRMA'
      Size = 5
    end
    object selP500INDIRIZZO_FIRMA: TStringField
      DisplayLabel = 'Indirizzo firmatario'
      FieldName = 'INDIRIZZO_FIRMA'
      Size = 35
    end
    object selP500TELEFONO_FIRMA: TStringField
      DisplayLabel = 'Telefono firmatario'
      FieldName = 'TELEFONO_FIRMA'
      Size = 12
    end
    object selP500CODICE_CARICA_FIRMA: TStringField
      DisplayLabel = 'Codice carica 770'
      FieldName = 'CODICE_CARICA_FIRMA'
      Size = 2
    end
    object selP500DECORRENZA_CARICA_FIRMA: TDateTimeField
      DisplayLabel = 'Decorrenza carica 770'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_CARICA_FIRMA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500COD_SIA: TStringField
      DisplayLabel = 'Codice SIA'
      FieldName = 'COD_SIA'
      Size = 8
    end
    object selP500COD_ABI: TStringField
      DisplayLabel = 'Codice ABI'
      FieldName = 'COD_ABI'
      Size = 5
    end
    object selP500COD_CAB: TStringField
      DisplayLabel = 'Codice CAB'
      FieldName = 'COD_CAB'
      Size = 5
    end
    object selP500CONTO_CORRENTE: TStringField
      DisplayLabel = 'Conto corrente'
      FieldName = 'CONTO_CORRENTE'
      Size = 13
    end
    object selP500COD_IBAN: TStringField
      DisplayLabel = 'Codice IBAN'
      FieldName = 'COD_IBAN'
      EditMask = 'LL-00-L-00000-00000-AAAAAAAAAAAA;_'
      Size = 32
    end
    object selP500ID_ABBONATO_POSTEL: TStringField
      DisplayLabel = 'Id abbonato'
      FieldName = 'ID_ABBONATO_POSTEL'
      Size = 8
    end
    object selP500TIPOLOGIA_INVIO_POSTEL: TStringField
      DisplayLabel = 'Tipologia invio'
      FieldName = 'TIPOLOGIA_INVIO_POSTEL'
      Size = 2
    end
    object selP500COLORE_POSTEL: TStringField
      DisplayLabel = 'Colore'
      FieldName = 'COLORE_POSTEL'
      Size = 3
    end
    object selP500PROCEDURA_POSTEL: TStringField
      DisplayLabel = 'Procedura'
      FieldName = 'PROCEDURA_POSTEL'
      Size = 12
    end
    object selP500TRATTAMENTO_POSTEL: TStringField
      DisplayLabel = 'Trattamento'
      FieldName = 'TRATTAMENTO_POSTEL'
      Size = 2
    end
    object selP500CENTRO_COSTO_POSTEL: TStringField
      DisplayLabel = 'Centro di costo'
      FieldName = 'CENTRO_COSTO_POSTEL'
      Size = 8
    end
    object selP500IND_DOM_POSTEL: TStringField
      DisplayLabel = 'Indirizzo domicilio'
      FieldName = 'IND_DOM_POSTEL'
      Size = 50
    end
    object selP500CAP_DOM_POSTEL: TStringField
      DisplayLabel = 'CAP domicilio'
      FieldName = 'CAP_DOM_POSTEL'
      Size = 50
    end
    object selP500COM_DOM_POSTEL: TStringField
      DisplayLabel = 'Comune domicilio'
      FieldName = 'COM_DOM_POSTEL'
      Size = 50
    end
    object selP500PRV_DOM_POSTEL: TStringField
      DisplayLabel = 'Provincia domicilio'
      FieldName = 'PRV_DOM_POSTEL'
      Size = 50
    end
    object selP500SEDE_SERVIZIO_CED: TStringField
      DisplayLabel = 'Sede servizio'
      FieldName = 'SEDE_SERVIZIO_CED'
      Size = 50
    end
    object selP500UNITA_OP_CED: TStringField
      DisplayLabel = 'Unit'#224' operativa'
      FieldName = 'UNITA_OP_CED'
      Size = 50
    end
    object selP500QUALIFICA_CED: TStringField
      DisplayLabel = 'Qualifica'
      FieldName = 'QUALIFICA_CED'
      Size = 50
    end
    object selP500DATA_INIZIO_CED: TStringField
      DisplayLabel = 'Data inizio rapporto'
      FieldName = 'DATA_INIZIO_CED'
      Size = 50
    end
    object selP500PIVA_CED: TStringField
      DisplayLabel = 'Partita IVA'
      FieldName = 'PIVA_CED'
      Size = 50
    end
    object selP500PATH_FILEPDF_CED: TStringField
      DisplayLabel = 'Percorso archivio PDF'
      FieldName = 'PATH_FILEPDF_CED'
      Size = 1000
    end
    object selP500FAM_DATA_DA: TDateTimeField
      DisplayLabel = 'Inizio periodo familiari'
      DisplayWidth = 10
      FieldName = 'FAM_DATA_DA'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500FAM_DATA_A: TDateTimeField
      DisplayLabel = 'Fine periodo familiari'
      DisplayWidth = 10
      FieldName = 'FAM_DATA_A'
      Visible = False
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selP500FAM_STATO_CIVILE: TStringField
      DisplayLabel = 'Richiesta stato civile familiari'
      FieldName = 'FAM_STATO_CIVILE'
      Visible = False
      Size = 1
    end
    object selP500FAM_PATH_ISTRUZIONI: TStringField
      DisplayLabel = 'Nome file familiari'
      FieldName = 'FAM_PATH_ISTRUZIONI'
      Visible = False
      Size = 1000
    end
    object selP500FAM_NOTE: TStringField
      DisplayLabel = 'Note familiari'
      FieldName = 'FAM_NOTE'
      Visible = False
      Size = 4000
    end
  end
  object dsrP030: TDataSource
    Left = 61
    Top = 8
  end
end
