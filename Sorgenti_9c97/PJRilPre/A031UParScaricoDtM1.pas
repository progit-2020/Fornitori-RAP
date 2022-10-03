unit A031UParScaricoDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, RegistrazioneLog, A000UCostanti, A000USessione,A000UInterfaccia, OracleData, Oracle,
  C180FunzioniGenerali, Variants;

type
  TA031FParScaricoDtM1 = class(TDataModule)
    QI100: TOracleDataSet;
    QI100SCARICO: TStringField;
    QI100NOMEFILE: TStringField;
    QI100TCP: TStringField;
    QI100IPADDRESS: TStringField;
    QI100CORRENTE: TStringField;
    QI100BADGE: TStringField;
    QI100EDBADGE: TStringField;
    QI100ANNO: TStringField;
    QI100MESE: TStringField;
    QI100GIORNO: TStringField;
    QI100ORE: TStringField;
    QI100MINUTI: TStringField;
    QI100SECONDI: TStringField;
    QI100VERSO: TStringField;
    QI100RILEVATORE: TStringField;
    QI100CAUSALE: TStringField;
    QI100ENTRATA: TStringField;
    QI100USCITA: TStringField;
    QI100TIPOSCARICO: TStringField;
    QI100TRIGGER_BEFORE: TStringField;
    QI100TRIGGER_AFTER: TStringField;
    QI100AZIENDE: TStringField;
    selI090: TOracleDataSet;
    QI100FUNZIONE: TStringField;
    QI100TIMB_NONTOLL_GGPREC: TIntegerField;
    QI100TIMB_NONTOLL_GGSUCC: TIntegerField;
    QI100TIMB_NONTOLL_LOG: TStringField;
    QI100TIMB_NONTOLL_REG: TStringField;
    QI100OFFSET_ANNO: TIntegerField;
    QI100CHIAVE: TStringField;
    QI100EXPR_CHIAVE: TStringField;
    procedure A031FParScaricoDtM1Create(Sender: TObject);
    procedure QI100NewRecord(DataSet: TDataSet);
    procedure QI100AfterPost(DataSet: TDataSet);
    procedure QI100AfterCancel(DataSet: TDataSet);
    procedure QI100AfterDelete(DataSet: TDataSet);
    procedure QI100BeforePost(DataSet: TDataSet);
    procedure QI100BeforeDelete(DataSet: TDataSet);
  private
    function CtrlExprChiave(const PExpr: String; var Err: String): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A031FParScaricoDtM1: TA031FParScaricoDtM1;

implementation

uses A031UParScarico;

{$R *.DFM}

procedure TA031FParScaricoDtM1.A031FParScaricoDtM1Create(Sender: TObject);
var i:Integer;
    where:String;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  QI100.ClearVariables;
  if (Parametri.Azienda <> 'AZIN') then
  begin
    Where:='WHERE INSTR('',''||I100.AZIENDE||'','','',' + Parametri.Azienda + ','') > 0';
    Where:=Where + ' OR I100.AZIENDE IS NULL';
    QI100.SetVariable('WHERE',where);
  end;

  QI100.Open;
  selI090.Open;
end;

procedure TA031FParScaricoDtM1.QI100NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('Corrente').AsString:='N';
  DataSet.FieldByName('TCP').AsString:='N';
  DataSet.FieldByName('Badge').AsString:='0,0';
  DataSet.FieldByName('EdBadge').AsString:='0,0';
  DataSet.FieldByName('Anno').AsString:='0,0';
  DataSet.FieldByName('Mese').AsString:='0,0';
  DataSet.FieldByName('Giorno').AsString:='0,0';
  DataSet.FieldByName('Ore').AsString:='0,0';
  DataSet.FieldByName('Minuti').AsString:='0,0';
  DataSet.FieldByName('Secondi').AsString:='0,0';
  DataSet.FieldByName('Verso').AsString:='0,0';
  DataSet.FieldByName('Rilevatore').AsString:='0,0';
  DataSet.FieldByName('Causale').AsString:='0,0';
  DataSet.FieldByName('Entrata').AsString:='1';
  DataSet.FieldByName('Uscita').AsString:='0';
  DataSet.FieldByName('TipoScarico').AsString:='0';
end;

function TA031FParScaricoDtM1.CtrlExprChiave(const PExpr: String; var Err: String): Boolean;
var
  Lst: TStringList;
  i: Integer;
  NomeVar: String;
  OQ: TOracleQuery;
  EsisteVarChiave: Boolean;
