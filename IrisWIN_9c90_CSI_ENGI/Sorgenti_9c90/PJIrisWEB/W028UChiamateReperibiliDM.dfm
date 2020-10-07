object W028FChiamateReperibiliDM: TW028FChiamateReperibiliDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 76
  Width = 163
  object selT380: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT T030.PROGRESSIVO, T030.MATRICOLA, T030.COGNOME, ' +
        'T030.NOME, '
      
        '                T430INDIRIZZO, T430CAP, T430D_COMUNE, T430D_PROV' +
        'INCIA, T430TELEFONO,'
      '                :DATI'
      
        '                T380.DATA DATA_TURNO, T380.TURNO1, T380.PRIORITA' +
        '1, T380.TURNO2, T380.PRIORITA2, T380.TURNO3, T380.PRIORITA3,'
      
        '                T350.DESCRIZIONE, T350.ORAINIZIO, T350.CODICE TU' +
        'RNO, '
      
        '                TO_CHAR(T350.ORAINIZIO,'#39'HH24.MI'#39') DALLE, TO_CHAR' +
        '(T350.ORAFINE,'#39'HH24.MI'#39') ALLE,'
      
        '                T350.TOLL_CHIAMATA_INIZIO, T350.TOLL_CHIAMATA_FI' +
        'NE'
      'FROM   T380_PIANIFREPERIB T380, T350_REGREPERIB T350,'
      ':QVISTAORACLE'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.TIPOLOGIA = '#39'R'#39
      
        'AND    (T380.TURNO1 = T350.CODICE OR T380.TURNO2 = T350.CODICE O' +
        'R T380.TURNO3 = T350.CODICE) '
      'AND    ((T380.DATA = :DATA AND '
      
        '         :ORA + OREMINUTI(T350.TOLL_CHIAMATA_INIZIO) >= OREMINUT' +
        'I(TO_CHAR(T350.ORAINIZIO,'#39'hh24.mi'#39')) AND '
      
        '         :ORA + OREMINUTI(T350.TOLL_CHIAMATA_FINE) <= DECODE(SIG' +
        'N(T350.ORAFINE - T350.ORAINIZIO), '
      '                                        1,'
      
        '                                        OREMINUTI(DECODE(TO_CHAR' +
        '(T350.ORAFINE,'#39'hh24.mi'#39'),'#39'00.00'#39','#39'23.59'#39',TO_CHAR(T350.ORAFINE,'#39'h' +
        'h24.mi'#39'))),'
      '                                        OREMINUTI('#39'23.59'#39')))'
      '        OR '
      '        (T380.DATA = :DATA - 1 AND'
      '         T350.ORAFINE <= T350.ORAINIZIO AND'
      '         :ORA BETWEEN 0 /*OREMINUTI('#39'00.00'#39')*/ AND '
      
        '         OREMINUTI(DECODE(TO_CHAR(T350.ORAFINE,'#39'hh24.mi'#39'),'#39'00.00' +
        #39','#39'23.59'#39',TO_CHAR(T350.ORAFINE,'#39'hh24.mi'#39'))) - OREMINUTI(T350.TOL' +
        'L_CHIAMATA_FINE))'
      '       )'
      
        'ORDER BY T380.DATA, T350.ORAINIZIO, DECODE(T350.CODICE,T380.TURN' +
        'O1,T380.PRIORITA1,T380.TURNO2,T380.PRIORITA2,T380.TURNO3,T380.PR' +
        'IORITA3), T030.COGNOME, T030.NOME, T030.MATRICOLA')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000005000000080000003A004F0052004100030000000000000000000000
      160000003A0044004100540041004C00410056004F0052004F000C0000000000
      0000000000001A0000003A005100560049005300540041004F00520041004300
      4C0045000100000000000000000000000A0000003A0044004100540049000100
      000000000000000000000A0000003A0044004100540041000C00000000000000
      00000000}
    Left = 102
    Top = 16
  end
  object selT390: TOracleDataSet
    SQL.Strings = (
      'select T390.ROWID, T390.*, '
      
        '       DECODE(NVL(T390.ESITO,'#39'N'#39'),'#39'S'#39','#39'Trovato'#39','#39'N'#39','#39'Non trovato' +
        #39','#39'Annullato'#39') D_ESITO,'
      
        '       DECODE(NVL(I060.NOME_UTENTE,'#39'X'#39'),'#39'X'#39',T390.UTENTE,T030OPER' +
        '.COGNOME || '#39' '#39' || T030OPER.NOME || '#39' ('#39' || T030OPER.MATRICOLA |' +
        '| '#39')'#39') OPERATORE,'
      
        '       T030.COGNOME || '#39' '#39' || T030.NOME /*|| '#39' ('#39' || T030.MATRIC' +
        'OLA || '#39')'#39'*/ DIPENDENTE, T030.MATRICOLA'
      
        'from   T390_CHIAMATE_REPERIB T390, MONDOEDP.I060_LOGIN_DIPENDENT' +
        'E I060, T030_ANAGRAFICO T030OPER, T030_ANAGRAFICO T030, V430_STO' +
        'RICO V430'
      'where  TRUNC(T390.DATA) BETWEEN :DATAINIZIO AND :DATAFINE'
      '  and  T390.UTENTE = I060.NOME_UTENTE (+)'
      '  and  I060.AZIENDA (+) = :AZIENDA '
      '  and  I060.MATRICOLA = T030OPER.MATRICOLA (+)'
      '  and  T390.PROGRESSIVO_REPER = T030.PROGRESSIVO'
      '  and  T030.PROGRESSIVO = T430PROGRESSIVO'
      
        '  and  TRUNC(T390.DATA) BETWEEN T430DATADECORRENZA AND T430DATAF' +
        'INE'
      '  :FILTRORICERCA'
      '  :FILTRO'
      'order by DATA DESC'
      '')
    ReadBuffer = 31
    Optimize = False
    Variables.Data = {
      0400000005000000160000003A00440041005400410049004E0049005A004900
      4F000C0000000000000000000000120000003A00440041005400410046004900
      4E0045000C0000000000000000000000100000003A0041005A00490045004E00
      440041000500000000000000000000000E0000003A00460049004C0054005200
      4F000100000000000000000000001C0000003A00460049004C00540052004F00
      5200490043004500520043004100010000000000000000000000}
    AfterOpen = selT390AfterOpen
    Left = 27
    Top = 16
    object selT390DATA: TDateTimeField
      FieldName = 'DATA'
    end
    object selT390UTENTE: TStringField
      FieldName = 'UTENTE'
      Size = 30
    end
    object selT390PROGRESSIVO_REPER: TFloatField
      FieldName = 'PROGRESSIVO_REPER'
    end
    object selT390ESITO: TStringField
      FieldName = 'ESITO'
      Size = 1
    end
    object selT390NOTE: TStringField
      FieldName = 'NOTE'
      Size = 2000
    end
    object selT390DATA_TURNO: TDateTimeField
      FieldName = 'DATA_TURNO'
    end
    object selT390TURNO: TStringField
      FieldName = 'TURNO'
      Size = 5
    end
    object selT390OPERATORE: TStringField
      FieldName = 'OPERATORE'
      Size = 80
    end
    object selT390DIPENDENTE: TStringField
      FieldName = 'DIPENDENTE'
      Size = 80
    end
    object selT390MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT390D_ESITO: TStringField
      FieldName = 'D_ESITO'
      Size = 50
    end
    object selT390D_SCHEDAANAG: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_SCHEDAANAG'
      Size = 1
      Calculated = True
    end
    object selT390D_INFO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_INFO'
      Size = 200
      Calculated = True
    end
  end
end
