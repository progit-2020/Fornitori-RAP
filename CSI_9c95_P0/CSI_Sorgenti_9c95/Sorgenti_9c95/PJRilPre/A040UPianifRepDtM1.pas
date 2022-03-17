unit A040UPianifRepDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  C700USelezioneAnagrafe, Oracle, OracleData,
  C180FunzioniGenerali, Variants, USelI010, DBClient,
  Math, StrUtils, A040UPianifRepMW;

type
  TA040FPianifRepDtM1 = class(TDataModule)
    selT380: TOracleDataSet;
    selT380DATA: TDateTimeField;
    selT380PROGRESSIVO: TFloatField;
    selT380TURNO1: TStringField;
    selT380TURNO2: TStringField;
    selT380DATOLIBERO: TStringField;
    selT380D_MATRICOLA: TStringField;
    selT380D_NOMINATIVO: TStringField;
    selT380TURNO3: TStringField;
    selT380TIPOLOGIA: TStringField;
    selT380D_BADGE: TFloatField;
    selT380PRIORITA1: TIntegerField;
    selT380PRIORITA2: TIntegerField;
    selT380PRIORITA3: TIntegerField;
    D010: TDataSource;
    D010B: TDataSource;
    Q380St: TOracleDataSet;
    selT350Cod: TOracleDataSet;
    selTurni: TOracleDataSet;
    selT380SUPERO_MAXMESE1: TStringField;
    selT380SUPERO_MAXMESE2: TStringField;
    selT380SUPERO_MAXMESE3: TStringField;
    procedure A040FPianifRepDtM1Create(Sender:TObject);
    procedure A040FPianifRepDtM1Destroy(Sender:TObject);
    procedure selT380AfterPost(DataSet:TDataSet);
    procedure selT380BeforeDelete(DataSet:TDataSet);
    procedure selT380BeforeInsert(DataSet:TDataSet);
    procedure selT380BeforePost(DataSet:TDataSet);
    procedure selT380NewRecord(DataSet:TDataSet);
    procedure TURNOSetText(Sender:TField;const Text:String);
    procedure TURNOValidate(Sender:TField);
    procedure selT380DATAValidate(Sender:TField);
    procedure selT380DATOLIBEROSetText(Sender:TField;const Text:String);
    procedure selT380DATOLIBEROValidate(Sender:TField);
  private
    { Private declarations }
    procedure evtRichiesta(Msg,Chiave:String);
    procedure evtRichiestaRefresh(Msg,Chiave:String);
    function evtGiornataAssenza(Msg:String):Integer;
    function evtTurnoNonInserito(Msg:String):Boolean;
    procedure evtLimitiMese(Msg,Chiave:String);
  public
    A040MW: TA040FPianifRepMW;
    selI010,selI010B: TselI010;
  end;

var
  A040FPianifRepDtM1: TA040FPianifRepDtM1;

implementation

uses A040UInserimento, A040UPianifRep;

{$R *.DFM}

procedure TA040FPianifRepDtM1.A040FPianifRepDtM1Create(Sender:TObject);
{Preparo le query Mensili}
var
  i:Integer;
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
  A040MW:=TA040FPianifRepMW.Create(Self);
  A040MW.selT380:=selT380;
  A040MW.evtRichiesta:=evtRichiesta;
  A040MW.evtRichiestaRefresh:=evtRichiestaRefresh;
  A040MW.evtGiornataAssenza:=evtGiornataAssenza;
  A040MW.evtTurnoNonInserito:=evtTurnoNonInserito;
  A040MW.evtLimitiMese:=evtLimitiMese;
  selT350Cod.OnFilterRecord:=A040MW.FiltroDizionario;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  D010.DataSet:=selI010;
  selI010B:=TselI010.Create(Self);
  selI010B.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  D010B.DataSet:=selI010B;
end;

procedure TA040FPianifRepDtM1.A040FPianifRepDtM1Destroy(Sender:TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(selI010);
  FreeAndNil(selI010B);
end;

procedure TA040FPianifRepDtM1.selT380AfterPost(DataSet:TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  A040MW.AfterPost;
end;

procedure TA040FPianifRepDtM1.selT380BeforeDelete(DataSet:TDataSet);
begin
  A040MW.BeforeDelete;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA040FPianifRepDtM1.selT380BeforeInsert(DataSet:TDataSet);
begin
  A040MW.BeforeInsert;
end;

procedure TA040FPianifRepDtM1.selT380BeforePost(DataSet:TDataSet);
begin
  Screen.Cursor:=crHourGlass;
  try
    A040MW.NonContDipPian:=A040FPianifRep.chkNonContDipPian.Checked;
    A040MW.BeforePost;
    case DataSet.State of
      dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
      dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA040FPianifRepDtM1.selT380NewRecord(DataSet:TDataSet);
begin
  A040MW.NewRecord(EncodeDate(A040FPianifRep.EAnno.Value,A040FPianifRep.EMese.Value,1));
end;

procedure TA040FPianifRepDtM1.TURNOSetText(Sender:TField;const Text:String);
begin
  A040MW.selT380ImpostaTesto(Sender,Text,5);
end;

procedure TA040FPianifRepDtM1.TURNOValidate(Sender:TField);
begin
  A040MW.selT380ValidaTurno(Sender);
end;

procedure TA040FPianifRepDtM1.selT380DATAValidate(Sender:TField);
begin
  A040MW.selT380ValidaData;
end;

procedure TA040FPianifRepDtM1.selT380DATOLIBEROSetText(Sender:TField;const Text:String);
begin
  A040MW.selT380ImpostaTesto(Sender,Text,20);
end;

procedure TA040FPianifRepDtM1.selT380DATOLIBEROValidate(Sender:TField);
begin
  A040MW.selT380ValidaDatoLibero;
end;

procedure TA040FPianifRepDtM1.evtRichiesta(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    abort
  else
    A040MW.TestoAnomalia:='';//Per segnalare eventuali anomalie non previste
end;

procedure TA040FPianifRepDtM1.evtRichiestaRefresh(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
  begin
    A040MW.RefreshT380;
    abort;
  end
  else
    A040MW.TestoAnomalia:='';//Per segnalare eventuali anomalie non previste
end;

function TA040FPianifRepDtM1.evtGiornataAssenza(Msg:String):Integer;
begin
  Result:=R180MessageBox(Msg,IfThen((A040MW.ProceduraChiamante = 1) and A040MW.TuttiDip,'DOMANDA_ALL','DOMANDA'));
end;

function TA040FPianifRepDtM1.evtTurnoNonInserito(Msg:String):Boolean;
begin
  Result:=R180MessageBox(Msg,'DOMANDA') = mrYes;
end;

procedure TA040FPianifRepDtM1.evtLimitiMese(Msg,Chiave:String);
var Risposta:Integer;
begin
  Risposta:=R180MessageBox(Msg,IfThen((A040MW.ProceduraChiamante = 1) and A040MW.TuttiDip,'DOMANDA_ESCI','DOMANDA'));
  if Risposta = mrCancel then
    A040MW.ElaborazioneInterrotta:=True;
  if Risposta <> mrYes then
    abort
  else
    A040MW.TestoAnomalia:='';//Per segnalare eventuali anomalie non previste
end;

end.

