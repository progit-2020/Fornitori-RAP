unit A128UPianPrestazioniAggiuntiveDtm;

interface

uses
  DB, OracleData, Classes, Forms, Oracle, SysUtils, Controls, StrUtils,
  USelI010, A000UInterfaccia, A000USessione,
  C180FunzioniGenerali, A128UPianPrestazioniAggiuntiveMW;

type
  TA128FPianPrestazioniAggiuntiveDtm = class(TDataModule)
    D010: TDataSource;
    Q332St: TOracleDataSet;
    selT332: TOracleDataSet;
    selT332D_MATRICOLA: TStringField;
    selT332D_NOMINATIVO: TStringField;
    selT332DATA: TDateTimeField;
    selT332PROGRESSIVO: TFloatField;
    selT332TURNO1: TStringField;
    selT332TURNO2: TStringField;
    selT332D_BADGE: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT332AfterPost(DataSet: TDataSet);
    procedure selT332BeforeDelete(DataSet: TDataSet);
    procedure selT332BeforeInsert(DataSet: TDataSet);
    procedure selT332BeforePost(DataSet: TDataSet);
    procedure selT332NewRecord(DataSet: TDataSet);
    procedure selT332DATAValidate(Sender: TField);
    procedure selT332TURNO1SetText(Sender: TField; const Text: String);
    procedure selT332TURNO1Validate(Sender: TField);
  private
    { Private declarations }
    procedure evtRichiesta(Msg,Chiave:String);
    //procedure evtRichiestaInserimento(Msg, Chiave: String);
  public
    { Public declarations }
    A128MW: TA128FPianPrestazioniAggiuntiveMW;
    selI010:TselI010;
  end;

var
  A128FPianPrestazioniAggiuntiveDtm: TA128FPianPrestazioniAggiuntiveDtm;

implementation

{$R *.DFM}

procedure TA128FPianPrestazioniAggiuntiveDtm.DataModuleCreate(Sender: TObject);
{Preparo le query Mensili}
var i:Integer;
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
  A128MW:=TA128FPianPrestazioniAggiuntiveMW.Create(Self);
  A128MW.selT332:=selT332;
  A128MW.evtRichiesta:=evtRichiesta;
  //A128MW.evtRichiestaInserimento:=evtRichiestaInserimento;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
  D010.DataSet:=selI010;
end;

procedure TA128FPianPrestazioniAggiuntiveDtm.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  FreeAndNil(selI010);
end;

procedure TA128FPianPrestazioniAggiuntiveDtm.selT332AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  A128MW.AfterPost;
end;

procedure TA128FPianPrestazioniAggiuntiveDtm.selT332BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA128FPianPrestazioniAggiuntiveDtm.selT332BeforeInsert(DataSet: TDataSet);
begin
  A128MW.BeforeInsert;
end;

procedure TA128FPianPrestazioniAggiuntiveDtm.selT332BeforePost(DataSet: TDataSet);
begin
  A128MW.BeforePost;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveDtm.selT332NewRecord(DataSet: TDataSet);
begin
  A128MW.NewRecord;
end;

procedure TA128FPianPrestazioniAggiuntiveDtm.selT332DATAValidate(Sender: TField);
begin
  A128MW.ValidaData;
end;

procedure TA128FPianPrestazioniAggiuntiveDtm.selT332TURNO1SetText(Sender: TField; const Text: String);
begin
  A128MW.ImpostaTestoTurno(Sender,Text);
end;

procedure TA128FPianPrestazioniAggiuntiveDtm.selT332TURNO1Validate(Sender: TField);
begin
  A128MW.ValidaTurno(Sender);
end;

procedure TA128FPianPrestazioniAggiuntiveDtm.evtRichiesta(Msg,Chiave:String);
begin
  if R180MessageBox(Msg,'DOMANDA') <> mrYes then
    abort;
end;

(*procedure TA128FPianPrestazioniAggiuntiveDtm.evtRichiestaInserimento(Msg,Chiave:String);
begin
  A128MW.sConfermaInserimento:=IfThen(R180MessageBox(Msg,'DOMANDA') = mrYes,'S','N');
end;*)

end.