begin
  Result:=True;
  Err:='';

  Lst:=TStringList.Create;
  OQ:=TOracleQuery.Create(Self);
  try
    // 1. l'espressione deve contenere la variabile :CHIAVE (tipo alfanumerico)
    //    e opzionalmente la variabile :DATA (tipo date)
    OQ.Session:=SessioneOracle;
    OQ.SQL.Text:=PExpr;

    Lst:=FindVariables(PExpr,False); // non considera i duplicati
    Lst.CaseSensitive:=False;

    // controllo presenza obbligatoria della variabile "chiave"
    if Lst.IndexOf('CHIAVE') = -1  then
    begin
      Result:=False;
      Err:='L''espressione per la chiave deve necessariamente contenere una variabile denominata ":CHIAVE"!';
      Exit;
    end;

    for i:=0 to Lst.Count - 1 do
    begin
      NomeVar:=UpperCase(Lst[i]);
      if NomeVar = 'CHIAVE' then
      begin
        OQ.DeclareAndSet(NomeVar,otString,'1');
      end
      else if NomeVar = 'DATA' then
      begin
        OQ.DeclareAndSet(NomeVar,otDate,DATE_NULL);
      end
      else
      begin
        Result:=False;
        Err:=Format('L''espressione per la chiave non ammette l''utilizzo della variabile "%s"!',[NomeVar]);
        Exit;
      end;
    end;

    // 2. l'espressione deve essere formalmente corretta
    try
      OQ.Execute;
    except
      on E: Exception do
      begin
        Result:=False;
        Err:=Format('L''espressione per la chiave non è corretta:'#13#10'%s',[E.Message]);
        Exit;
      end;
    end;

    // 3. l'espressione deve estrarre una sola colonna di tipo number (il progressivo)
    if OQ.FieldCount > 1 then
    begin
      Result:=False;
      Err:='L''espressione per la chiave deve selezionare unicamente il progressivo del dipendente!';
      Exit;
    end;
    if (OQ.FieldType(0) <> otInteger) and
       (OQ.FieldType(0) <> otFloat) then
    begin
      Result:=False;
      Err:=Format('L''espressione per la chiave deve selezionare il progressivo del dipendente: ' +
                  'il dato selezionato "%s" non è di tipo numerico!',[OQ.FieldName(0)]);
      Exit;
    end;
  finally
    FreeAndNil(Lst);
    FreeAndNil(OQ);
  end;
end;

procedure TA031FParScaricoDtM1.QI100BeforePost(DataSet: TDataSet);
{Copio i dati della griglia nei campi corrispondenti prima di confermare le modifiche}
var
  {i:Byte;
  P,L:Word;
  }
  i,P,L: Integer;
  Errore: String;
begin
  if QueryPK1.EsisteChiave('MONDOEDP.I100_PARSCARICO',QI100.RowId,QI100.State,['SCARICO'],[QI100Scarico.AsString]) then
    raise Exception.Create('Codice già esistente!');

  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
  // trim dell'espressione per la chiave
  QI100.FieldByName('EXPR_CHIAVE').AsString:=Trim(QI100.FieldByName('EXPR_CHIAVE').AsString);
  // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine

  with A031FParScarico do
  begin
    for i:=5 to {15}16 do // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6
    begin
      P:=StrToIntDef(StringGrid1.Cells[i - 4,1],0);
      L:=StrToIntDef(StringGrid1.Cells[i - 4,2],0);
      if (QI100.Fields[i].Name = 'QI100RILEVATORE') and (L > 10) then
        raise Exception.Create('Il rilevatore può essere lungo al massimo 10 caratteri!');
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
      // chiave max 20 caratteri
      if (QI100.Fields[i].FieldName = 'CHIAVE') and (L > 20) then
        raise Exception.Create('Il dato Chiave può essere lungo al massimo 20 caratteri!');
      // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
      QI100.Fields[i].AsString:=IntToStr(P) + ',' + IntToStr(L);
    end;

    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.ini
    // controllo indicazione chiave in alternativa al badge
    if (QI100.FieldByName('BADGE').AsString <> '0,0') and
       (QI100.FieldByName('CHIAVE').AsString <> '0,0') then
    begin
      raise Exception.Create('La parametrizzazione del dato Chiave è ammessa solo in alternativa al Badge!');
    end;

    // se il dato chiave è indicato richiede obbligatoriamente l'espressione relativa
    if (QI100.FieldByName('CHIAVE').AsString <> '0,0') and
       (QI100.FieldByName('EXPR_CHIAVE').AsString = '') then
    begin
      raise Exception.Create('E'' necessario indicare obbligatoriamente l''espressione per la chiave!');
    end;

    // controllo indicazione espressione chiave
    if QI100.FieldByName('EXPR_CHIAVE').AsString <> '' then
    begin
      // l'espressione è ammessa solo se è parametrizzato il dato Chiave
      if QI100.FieldByName('CHIAVE').AsString = '0,0' then
      begin
        raise Exception.Create('L''espressione per la chiave è da indicare solo se è parametrizzato il corrispondente dato!');
      end;

      // controlli sull'espressione SQL per la chiave
      if not CtrlExprChiave(QI100.FieldByName('EXPR_CHIAVE').AsString,Errore) then
        raise Exception.Create(Errore);
    end;
    // AOSTA_REGIONE - commessa 2013/118 SVILUPPO#6.fine
  end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA031FParScaricoDtM1.QI100AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=QI100Scarico.AsString;
  SessioneOracle.ApplyUpdates([QI100],True);
  RegistraLog.RegistraOperazione;
  QI100.Close;
  QI100.Open;
  QI100.Locate('Scarico',S,[]);
end;

procedure TA031FParScaricoDtM1.QI100AfterCancel(DataSet: TDataSet);
begin
  QI100.CancelUpdates;
end;

procedure TA031FParScaricoDtM1.QI100AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([QI100],True);
  RegistraLog.RegistraOperazione;
end;

procedure TA031FParScaricoDtM1.QI100BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

end.
