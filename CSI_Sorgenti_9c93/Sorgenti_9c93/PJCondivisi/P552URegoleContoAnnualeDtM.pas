unit P552URegoleContoAnnualeDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, C180FunzioniGenerali,
  USelI010, A000UCostanti, A000USessione, A000UInterfaccia;

type
  TP552FRegoleContoAnnualeDtM = class(TR004FGestStoricoDtM)
    selP552: TOracleDataSet;
    selP552Ricerca: TOracleDataSet;
    dsrP552Ricerca: TDataSource;
    selP552Righe: TOracleDataSet;
    selP552Colonne: TOracleDataSet;
    dsrP552Righe: TDataSource;
    dsrP552Colonne: TDataSource;
    selP552RigheRIGA: TIntegerField;
    selP552RigheDESCRIZIONE: TStringField;
    selP552RigheVALORE_COSTANTE: TStringField;
    selP552RigheCODICI_ACCORPAMENTOVOCI: TStringField;
    selP552RigheREGOLA_CALCOLO_MANUALE: TStringField;
    selP552RigheNUMERO_TREDCORR: TStringField;
    selP552RigheNUMERO_TREDPREC: TStringField;
    selP552RigheNUMERO_ARRCORR: TStringField;
    selP552RigheNUMERO_ARRPREC: TStringField;
    selP552RigheANNO: TIntegerField;
    selP552RigheCOD_TABELLA: TStringField;
    selP552RigheCOLONNA: TIntegerField;
    selP552RigheTIPO_TABELLA_RIGHE: TStringField;
    selP552RigheCOD_ARROTONDAMENTO: TStringField;
    selP552RigheREGOLA_CALCOLO_AUTOMATICA: TStringField;
    selP552RigheREGOLA_MODIFICABILE: TStringField;
    selP552RigheDATA_ACCORPAMENTO: TStringField;
    selP552ColonneANNO: TIntegerField;
    selP552ColonneCOD_TABELLA: TStringField;
    selP552ColonneRIGA: TIntegerField;
    selP552ColonneCOLONNA: TIntegerField;
    selP552ColonneDESCRIZIONE: TStringField;
    selP552ColonneTIPO_TABELLA_RIGHE: TStringField;
    selP552ColonneCOD_ARROTONDAMENTO: TStringField;
    selP552ColonneVALORE_COSTANTE: TStringField;
    selP552ColonneCODICI_ACCORPAMENTOVOCI: TStringField;
    selP552ColonneREGOLA_CALCOLO_AUTOMATICA: TStringField;
    selP552ColonneREGOLA_CALCOLO_MANUALE: TStringField;
    selP552ColonneREGOLA_MODIFICABILE: TStringField;
    selP552ColonneNUMERO_TREDCORR: TStringField;
    selP552ColonneNUMERO_TREDPREC: TStringField;
    selP552ColonneNUMERO_ARRCORR: TStringField;
    selP552ColonneNUMERO_ARRPREC: TStringField;
    selP552ColonneDATA_ACCORPAMENTO: TStringField;
    QSQL: TOracleDataSet;
    selP552RigheDesc_Data_Accorp: TStringField;
    selP552ColonneDesc_Data_Accorp: TStringField;
    delP552: TOracleQuery;
    dsrI010: TDataSource;
    selP050: TOracleDataSet;
    dsrP050: TDataSource;
    selP215: TOracleDataSet;
    selP552RigheFILTRO_DIPENDENTI: TStringField;
    selP552ColonneFILTRO_DIPENDENTI: TStringField;
    selP551: TOracleDataSet;
    dsrP551: TDataSource;
    selP551ANNO: TIntegerField;
    selP551COD_TABELLA: TStringField;
    selP551NUM_CAMPO: TIntegerField;
    selP551DESCRIZIONE: TStringField;
    selP551TIPO_CAMPO: TStringField;
    selP551FORMATO: TStringField;
    selP551FORMULA: TStringField;
    selP551LUNGHEZZA: TIntegerField;
    selP551LungProg: TIntegerField;
    delP551: TOracleQuery;
    procedure selP551AfterDelete(DataSet: TDataSet);
    procedure selP551AfterPost(DataSet: TDataSet);
    procedure selP551BeforeDelete(DataSet: TDataSet);
    procedure selP551CalcFields(DataSet: TDataSet);
    procedure selP551NewRecord(DataSet: TDataSet);
    procedure selP551BeforePost(DataSet: TDataSet);
    procedure selP551AfterScroll(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selP552RigheAfterDelete(DataSet: TDataSet);
    procedure selP552RigheAfterPost(DataSet: TDataSet);
    procedure selP552RigheBeforeDelete(DataSet: TDataSet);
    procedure selP552RigheCalcFields(DataSet: TDataSet);
    procedure selP552RigheBeforePost(DataSet: TDataSet);
    procedure selP552RigheAfterScroll(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selP552AfterScroll(DataSet: TDataSet);
    procedure selP552NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    selI010:TselI010;
  public
    { Public declarations }
  end;

var
  P552FRegoleContoAnnualeDtM: TP552FRegoleContoAnnualeDtM;

implementation

uses P552URegoleContoAnnuale, P552UDettaglioRegoleContoAnn,
  P552UEsportazioneFile;

{$R *.dfm}

procedure TP552FRegoleContoAnnualeDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selP552,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selP552.AfterScroll:=nil;
  selP552.Open;
  selP552.AfterScroll:=selP552AfterScroll;
  selP552Colonne.Open;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,'',Parametri.Applicazione,
    'DECODE(SUBSTR(NOME_CAMPO,1,4),''T430'',''T430_STORICO'',''P430'',''P430_ANAGRAFICO'','''') TABELLA, ' +
      'REPLACE(REPLACE(NOME_CAMPO,''T430'',''''),''P430'','''') NOME_CAMPO, ' +
      'NOME_LOGICO',
    'TABLE_NAME = ''V430_STORICO'' AND SUBSTR(NOME_CAMPO,5,2) <> ''D_''' +
      ' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''PROGRESSIVO'' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''DATADECORRENZA''' +
      ' AND REPLACE(NOME_CAMPO,''T430'','''') <> ''DATAFINE'' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''PROGRESSIVO''' +
      ' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''DECORRENZA'' AND REPLACE(NOME_CAMPO,''P430'','''') <> ''DECORRENZA_FINE''',
    'NOME_LOGICO');
  dsrI010.DataSet:=selI010;
end;

procedure TP552FRegoleContoAnnualeDtM.selP552NewRecord(DataSet: TDataSet);
begin
  inherited;
  selP552.FieldByName('ANNO').AsInteger:=StrToIntDef(P552FRegoleContoAnnuale.edtAnno.Text,1900);
  selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString:='0';
end;

procedure TP552FRegoleContoAnnualeDtM.selP552AfterScroll(DataSet: TDataSet);
begin
  inherited;
  selP050.Close;
  selP050.SetVariable('DECORRENZA',EncodeDate(selP552.FieldByName('ANNO').AsInteger,12,31));
  selP050.Open;
  P552FRegoleContoAnnuale.drdgTipologiaClick(nil);
end;

procedure TP552FRegoleContoAnnualeDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if (selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '1') and
     (Trim(selP552.FieldByName('VALORE_COSTANTE').AsString) = '') then
    raise exception.Create('Indicare il Nome del dato libero!');
  if (selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '3') and
     (Trim(selP552.FieldByName('VALORE_COSTANTE').AsString) = '') then
    raise exception.Create('Indicare il testo della Funzione Oracle!');
  selP552.FieldByName('RIGA').AsInteger:=0;
  selP552.FieldByName('COLONNA').AsInteger:=0;
end;

procedure TP552FRegoleContoAnnualeDtM.selP552RigheAfterScroll(DataSet: TDataSet);
var i:Integer;
  App:String;
begin
  inherited;
  if P552FDettaglioRegoleContoAnn <> nil then
    with P552FDettaglioRegoleContoAnn do
    begin
      if Dataset.FieldByName('NUMERO_TREDCORR').AsString = 'NC' then
      begin
        CmbTabTredicesimaAC.Text:=Format('%-10s',['NC']) + '-' + 'Non conteggiare';
        cmbTabTredicesimaACChange(nil);
        CmbRigheTredicesimaAC.Text:='';
      end
      else
      begin
        App:=Copy(Dataset.FieldByName('NUMERO_TREDCORR').AsString,1,Pos('.',Dataset.FieldByName('NUMERO_TREDCORR').AsString)-1);
        i:=R180IndexOf(CmbTabTredicesimaAC.Items,App,10);
        if i >= 0 then
          CmbTabTredicesimaAC.Text:=Format('%-10s',[App]) + '-' +
                                    Copy(CmbTabTredicesimaAC.Items[i],12,Length(CmbTabTredicesimaAC.Items[i])-11)
        else
          CmbTabTredicesimaAC.Text:='';
        cmbTabTredicesimaACChange(nil);
        App:=Copy(Dataset.FieldByName('NUMERO_TREDCORR').AsString, Pos('.',Dataset.FieldByName('NUMERO_TREDCORR').AsString)+1,
             Length(Dataset.FieldByName('NUMERO_TREDCORR').AsString)-Pos('.',Dataset.FieldByName('NUMERO_TREDCORR').AsString));
        i:=R180IndexOf(CmbRigheTredicesimaAC.Items,App,3);
        if i >= 0 then
          CmbRigheTredicesimaAC.Text:=Format('%-3s',[App]) + '-' +
                                      Copy(CmbRigheTredicesimaAC.Items[i],5,Length(CmbRigheTredicesimaAC.Items[i])-4)
        else
          CmbRigheTredicesimaAC.Text:='';
      end;
      if Dataset.FieldByName('NUMERO_TREDPREC').AsString = 'NC' then
      begin
        CmbTabTredicesimaAP.Text:=Format('%-10s',['NC']) + '-' + 'Non conteggiare';
        CmbRigheTredicesimaAP.Text:='';
      end
      else
      begin
        App:=Copy(Dataset.FieldByName('NUMERO_TREDPREC').AsString,1,Pos('.',Dataset.FieldByName('NUMERO_TREDPREC').AsString)-1);
        i:=R180IndexOf(CmbTabTredicesimaAP.Items,App,10);
        if i >= 0 then
          CmbTabTredicesimaAP.Text:=Format('%-10s',[App]) + '-' +
                                    Copy(CmbTabTredicesimaAP.Items[i],12,Length(CmbTabTredicesimaAP.Items[i])-11)
        else
          CmbTabTredicesimaAP.Text:='';
        cmbTabTredicesimaAPChange(nil);
        App:=Copy(Dataset.FieldByName('NUMERO_TREDPREC').AsString, Pos('.',Dataset.FieldByName('NUMERO_TREDPREC').AsString)+1,
             Length(Dataset.FieldByName('NUMERO_TREDPREC').AsString)-Pos('.',Dataset.FieldByName('NUMERO_TREDPREC').AsString));
        i:=R180IndexOf(CmbRigheTredicesimaAP.Items,App,3);
        if i >= 0 then
          CmbRigheTredicesimaAP.Text:=Format('%-3s',[App]) + '-' +
                                      Copy(CmbRigheTredicesimaAP.Items[i],5,Length(CmbRigheTredicesimaAP.Items[i])-4)
        else
          CmbRigheTredicesimaAP.Text:='';
      end;
      if Dataset.FieldByName('NUMERO_ARRCORR').AsString = 'NC' then
      begin
        CmbTabArretratiAC.Text:=Format('%-10s',['NC']) + '-' + 'Non conteggiare';
        CmbRigheArretratiAC.Text:='';
      end
      else
      begin
        App:=Copy(Dataset.FieldByName('NUMERO_ARRCORR').AsString,1,Pos('.',Dataset.FieldByName('NUMERO_ARRCORR').AsString)-1);
        i:=R180IndexOf(CmbTabArretratiAC.Items,App,10);
        if i >= 0 then
          CmbTabArretratiAC.Text:=Format('%-10s',[App]) + '-' +
                                  Copy(CmbTabArretratiAC.Items[i],12,Length(CmbTabArretratiAC.Items[i])-11)
        else
          CmbTabArretratiAC.Text:='';
        CmbTabArretratiACChange(nil);
        App:=Copy(Dataset.FieldByName('NUMERO_ARRCORR').AsString, Pos('.',Dataset.FieldByName('NUMERO_ARRCORR').AsString)+1,
             Length(Dataset.FieldByName('NUMERO_ARRCORR').AsString)-Pos('.',Dataset.FieldByName('NUMERO_ARRCORR').AsString));
        i:=R180IndexOf(CmbRigheArretratiAC.Items,App,3);
        if i >= 0 then
          CmbRigheArretratiAC.Text:=Format('%-3s',[App]) + '-' +
                                      Copy(CmbRigheArretratiAC.Items[i],5,Length(CmbRigheArretratiAC.Items[i])-4)
        else
          CmbRigheArretratiAC.Text:='';
      end;
      if Dataset.FieldByName('NUMERO_ARRPREC').AsString = 'NC' then
      begin
        CmbTabArretratiAP.Text:=Format('%-10s',['NC']) + '-' + 'Non conteggiare';
        CmbRigheArretratiAP.Text:='';
      end
      else
      begin
        App:=Copy(Dataset.FieldByName('NUMERO_ARRPREC').AsString,1,Pos('.',Dataset.FieldByName('NUMERO_ARRPREC').AsString)-1);
        i:=R180IndexOf(CmbTabArretratiAP.Items,App,10);
        if i >= 0 then
          CmbTabArretratiAP.Text:=Format('%-10s',[App]) + '-' +
                                  Copy(CmbTabArretratiAP.Items[i],12,Length(CmbTabArretratiAP.Items[i])-11)
        else
          CmbTabArretratiAP.Text:='';
        CmbTabArretratiAPChange(nil);
        App:=Copy(Dataset.FieldByName('NUMERO_ARRPREC').AsString, Pos('.',Dataset.FieldByName('NUMERO_ARRPREC').AsString)+1,
             Length(Dataset.FieldByName('NUMERO_ARRPREC').AsString)-Pos('.',Dataset.FieldByName('NUMERO_ARRPREC').AsString));
        i:=R180IndexOf(CmbRigheArretratiAP.Items,App,3);
        if i >= 0 then
          CmbRigheArretratiAP.Text:=Format('%-3s',[App]) + '-' +
                                      Copy(CmbRigheArretratiAP.Items[i],5,Length(CmbRigheArretratiAP.Items[i])-4)
        else
          CmbRigheArretratiAP.Text:='';
        dedtCodAccorpamento.Hint:=Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString;
      end;
      drdgModalitaClick(nil);
      dchkRegolaModifClick(nil);
  end;
end;

procedure TP552FRegoleContoAnnualeDtM.selP552RigheBeforePost(DataSet: TDataSet);
begin
  inherited;
  with P552FDettaglioRegoleContoAnn do
  begin
    if (Trim(CmbTabTredicesimaAC.Text) <> '') and (Trim(Copy(CmbTabTredicesimaAC.Text,1,10)) <> 'NC') and
       (Trim(CmbRigheTredicesimaAC.Text) = '') then
      raise exception.Create('Specificare la colonna sostitutiva della Tredicesima AA Corr.!');
    if (Trim(CmbTabTredicesimaAP.Text) <> '') and (Trim(Copy(CmbTabTredicesimaAP.Text,1,10)) <> 'NC') and
       (Trim(CmbRigheTredicesimaAP.Text) = '') then
      raise exception.Create('Specificare la colonna sostitutiva della Tredicesima AA Prec.!');
    if (Trim(CmbTabArretratiAC.Text) <> '') and (Trim(Copy(CmbTabArretratiAC.Text,1,10)) <> 'NC') and
       (Trim(CmbRigheArretratiAC.Text) = '') then
      raise exception.Create('Specificare la colonna sostitutiva degli Arretrati AA Corr.!');
    if (Trim(CmbTabArretratiAP.Text) <> '') and (Trim(Copy(CmbTabArretratiAP.Text,1,10)) <> 'NC') and
       (Trim(CmbRigheArretratiAP.Text) = '') then
      raise exception.Create('Specificare la colonna sostitutiva degli Arretrati AA Prec.!');
    DataSet.FieldByName('COD_TABELLA').AsString:=TabElab;
    DataSet.FieldByName('ANNO').AsInteger:=StrToIntDef(AnnoElab,0);
    if DataSet = selP552Righe then
      Dataset.FieldByName('COLONNA').AsInteger:=0
    else if DataSet = selP552Colonne then
      Dataset.FieldByName('RIGA').AsInteger:=0;
    if not dedtCodAccorpamento.Visible then
      Dataset.FieldByName('CODICI_ACCORPAMENTOVOCI').AsString:='';
    DataSet.FieldByName('NUMERO_TREDCORR').AsString:='';
    if gpbTabSostitutive.Visible then
    begin
      if Trim(Copy(CmbTabTredicesimaAC.Text,1,10)) = 'NC' then
        DataSet.FieldByName('NUMERO_TREDCORR').AsString:='NC'
      else if Trim(CmbTabTredicesimaAC.Text) <> '' then
        DataSet.FieldByName('NUMERO_TREDCORR').AsString:=TrimRight(Copy(CmbTabTredicesimaAC.Text,1,10)) + '.' +
                                                         TrimRight(Copy(CmbRigheTredicesimaAC.Text,1,3));
    end;
    DataSet.FieldByName('NUMERO_TREDPREC').AsString:='';
    if gpbTabSostitutive.Visible then
    begin
      if Trim(Copy(CmbTabTredicesimaAP.Text,1,10)) = 'NC' then
        DataSet.FieldByName('NUMERO_TREDPREC').AsString:='NC'
      else if Trim(CmbTabTredicesimaAP.Text) <> '' then
        DataSet.FieldByName('NUMERO_TREDPREC').AsString:=TrimRight(Copy(CmbTabTredicesimaAP.Text,1,10)) + '.' +
                                                         TrimRight(Copy(CmbRigheTredicesimaAP.Text,1,3));
    end;
    DataSet.FieldByName('NUMERO_ARRCORR').AsString:='';
    if gpbTabSostitutive.Visible then
    begin
      if Trim(Copy(CmbTabArretratiAC.Text,1,10)) = 'NC' then
        DataSet.FieldByName('NUMERO_ARRCORR').AsString:='NC'
      else if Trim(CmbTabArretratiAC.Text) <> '' then
        DataSet.FieldByName('NUMERO_ARRCORR').AsString:=TrimRight(Copy(CmbTabArretratiAC.Text,1,10)) + '.' +
                                                        TrimRight(Copy(CmbRigheArretratiAC.Text,1,3));
    end;
    DataSet.FieldByName('NUMERO_ARRPREC').AsString:='';
    if gpbTabSostitutive.Visible then
    begin
      if Trim(Copy(CmbTabArretratiAP.Text,1,10)) = 'NC' then
        DataSet.FieldByName('NUMERO_ARRPREC').AsString:='NC'
      else if Trim(CmbTabArretratiAP.Text) <> '' then
        DataSet.FieldByName('NUMERO_ARRPREC').AsString:=TrimRight(Copy(CmbTabArretratiAP.Text,1,10)) + '.' +
                                                        TrimRight(Copy(CmbRigheArretratiAP.Text,1,3));
    end;
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TP552FRegoleContoAnnualeDtM.selP552RigheCalcFields(DataSet: TDataSet);
begin
  inherited;
  if DataSet.FieldByName('DATA_ACCORPAMENTO').AsString = 'NA' then
    DataSet.FieldByName('Desc_Data_Accorp').AsString:='Nessun accorpamento'
  else if DataSet.FieldByName('DATA_ACCORPAMENTO').AsString = 'DC' then
    DataSet.FieldByName('Desc_Data_Accorp').AsString:='Data cedolino'
  else if DataSet.FieldByName('DATA_ACCORPAMENTO').AsString = 'DR' then
    DataSet.FieldByName('Desc_Data_Accorp').AsString:='Data retribuzione'
  else if DataSet.FieldByName('DATA_ACCORPAMENTO').AsString = 'CM' then
    DataSet.FieldByName('Desc_Data_Accorp').AsString:='Data competenza';
end;

procedure TP552FRegoleContoAnnualeDtM.selP552RigheBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TP552FRegoleContoAnnualeDtM.selP552RigheAfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TP552FRegoleContoAnnualeDtM.selP552RigheAfterDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TP552FRegoleContoAnnualeDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selI010);
end;

