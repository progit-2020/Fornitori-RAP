inherited B021FDizionarioOrariDM: TB021FDizionarioOrariDM
  OldCreateOrder = True
  Height = 83
  Width = 193
  object selOrari: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT '
      '       TORARI.REPARTO, T020.DESCRIZIONE, '
      
        '       T021.ENTRATA INIZIO_TURNO, T021.USCITA FINE_TURNO, T020.O' +
        'RETEOR DURATA_TURNO,'
      
        '       T021PM.ENTRATA INIZIO_PM, T021PM.USCITA FINE_PM, T020.MMM' +
        'INIMI DURATA_PM'
      'FROM   T020_ORARI T020, '
      '       T021_FASCEORARI T021, '
      '       T021_FASCEORARI T021PM,'
      '       ('
      '        SELECT T430.REPARTO, T220.ORARIO'
      '        FROM   T430_STORICO T430, '
      '               T030_ANAGRAFICO T030,'
      '               ('
      
        '                SELECT T220.CODICE,T220.DECORRENZA,T220.DECORREN' +
        'ZA_FINE,T221.LUNEDI ORARIO'
      
        '                FROM   T220_PROFILIORARI T220, T221_PROFILISETTI' +
        'MANA T221'
      
        '                WHERE  T221.CODICE = T220.CODICE AND T221.DECORR' +
        'ENZA = T220.DECORRENZA'
      '                UNION ALL'
      
        '                SELECT T220.CODICE,T220.DECORRENZA,T220.DECORREN' +
        'ZA_FINE,T221.MARTEDI'
      
        '                FROM   T220_PROFILIORARI T220, T221_PROFILISETTI' +
        'MANA T221'
      
        '                WHERE  T221.CODICE = T220.CODICE AND T221.DECORR' +
        'ENZA = T220.DECORRENZA'
      '                UNION ALL'
      
        '                SELECT T220.CODICE,T220.DECORRENZA,T220.DECORREN' +
        'ZA_FINE,T221.MERCOLEDI'
      
        '                FROM   T220_PROFILIORARI T220, T221_PROFILISETTI' +
        'MANA T221'
      
        '                WHERE  T221.CODICE = T220.CODICE AND T221.DECORR' +
        'ENZA = T220.DECORRENZA'
      '                UNION ALL'
      
        '                SELECT T220.CODICE,T220.DECORRENZA,T220.DECORREN' +
        'ZA_FINE,T221.GIOVEDI'
      
        '                FROM   T220_PROFILIORARI T220, T221_PROFILISETTI' +
        'MANA T221'
      
        '                WHERE  T221.CODICE = T220.CODICE AND T221.DECORR' +
        'ENZA = T220.DECORRENZA'
      '                UNION ALL'
      
        '                SELECT T220.CODICE,T220.DECORRENZA,T220.DECORREN' +
        'ZA_FINE,T221.VENERDI'
      
        '                FROM   T220_PROFILIORARI T220, T221_PROFILISETTI' +
        'MANA T221'
      
        '                WHERE  T221.CODICE = T220.CODICE AND T221.DECORR' +
        'ENZA = T220.DECORRENZA'
      '                UNION ALL'
      
        '                SELECT T220.CODICE,T220.DECORRENZA,T220.DECORREN' +
        'ZA_FINE,T221.SABATO'
      
        '                FROM   T220_PROFILIORARI T220, T221_PROFILISETTI' +
        'MANA T221'
      
        '                WHERE  T221.CODICE = T220.CODICE AND T221.DECORR' +
        'ENZA = T220.DECORRENZA'
      '                UNION ALL'
      
        '                SELECT T220.CODICE,T220.DECORRENZA,T220.DECORREN' +
        'ZA_FINE,T221.DOMENICA'
      
        '                FROM   T220_PROFILIORARI T220, T221_PROFILISETTI' +
        'MANA T221'
      
        '                WHERE  T221.CODICE = T220.CODICE AND T221.DECORR' +
        'ENZA = T220.DECORRENZA'
      '                UNION ALL'
      
        '                SELECT T220.CODICE,T220.DECORRENZA,T220.DECORREN' +
        'ZA_FINE,T221.NONLAV'
      
        '                FROM   T220_PROFILIORARI T220, T221_PROFILISETTI' +
        'MANA T221'
      
        '                WHERE  T221.CODICE = T220.CODICE AND T221.DECORR' +
        'ENZA = T220.DECORRENZA'
      '                UNION ALL'
      
        '                SELECT T220.CODICE,T220.DECORRENZA,T220.DECORREN' +
        'ZA_FINE,T221.FESTIVO'
      
        '                FROM   T220_PROFILIORARI T220, T221_PROFILISETTI' +
        'MANA T221'
      
        '                WHERE  T221.CODICE = T220.CODICE AND T221.DECORR' +
        'ENZA = T220.DECORRENZA'
      '               ) T220'
      
        '        WHERE  :DATA between T430.DATADECORRENZA AND T430.DATAFI' +
        'NE'
      '        AND    T220.CODICE = T430.PORARIO'
      
        '        AND    :DATA between T220.DECORRENZA AND T220.DECORRENZA' +
        '_FINE'
      '        AND    T220.ORARIO is not null'
      '        AND    T030.PROGRESSIVO = T430.PROGRESSIVO'
      '        :FILTRO'
      '       ) TORARI'
      
        'WHERE  :DATA between T020.DECORRENZA AND T020F_GETDECORRENZAFINE' +
        '(T020.CODICE,T020.DECORRENZA)'
      'AND    T021.CODICE = T020.CODICE'
      'AND    T021.DECORRENZA = T020.DECORRENZA'
      'AND    T021.TIPO_FASCIA = '#39'PN'#39
      'AND    T021PM.CODICE(+) = T020.CODICE'
      'AND    T021PM.DECORRENZA(+) = T020.DECORRENZA'
      'AND    T021PM.TIPO_FASCIA(+) = '#39'PMT'#39
      'AND    T020.CODICE = TORARI.ORARIO'
      'ORDER BY TORARI.REPARTO, T020.DESCRIZIONE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      00000E0000003A00460049004C00540052004F00010000000000000000000000}
    Left = 117
    Top = 17
  end
end
