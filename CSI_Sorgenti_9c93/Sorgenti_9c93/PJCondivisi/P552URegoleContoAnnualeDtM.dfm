inherited P552FRegoleContoAnnualeDtM: TP552FRegoleContoAnnualeDtM
  OldCreateOrder = True
  Width = 662
  object selP552: TOracleDataSet
    SQL.Strings = (
      'select P552.*, P552.rowid '
      'from p552_contoannregole P552'
      'where P552.riga = 0 and p552.colonna = 0'
      'order by p552.anno, p552.cod_tabella')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000120000000800000041004E004E004F00010000000000160000004300
      4F0044005F0054004100420045004C004C004100010000000000080000005200
      4900470041000100000000000E00000043004F004C004F004E004E0041000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000240000005400490050004F005F0054004100420045004C004C004100
      5F00520049004700480045000100000000002400000043004F0044005F004100
      520052004F0054004F004E00440041004D0045004E0054004F00010000000000
      1E000000560041004C004F00520045005F0043004F005300540041004E005400
      45000100000000002E00000043004F0044004900430049005F00410043004300
      4F005200500041004D0045004E0054004F0056004F0043004900010000000000
      320000005200450047004F004C0041005F00430041004C0043004F004C004F00
      5F004100550054004F004D00410054004900430041000100000000002C000000
      5200450047004F004C0041005F00430041004C0043004F004C004F005F004D00
      41004E00550041004C004500010000000000260000005200450047004F004C00
      41005F004D004F00440049004600490043004100420049004C00450001000000
      00001E0000004E0055004D00450052004F005F00540052004500440043004F00
      520052000100000000001E0000004E0055004D00450052004F005F0054005200
      4500440050005200450043000100000000001C0000004E0055004D0045005200
      4F005F0041005200520043004F00520052000100000000001C0000004E005500
      4D00450052004F005F0041005200520050005200450043000100000000002200
      000044004100540041005F004100430043004F005200500041004D0045004E00
      54004F0001000000000022000000460049004C00540052004F005F0044004900
      500045004E00440045004E0054004900010000000000}
    BeforePost = BeforePostNoStorico
    AfterScroll = selP552AfterScroll
    OnNewRecord = selP552NewRecord
    Left = 32
    Top = 40
  end
  object selP552Ricerca: TOracleDataSet
    SQL.Strings = (
      'select distinct cod_tabella, descrizione'
      'from p552_contoannregole P552'
      'where riga = 0 and colonna = 0'
      '  and anno = :Anno'
      'order by cod_tabella')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0041004E004E004F0003000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000020000001600000043004F0044005F0054004100420045004C004C00
      4100010000000000160000004400450053004300520049005A0049004F004E00
      4500010000000000}
    Left = 120
    Top = 40
  end
  object dsrP552Ricerca: TDataSource
    DataSet = selP552Ricerca
    Left = 120
    Top = 96
  end
  object selP552Righe: TOracleDataSet
    SQL.Strings = (
      'select P552.*, P552.rowid'
      'from p552_contoannregole P552'
      'where P552.riga > 0 and p552.colonna = 0'
      'and anno = :Anno and cod_tabella = :CodTabella'
      'order by p552.anno, p552.cod_tabella, p552.riga'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000160000003A0043004F00440054004100420045004C004C00410005000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000120000000800000041004E004E004F00010000000000160000004300
      4F0044005F0054004100420045004C004C004100010000000000080000005200
      4900470041000100000000000E00000043004F004C004F004E004E0041000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000240000005400490050004F005F0054004100420045004C004C004100
      5F00520049004700480045000100000000002400000043004F0044005F004100
      520052004F0054004F004E00440041004D0045004E0054004F00010000000000
      1E000000560041004C004F00520045005F0043004F005300540041004E005400
      45000100000000002E00000043004F0044004900430049005F00410043004300
      4F005200500041004D0045004E0054004F0056004F0043004900010000000000
      320000005200450047004F004C0041005F00430041004C0043004F004C004F00
      5F004100550054004F004D00410054004900430041000100000000002C000000
      5200450047004F004C0041005F00430041004C0043004F004C004F005F004D00
      41004E00550041004C004500010000000000260000005200450047004F004C00
      41005F004D004F00440049004600490043004100420049004C00450001000000
      00001E0000004E0055004D00450052004F005F00540052004500440043004F00
      520052000100000000001E0000004E0055004D00450052004F005F0054005200
      4500440050005200450043000100000000001C0000004E0055004D0045005200
      4F005F0041005200520043004F00520052000100000000001C0000004E005500
      4D00450052004F005F0041005200520050005200450043000100000000002200
      000044004100540041005F004100430043004F005200500041004D0045004E00
      54004F0001000000000022000000460049004C00540052004F005F0044004900
      500045004E00440045004E0054004900010000000000}
    BeforePost = selP552RigheBeforePost
    AfterPost = selP552RigheAfterPost
    BeforeDelete = selP552RigheBeforeDelete
    AfterDelete = selP552RigheAfterDelete
    AfterScroll = selP552RigheAfterScroll
    OnCalcFields = selP552RigheCalcFields
    Left = 200
    Top = 40
    object selP552RigheRIGA: TIntegerField
      DisplayLabel = 'N.riga'
      DisplayWidth = 5
      FieldName = 'RIGA'
      Required = True
    end
    object selP552RigheDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selP552RigheVALORE_COSTANTE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 10
      FieldName = 'VALORE_COSTANTE'
      Size = 500
    end
    object selP552RigheCOD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Arrot.'
      FieldName = 'COD_ARROTONDAMENTO'
      Size = 5
    end
    object selP552RigheDesc_Data_Accorp: TStringField
      DisplayLabel = 'Modalit'#224' accorp.'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Desc_Data_Accorp'
      Size = 50
      Calculated = True
    end
    object selP552RigheCODICI_ACCORPAMENTOVOCI: TStringField
      DisplayLabel = 'Accorp.voci/Parametro'
      DisplayWidth = 15
      FieldName = 'CODICI_ACCORPAMENTOVOCI'
      Size = 500
    end
    object selP552RigheNUMERO_TREDCORR: TStringField
      DisplayLabel = '13A corr.'
      DisplayWidth = 10
      FieldName = 'NUMERO_TREDCORR'
      Size = 15
    end
    object selP552RigheNUMERO_TREDPREC: TStringField
      DisplayLabel = '13A prec.'
      DisplayWidth = 10
      FieldName = 'NUMERO_TREDPREC'
      Size = 15
    end
    object selP552RigheNUMERO_ARRCORR: TStringField
      DisplayLabel = 'Arr.corr.'
      DisplayWidth = 10
      FieldName = 'NUMERO_ARRCORR'
      Size = 15
    end
    object selP552RigheNUMERO_ARRPREC: TStringField
      DisplayLabel = 'Arr.prec.'
      DisplayWidth = 10
      FieldName = 'NUMERO_ARRPREC'
      Size = 15
    end
    object selP552RigheREGOLA_MODIFICABILE: TStringField
      DisplayLabel = 'Regola modif.'
      FieldName = 'REGOLA_MODIFICABILE'
      Size = 1
    end
    object selP552RigheREGOLA_CALCOLO_MANUALE: TStringField
      DisplayLabel = 'Regola'
      DisplayWidth = 100
      FieldName = 'REGOLA_CALCOLO_MANUALE'
      Size = 3000
    end
    object selP552RigheANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
      Visible = False
    end
    object selP552RigheCOD_TABELLA: TStringField
      FieldName = 'COD_TABELLA'
      Required = True
      Visible = False
      Size = 10
    end
    object selP552RigheCOLONNA: TIntegerField
      FieldName = 'COLONNA'
      Required = True
      Visible = False
    end
    object selP552RigheTIPO_TABELLA_RIGHE: TStringField
      FieldName = 'TIPO_TABELLA_RIGHE'
      Visible = False
      Size = 1
    end
    object selP552RigheREGOLA_CALCOLO_AUTOMATICA: TStringField
      FieldName = 'REGOLA_CALCOLO_AUTOMATICA'
      Visible = False
      Size = 3000
    end
    object selP552RigheDATA_ACCORPAMENTO: TStringField
      DisplayLabel = 'Mod.accorp.'
      FieldName = 'DATA_ACCORPAMENTO'
      Visible = False
      Size = 2
    end
    object selP552RigheFILTRO_DIPENDENTI: TStringField
      FieldName = 'FILTRO_DIPENDENTI'
      Visible = False
      Size = 500
    end
  end
  object selP552Colonne: TOracleDataSet
    SQL.Strings = (
      'select P552.*, P552.rowid '
      'from p552_contoannregole P552'
      'where P552.riga = 0 and p552.colonna > 0'
      'and anno = :Anno and cod_tabella = :CodTabella'
      'order by p552.anno, p552.cod_tabella, p552.colonna')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000160000003A0043004F00440054004100420045004C004C00410005000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000120000000800000041004E004E004F00010000000000160000004300
      4F0044005F0054004100420045004C004C004100010000000000080000005200
      4900470041000100000000000E00000043004F004C004F004E004E0041000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      00000000240000005400490050004F005F0054004100420045004C004C004100
      5F00520049004700480045000100000000002400000043004F0044005F004100
      520052004F0054004F004E00440041004D0045004E0054004F00010000000000
      1E000000560041004C004F00520045005F0043004F005300540041004E005400
      45000100000000002E00000043004F0044004900430049005F00410043004300
      4F005200500041004D0045004E0054004F0056004F0043004900010000000000
      320000005200450047004F004C0041005F00430041004C0043004F004C004F00
      5F004100550054004F004D00410054004900430041000100000000002C000000
      5200450047004F004C0041005F00430041004C0043004F004C004F005F004D00
      41004E00550041004C004500010000000000260000005200450047004F004C00
      41005F004D004F00440049004600490043004100420049004C00450001000000
      00001E0000004E0055004D00450052004F005F00540052004500440043004F00
      520052000100000000001E0000004E0055004D00450052004F005F0054005200
      4500440050005200450043000100000000001C0000004E0055004D0045005200
      4F005F0041005200520043004F00520052000100000000001C0000004E005500
      4D00450052004F005F0041005200520050005200450043000100000000002200
      000044004100540041005F004100430043004F005200500041004D0045004E00
      54004F0001000000000022000000460049004C00540052004F005F0044004900
      500045004E00440045004E0054004900010000000000}
    BeforePost = selP552RigheBeforePost
    AfterPost = selP552RigheAfterPost
    BeforeDelete = selP552RigheBeforeDelete
    AfterDelete = selP552RigheAfterDelete
    AfterScroll = selP552RigheAfterScroll
    OnCalcFields = selP552RigheCalcFields
    Left = 280
    Top = 40
    object selP552ColonneCOLONNA: TIntegerField
      DisplayLabel = 'N.Col'
      DisplayWidth = 5
      FieldName = 'COLONNA'
      Required = True
    end
    object selP552ColonneDESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selP552ColonneVALORE_COSTANTE: TStringField
      DisplayLabel = 'Parametro'
      DisplayWidth = 10
      FieldName = 'VALORE_COSTANTE'
      Size = 500
    end
    object selP552ColonneCOD_ARROTONDAMENTO: TStringField
      DisplayLabel = 'Arrot.'
      FieldName = 'COD_ARROTONDAMENTO'
      Size = 5
    end
    object selP552ColonneDesc_Data_Accorp: TStringField
      DisplayLabel = 'Modalit'#224' accorp.'
      DisplayWidth = 20
      FieldKind = fkCalculated
      FieldName = 'Desc_Data_Accorp'
      Size = 50
      Calculated = True
    end
    object selP552ColonneNUMERO_TREDCORR: TStringField
      DisplayLabel = '13A corr.'
      DisplayWidth = 10
      FieldName = 'NUMERO_TREDCORR'
      Size = 15
    end
    object selP552ColonneNUMERO_TREDPREC: TStringField
      DisplayLabel = '13A prec.'
      DisplayWidth = 10
      FieldName = 'NUMERO_TREDPREC'
      Size = 15
    end
    object selP552ColonneNUMERO_ARRCORR: TStringField
      DisplayLabel = 'Arr.corr.'
      DisplayWidth = 10
      FieldName = 'NUMERO_ARRCORR'
      Size = 15
    end
    object selP552ColonneNUMERO_ARRPREC: TStringField
      DisplayLabel = 'Arr.prec.'
      DisplayWidth = 10
      FieldName = 'NUMERO_ARRPREC'
      Size = 15
    end
    object selP552ColonneREGOLA_MODIFICABILE: TStringField
      DisplayLabel = 'Regola modif.'
      FieldName = 'REGOLA_MODIFICABILE'
      Size = 1
    end
    object selP552ColonneREGOLA_CALCOLO_MANUALE: TStringField
      DisplayLabel = 'Regola'
      DisplayWidth = 100
      FieldName = 'REGOLA_CALCOLO_MANUALE'
      Size = 3000
    end
    object selP552ColonneANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
      Visible = False
    end
    object selP552ColonneCOD_TABELLA: TStringField
      FieldName = 'COD_TABELLA'
      Required = True
      Visible = False
      Size = 10
    end
    object selP552ColonneRIGA: TIntegerField
      FieldName = 'RIGA'
      Required = True
      Visible = False
    end
    object selP552ColonneTIPO_TABELLA_RIGHE: TStringField
      FieldName = 'TIPO_TABELLA_RIGHE'
      Visible = False
      Size = 1
    end
    object selP552ColonneCODICI_ACCORPAMENTOVOCI: TStringField
      FieldName = 'CODICI_ACCORPAMENTOVOCI'
      Visible = False
      Size = 50
    end
    object selP552ColonneREGOLA_CALCOLO_AUTOMATICA: TStringField
      FieldName = 'REGOLA_CALCOLO_AUTOMATICA'
      Visible = False
      Size = 3000
    end
    object selP552ColonneDATA_ACCORPAMENTO: TStringField
      FieldName = 'DATA_ACCORPAMENTO'
      Visible = False
      Size = 2
    end
    object selP552ColonneFILTRO_DIPENDENTI: TStringField
      FieldName = 'FILTRO_DIPENDENTI'
      Visible = False
      Size = 500
    end
  end
  object dsrP552Righe: TDataSource
    DataSet = selP552Righe
    Left = 200
    Top = 96
  end
  object dsrP552Colonne: TDataSource
    DataSet = selP552Colonne
    Left = 280
    Top = 96
  end
  object QSQL: TOracleDataSet
    Optimize = False
    Left = 36
    Top = 192
  end
  object delP552: TOracleQuery
    SQL.Strings = (
      'DELETE FROM P552_CONTOANNREGOLE'
      ' WHERE ANNO = :Anno'
      '   AND COD_TABELLA = :Tabella')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000100000003A0054004100420045004C004C00410005000000000000000000
      0000}
    Left = 104
    Top = 192
  end
  object dsrI010: TDataSource
    Left = 352
    Top = 96
  end
  object selP050: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT COD_ARROTONDAMENTO FROM P050_ARROTONDAMENTI '
      'WHERE DECORRENZA <= :Decorrenza'
      'ORDER BY COD_ARROTONDAMENTO')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    Left = 408
    Top = 40
  end
  object dsrP050: TDataSource
    DataSet = selP050
    Left = 408
    Top = 96
  end
  object selP215: TOracleDataSet
    SQL.Strings = (
      
        'select t.cod_tipoaccorpamentovoci || '#39'.'#39' || t.cod_codiciaccorpam' +
        'entovoci codice, descrizione'
      'from p215_codiciaccorpamentovoci t'
      'order by codice')
    Optimize = False
    Left = 472
    Top = 40
  end
  object selP551: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from p551_contoannfile t'
      'where anno = :Anno'
      '  and cod_tabella = :CodTabella'
      'order by num_campo')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000160000003A0043004F00440054004100420045004C004C00410005000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000080000000800000041004E004E004F00010000000000160000004300
      4F0044005F0054004100420045004C004C004100010000000000120000004E00
      55004D005F00430041004D0050004F0001000000000016000000440045005300
      4300520049005A0049004F004E00450001000000000014000000540049005000
      4F005F00430041004D0050004F000100000000000E00000046004F0052004D00
      410054004F000100000000000E00000046004F0052004D0055004C0041000100
      00000000120000004C0055004E004700480045005A005A004100010000000000}
    BeforePost = selP551BeforePost
    AfterPost = selP551AfterPost
    BeforeDelete = selP551BeforeDelete
    AfterDelete = selP551AfterDelete
    AfterScroll = selP551AfterScroll
    OnCalcFields = selP551CalcFields
    OnNewRecord = selP551NewRecord
    Left = 552
    Top = 40
    object selP551ANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
      Visible = False
    end
    object selP551COD_TABELLA: TStringField
      FieldName = 'COD_TABELLA'
      Required = True
      Visible = False
      Size = 10
    end
    object selP551NUM_CAMPO: TIntegerField
      DisplayLabel = 'Num.'
      DisplayWidth = 5
      FieldName = 'NUM_CAMPO'
      Required = True
    end
    object selP551TIPO_CAMPO: TStringField
      DisplayLabel = 'Tipo campo'
      FieldName = 'TIPO_CAMPO'
      Required = True
      Size = 10
    end
    object selP551DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selP551FORMATO: TStringField
      DisplayLabel = 'Formato'
      FieldName = 'FORMATO'
      Required = True
      Size = 5
    end
    object selP551LUNGHEZZA: TIntegerField
      DisplayLabel = 'Lunghezza'
      FieldName = 'LUNGHEZZA'
      Required = True
    end
    object selP551LungProg: TIntegerField
      DisplayLabel = 'Lung.prog.'
      FieldKind = fkCalculated
      FieldName = 'LungProg'
      Calculated = True
    end
    object selP551FORMULA: TStringField
      DisplayLabel = 'Formula'
      DisplayWidth = 20
      FieldName = 'FORMULA'
      Size = 200
    end
  end
  object dsrP551: TDataSource
    DataSet = selP551
    Left = 552
    Top = 96
  end
  object delP551: TOracleQuery
    SQL.Strings = (
      'DELETE FROM P551_CONTOANNFILE'
      ' WHERE ANNO = :Anno'
      '   AND COD_TABELLA = :Tabella')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0041004E004E004F0003000000000000000000
      0000100000003A0054004100420045004C004C00410005000000000000000000
      0000}
    Left = 104
    Top = 240
  end
end