procedure TP552FRegoleContoAnnualeDtM.selP551AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if P552FEsportazioneFile = nil then
    Exit;
  with P552FEsportazioneFile do
  begin
    edtNumCampo.Value:=selP551.FieldByName('NUM_CAMPO').AsInteger;
    cmbFormato.Text:=cmbFormato.Items[R180IndexOf(cmbFormato.Items,selP551.FieldByName('FORMATO').AsString,3)];
    cmbTipoCampo.Text:=cmbTipoCampo.Items[R180IndexOf(cmbTipoCampo.Items,selP551.FieldByName('TIPO_CAMPO').AsString,10)];
  end;
end;

procedure TP552FRegoleContoAnnualeDtM.selP551BeforePost(DataSet: TDataSet);
begin
  inherited;
  if P552FEsportazioneFile = nil then
    Exit;
  with P552FEsportazioneFile do
  begin
    if R180IndexOf(cmbTipoCampo.Items,Copy(cmbTipoCampo.Text,1,10),10) < 0 then
    begin
      cmbTipoCampo.SetFocus;
      raise exception.Create('Attenzione: tipo campo non previsto!');
    end;
    if R180IndexOf(cmbFormato.Items,Copy(cmbFormato.Text,1,10),10) < 0 then
    begin
      cmbFormato.SetFocus;
      raise exception.Create('Attenzione: formato non previsto!');
    end;
    if (TrimRight(Copy(cmbTipoCampo.Text,1,10)) = 'FORMULA') and (Trim(selP551.FieldByName('FORMULA').AsString) = '') then
    begin
      dedtFormula.SetFocus;
      raise exception.Create('Attenzione: specificare il dato formula!');
    end;
    selP551.FieldByName('NUM_CAMPO').AsInteger:=edtNumCampo.Value;
    selP551.FieldByName('FORMATO').AsString:=TrimRight(Copy(cmbFormato.Text,1,3));
    selP551.FieldByName('TIPO_CAMPO').AsString:=TrimRight(Copy(cmbTipoCampo.Text,1,10));
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TP552FRegoleContoAnnualeDtM.selP551NewRecord(DataSet: TDataSet);
begin
  inherited;
  selP551.FieldByName('ANNO').AsInteger:=StrToIntDef(P552FEsportazioneFile.AnnoElab,0);
  selP551.FieldByName('COD_TABELLA').AsString:=P552FEsportazioneFile.TabElab;
end;

procedure TP552FRegoleContoAnnualeDtM.selP551CalcFields(DataSet: TDataSet);
begin
  inherited;
  if (selP551.RecordCount > 0) and (selP551.State <> dsInsert) then
  begin
    QSQL.Close;
    QSQL.SQL.Clear;
    QSQL.SQL.Text:='SELECT SUM(LUNGHEZZA) LUNG FROM P551_CONTOANNFILE ' +
                   ' WHERE COD_TABELLA = ''' + selP551.FieldByName('COD_TABELLA').AsString + '''' +
                   '   AND ANNO = ' + selP551.FieldByName('ANNO').AsString +
                   '   AND NUM_CAMPO <= ' + selP551.FieldByName('NUM_CAMPO').AsString;
    QSQL.Open;
    selP551.FieldByName('LungProg').AsInteger:=QSQL.FieldByName('LUNG').AsInteger;
  end
  else
    selP551.FieldByName('LungProg').AsInteger:=0;
end;

procedure TP552FRegoleContoAnnualeDtM.selP551BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TP552FRegoleContoAnnualeDtM.selP551AfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TP552FRegoleContoAnnualeDtM.selP551AfterDelete(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

end.
